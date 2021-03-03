*** Settings ***
Documentation   Testing Hero Block Settings in Platform
Resource        ../../../robotframework-keywords/platform/Commonkeywords.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	

*** Variables ***
${picture} 			 nopicture
${picalign} 		 ${EMPTY}
*** Test Cases ***

Left Aligned
	[Documentation]   Left Aligned Hero Block with Short version of text files in Finnish. 'Vaakuna' style.
	[Tags]   HERO 
	Given User Starts Creating a Left Aligned Page With Hero Block
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed	

Center Aligned
	[Documentation]   Center Aligned Hero Block with Short version of text files in Finnish. 'Vaakuna' style.
	[Tags]  HERO     
	Given User Starts Creating a Center Aligned Page With Hero Block
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed	

Left Aligned Picture
	[Documentation]   Left Aligned Hero Block with Picture
	[Tags]  HERO    
	Given User Starts Creating Hero Block Page with Picture on Left
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed	

Right Aligned Picture
	[Documentation]   Right Aligned Hero Block with Picture
	[Tags]  HERO
	Given User Starts Creating Hero Block Page with Picture on Right
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed
	
Bottom Aligned Picture
	[Documentation]   Bottom Aligned Hero Block with Picture
	[Tags]  HERO
	Given User Starts Creating Hero Block Page with Picture on Bottom
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed
	
Background Picture
	[Documentation]    Hero Block with Background Picture
	[Tags]  HERO   
	Given User Starts Creating Hero Block Page with Picture on Background
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed			
   
*** Keywords ***
 
User Starts Creating a ${value} Aligned Page With Hero Block 
	
	Set Test Variable   ${value}    ${value} 
	
	Go To New Page Site
	Input Text  ${Inp_Title}  Test Automation: ${value} Aligned Hero Block Page
		
	${TextFileContent}=  Get File  ${CONTENT_PATH}/text_content_short_fi.txt
	${TextFileDescription}=  Get File  ${CONTENT_PATH}/text_description_short_fi.txt
	Click Element   ${Swh_HeroOnOff}
	Wait Until Keyword Succeeds  5x  100ms  Run Keyword If  '${value}'=='Center'  Click Element   ${Ddn_Hero_Alignment}
	Run Keyword If  '${value}'=='Center'  Click Element   ${Opt_Hero_Alignment_Center} 
	Wait Until Keyword Succeeds  5x  100ms  Input Text  ${Inp_Hero_Title}   Juhani Aho: Rautatie
	
	Input Text To Frame   ${Frm_Content}   //body   ${TextFileContent}
	Input Text To Frame   ${Frm_Content_Description}   //body   ${TextFileDescription}

User Starts Creating Hero Block Page with Picture on ${picalign}
	User Starts Creating a Left Aligned Page With Hero Block
    Set Test Variable   ${picture}  picture
    Set Test Variable   ${picalign}   ${picalign}    
	Run Keyword If  '${picalign}'=='Left'  Click Element   ${Opt_Hero_Picture_On_Left}
	Run Keyword If  '${picalign}'=='Right'  Click Element   ${Opt_Hero_Picture_On_Right}
	Run Keyword If  '${picalign}'=='Bottom'  Click Element   ${Opt_Hero_Picture_On_Bottom}
	Run Keyword If  '${picalign}'=='Background'  Click Element   ${Opt_Hero_Picture_On_Background}
		 
	Click Button   ${Btn_Hero_Picture}
	Wait Until Keyword Succeeds  5x  100ms  Choose File   ${Btn_Hero_File_Upload}   ${IMAGES_PATH}/train.jpg
	Wait Until Keyword Succeeds  5x  100ms  Focus  ${Inp_Hero_Pic_Name}
	Input Text    ${Inp_Hero_Pic_Name}   Juna sillalla
	Focus  ${Inp_Hero_Pic_AltText}
	Input Text    ${Inp_Hero_Pic_AltText}   Vanha juna kuljettaa matkustajia 
	Focus  ${Inp_Hero_Pic_Photographer}
	Input Text    ${Inp_Hero_Pic_Photographer}   Testi Valokuvaaja
	Focus  ${Btn_Hero_Save_Pic}
	Click Button   ${Btn_Hero_Save_Pic}
	Wait Until Keyword Succeeds  5x  100ms  Click Button   ${Btn_Hero_Insert_Pic}   

User Submits The New Page
	Wait Until Keyword Succeeds  5x  100ms  Click Button   ${Btn_Submit}
		
	
User Opens Created Content
	Go To   ${URL_content_page}
	Wait Until Keyword Succeeds  5x  200ms  Click Element  //a[contains(@href, '/fi/test-automation')]
	Wait Until Keyword Succeeds  3x  200ms  Click Button  //button[contains(text(), 'Accept all cookies')]
	Maximize Browser Window
	Execute javascript  document.body.style.zoom="40%"
	Capture Page Screenshot    filename=HERO_chrome_TESTRUN.png

Layout Should Not Have Changed
	${originalpic}=  Set Variable If  '${picalign}'!='${EMPTY}'  ${SCREENSHOTS_PATH}/fi_short_HERO_${picalign}_vaakuna_${picture}_chrome.png   ${SCREENSHOTS_PATH}/fi_short_HERO_${value}_vaakuna_nopicture_chrome.png
	${comparisonpic}=  Set Variable  ${REPORTS_PATH}/HERO_chrome_TESTRUN.png
	Compared Pictures Match   ${originalpic}    ${comparisonpic}
	
Cleanup and Close Browser
	Go To   ${URL_content_page}
	Wait Until Keyword Succeeds  2x  200ms  Delete Newly Created Item on Content Menu List
	Run Keyword If  '${picalign}'!='${EMPTY}'  Wait Until Keyword Succeeds  2x  200ms 	Delete Newly Created Item from Content Media List
	Close Browser	
	