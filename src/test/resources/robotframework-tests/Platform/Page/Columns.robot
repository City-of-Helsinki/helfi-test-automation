*** Settings ***
Documentation   Testing Columns Settings in Platform by comparing layout to default picture. Testing is performed with
...				Different text deviation like 50-50, 30-70 and with pictures and links added.
Resource        ../../../robotframework-keywords/platform/Commonkeywords.robot
Resource        ../../../robotframework-keywords/platform/Page.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	

*** Variables ***


*** Test Cases ***
# 	LINKKILISTOISTA EI TARVITSE TEHDÄ TESTEJÄ
50-50
	[Tags]  COLUMNS   CRITICAL   
	Given User Starts Creating a Page With 50-50 Division And Text Content
	And User Adds Text to Left Column
	And User Adds Text to Right Column
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed	
	
30-70
	[Tags]  COLUMNS   
	Given User Starts Creating a Page With 30-70 Division And Text Content
	And User Adds Text to Left Column
	And User Adds Text to Right Column
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed	

70-30
	[Tags]  COLUMNS
	Given User Starts Creating a Page With 70-30 Division And Text Content
	And User Adds Text to Left Column
	And User Adds Text to Right Column
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed	

50-50 with picture
	[Tags]  COLUMNS   CRITICAL   
	Given User Starts Creating a Page With 50-50 Division And Picture Content
	And User Adds Picture to Left Column
	And User Adds Picture to Right Column
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed	

50-50 with picture and text
	[Tags]  COLUMNS   CRITICAL   
	Given User Starts Creating a Page With 50-50 Division And Mixed Content
	And User Adds Picture to Left Column
	And User Adds Text to Right Column
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed

70-30 with original size picture and text
	[Tags]  COLUMNS   CRITICAL   
	Given User Starts Creating a Page With 70-30 Division And Mixed Content
	And User Adds Original Picture to Left Column
	And Picture on Left Has Original Aspect Ratio Enabled
	And User Adds Text to Right Column
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed

50-50 with text and fullcolor link
	[Tags]  COLUMNS   CRITICAL
	Given User Starts Creating a Page With 50-50 Division And Mixed Content
	And User Adds Text to Left Column
	And User Adds Link Button With Fullcolor Style into Right Column
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed

50-50 With Text And Transparent Link
	[Tags]  COLUMNS
	Given User Starts Creating a Page With 50-50 Division And Mixed Content
	And User Adds Text to Left Column
	And User Adds Link Button With Transparent Style into Right Column
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed

50-50 With Text And Framed Link
	[Tags]  COLUMNS
	Given User Starts Creating a Page With 50-50 Division And Mixed Content
	And User Adds Text to Left Column
	And User Adds Link Button With Framed Style into Right Column
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed

*** Keywords ***
User Starts Creating a Page With ${division} Division And ${contenttype} Content
 	Set Test Variable  ${contenttype}   ${contenttype}
	Go To New Page Site
	Set Test Variable   ${division}   ${division}
	Input Title  Test Automation: ${TEST NAME}
	${headertitle}=  Get File  ${CONTENT_PATH}/text_description_short_fi.txt
	Input Text Content   ${headertitle}
	Wait Until Element Is Clickable   ${Ddn_AddContent}   timeout=3
	Focus   ${Ddn_AddContent}
	Click Element	${Ddn_AddContent}
	Click Element   ${Opt_AddColumns}
	Wait Until Keyword Succeeds  5x  100ms  Input Text   ${Inp_Column_Title}   Juhani Aho: Rautatie
	Click Element    ${Ddn_Column_Style}
	Click Element With Value   '${division}'

User Adds ${content} to Left Column
	${content}=  Convert To Lower Case   ${content}
	Add ${content} to Left Column

User Adds ${content} to Right Column
	Add ${content} to Right Column

User Adds Link Button With ${linkstyle} Style into ${side} Column
	Set Test Variable   ${linkstyle}   ${linkstyle}
	${side}=  Convert To Lower Case   ${side}
	Run Keyword If  '${side}'=='right'  Add Link to Right Column
	Run Keyword If  '${side}'=='left'  Add Link to Left Column

User Opens Created Content
	Open Test Automation Created Content

User Submits The New Page
	Submit Page

Picture on ${side} Has Original Aspect Ratio Enabled
	Use Original Aspect Ratio on ${side}

Layout Should Not Have Changed
	${contenttype}=  Convert To Lower Case   ${contenttype}
	${originalpic} =  Set Variable If  
	...  '${contenttype}'=='picture'   ${SCREENSHOTS_PATH}/fi_short_COLUMNS_${division}_picture_${picsize}_chrome.png
	...	 '${linkstyle}'!='${EMPTY}'   ${SCREENSHOTS_PATH}/fi_short_COLUMNS_${division}_left_${content1}_right_${content2}_${linkstyle}_chrome.png
	...  '${contenttype}'=='mixed'   ${SCREENSHOTS_PATH}/fi_short_COLUMNS_${division}_left_${content1}_right_${content2}_${picsize}_chrome.png
	...   ${SCREENSHOTS_PATH}/fi_short_COLUMNS_${division}_text_chrome.png
	${comparisonpic}=  Set Variable  ${REPORTS_PATH}/chrome_TESTRUN-${TEST NAME}.png
	Compared Pictures Match   ${originalpic}    ${comparisonpic}
