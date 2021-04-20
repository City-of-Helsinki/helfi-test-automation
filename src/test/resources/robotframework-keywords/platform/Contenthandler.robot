*** Settings ***
Documentation   Handler class for several content handling keywords.
...				Variables:
...				Submitted:  Is the new page submitted. This is needed when tearing down creating content after test.
...				Picalign:   Picture alignment value in hero cases.
...				Picture:    Is at least one picture added to content = picture , else 'nopicture'
...				Picsadded:  Number of pictures added to content. This is needed in teardown after test, so all media
...				Picsize:   Picture size for column pictures. Original=  If use original aspect ratio. Cropped otherwise  
...				gets deleted succesfully. Please note that pictures with greater value of width than length are not 
...				modified in any way by drupal.
...				Linkstyle:	Styling of the link used in some test cases.
...				language:  Not UI language but content translation.
...				gallery:  is gallery paragraph used in this test.  
Resource        Commonkeywords.robot
Resource		  ./variables/create_content.robot
Resource		  ./variables/picture_comparison.robot
Library 		   helfi.ta.PictureCompare
Library           OperatingSystem
Library			  Collections

*** Variables ***
${submitted}								false
${picalign} 		 						${EMPTY}
${picture} 			 						nopicture
${picsadded}								0
${pagesadded}								0
${picsize}									cropped
${linkstyle} 		 						${EMPTY}
${language}	 		 						fi
${gallery}									false

${URL_content_page}							${PROTOCOL}://${BASE_URL}/fi/admin/content
${URL_media_page}							${PROTOCOL}://${BASE_URL}/fi/admin/content/media		
*** Keywords ***

Input Title
	[Arguments]   ${title}
	Wait Until Element Is Visible   ${Inp_Title}   timeout=3  
	Input Text  ${Inp_Title}   ${title}  

Input Author
	[Arguments]   ${author}
	Wait Until Element Is Visible   ${Inp_Author}   timeout=3  
	Input Text  ${Inp_Author}   ${author}  

Input Lead
	[Arguments]   ${lead}
	Wait Until Element Is Visible   ${Inp_Lead}   timeout=3  
	Input Text  ${Inp_Lead}   ${lead} 

Input Content Header Title
	[Arguments]   ${content}
	Input Text To Frame   ${Frm_Content}   //body   ${content}
	
Go To Translations Tab
	Click Button   //a[contains(text(),'Translate')]	
	
Go To ${language} Translation Page
	${language_pointer}=  Get Language Pointer   ${language}
	Click Element   //a[contains(@href, 'translations/add/fi/${language_pointer}')]
		
Cleanup and Close Browser
	[Documentation]  Deletes content created by testcases. Page , if created and picture if added.
	Run Keyword If   ${DEBUG}   Run Keyword If Test Failed   Debug Error
	FOR    ${i}    IN RANGE    ${pagesadded}
           Wait Until Keyword Succeeds  2x  200ms 	Delete Newly Created Item on Content Menu List
    END
	FOR    ${i}    IN RANGE    ${picsadded}
           Wait Until Keyword Succeeds  2x  200ms 	Delete Newly Created Item from Content Media List
    END
	Close Browser	
	
Image Comparison Needs To Exclude Areas
	[Documentation]   Image Comparison needs to exclude some parts of the picture in case of for example changing date
	... 			  values and such which cause the test to fail in comparion stage. For this reason we check if
	...				  excluding is needed and save possible excludetag in test variable so that right parts will later
	...				  be excluded
	Log List   ${TEST TAGS}
	${count}=  Get Length   ${excludetaglist}
	FOR    ${i}    IN RANGE    ${count}
		   ${tag}=  Get From List  ${excludetaglist}   ${i}	
           ${status}=   Run Keyword And Return Status   Should Contain Match   ${TEST TAGS}    ${tag}
           Run Keyword If   '${status}'=='True'   Set Test Variable   ${excludetag}    ${tag}
           Exit For Loop If   '${status}'=='True'   
    END
    [Return]   ${status}
		
Add Excluded Areas To List
	[Documentation]    We get list of areas needed to be excluded from the picture compare and add them into list.
	@{content} =	Split String	@{${excludetag}}   |
	[Return]   @{content}	


Click Content Link From Notification Banner
	Wait Until Element Is Visible   css:div.messages__content > em > a
	Wait Until Keyword Succeeds  5x  200ms  Click Element   css:div.messages__content > em > a
	Element Should Not Be Visible   //a[contains(@href, '/node/add')]

Accept Cookies
	Wait Until Keyword Succeeds  5x  400ms  Click Button  //button[@class='agree-button eu-cookie-compliance-default-button hds-button hds-button--primary']

Open Created Content
	Run Keyword Unless  ${CI}  Open Content In Non CI Environments
	Run Keyword If   (${CI}) & ('${language}'=='fi')  	Accept Cookies
	Run Keyword If   ${CI}  Reload Page
	  

Open Content In Non CI Environments
	[Documentation]   Goes to content view of created content through content list page (since local environment errors prevent
	...				  viewing it directly after creation)
	Go To   ${URL_content_page}
	Wait Until Keyword Succeeds  5x  200ms  Click Content Link From Notification Banner
	Run Keyword If  '${language}'=='fi'  	Accept Cookies
	
Get Language Pointer
	[Arguments]     ${language}
	[Documentation]  fi = Finnish is default
	${language_pointer}=  Set Variable If  '${language}'=='Finnish'   fi
	...		'${language}'=='Swedish'   sv
	...		'${language}'=='English'   en
	...		'${language}'=='Russian'   ru
	[Return]   ${language_pointer}

Set Language Pointer
	[Arguments]     ${language}
	[Documentation]  Language to set to Test Variable
	${language_pointer}=  Set Variable If  '${language}'=='Finnish'   fi
	...		'${language}'=='Swedish'   sv
	...		'${language}'=='English'   en
	...		'${language}'=='Russian'   ru
	Set Test Variable   ${language}   ${language_pointer}
	
	
Compared Pictures Match
	[Documentation]   Tests that two pictures look same --> layout is not broken
	[Arguments]	   ${pic1}   ${pic2}   @{arealist}=${None}
	${results}=  compare      ${pic1}   ${pic2}   ${REPORTS_PATH}/pic_difference-${SUITE NAME}-${TEST NAME}.png   ${arealist}
    Run keyword if  ${results}==False   fail    "Pictures are different"
    

Go To New Article Site
	Click Add Content
	Wait Until Keyword Succeeds  5x  200ms  Click Add Article

Go To New Page Site
	Click Add Content
	Wait Until Keyword Succeeds  5x  200ms  Click Add Page

Click Add Content
	[Documentation]   Add Content ('Lisää sisältöä') in Content Menu
	Wait Until Element Is Visible   css:#block-hdbt-admin-local-actions > ul > li > a   timeout=3
	Wait Until Keyword Succeeds  5x  200ms  Click Element  css:#block-hdbt-admin-local-actions > ul > li > a
	
   
Click Add Page
	[Documentation]   Add Page ('Sivu') click in Add Content('Lisää sisältöä') -menu
	Wait Until Element Is Clickable  //a[contains(@href, '/node/add/page')][@class='admin-item__link']   timeout=3
	Wait Until Keyword Succeeds  5x  200ms  Click Element  //a[contains(@href, '/node/add/page')][@class='admin-item__link']
	Element Should Not Be Visible   //a[contains(@href, '/node/add/page')][@class='admin-item__link']
	
Click Add Article
	[Documentation]   Add Article ('Artikkeli') click in Add Content('Lisää sisältöä') -menu
	Wait Until Element Is Visible  //a[contains(@href, '/node/add/article')][@class='admin-item__link']   timeout=3
	Wait Until Keyword Succeeds  5x  200ms  Click Element  //a[contains(@href, '/node/add/article')][@class='admin-item__link']
	Element Should Not Be Visible   //a[contains(@href, '/node/add/article')][@class='admin-item__link']

Go To Translate Selection Page
	[Documentation]   Goes To Translations Page for first document in the content list
	Go To   ${URL_content_page}
	Click Button   ${Btn_Actions_Dropbutton}
	Click Element  ${Btn_Actions_ContentMenu_Translatebutton}

Submit The New ${pagetype}
	[Documentation]   Sleeps 1 second in case of pictures added so that they have time to load into content view.
	Run Keyword If  '${picture}'=='picture'   Sleep  1
	Submit New Content

Submit New Content
	[Documentation]  User submits new page and it is saved and appears in content view
	Wait Until Keyword Succeeds  5x  100ms  Click Button   ${Btn_Submit}
	Wait Until Keyword Succeeds  5x  100ms  Element Should Not Be Visible   ${Btn_Submit}
	Set Test Variable  ${pagesadded}    ${pagesadded}+1
		
Go To New ${pagetype} -View For ${language} Translation
	Go To Translate Selection Page
	Go To ${language} Translation Page
	
Delete Newly Created Item on Content Menu List
	[Documentation]   Deletes Created Item By assuming it is the topmost one in the list. Returns to content page afterwards.
	Go To   ${URL_content_page}
	Click Button   ${Btn_Actions_Dropbutton}
	Click Element  ${Btn_Actions_ContentMenu_Deletebutton}
	Click Element  ${Btn_Actions_SelectedItem_Deletebutton}
	Go To   ${URL_content_page}
	
Delete Newly Created Item from Content Media List
	Go To   ${URL_media_page}
	Wait Until Keyword Succeeds  5x  200ms  Click Button   ${Btn_Actions_Dropbutton}
	Click Element  ${Btn_Actions_ContentMenu_Deletebutton}
	Click Element  ${Btn_Actions_SelectedItem_Deletebutton}
	Go To   ${URL_media_page}	
	
Copy Original Screenshot To Reports Folder
	[Arguments]     ${source}
	Copy File    ${source}    ${REPORTS_PATH}/originals/

Get Admin Url
   [Documentation]   Gets URL needed in localhost testing.
   ${admin_url} =   Run  ${ADMIN_URL}
   Set Test Variable   ${admin_url}

Select Language
	[Arguments]     ${value}
	[Documentation]  fi = Finnish , sv = Swedish , en = English , ru = Russian
	Run Keyword If  '${value}'=='Finnish'  Click Element  css:[lang|=fi]
	Run Keyword If  '${value}'=='Swedish'  Click Element  css:[lang|=sv]
	Run Keyword If  '${value}'=='English'  Click Element  css:[lang|=en]
	Run Keyword If  '${value}'=='Russian'  Click Element  css:[lang|=ru]

Return Correct Title
	[Arguments]     ${language}
	${title}=	Set Variable If  '${language}'=='fi'  Juhani Aho: Rautatie
	...				'${language}'=='en'  Emily Bronte: Wuthering Heights
	...		 		'${language}'=='sv'  Selma Lagerlof: Bannlyst
	[Return]		${title}

Title Should Match Current Language Selection
	[Arguments]   ${string}
	${string}=   Encode String To Bytes   ${string}   UTF-8
	Run Keyword If  '${language}'=='fi'  Should Match   ${string.replace('\xc2\xad', '')}	Juhani Aho: Rautatie
	Run Keyword If  '${language}'=='en'  Should Match   ${string.replace('\xc2\xad', '')}   Emily Bronte: Wuthering Heights
	Run Keyword If  '${language}'=='sv'  Should Match   ${string.replace('\xc2\xad', '')}   Selma Lagerlof: Bannlyst  

Description Should Match Current Language Selection
	[Arguments]   ${string}
	Run Keyword If  '${language}'=='fi'  Should Match Regexp  ${string}   "Rautatie" on Juhani Ahon
	Run Keyword If  '${language}'=='en'  Should Match Regexp  ${string}   In the late winter months
	Run Keyword If  '${language}'=='sv'  Should Match Regexp  ${string}   Sven Elversson var nära att dö under en nordpolsexpedtion

Content Should Match Current Language Selection
	[Arguments]   ${string}
	Run Keyword If  '${language}'=='fi'  Should Match Regexp  ${string}   Viittatie teki niemen nenässä polvekkeen
	Run Keyword If  '${language}'=='en'  Should Match Regexp  ${string}   If all else perished, and he remained
	Run Keyword If  '${language}'=='sv'  Should Match Regexp  ${string}   Det är bara synd, att han inte är

Login And Go To Content Page
	[Documentation]   Preparatory action for platform tests: User logs in and then navigates to Content('Sisältö')
	...				  page. Also accepts cookies here.
	Get Admin Url
	Open Browser  ${admin_url}  ${BROWSER}
	Go To   ${URL_content_page}
	Set Window Size   1296   696