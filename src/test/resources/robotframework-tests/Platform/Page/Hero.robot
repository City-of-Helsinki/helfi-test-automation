*** Settings ***
Documentation   Testing Hero Block Settings in Platform
Resource        ../../../../../main/resources/platform/Commonkeywords.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	

*** Test Cases ***

Browse Content Item
	[Tags]  HERO 
	When User Creates a Page With Hero Block
	User Opens Created Content	
   
*** Keywords ***
User Creates a Page With Hero Block
	Go To New Page Site
	Input Text  ${Inp_Title}  Test Automation: User Creates a Page With Hero Block
	${TextFileContent}=  Get File  ${CURDIR}../../../../../../main/resources/content/text_content_short_fi.txt
	${TextFileDescription}=  Get File  ${CURDIR}../../../../../../main/resources/content/text_description_short_fi.txt
	Click Element   ${Swh_HeroOnOff} 
	Wait Until Keyword Succeeds  5x  100ms  Input Text  ${Inp_Hero_Title}   Test Automation Hero Title
	
	Select Frame   css:#cke_1_contents > iframe
	Input Text   //body   ${TextFileContent}
	Unselect Frame

	Select Frame   css:#cke_58_contents > iframe
	Input Text   //body   ${TextFileDescription}
	Unselect Frame

		
	Click Button   ${Btn_Submit}
	Go To   ${URL_content_page}
	
	
User Opens Created Content
	Wait Until Keyword Succeeds  5x  200ms  Click Element  //a[contains(@href, '/fi/test-automation')]
	Wait Until Keyword Succeeds  3x  200ms  Click Button  //button[contains(text(), 'Accept all cookies')]
	Maximize Browser Window
	Execute javascript  document.body.style.zoom="40%"
	Capture Page Screenshot
	
Cleanup and Close Browser
	Go To   ${URL_content_page}
	Wait Until Keyword Succeeds  5x  200ms  Delete Newly Created Item on Content Menu List
	Close Browser
	