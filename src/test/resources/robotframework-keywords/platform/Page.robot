*** Settings ***
Documentation   New Page creation spesific keywords here. Variables are
...				Submitted:  Is the new page submitted. This is needed when tearing down creating content after test.
...				Picalign:   Picture alignment value in hero cases.
...				Picture:    Is at least one picture added to content = picture , else 'nopicture'
...				Picsadded:  Number of pictures added to content. This is needed in teardown after test, so all media 
...				gets deleted succesfully.
Resource        Commonkeywords.robot

*** Variables ***
${submitted}								false
${picalign} 		 						${EMPTY}
${picture} 			 						nopicture
${picsadded}								0

*** Keywords ***

Input Title
	[Arguments]   ${title}
	Input Text  ${Inp_Title}   ${title}  
	
Input Text Content
	[Arguments]   ${content}
	Input Text To Frame   ${Frm_Content}   //body   ${content}
	
Select Language
	[Arguments]     ${value}
	[Documentation]  fi = Finnish , sv = Swedish , en = English , ru = Russian
	Click Element  ${Ddn_SelectLanguage}
	Wait Until Keyword Succeeds  5x  200ms  Click Element With Value   ${value}
	
Submit Page
	[Documentation]  User submits new page and it is saved and appears in content view
	Wait Until Keyword Succeeds  5x  100ms  Click Button   ${Btn_Submit}
	Set Test Variable   ${submitted}   true
	
Add Picture to Column
	[Documentation]  Adds picture and fills given content. selection= picture name from images -folder at src/main/
	...			     resources.  side = 'left' of 'right' column  . content = content as list items.    
	[Arguments]     ${side}   ${selection}   @{content}
	Wait Until Element Is Clickable  ${Opt_Column_${side}_AddContent_Image}   timeout=3
	Click Element  ${Opt_Column_${side}_AddContent_Image}
	${pictitle}=  Get From List  ${content}   0
	${picdescription}=  Get From List  ${content}   1
	${pgrapher}=  Get From List  ${content}   2
	Wait Until Element Is Clickable  ${Btn_Column_${side}_Picture}   timeout=3
	Wait Until Keyword Succeeds  10x  500ms  Click Element  ${Btn_Column_${side}_Picture}
	Wait Until Keyword Succeeds  10x  500ms  Choose File   ${Btn_File_Upload}   ${IMAGES_PATH}/${selection}.jpg
	Wait Until Keyword Succeeds  10x  500ms  Input Text    ${Inp_Pic_Name}   ${pictitle}
	Input Text    ${Inp_Pic_AltText}   ${picdescription} 
	Input Text    ${Inp_Pic_Photographer}   ${pgrapher}
	Click Button   ${Btn_Save_Pic}
	Wait Until Keyword Succeeds  10x  500ms  Click Button   ${Btn_Insert_Pic}
	Set Test Variable  ${picsadded}    ${picsadded}+1
	Set Test Variable  ${picture}    picture   
	
Add Text Content To Column on ${side}
	Wait Until Element Is Clickable  ${Opt_Column_${side}_AddContent_Text}   timeout=3
	Wait Until Keyword Succeeds  10x  500ms  Click Element  ${Opt_Column_${side}_AddContent_Text}
	${TextFileContent}=  Get File  ${CONTENT_PATH}/text_content_short_fi.txt
	@{content} =	Split String	${TextFileContent}   .,.
	${content_left}=  Get From List  ${content}   0
	${content_right}=  Get From List  ${content}   1
	${content_text}=  Set Variable If
	... 	 '${side}'=='Left'	${content_left}
	... 	 '${side}'=='Right'	${content_right}
	Wait Until Keyword Succeeds  10x  500ms  Input Text To Frame   ${Frm_Column_${side}_Text}   //body   ${content_text}

Add ${content} to Left Column
	Set Test Variable  ${content1}   ${content}
	Wait Until Keyword Succeeds  5x  100ms  Click Button  ${Ddn_Column_Left_AddContent}
	${content_left}=  Create List  Juna sillalla   Vanha juna kuljettaa matkustajia   Testi Valokuvaaja
	Run Keyword If  '${content}'=='Picture'  Add Picture to Column   left    train   @{content_left}
	Run Keyword If  '${content}'=='Text'  Add Text Content To Column on Left

Add ${content} to Right Column
	Set Test Variable  ${content2}   ${content}
	Wait Until Element Is Clickable  ${Ddn_Column_Right_AddContent}   timeout=3	 
	Wait Until Keyword Succeeds  10x  500ms  Click Button  ${Ddn_Column_Right_AddContent}
	${content_right}=  Create List  Temppeli koreassa   Buddhalaistemppeli talvella Aasiassa   Testi Valokuvaaja2
	Run Keyword If  '${content}'=='Picture'  Add Picture to Column   right    temple   @{content_right}
	Run Keyword If  '${content}'=='Text'  Add Text Content To Column on Right
	
Cleanup and Close Browser
	[Documentation]  Deletes content created by testcases. Page , if created and picture if added.
	Run Keyword If  '${submitted}'!='false'  Wait Until Keyword Succeeds  2x  200ms  Delete Newly Created Item on Content Menu List
	FOR    ${i}    IN RANGE    ${picsadded}
           Wait Until Keyword Succeeds  2x  200ms 	Delete Newly Created Item from Content Media List
    END
	Close Browser	