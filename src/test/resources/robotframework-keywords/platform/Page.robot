*** Settings ***
Documentation   New Page creation spesific keywords here. Variables are
...				Submitted:  Is the new page submitted. This is needed when tearing down creating content after test.
...				Picalign:   Picture alignment value in hero cases.
...				Picture:    Is at least one picture added to content = picture , else 'nopicture'
...				Picsadded:  Number of pictures added to content. This is needed in teardown after test, so all media
...				Picsize:   Picture size for column pictures. Original=  If use original aspect ratio. Cropped otherwise  
...				gets deleted succesfully. Please note that pictures with greater value of width than length are not 
...				modified in any way by drupal.
Resource        Commonkeywords.robot

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
*** Keywords ***

Input Title
	[Arguments]   ${title}
	Wait Until Element Is Visible   ${Inp_Title}   timeout=3  
	Input Text  ${Inp_Title}   ${title}  

Input Content Header Title
	[Arguments]   ${content}
	Input Text To Frame   ${Frm_Content}   //body   ${content}

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

	
Submit Page
	[Documentation]  User submits new page and it is saved and appears in content view
	Wait Until Keyword Succeeds  5x  100ms  Click Button   ${Btn_Submit}
	Wait Until Keyword Succeeds  5x  100ms  Element Should Not Be Visible   ${Btn_Submit}
	Set Test Variable  ${pagesadded}    ${pagesadded}+1
	
Add ${linkstyle} Link To ${side} Column
	${linkstyle}=  Remove String And Strip Text   ${linkstyle}   "
	Wait Until Element Is Clickable  ${Opt_Column_${side}_AddContent_Link}   timeout=3
	Click Element  ${Opt_Column_${side}_AddContent_Link}
	Wait Until Keyword Succeeds  5x  100ms  Input Text   ${Inp_Column_${side}_Link_URL}   https://fi.wikipedia.org/wiki/Rautatie_(romaani)    
	Input Text   ${Inp_Column_${side}_Link_Title}    ${link_title_${language}}
	Click Element  ${Ddn_Column_${side}_Link_Design}
	Run Keyword If  '${linkstyle}'=='Fullcolor'  Click Element   ${Opt_Column_${side}_Link_ButtonFullcolor}
	Run Keyword If  '${linkstyle}'=='Framed'  Click Element   ${Opt_Column_${side}_Link_ButtonFramed}
	Run Keyword If  '${linkstyle}'=='Transparent'  Click Element   ${Opt_Column_${side}_Link_ButtonTransparent}
	
Add Picture to Column
	[Documentation]  Adds picture and fills given content. selection= picture name from images -folder at src/main/
	...			     resources.  side = 'left' of 'right' column  . content = content as list items.    
	[Arguments]     ${side}   ${selection}   @{content}
	Wait Until Element Is Clickable  ${Opt_Column_${side}_AddContent_Image}   timeout=3
	Click Element  ${Opt_Column_${side}_AddContent_Image}
	${pictitle}=  Get From List  ${content}   0
	${picdescription}=  Get From List  ${content}   1
	${pgrapher}=  Get From List  ${content}   2
	Wait Until Element Is Clickable  ${Btn_Column_${side}_Picture}   timeout=3
	Focus   ${Btn_Column_${side}_Picture}
	Wait Until Keyword Succeeds  10x  500ms  Click Element  ${Btn_Column_${side}_Picture}
	Wait Until Keyword Succeeds  10x  500ms  Choose File   ${Btn_File_Upload}   ${IMAGES_PATH}/${selection}.jpg
	Wait Until Keyword Succeeds  10x  500ms  Input Text    ${Inp_Pic_Name}   ${pictitle}
	Input Text    ${Inp_Pic_AltText}   ${picdescription} 
	Input Text    ${Inp_Pic_Photographer}   ${pgrapher}
	Click Button   ${Btn_Save_Pic}
	Set Test Variable  ${picsadded}    ${picsadded}+1
	Set Test Variable  ${picture}    picture   
	Wait Until Keyword Succeeds  10x  500ms  Click Button   ${Btn_Insert_Pic}
	Wait Until Keyword Succeeds  10x  500ms   Add Picture Caption to ${side}  
	

Add Picture Caption to ${side}
	${editpicturevisible}=  Run Keyword And Return Status    Element Should Not Be Visible  ${Btn_Column_${side}_Edit}   timeout=1
	Run Keyword Unless   ${editpicturevisible}   Wait Until Keyword Succeeds  5x  200ms  Click Element   ${Btn_Column_${side}_Edit}
	Run Keyword If  '${side}'=='Left'	Wait Until Keyword Succeeds  5x  200ms  Input Text    ${Inp_Column_Left_Picture_Caption}   ${pic_1_caption_${language}}
	Run Keyword If  '${side}'=='Right'	Wait Until Keyword Succeeds  5x  200ms  Input Text    ${Inp_Column_Right_Picture_Caption}   ${pic_2_caption_${language}}


Use Original Aspect Ratio on ${side}
	Run keyword if  '${BROWSER}'=='chromeheadless'  Execute javascript  window.scrollTo(0, 1000)
	Focus   ${Swh_Column_${side}_Picture_Orig_Aspect_Ratio}
	Capture Page Screenshot
	Wait Until Keyword Succeeds  5x  200ms  Click Element   ${Swh_Column_${side}_Picture_Orig_Aspect_Ratio}
	Execute javascript  document.body.style.zoom="100%"
	Set Test Variable  ${picsize}   original
	
Click And Select Text As ${side} Content Type
	Wait Until Element Is Clickable  ${Opt_Column_${side}_AddContent_Text}   timeout=3
	Wait Until Keyword Succeeds  10x  500ms  Click Element  ${Opt_Column_${side}_AddContent_Text}

Add Text Content To Column on ${side}
	[Documentation]   Adds text content to selected column by selecting content type first and then inserting text
	Run Keyword If  '${language}'=='fi'  Click And Select Text As ${side} Content Type
	${TextFileContent}=  Get File  ${CONTENT_PATH}/text_content_short_${language}.txt
	@{content} =	Split String	${TextFileContent}   .,.
	${content_left}=  Get From List  ${content}   0
	${content_right}=  Get From List  ${content}   1
	${content_text}=  Set Variable If
	... 	 '${side}'=='Left'	${content_left}
	... 	 '${side}'=='Right'	${content_right}
	${editpicturevisible}=  Run Keyword And Return Status    Element Should Not Be Visible  ${Btn_Column_${side}_Edit}   timeout=1
	Run Keyword Unless   ${editpicturevisible}   Wait Until Keyword Succeeds  5x  200ms  Click Element   ${Btn_Column_${side}_Edit}
	Wait Until Keyword Succeeds  10x  500ms  Input Text To Frame   ${Frm_Column_${side}_Text}   //body   ${content_text}

Add ${content} to Left Column
	[Documentation]  Here we need to do some tricks in case picture tests original size. Content -string is modified
	...				 so that picture compare assertion works. Also long, snowdrops picture is used in the case because
	...				 pictures with longer width value does not get cropped. Only long pictures do.
	Focus   ${Ddn_Column_Left_AddContent}
	Wait Until Keyword Succeeds  5x  100ms  Click Button  ${Ddn_Column_Left_AddContent}
	Run Keyword If  '${content}'=='picture'  Add Picture to Column   Left    train   @{pic_1_texts_${language}}
	Run Keyword If  '${content}'=='original picture'  Add Picture to Column   Left    snowdrops   @{pic_1_texts_${language}}
	Run Keyword If  '${content}'=='text'  Add Text Content To Column on Left
	Run Keyword If  ('${content}'=='picture') & ('${language}'=='fi')  Add Picture Caption to Left
	${content}=  Remove String And Strip Text   ${content}   original
	Set Test Variable  ${content1}   ${content}
  

Add ${content:[^"]+} to Right Column
	[Documentation]   Adds given content to Right column.
	Set Test Variable  ${content2}   ${content}
	Wait Until Element Is Clickable  ${Ddn_Column_Right_AddContent}   timeout=3
	Focus   ${Ddn_Column_Right_AddContent}
	Wait Until Keyword Succeeds  10x  500ms  Click Button  ${Ddn_Column_Right_AddContent}
	Run Keyword If  '${content}'=='Picture'  Add Picture to Column   Right    temple   @{pic_2_texts_${language}}
	Run Keyword If  '${content}'=='Text'  Add Text Content To Column on Right
	Run Keyword If  '${content}'=='Link'  Add "${linkstyle}" Link To Right Column

Go To Translations Tab
	Click Button   //a[contains(text(),'Translate')]	
	
Go To ${language} Translation Page
	${language_pointer}=  Get Language Pointer   ${language}
	Click Element   //a[contains(@href, 'translations/add/fi/${language_pointer}')]
		
Cleanup and Close Browser
	[Documentation]  Deletes content created by testcases. Page , if created and picture if added.
	FOR    ${i}    IN RANGE    ${pagesadded}
           Wait Until Keyword Succeeds  2x  200ms 	Delete Newly Created Item on Content Menu List
    END
	FOR    ${i}    IN RANGE    ${picsadded}
           Wait Until Keyword Succeeds  2x  200ms 	Delete Newly Created Item from Content Media List
    END
	Close Browser	