*** Settings ***
Resource        ../Contenthandler.robot
Resource        ../Commonkeywords.robot

*** Keywords ***
Set Article Spesific Values
	Input Author   Test Automation Author
	${ingress}=  Get File  ${CONTENT_PATH}/text_ingress_${language}.txt
	Input Lead   ${ingress}
	
Create ${pagetype} With ${division} Division And ${contenttype} Content
 	Set Test Variable  ${contenttype}   ${contenttype}
 	Input Title  Test Automation: ${TEST NAME}
 	Run Keyword If  '${pagetype}'=='Article'   Set Article Spesific Values
	Set Test Variable   ${division}   ${division}
	${headertitle}=  Get File  ${CONTENT_PATH}/text_description_short_${language}.txt
	Input Content Header Title  ${headertitle}
	Wait Until Element Is Visible   ${Ddn_AddContent}   timeout=3
	Focus   ${Ddn_AddContent}
	Run Keyword If  '${language}'=='fi'  Click Element	${Ddn_AddContent}
	Run Keyword If  '${language}'=='fi'  Click Element   ${Opt_AddColumns}
	${title}=  Return Correct Title   ${language}
	Wait Until Keyword Succeeds  5x  100ms  Input Text   ${Inp_Column_Title}   ${title}
	Click Element With Value   '${division}'

Create ${pagetype} With ${division} Division And ${contenttype} Content in ${lang_selection} Language
	${language_pointer}=   Get Language Pointer   ${lang_selection}
	Set Test Variable   ${language}   ${language_pointer}
	Run Keyword If  '${lang_selection}'=='Finnish'  Go To New ${pagetype} Site
	Run Keyword If  '${lang_selection}'!='Finnish'  Go To New ${pagetype} -View For ${lang_selection} Translation
	User Starts Creating ${pagetype} With ${division} Division And ${contenttype} Content
	Run Keyword If  '${lang_selection}'=='Finnish'  User Adds Picture to Left Column
	Add Picture Caption to Left
	Run Keyword If  '${lang_selection}'=='Finnish'  User Adds Text to Right Column
	Run Keyword If  '${lang_selection}'!='Finnish'	Add Text Content To Column on Right
	Submit The New ${pagetype}
	Open Created Content
	Take Screenshot Of Content

Add ${linkstyle} Link To ${side} Column
	${linkstyle}=  Remove String And Strip Text   ${linkstyle}   "
	Wait Until Element Is Clickable  ${Opt_Column_${side}_AddContent_Link}   timeout=3
	Click Element  ${Opt_Column_${side}_AddContent_Link}
	Wait Until Keyword Succeeds  5x  100ms  Input Text   ${Inp_Column_${side}_Link_URL}   https://fi.wikipedia.org/wiki/Rautatie_(romaani)    
	Input Text   ${Inp_Column_${side}_Link_Title}    ${link_title_${language}}
	Click Element  ${Ddn_Column_${side}_Link_Design}
	Run Keyword If  '${linkstyle}'=='Fullcolor'  Click Element   ${Opt_Column_${side}_Link_ButtonFullcolor}
	Run Keyword If  '${linkstyle}'=='Framed'  Click Element   ${Opt_Column_${side}_Link_ButtonFramed}
	Run Keyword If  '${linkstyle}'=='Transparent'  Click Element   ${Opt_Column_${side}_Link_ButtonTransparent}
	
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
	Focus   ${Btn_Column_${side}_Picture}
	Wait Until Keyword Succeeds  10x  500ms  Click Element  ${Btn_Column_${side}_Picture}
	Wait Until Keyword Succeeds  10x  500ms  Choose File   ${Btn_File_Upload}   ${IMAGES_PATH}/${selection}.jpg
	Wait Until Keyword Succeeds  10x  500ms  Input Text    ${Inp_Pic_Name}   ${pictitle}
	Input Text    ${Inp_Pic_AltText}   ${picdescription} 
	Input Text    ${Inp_Pic_Photographer}   ${pgrapher}
	Click Button   ${Btn_Save}
	Set Test Variable  ${picsadded}    ${picsadded}+1
	Set Test Variable  ${picture}    picture   
	Wait Until Keyword Succeeds  10x  500ms  Click Button   ${Btn_Insert_Pic}
	Wait Until Keyword Succeeds  10x  500ms   Add Picture Caption to ${side}  
	

Add Picture Caption to ${side}
	${editpicturevisible}=  Run Keyword And Return Status    Element Should Not Be Visible  ${Btn_Column_${side}_Edit}   timeout=1
	Run Keyword Unless   ${editpicturevisible}   Wait Until Keyword Succeeds  5x  200ms  Click Element   ${Btn_Column_${side}_Edit}
	Run Keyword If  '${side}'=='Left'	Wait Until Keyword Succeeds  5x  200ms  Input Text    ${Inp_Column_Left_Picture_Caption}   ${pic_1_caption_${language}}
	Run Keyword If  '${side}'=='Right'	Wait Until Keyword Succeeds  5x  200ms  Input Text    ${Inp_Column_Right_Picture_Caption}   ${pic_2_caption_${language}}


Use Original Aspect Ratio on ${side}
	#Element is behind another. --> Scroll it into view so we can click it
	${containspage}=    Suite Name Contains Text   Page
	Run Keyword If   ${containspage}   Execute javascript  window.scrollTo(0, 400)
	Focus   ${Swh_Column_${side}_Picture_Orig_Aspect_Ratio}
	Wait Until Keyword Succeeds  5x  200ms  Click Element   ${Swh_Column_${side}_Picture_Orig_Aspect_Ratio}
	Set Test Variable  ${picsize}   original
	
Click And Select Text As ${side} Content Type
	Wait Until Element Is Clickable  ${Opt_Column_${side}_AddContent_Text}   timeout=3
	Wait Until Keyword Succeeds  10x  500ms  Click Element  ${Opt_Column_${side}_AddContent_Text}

Add Text Content To Column on ${side}
	[Documentation]   Adds text content to selected column by selecting content type first and then inserting text
	Run Keyword If  '${language}'=='fi'  Click And Select Text As ${side} Content Type
	${TextFileContent}=  Get File  ${CONTENT_PATH}/text_content_short_${language}.txt
	@{content} =	Split String	${TextFileContent}   .,.
	${content_left}=  Get From List  ${content}   0
	${content_right}=  Get From List  ${content}   1
	${content_text}=  Set Variable If
	... 	 '${side}'=='Left'	${content_left}
	... 	 '${side}'=='Right'	${content_right}
	${editpicturevisible}=  Run Keyword And Return Status    Element Should Not Be Visible  ${Btn_Column_${side}_Edit}   timeout=1
	Run Keyword Unless   ${editpicturevisible}   Wait Until Keyword Succeeds  5x  200ms  Click Element   ${Btn_Column_${side}_Edit}
	Wait Until Keyword Succeeds  10x  500ms  Input Text To Frame   ${Frm_Column_${side}_Text}   //body   ${content_text}

Add ${content} to Left Column
	[Documentation]  Here we need to do some tricks in case picture tests original size. Content -string is modified
	...				 so that picture compare assertion works. Also long, snowdrops picture is used in the case because
	...				 pictures with longer width value does not get cropped. Only long pictures do.
	Focus   ${Ddn_Column_Left_AddContent}
	Wait Until Keyword Succeeds  5x  100ms  Click Button  ${Ddn_Column_Left_AddContent}
	Run Keyword If  '${content}'=='picture'  Add Picture to Column   Left    train   @{pic_1_texts_${language}}
	Run Keyword If  '${content}'=='original picture'  Add Picture to Column   Left    snowdrops   @{pic_1_texts_${language}}
	Run Keyword If  '${content}'=='text'  Add Text Content To Column on Left
	Run Keyword If  ('${content}'=='picture') & ('${language}'=='fi')  Add Picture Caption to Left
	${content}=  Remove String And Strip Text   ${content}   original
	Set Test Variable  ${content1}   ${content}
  

Add ${content:[^"]+} to Right Column
	[Documentation]   Adds given content to Right column.
	Set Test Variable  ${content2}   ${content}
	Wait Until Element Is Clickable  ${Ddn_Column_Right_AddContent}   timeout=3
	Focus   ${Ddn_Column_Right_AddContent}
	Wait Until Keyword Succeeds  10x  500ms  Click Button  ${Ddn_Column_Right_AddContent}
	Run Keyword If  '${content}'=='Picture'  Add Picture to Column   Right    temple   @{pic_2_texts_${language}}
	Run Keyword If  '${content}'=='Text'  Add Text Content To Column on Right
	Run Keyword If  '${content}'=='Link'  Add "${linkstyle}" Link To Right Column


Take Screenshot Of Content
	Maximize Browser Window
	Execute javascript  document.body.style.zoom="40%"
	Run keyword if  ('${picsize}'=='original') & ('${BROWSER}'=='chromeheadless')   Execute javascript  document.body.style.zoom="30%"
	Capture Page Screenshot    filename=${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}.png
	Execute javascript  document.body.style.zoom="100%"

${pagetype} Content Matches Language
	${Title}=  Return Title From ${pagetype}
	${Description}=  Return Description From ${pagetype}
	${Content}=   Return Content From ${pagetype}
	${Lead}=  Run Keyword If  '${pagetype}'=='Article'  Return Lead From Article
	${Author}=  Run Keyword If  '${pagetype}'=='Article'   Return Author From Article
	Title Should Match Current Language Selection   ${Title}
	Description Should Match Current Language Selection   ${Description}	
	Content Should Match Current Language Selection   ${Content}
	Run Keyword If  '${pagetype}'=='Article'  Lead Should Match Current Language Selection   ${Lead}
	Run Keyword If  '${pagetype}'=='Article'  Author Should Be Correct   ${Author}
	
Return Title From ${pagetype}
	${title}=	Get Text    ${Txt_Column_Title}
	[Return]		${title}

Return Description From ${pagetype}
	${description}=	Get Text    ${Txt_Column_Description}
	[Return]		${description}

Return Content From ${pagetype}
	${content}=	Get Text    ${Txt_Column_Content}
	[Return]		${content}
	
Return Lead From Article
	${lead}=	Get Text    ${Txt_Lead}
	[Return]		${lead}

Return Author From Article
	${author}=	Get Text    ${Txt_Author}
	[Return]		${author}
	
Lead Should Match Current Language Selection
	[Arguments]   ${string}
	Run Keyword If  '${language}'=='fi'  Should Match Regexp  ${string}   Ingressi eli johdate on tekstin
	Run Keyword If  '${language}'=='en'  Should Match Regexp  ${string}   A lead paragraph
	Run Keyword If  '${language}'=='sv'  Should Match Regexp  ${string}   Ingressen är den inledande delen av en artikel

Author Should Be Correct
	[Arguments]   ${string}
	Should Match Regexp  ${string}   Test Automation Author