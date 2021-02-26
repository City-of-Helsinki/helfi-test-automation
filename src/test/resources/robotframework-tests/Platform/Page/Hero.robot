*** Settings ***
Documentation   Testing Hero Block Settings in Platform
Resource        ../../../../../main/resources/platform/Commonkeywords.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	

*** Test Cases ***

Browse Content Item
	[Tags]  HERO 
	When User Creates a Page With Hero Block
	And User Opens Created Content
	Then Layout Should Not Have Changed	
	
   
*** Keywords ***
User Creates a Page With Hero Block
	Go To New Page Site
	Input Text  ${Inp_Title}  Test Automation: User Creates a Page With Hero Block
	${TextFileContent}=  Get File  ${CURDIR}../../../../../../main/resources/content/text_content_short_fi.txt
	${TextFileDescription}=  Get File  ${CURDIR}../../../../../../main/resources/content/text_description_short_fi.txt
	Click Element   ${Swh_HeroOnOff} 
	Wait Until Keyword Succeeds  5x  100ms  Input Text  ${Inp_Hero_Title}   Test Automation Hero Title
	
	Input Text To Frame   css:#cke_1_contents > iframe   //body   ${TextFileContent}
	Input Text To Frame   css:#cke_58_contents > iframe   //body   ${TextFileDescription}

		
	Click Button   ${Btn_Submit}
	Go To   ${URL_content_page}
	
	
User Opens Created Content
	Wait Until Keyword Succeeds  5x  200ms  Click Element  //a[contains(@href, '/fi/test-automation')]
	Wait Until Keyword Succeeds  3x  200ms  Click Button  //button[contains(text(), 'Accept all cookies')]
	Maximize Browser Window
	Execute javascript  document.body.style.zoom="40%"
	Capture Page Screenshot    filename=fi_HERO_left_vaakuna_nopicture_chrome_TESTRUN.png
	
Cleanup and Close Browser
	Go To   ${URL_content_page}
	Wait Until Keyword Succeeds  5x  200ms  Delete Newly Created Item on Content Menu List
	Close Browser

Layout Should Not Have Changed
	${originalpic}=  Set Variable  ${SCREENSHOTS_PATH}/fi_HERO_left_vaakuna_no_picture_chrome.png
	${comparisonpic}=  Set Variable  ${REPORTS_PATH}/fi_HERO_left_vaakuna_nopicture_chrome_TESTRUN.png
	Compared Pictures Match   ${originalpic}    ${comparisonpic}
	
	
	