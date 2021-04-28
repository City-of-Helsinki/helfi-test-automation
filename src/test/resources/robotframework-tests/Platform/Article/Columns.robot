*** Settings ***
Documentation   Testing Columns Settings in Platform by comparing layout to default picture. Testing is performed with
...				Different text deviation like 50-50, 30-70 and with pictures and links added.
Resource        ../../../robotframework-keywords/platform/Paragraphs/Columns.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser
Force Tags		ARTICLE
*** Variables ***


*** Test Cases ***
50-50
	[Tags]  COLUMNS   CRITICAL
	Given User Goes To New Article Site
	And User Starts Creating Article With 50-50 Division And Text Content
	And User Adds Text to Left Column
	And User Adds Text to Right Column
	When User Submits The New Article
	And User Opens Created Content
	Then Layout Should Not Have Changed
	
30-70
	[Tags]  COLUMNS
	Given User Goes To New Article Site 
	And User Starts Creating Article With 30-70 Division And Text Content
	And User Adds Text to Left Column
	And User Adds Text to Right Column
	When User Submits The New Article
	And User Opens Created Content
	Then Layout Should Not Have Changed	

70-30
	[Tags]  COLUMNS
	Given User Goes To New Article Site
	And User Starts Creating Article With 70-30 Division And Text Content
	And User Adds Text to Left Column
	And User Adds Text to Right Column
	When User Submits The New Article
	And User Opens Created Content
	Then Layout Should Not Have Changed	

50-50 with picture
	[Tags]  COLUMNS   CRITICAL
	Given User Goes To New Article Site  
	And User Starts Creating Article With 50-50 Division And Picture Content
	And User Adds Picture to Left Column
	And User Adds Picture to Right Column
	When User Submits The New Article
	And User Opens Created Content
	Then Layout Should Not Have Changed	

50-50 with picture and text
	[Tags]  COLUMNS   CRITICAL
	Given User Goes To New Article Site 
	And User Starts Creating Article With 50-50 Division And Mixed Content
	And User Adds Picture to Left Column
	And User Adds Text to Right Column
	When User Submits The New Article
	And User Opens Created Content
	Then Layout Should Not Have Changed

70-30 with original size picture and text
	[Tags]  COLUMNS   CRITICAL
	Given User Goes To New Article Site
	And User Starts Creating Article With 70-30 Division And Mixed Content
	And User Adds Original Picture to Left Column
	And Picture on Left Has Original Aspect Ratio Enabled
	And User Adds Text to Right Column
	When User Submits The New Article
	And User Opens Created Content
	Then Layout Should Not Have Changed

Finnish English Swedish Translations
	[Tags]  COLUMNS   CRITICAL
	Given User Creates Article With 50-50 Division And Mixed Content in Finnish Language
	And User Creates Article With 50-50 Division And Mixed Content in English Language
	And User Creates Article With 50-50 Division And Mixed Content in Swedish Language
	Then Page Should Have Finnish Translation
	And Page Should Have English Translation
	And Page Should Have Swedish Translation

*** Keywords ***
User Goes To New Article Site  Go To New Article Site

User Creates ${pagetype} With ${division} Division And ${contenttype} Content in ${lang_selection} Language
	Create ${pagetype} With ${division} Division And ${contenttype} Content in ${lang_selection} Language

User Starts Creating ${pagetype} With ${division} Division And ${contenttype} Content
	Create ${pagetype} With ${division} Division And ${contenttype} Content

User Adds ${content} to Left Column
	${content}=  Convert To Lower Case   ${content}
	Add ${content} to Left Column

User Adds ${content} to Right Column	Add ${content} to Right Column

User Adds Link Button With ${linkstyle} Style into ${side} Column
	Set Test Variable   ${linkstyle}   ${linkstyle}
	${side}=  Convert To Lower Case   ${side}
	Run Keyword If  '${side}'=='right'  Add Link to Right Column
	Run Keyword If  '${side}'=='left'  Add Link to Left Column

User Opens Created Content
	 Open Created Content
	 Columns.Take Screenshot Of Content
	
User Submits The New Article
	Submit The New Article
	
Picture on ${side} Has Original Aspect Ratio Enabled	Use Original Aspect Ratio on ${side}

Layout Should Not Have Changed
	${excludeneeded}=  Image Comparison Needs To Exclude Areas
	@{arealist}=  Run Keyword If   ${excludeneeded}    Add Excluded Areas To List
	${contenttype}=  Convert To Lower Case   ${contenttype}
	${originalpic} =  Set Variable If  
	...  '${contenttype}'=='picture'   ${SCREENSHOTS_PATH}/${BROWSER}/${language}_short_ARTICLE_COLUMNS_${division}_picture_${picsize}_${BROWSER}.png
	...	 '${linkstyle}'!='${EMPTY}'   ${SCREENSHOTS_PATH}/${BROWSER}/${language}_short_ARTICLE_COLUMNS_${division}_left_${content1}_right_${content2}_${linkstyle}_${BROWSER}.png
	...  '${contenttype}'=='mixed'   ${SCREENSHOTS_PATH}/${BROWSER}/${language}_short_ARTICLE_COLUMNS_${division}_left_${content1}_right_${content2}_${picsize}_${BROWSER}.png
	...   ${SCREENSHOTS_PATH}/${BROWSER}/${language}_short_ARTICLE_COLUMNS_${division}_text_${BROWSER}.png
	${comparisonpic}=  Set Variable  ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}.png
	Copy Original Screenshot To Reports Folder   ${originalpic}
	Run Keyword If  ${excludeneeded}   Compared Pictures Match   ${originalpic}    ${comparisonpic}    ${arealist}
	Run Keyword Unless   ${excludeneeded}   Compared Pictures Match   ${originalpic}    ${comparisonpic}

Page Should Have ${lang_input} Translation
	Set Language Pointer   ${lang_input}
	Select Language   ${lang_input}
	Article Content Matches Language

			

		