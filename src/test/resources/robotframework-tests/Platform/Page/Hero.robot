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
	Given User Starts Creating a Left Aligned Page With Hero Block
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed	

Center Aligned
	[Tags]  HERO   
	Given User Starts Creating a Center Aligned Page With Hero Block
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed	

Left Aligned Picture
	[Documentation]   Left Aligned Hero Block with Picture
	[Tags]  HERO    CRITICAL   
	Given User Starts Creating Hero Block Page with Left Picture
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed	

Right Aligned Picture
	[Tags]  HERO
	Given User Starts Creating Hero Block Page with Right Picture
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed
	
Bottom Aligned Picture
	[Tags]  HERO
	Given User Starts Creating Hero Block Page with Bottom Picture
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed
	
Background Picture
	[Tags]  HERO
	Given User Starts Creating Hero Block Page with Background Picture
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed			

Diagonal Picture
	[Tags]  HERO
	Given User Starts Creating Hero Block Page with Diagonal Picture
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed	

Fullcolor Link
	[Documentation]   Adds Left aligned page and a link with Fullcolor styling option selected
	[Tags]   HERO    CRITICAL
	Given User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Hero Link Button With Fullcolor Style
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed

Framed Link
	[Tags]   HERO
	Given User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Hero Link Button With Framed Style
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed

Transparent Link
	[Tags]   HERO 
	Given User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Hero Link Button With Transparent Style
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed

Gold Background Color
	[Documentation]   Left Aligned Hero Block with Background Color selection 'Gold' 
	[Tags]   HERO    CRITICAL 
	Given User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Gold As Background Color
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed

Silver Background Color
	[Tags]   HERO
	Given User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Silver As Background Color
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed
	
Brick Background Color
	[Tags]   HERO
	Given User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Brick As Background Color
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed
	
Bus Background Color
	[Tags]   HERO
	Given User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Bus As Background Color
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed
	
Copper Background Color
	[Tags]   HERO
	Given User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Copper As Background Color
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed
	
Engel Background Color
	[Tags]   HERO
	Given User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Engel As Background Color
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed
	
Fog Background Color
	[Tags]   HERO
	Given User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Fog As Background Color
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed
	
Metro Background Color
	[Tags]   HERO
	Given User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Metro As Background Color
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed
	
Summer Background Color
	[Tags]   HERO
	Given User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Summer As Background Color
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed
	
Suomenlinna Background Color
	[Tags]   HERO
	Given User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Suomenlinna As Background Color
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed
	
Tram Background Color
	[Tags]   HERO
	Given User Starts Creating a Left Aligned Page With Hero Block
	And User Adds Tram As Background Color
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed

   
*** Keywords ***
 
User Starts Creating a ${value} Aligned Page With Hero Block 
	Set Test Variable   ${value}    ${value} 
	Go To New Page Site
	
	Input Title  Test Automation: ${value} Aligned Hero Block Page
	
	Click Element   ${Swh_HeroOnOff}
	Wait Until Keyword Succeeds  5x  100ms  Focus   ${Ddn_Hero_Alignment}
	Wait Until Keyword Succeeds  5x  100ms  Run Keyword If  '${value}'=='Center'  Click Element   ${Ddn_Hero_Alignment}
	Run Keyword If  '${value}'=='Center'  Click Element   ${Opt_Hero_Alignment_Center} 
	Wait Until Keyword Succeeds  5x  100ms  Input Text  ${Inp_Hero_Title}   Juhani Aho: Rautatie
	
	${TextFileContent}=  Get File  ${CONTENT_PATH}/text_content_short_fi.txt
	${TextFileDescription}=  Get File  ${CONTENT_PATH}/text_description_short_fi.txt
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
	Input Text   ${Inp_Hero_Link_Title}    Tietoa teoksesta
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
	Input Text To Frame   ${Frm_Content_Description}   //body   ${description}

User Submits The New Page
	Submit Page
		
		
	
User Opens Created Content
	Open Test Automation Created Content

Layout Should Not Have Changed
	${originalpic} =  Set Variable If
...  '${picalign}'!='${EMPTY}'  ${SCREENSHOTS_PATH}/${BROWSER}/fi_short_HERO_${picalign}_vaakuna_${picture}_${BROWSER}.png
...  '${linkstyle}'!='${EMPTY}'  ${SCREENSHOTS_PATH}/${BROWSER}/fi_short_HERO_left_vaakuna_nopicture_${linkstyle}link_${BROWSER}.png
...  '${color}'!='${EMPTY}'  ${SCREENSHOTS_PATH}/${BROWSER}/fi_short_HERO_left_${color}_nopicture_${BROWSER}.png
...   ${SCREENSHOTS_PATH}/${BROWSER}/fi_short_HERO_${value}_vaakuna_nopicture_${BROWSER}.png
	${comparisonpic}=  Set Variable  ${REPORTS_PATH}/${BROWSER}_TESTRUN-${TEST NAME}.png
	Compared Pictures Match   ${originalpic}    ${comparisonpic}
	

	
	