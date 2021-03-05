*** Settings ***
Documentation   Testing Columns Settings in Platform by comparing layout to default picture.
Resource        ../../../robotframework-keywords/platform/Commonkeywords.robot
Resource        ../../../robotframework-keywords/platform/Page.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	

*** Variables ***


*** Test Cases ***
50-50
	[Tags]  COLUMNS
	Given User Starts Creating a Page With 50-50 Columns And Text Content
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed	

*** Keywords ***
User Starts Creating a Page With ${division} Columns And ${option} Content
	Go To New Page Site
	Set Test Variable   ${division}   ${division}
	Input Title  Test Automation: ${TEST NAME}
	${TextFileContent}=  Get File  ${CONTENT_PATH}/text_content_short_fi.txt
	@{content} =	Split String	${TextFileContent}   . ..
	${headertitle}=  Get File  ${CONTENT_PATH}/text_description_short_fi.txt
	Input Text Content   ${headertitle}
	Click Button	${Ddn_AddContent}
	Click Element   ${Opt_AddColumns}
	Wait Until Keyword Succeeds  5x  100ms  Input Text   ${Inp_Column_Title}   Juhani Aho: Rautatie
	Click Button  ${Ddn_Column_LeftColumn_AddContent}
	Run Keyword If  '${option}'=='Text'  Click Element  ${Opt_Column_LeftColumn_AddContent_Text}
	${content_left}=  Get From List  ${content}   0
	Wait Until Keyword Succeeds  5x  100ms  Input Text To Frame   ${Frm_Column_LeftColumn_Text}   //body   ${content_left}
	Click Button  ${Ddn_Column_RightColumn_AddContent}
	Run Keyword If  '${option}'=='Text'  Click Element  ${Opt_Column_RightColumn_AddContent_Text}
	
	${content_right}=  Get From List  ${content}   1
	Wait Until Keyword Succeeds  5x  200ms  Input Text To Frame   ${Frm_Column_RightColumn_Text}   //body   ${content_right}

User Opens Created Content
	Open Test Automation Created Content

User Submits The New Page
	Submit Page

Layout Should Not Have Changed
	${originalpic} =  Set Variable  ${SCREENSHOTS_PATH}/fi_short_COLUMNS_${division}_text_chrome.png
	${comparisonpic}=  Set Variable  ${REPORTS_PATH}/chrome_TESTRUN-${TEST NAME}.png
	Compared Pictures Match   ${originalpic}    ${comparisonpic}
