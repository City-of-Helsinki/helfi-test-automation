*** Settings ***
Documentation   Testing Gallery. Actually just checking that layout is not broken. No functional testing of the gallery
...			    component atm.
Resource        ../../../robotframework-keywords/platform/Commonkeywords.robot
Resource        ../../../robotframework-keywords/platform/Page.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	
Force Tags		PAGE

*** Test Cases ***
Browse Gallery Images
	[Tags]  GALLERY   CRITICAL
	Given User Goes To New Page -Site
	And User Starts Creating Page With Gallery
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed
		
	
*** Keywords ***
User Goes To New Page -Site  	Go To New Page Site
User Submits The New Page   	
	Sleep  1
	Submit Page 

User Starts Creating Page With Gallery
	Input Title  Test Automation: ${TEST NAME}
	${headertitle}=  Get File  ${CONTENT_PATH}/text_description_short_${language}.txt
	Input Content Header Title  ${headertitle}
	Wait Until Element Is Visible   ${Ddn_AddContent}   timeout=3
	Focus   ${Ddn_AddContent}
	Click Element	${Ddn_AddContent}
	Click Element	${Opt_AddGallery}
	Add Picture 'train' And Caption To 1:th Picture
	Add Picture 'temple' And Caption To 2:th Picture
	Add Picture 'tulips' And Caption To 3:th Picture

Add Picture '${name}' And Caption To ${number}:th Picture
	${number}=   Convert To Integer   ${number}
	Run Keyword If  ${number}>=2   Click Element   ${Btn_Gallery_Picture_Addmore}
	${editgalleryvisible}=  Run Keyword And Return Status    Wait Until Element Is Visible  name:field_content_0_edit   timeout=1
	Run Keyword If   ${editgalleryvisible}  Focus   name:field_content_0_edit
	Run Keyword If   ${editgalleryvisible}   Click Element   name:field_content_0_edit
	Run Keyword If  ${editgalleryvisible}  Wait Until Keyword Succeeds  6x  300ms  Click Element   ${Btn_Gallery_Picture_Addmore}
	Wait Until Element Is Visible   ${Btn_Gallery_Picture}${number-1}-subform   timeout=3
	Click Element	${Btn_Gallery_Picture}${number-1}-subform
	@{content}=  Set Variable  @{pic_1_texts_${language}}
	${pictitle}=  Get From List  ${content}   0
	${picdescription}=  Get From List  ${content}   1
	${pgrapher}=  Get From List  ${content}   2
	Wait Until Keyword Succeeds  5x  200ms  Choose File   ${Btn_File_Upload}   ${IMAGES_PATH}/${name}.jpg
	Wait Until Keyword Succeeds  5x  200ms  Input Text    ${Inp_Pic_Name}   ${pictitle}
	Input Text    ${Inp_Pic_AltText}   ${picdescription} 
	Input Text    ${Inp_Pic_Photographer}   ${pgrapher}
	Click Button   ${Btn_Save_Pic}
	Wait Until Keyword Succeeds  5x  200ms  Click Button   ${Btn_Insert_Pic}
	${pic_caption_locator}=   Set Variable  name:field_content[1][subform][field_gallery_slides][${number-1}][subform][field_gallery_slide_caption][0][value]
	Wait Until Keyword Succeeds  5x  200ms   Input Text      ${pic_caption_locator}   ${pic_1_caption_${language}}
	Set Test Variable  ${picsadded}    ${picsadded}+1
	Set Test Variable  ${picture}    picture 
    						
User Opens Created Content
	 Open Created Content
	 Take Screenshot Of Content

Take Screenshot Of Content
	Maximize Browser Window
	Wait Until Element Is Visible   ${Itm_Gallery_Slidetrack}   timeout=5
	Execute javascript  document.body.style.zoom="28%"
	Capture Page Screenshot    filename=${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}.png
	Execute javascript  document.body.style.zoom="100%"

Layout Should Not Have Changed
	${originalpic} =  Set Variable   ${SCREENSHOTS_PATH}/${BROWSER}/${language}_short_GALLERY_${BROWSER}.png
	${comparisonpic}=  Set Variable  ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}.png
	Copy Original Screenshot To Reports Folder   ${originalpic}
	Compared Pictures Match   ${originalpic}    ${comparisonpic}
	