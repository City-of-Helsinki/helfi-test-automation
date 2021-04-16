*** Settings ***
Documentation   Common Keywords referred by many testsuites. Platform side tests only
Library           SeleniumLibrary
Library           OperatingSystem
Library			  Collections
Library			  String
Resource		  ./variables/create_content.robot
Resource		  ./variables/picture_comparison.robot
Library 		   helfi.ta.PictureCompare
 
*** Variables ***
${URL_content_page}							${PROTOCOL}://${BASE_URL}/fi/admin/content
${URL_media_page}							${PROTOCOL}://${BASE_URL}/fi/admin/content/media							


*** Keywords ***
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

Login And Go To Content Page
	[Documentation]   Preparatory action for platform tests: User logs in and then navigates to Content('Sisältö')
	...				  page. Also accepts cookies here.
	Get Admin Url
	Open Browser  ${admin_url}  ${BROWSER}
	Go To   ${URL_content_page}
	Set Window Size   1296   696
	#Run Keyword If   ${DEBUG}   Register Keyword To Run On Failure   Debug Error

Debug Error
	Maximize Browser Window   
	Execute javascript  document.body.style.zoom="30%"
	Capture Page Screenshot    filename=/debug/${SUITE NAME}-${TEST NAME}_error_zoomout.png
	Execute javascript  document.body.style.zoom="100%"
	${source}=   Get Source
	Create File  ${REPORTS_PATH}/debug/${SUITE NAME}-${TEST NAME}_error_source.html  ${source}

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
	Wait Until Element Is Visible  //a[contains(@href, '/node/add/page')]   timeout=3
	Wait Until Keyword Succeeds  5x  200ms  Click Element  //a[contains(@href, '/node/add/page')]
	Element Should Not Be Visible   //a[contains(@href, '/node/add/page')]
	
Click Add Article
	[Documentation]   Add Article ('Artikkeli') click in Add Content('Lisää sisältöä') -menu
	Wait Until Element Is Visible  //a[contains(@href, '/node/add/article')]   timeout=3
	Wait Until Keyword Succeeds  5x  200ms  Click Element  //a[contains(@href, '/node/add/article')]
	Element Should Not Be Visible   //a[contains(@href, '/node/add/article')]

Go To Translate Selection Page
	[Documentation]   Goes To Translations Page for first document in the content list
	Go To   ${URL_content_page}
	Click Button   ${Btn_Actions_Dropbutton}
	Click Element  ${Btn_Actions_ContentMenu_Translatebutton}
	
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
	
Input Text To Frame
	[Documentation]   Inserts text to given frame and returns to original content
	[Arguments]	   ${frame}   ${locator}   ${input}
	Select Frame   ${frame}
	Input Text   ${locator}   ${input}
	Unselect Frame
	
Compared Pictures Match
	[Documentation]   Tests that two pictures look same --> layout is not broken
	[Arguments]	   ${pic1}   ${pic2}   @{arealist}=${None}
	${results}=  compare      ${pic1}   ${pic2}   ${REPORTS_PATH}/pic_difference-${SUITE NAME}-${TEST NAME}.png   ${arealist}
    Run keyword if  ${results}==False   fail    "Pictures are different"
    
Click Element With Value
	[Arguments]	   ${value}
	${value}=  Convert To Lower Case   ${value}
	Click Element  css:[value=${value}]

Remove String And Strip Text
	[Documentation]   Value= String to be modified , String = String to be removed from value -content
	[Arguments]	   ${value}   ${string}
	${value}=  Run Keyword And Continue On Failure   Remove String   ${value}   ${string}
	${value}=  Strip String   ${value} 
	[Return]    ${value}

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
	
	
	
	