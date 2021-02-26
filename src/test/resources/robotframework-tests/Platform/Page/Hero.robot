*** Settings ***
Documentation   Testing Hero Block Settings in Platform
Resource        ../../../../../main/resources/platform/Commonkeywords.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	

*** Test Cases ***

Left Aligned
	[Documentation]   Left Aligned Hero Block with Short version of text files in Finnish. 'Vaakuna' style.
	[Tags]   HERO
	When User Creates a Left Aligned Page With Hero Block
	And User Opens Created Content
	Then Layout Should Not Have Changed	

Center Aligned
	[Documentation]   Center Aligned Hero Block with Short version of text files in Finnish. 'Vaakuna' style.
	[Tags]  HERO
	When User Creates a Center Aligned Page With Hero Block
	And User Opens Created Content
	Then Layout Should Not Have Changed	
   
*** Keywords ***
User Creates a ${value} Aligned Page With Hero Block
	
	Set Test Variable   ${value}    ${value} 
	
	Go To New Page Site
	Input Text  ${Inp_Title}  Test Automation: ${value} Aligned Hero Block Page Without Picture
		
	${TextFileContent}=  Get File  ${CONTENT_PATH}/text_content_short_fi.txt
	${TextFileDescription}=  Get File  ${CONTENT_PATH}/text_description_short_fi.txt
	Click Element   ${Swh_HeroOnOff}
	Wait Until Keyword Succeeds  5x  100ms  Run Keyword If  '${value}'=='Center'  Click Element   ${Ddn_Hero_Alignment}
	Run Keyword If  '${value}'=='Center'  Click Element   ${Opt_Hero_Alignment_Center} 
	Wait Until Keyword Succeeds  5x  100ms  Input Text  ${Inp_Hero_Title}   Juhani Aho: Rautatie
	
	Input Text To Frame   ${Frm_Content}   //body   ${TextFileContent}
	Input Text To Frame   ${Frm_Content_Description}   //body   ${TextFileDescription}
	#SUBMIT FORM
	Click Button   ${Btn_Submit}
	Go To   ${URL_content_page}
	
	
User Opens Created Content
	Wait Until Keyword Succeeds  5x  200ms  Click Element  //a[contains(@href, '/fi/test-automation')]
	Wait Until Keyword Succeeds  3x  200ms  Click Button  //button[contains(text(), 'Accept all cookies')]
	Maximize Browser Window
	Execute javascript  document.body.style.zoom="40%"
	Capture Page Screenshot    filename=HERO_chrome_TESTRUN.png

Layout Should Not Have Changed
	${originalpic}=  Set Variable  ${SCREENSHOTS_PATH}/fi_short_HERO_${value}_vaakuna_nopicture_chrome.png
	${comparisonpic}=  Set Variable  ${REPORTS_PATH}/HERO_chrome_TESTRUN.png
	Compared Pictures Match   ${originalpic}    ${comparisonpic}
	
Cleanup and Close Browser
	Go To   ${URL_content_page}
	Wait Until Keyword Succeeds  2x  200ms  Delete Newly Created Item on Content Menu List
	Close Browser	
	