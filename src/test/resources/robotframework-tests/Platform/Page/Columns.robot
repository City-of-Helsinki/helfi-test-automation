*** Settings ***
Documentation   Testing Columns Settings in Platform by comparing layout to default picture. Testing is performed with
...				Different text deviation like 50-50, 30-70 and with pictures and links added.
Resource        ../../../robotframework-keywords/platform/Commonkeywords.robot
Resource        ../../../robotframework-keywords/platform/Page.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	

*** Variables ***


*** Test Cases ***
50-50
	[Tags]  COLUMNS   CRITICAL   TODO
	Given User Goes To New Page -Site
	And User Starts Creating a Page With 50-50 Division And Text Content
	And User Adds Text to Left Column
	And User Adds Text to Right Column
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed	
	
30-70
	[Tags]  COLUMNS
	Given User Goes To New Page -Site 
	And User Starts Creating a Page With 30-70 Division And Text Content
	And User Adds Text to Left Column
	And User Adds Text to Right Column
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed	

70-30
	[Tags]  COLUMNS
	Given User Goes To New Page -Site
	And User Starts Creating a Page With 70-30 Division And Text Content
	And User Adds Text to Left Column
	And User Adds Text to Right Column
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed	

50-50 with picture
	[Tags]  COLUMNS   CRITICAL
	Given User Goes To New Page -Site  
	And User Starts Creating a Page With 50-50 Division And Picture Content
	And User Adds Picture to Left Column
	And User Adds Picture to Right Column
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed	

50-50 with picture and text
	[Tags]  COLUMNS   CRITICAL
	Given User Goes To New Page -Site 
	And User Starts Creating a Page With 50-50 Division And Mixed Content
	And User Adds Picture to Left Column
	And User Adds Text to Right Column
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed

70-30 with original size picture and text
	[Tags]  COLUMNS   CRITICAL
	Given User Goes To New Page -Site
	And User Starts Creating a Page With 70-30 Division And Mixed Content
	And User Adds Original Picture to Left Column
	And Picture on Left Has Original Aspect Ratio Enabled
	And User Adds Text to Right Column
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed

50-50 with text and fullcolor link
	[Tags]  COLUMNS   CRITICAL
	Given User Goes To New Page -Site
	And User Starts Creating a Page With 50-50 Division And Mixed Content
	And User Adds Text to Left Column
	And User Adds Link Button With Fullcolor Style into Right Column
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed

50-50 With Text And Transparent Link
	[Tags]  COLUMNS
	Given Given User Goes To New Page -Site
	And User Starts Creating a Page With 50-50 Division And Mixed Content
	And User Adds Text to Left Column
	And User Adds Link Button With Transparent Style into Right Column
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed

50-50 With Text And Framed Link
	[Tags]  COLUMNS 
	Given User Goes To New Page -Site
	And User Starts Creating a Page With 50-50 Division And Mixed Content
	And User Adds Text to Left Column
	And User Adds Link Button With Framed Style into Right Column
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed

Finnish English Swedish Translations
	[Tags]  COLUMNS   CRITICAL
	Given User Creates a Page With 50-50 Division And Mixed Content in Finnish Language
	And User Creates a Page With 50-50 Division And Mixed Content in English Language
	And User Creates a Page With 50-50 Division And Mixed Content in Swedish Language
	Then Page Should Have Finnish Translation
	And Page Should Have English Translation
	And Page Should Have Swedish Translation

*** Keywords ***
User Goes To New Page -Site		Go To New Page Site

Input Content Header Title
	[Arguments]   ${content}
	Input Text To Frame   css:#cke_1_contents > iframe   //body   ${content}
	

User Starts Creating a Page With ${division} Division And ${contenttype} Content
 	Set Test Variable  ${contenttype}   ${contenttype}
	Set Test Variable   ${division}   ${division}
	Input Title  Test Automation: ${TEST NAME}
	${headertitle}=  Get File  ${CONTENT_PATH}/text_description_short_${language}.txt
	Input Content Header Title  ${headertitle}
	Wait Until Element Is Clickable   ${Ddn_AddContent}   timeout=3
	Focus   ${Ddn_AddContent}
	Run Keyword If  '${language}'=='fi'  Click Element	${Ddn_AddContent}
	Run Keyword If  '${language}'=='fi'  Click Element   ${Opt_AddColumns}
	${title}=  Return Correct Title   ${language}
	Wait Until Keyword Succeeds  5x  100ms  Input Text   ${Inp_Column_Title}   ${title}
	Click Element    ${Ddn_Column_Style}
	Click Element With Value   '${division}'

User Creates a Page With ${division} Division And ${contenttype} Content in ${lang_selection} Language
	${language_pointer}=   Get Language Pointer   ${lang_selection}
	Set Test Variable   ${language}   ${language_pointer}
	Run Keyword If  '${lang_selection}'=='Finnish'  Go To New Page Site
	Run Keyword If  '${lang_selection}'!='Finnish'  Go To New Page -View For ${lang_selection} Translation
	User Starts Creating a Page With ${division} Division And ${contenttype} Content
	Run Keyword If  '${lang_selection}'=='Finnish'  User Adds Picture to Left Column
	Run Keyword If  '${lang_selection}'=='Finnish'  Add Picture Caption to Left
	Run Keyword If  '${lang_selection}'!='Finnish'  Add Picture Caption to Left
	Run Keyword If  '${lang_selection}'=='Finnish'  User Adds Text to Right Column
	Run Keyword If  '${lang_selection}'!='Finnish'	Add Text Content To Column on Right
	User Submits The New Page
	User Opens Created Content

Go To New Page -View For ${language} Translation
	Go To Translate Selection Page
	Go To ${language} Translation Page

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

Return Correct Title
	[Arguments]     ${language}
	${title}=	Set Variable If  '${language}'=='fi'  Juhani Aho: Rautatie
	...				'${language}'=='en'  Emily Bronte: Wuthering Heights
	...		 		'${language}'=='sv'  Selma Lagerlof: Bannlyst
	[Return]		${title}

Layout Should Not Have Changed
	${contenttype}=  Convert To Lower Case   ${contenttype}
	${originalpic} =  Set Variable If  
	...  '${contenttype}'=='picture'   ${SCREENSHOTS_PATH}/${BROWSER}/${language}_short_COLUMNS_${division}_picture_${picsize}_${BROWSER}.png
	...	 '${linkstyle}'!='${EMPTY}'   ${SCREENSHOTS_PATH}/${BROWSER}/${language}_short_COLUMNS_${division}_left_${content1}_right_${content2}_${linkstyle}_${BROWSER}.png
	...  '${contenttype}'=='mixed'   ${SCREENSHOTS_PATH}/${BROWSER}/${language}_short_COLUMNS_${division}_left_${content1}_right_${content2}_${picsize}_${BROWSER}.png
	...   ${SCREENSHOTS_PATH}/${BROWSER}/${language}_short_COLUMNS_${division}_text_${BROWSER}.png
	${comparisonpic}=  Set Variable  ${REPORTS_PATH}/${BROWSER}_TESTRUN-${TEST NAME}_${language}.png
	Compared Pictures Match   ${originalpic}    ${comparisonpic}

Page Should Have ${lang_input} Translation
	Set Language Pointer   ${lang_input}
	Select Language   ${lang_input}
	Page Content Matches Language

Return Title From Page
	${title}=	Get Text    ${Txt_Column_Title}
	[Return]		${title}

Return Description From Page
	${description}=	Get Text    ${Txt_Column_Description}
	[Return]		${description}

Return Content From Page
	${content}=	Get Text    ${Txt_Column_Content}
	[Return]		${content}

Page Content Matches Language
	${Title}=  Return Title From Page
	${Description}=  Return Description From Page
	${Content}=  Return Content From Page
	Title Should Match Current Language Selection   ${Title}
	Description Should Match Current Language Selection   ${Description}	
	Content Should Match Current Language Selection   ${Content}
			
Title Should Match Current Language Selection
	[Arguments]   ${string}
	${string}=   Encode String To Bytes   ${string}   UTF-8
	Run Keyword If  '${language}'=='fi'  Should Match   ${string.replace('\xc2\xad', '')}	Juhani Aho: Rautatie
	Run Keyword If  '${language}'=='en'  Should Match   ${string.replace('\xc2\xad', '')}   Emily Bronte: Wuthering Heights
	Run Keyword If  '${language}'=='sv'  Should Match   ${string.replace('\xc2\xad', '')}   Selma Lagerlof: Bannlyst  

Description Should Match Current Language Selection
	[Arguments]   ${string}
	Run Keyword If  '${language}'=='fi'  Should Match Regexp  ${string}   "Rautatie" on Juhani Ahon
	Run Keyword If  '${language}'=='en'  Should Match Regexp  ${string}   In the late winter months
	Run Keyword If  '${language}'=='sv'  Should Match Regexp  ${string}   Sven Elversson var nära att dö under en nordpolsexpedtion

Content Should Match Current Language Selection
	[Arguments]   ${string}
	Run Keyword If  '${language}'=='fi'  Should Match Regexp  ${string}   Viittatie teki niemen nenässä polvekkeen
	Run Keyword If  '${language}'=='en'  Should Match Regexp  ${string}   If all else perished, and he remained
	Run Keyword If  '${language}'=='sv'  Should Match Regexp  ${string}   Det är bara synd, att han inte är	