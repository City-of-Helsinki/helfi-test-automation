*** Settings ***
Documentation   Testing Hero Block Settings in Platform. Tests are created with different text alignatiotions like
...				Left, Center. For pictures there are more alignation options. Also differentlink icon styles are 
...				tested with default pictureless layout. Also Background color options are tested in several testcases
Resource        ../../../robotframework-keywords/platform/Commonkeywords.robot
Resource        ../../../robotframework-keywords/platform/Page.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	

*** Variables ***
${color}	 		 ${EMPTY}

*** Test Cases ***

Left Aligned
	[Documentation]   Left Aligned Hero Block with Short version of text files in Finnish. 'Vaakuna' style.
	[Tags]   HERO    CRITICAL
	Given User Goes To New Page -Site
	And User Starts Creating a Left Aligned Page With Hero Block
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed	

Center Aligned
	[Tags]  HERO   
	Given User Goes To New Page -Site
	And User Starts Creating a Center Aligned Page With Hero Block
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed	

Left Aligned Picture
	[Documentation]   Left Aligned Hero Block with Picture
	[Tags]  HERO    CRITICAL
	Given User Goes To New Page -Site
	And User Starts Creating Hero Block Page with Left Picture
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed	

Right Aligned Picture
	[Tags]  HERO
	Given User Goes To New Page -Site
	And User Starts Creating Hero Block Page with Right Picture
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed
	
Bottom Aligned Picture
	[Tags]  HERO
	Given User Goes To New Page -Site
	And User Starts Creating Hero Block Page with Bottom Picture
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed
	
Background Picture
	[Tags]  HERO
	Given User Goes To New Page -Site
	And User Starts Creating Hero Block Page with Background Picture
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed			

Diagonal Picture
	[Tags]  HERO
	Given User Goes To New Page -Site
	And User Starts Creating Hero Block Page with Diagonal Picture
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed	

Fullcolor Link
	[Documentation]   Adds Left aligned page and a link with Fullcolor styling option selected
	[Tags]   HERO    CRITICAL
	Given User Goes To New Page -Site
	And User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Hero Link Button With Fullcolor Style
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed

Framed Link
	[Tags]   HERO
	Given User Goes To New Page -Site
	And User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Hero Link Button With Framed Style
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed

Transparent Link
	[Tags]   HERO 
	Given User Goes To New Page -Site
	And User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Hero Link Button With Transparent Style
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed

Gold Background Color
	[Documentation]   Left Aligned Hero Block with Background Color selection 'Gold' 
	[Tags]   HERO    CRITICAL 
	Given User Goes To New Page -Site
	And User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Gold As Background Color
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed

Silver Background Color
	[Tags]   HERO
	Given User Goes To New Page -Site
	And User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Silver As Background Color
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed
	
Brick Background Color
	[Tags]   HERO
	Given User Goes To New Page -Site
	And User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Brick As Background Color
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed
	
Bus Background Color
	[Tags]   HERO
	Given User Goes To New Page -Site
	And User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Bus As Background Color
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed
	
Copper Background Color
	[Tags]   HERO
	Given User Goes To New Page -Site
	And User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Copper As Background Color
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed
	
Engel Background Color
	[Tags]   HERO
	Given User Goes To New Page -Site
	And User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Engel As Background Color
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed
	
Fog Background Color
	[Tags]   HERO
	Given User Goes To New Page -Site
	And User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Fog As Background Color
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed
	
Metro Background Color
	[Tags]   HERO
	Given User Goes To New Page -Site
	And User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Metro As Background Color
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed
	
Summer Background Color
	[Tags]   HERO
	Given User Goes To New Page -Site
	And User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Summer As Background Color
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed
	
Suomenlinna Background Color
	[Tags]   HERO
	Given User Goes To New Page -Site
	And User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Suomenlinna As Background Color
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed
	
Tram Background Color
	[Tags]   HERO
	Given User Goes To New Page -Site
	And User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Tram As Background Color
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed

English Swedish Translations
	[Tags]   HERO   CRITICAL
	Given User Creates a Left Aligned Page With Hero Block In Finnish Language
	And User Creates a Left Aligned Page With Hero Block In English Language
	And User Creates a Left Aligned Page With Hero Block In Swedish Language
	Then Page Should Have Finnish Translation
	And Page Should Have English Translation
	And Page Should Have Swedish Translation
	
	
	
   
*** Keywords ***
Return Correct Title
	[Arguments]     ${language}
	${title}=	Set Variable If  '${language}'=='fi'  Juhani Aho: Rautatie
	...				'${language}'=='en'  Emily Bronte: Wuthering Heights
	...		 		'${language}'=='sv'  Selma Lagerlof: Bannlyst
	[Return]		${title}

Return Correct Description
	[Arguments]     ${language}
	${description}=	Get File  ${CONTENT_PATH}/text_description_short_${language}.txt
	[Return]		${description}

Return Correct Content
	[Arguments]     ${language}
	${content}=	Get File  ${CONTENT_PATH}/text_content_short_${language}.txt
	[Return]		${content}

Return Title From Page
	${title}=	Get Text    ${Txt_Hero_Title}
	[Return]		${title}

Return Description From Page
	${description}=	Get Text    ${Txt_Hero_Description}
	[Return]		${description}

Return Content From Page
	${content}=	Get Text    ${Txt_Content}
	[Return]		${content}

 
User Creates a ${value} Aligned Page With Hero Block In ${lang_selection} Language
	${language_pointer}=   Get Language Pointer   ${lang_selection}
	Set Test Variable   ${language}   ${language_pointer}
	Run Keyword If  '${lang_selection}'=='Finnish'  User Goes To New Page -Site
	Run Keyword If  '${lang_selection}'!='Finnish'  Go To New Page -View For ${lang_selection} Translation
	User Starts Creating a Left Aligned Page With Hero Block
	User Submits The New Page
	User Opens Created Content

Go To New Page -View For ${language} Translation
	Go To Translate Selection Page
	Go To ${language} Translation Page

User Goes To New Page -Site
	Go To New Page Site
 
Input Title To Hero Block
	${title}=  Return Correct Title   ${language}
	Input Text  ${Inp_Hero_Title}   ${title}
 
User Starts Creating a ${value} Aligned Page With Hero Block 
	Set Test Variable   ${value}    ${value} 
    Input Title  Test Automation: ${value} Aligned Hero Block Page
	${titleisvisible}=  Run Keyword And Return Status   Element Should Be Enabled   ${Inp_Hero_Title}
	Run Keyword Unless  ${titleisvisible} 	Click Element   ${Swh_HeroOnOff}
	Wait Until Keyword Succeeds  5x  100ms  Focus   ${Ddn_Hero_Alignment}
	Wait Until Keyword Succeeds  5x  100ms  Run Keyword If  '${value}'=='Center'  Click Element   ${Ddn_Hero_Alignment}
	Run Keyword If  '${value}'=='Center'  Click Element   ${Opt_Hero_Alignment_Center} 
	Wait Until Keyword Succeeds  5x  100ms   Input Title To Hero Block
		
	${TextFileContent}=  Return Correct Content   ${language}
	${TextFileDescription}=  Return Correct Description   ${language}
	Input Text Content   ${TextFileContent}
	Input Hero Description   ${TextFileDescription}

User Starts Creating Hero Block Page with ${picalign} Picture 
	User Starts Creating a Left Aligned Page With Hero Block
    Set Test Variable   ${picture}  picture
    Set Test Variable   ${picalign}   ${picalign}    
	Run Keyword If  '${picalign}'=='Left'  Click Element   ${Opt_Hero_Picture_On_Left}
	Run Keyword If  '${picalign}'=='Right'  Click Element   ${Opt_Hero_Picture_On_Right}
	Run Keyword If  '${picalign}'=='Bottom'  Click Element   ${Opt_Hero_Picture_On_Bottom}
	Run Keyword If  '${picalign}'=='Background'  Click Element   ${Opt_Hero_Picture_On_Background}
	Run Keyword If  '${picalign}'=='Diagonal'  Click Element   ${Opt_Hero_Diagonal}
	Wait Until Keyword Succeeds  5x  100ms  Focus   ${Btn_Hero_Picture}
	Wait Until Keyword Succeeds  5x  100ms  Click Button   ${Btn_Hero_Picture}
	Wait Until Keyword Succeeds  5x  100ms  Choose File   ${Btn_File_Upload}   ${IMAGES_PATH}/train.jpg
	Wait Until Keyword Succeeds  5x  100ms  Focus  ${Inp_Pic_Name}
	Input Text    ${Inp_Pic_Name}   Juna sillalla
	Input Text    ${Inp_Pic_AltText}   Vanha juna kuljettaa matkustajia 
	Input Text    ${Inp_Pic_Photographer}   Testi Valokuvaaja
	Click Button   ${Btn_Save_Pic}
	Wait Until Keyword Succeeds  5x  100ms  Click Button   ${Btn_Insert_Pic}
	Wait Until Element Is Visible  //input[@data-drupal-selector='edit-field-hero-0-subform-field-hero-image-selection-0-remove-button']   timeout=3
	Set Test Variable  ${picsadded}    ${picsadded}+1   



User Adds Hero Link Button With ${style} Style
	Set Test Variable   ${linkstyle}  ${style}
	Click Button   ${Btn_Hero_AddLink}
	Wait Until Keyword Succeeds  5x  100ms  Input Text   ${Inp_Hero_Link_URL}   https://fi.wikipedia.org/wiki/Rautatie_(romaani)    
	Input Text   ${Inp_Hero_Link_Title}    ${link_title_${language}}
	Focus   ${Ddn_Hero_Link_Design}
	Click Element  ${Ddn_Hero_Link_Design}
	Run Keyword If  '${style}'=='Fullcolor'  Click Element   ${Opt_Hero_Link_ButtonFullcolor}
	Run Keyword If  '${style}'=='Framed'  Click Element   ${Opt_Hero_Link_ButtonFramed}
	Run Keyword If  '${style}'=='Transparent'  Click Element   ${Opt_Hero_Link_ButtonTransparent}

User Adds ${color} As Background Color
	Set Test Variable   ${color}  ${color}
	Focus    ${Ddn_Hero_Color}
	Click Element   ${Ddn_Hero_Color}
	Click Element With Value   ${color}

Input Hero Description
	[Arguments]   ${description}
	[Documentation]	  Here. In translation cases cke -identifier numbers have changed. Thus some if else is needed.
	Run Keyword If  '${language}'=='fi'	Input Text To Frame   ${Frm_Content_Description}   //body   ${description}
	Run Keyword If  '${language}'!='fi'   Input Text To Frame   ${Frm_Content}   //body   ${description}

User Submits The New Page
	Submit Page
		
User Opens Created Content
	Open Test Automation Created Content

Layout Should Not Have Changed
	${originalpic} =  Set Variable If
...  '${picalign}'!='${EMPTY}'  ${SCREENSHOTS_PATH}/${BROWSER}/${language}_short_HERO_${picalign}_vaakuna_${picture}_${BROWSER}.png
...  '${linkstyle}'!='${EMPTY}'  ${SCREENSHOTS_PATH}/${BROWSER}/${language}_short_HERO_left_vaakuna_nopicture_${linkstyle}link_${BROWSER}.png
...  '${color}'!='${EMPTY}'  ${SCREENSHOTS_PATH}/${BROWSER}/${language}_short_HERO_left_${color}_nopicture_${BROWSER}.png
...   ${SCREENSHOTS_PATH}/${BROWSER}/${language}_short_HERO_${value}_vaakuna_nopicture_${BROWSER}.png
	${comparisonpic}=  Set Variable  ${REPORTS_PATH}/${BROWSER}_TESTRUN-${TEST NAME}_${language}.png
	Compared Pictures Match   ${originalpic}    ${comparisonpic}

Page Should Have ${lang_input} Translation
	Set Language Pointer   ${lang_input}
	Select Language   ${lang_input}
	Page Content Matches Language

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
	Run Keyword If  '${language}'=='fi'  Should Match Regexp  ${string}   Sitä Matti ajatteli
	Run Keyword If  '${language}'=='en'  Should Match Regexp  ${string}   “It is not,” retorted she
	Run Keyword If  '${language}'=='sv'  Should Match Regexp  ${string}   På Grimön i den västra skärgården bodde för några år sedan	


	
	