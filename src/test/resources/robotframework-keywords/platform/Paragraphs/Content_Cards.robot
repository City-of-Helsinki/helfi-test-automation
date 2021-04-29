*** Settings ***

Resource        ../Contenthandler.robot
Resource        ../Commonkeywords.robot

*** Keywords ***

Resolve Card-Size Variable
	[Arguments]  ${card-size}
	${card-size}=  Convert To Lower Case   ${card-size}
	${cardsizevariable}=   Set Variable If   '${card-size}'=='small'    small-cards
	...			'${card-size}'=='large'    large-cards
	...			'${card-size}'=='small grey'    small-cards-grey
	...			'${card-size}'=='large grey'    large-cards-grey
	[Return]   ${cardsizevariable}

Set Article Spesific Values
	Input Author   Test Automation Author
	${ingress}=  Get File  ${CONTENT_PATH}/text_ingress_${language}.txt
	Input Lead   ${ingress}

Create ${pagetype} With ${cardsize} Cards For ${contentname} Content
 	Input Title  Test Automation: ${TEST NAME}
 	Set Test Variable  ${cardsize}  ${cardsize}
 	Run Keyword If  '${pagetype}'=='Article'   Set Article Spesific Values
	${headertitle}=  Get File  ${CONTENT_PATH}/text_description_short_${language}.txt
	${islandingpage}=  Suite Name Contains Text    Landing Page
	Run Keyword Unless  ${islandingpage}   Input Content Header Title  ${headertitle}
	Open Paragraph For Edit   ${Opt_AddContentCards}
	Wait Until Keyword Succeeds  5x  100ms  Input Title To Paragraph   ${Inp_ContentCard_Title}
	${cardsizevalue}=  Resolve Card-Size Variable   ${cardsize}
	Select From List By Value  ${Inp_ContentCard_Design}  ${cardsizevalue}
	Input Text   ${Inp_ContentCard_TargetId}   ${contentname}
	Wait Until Keyword Succeeds  5x  100ms  Click Element   //a[contains(text(),'${contentname}')]
	
Add New ContentCard For ${contentname} Content
	Wait Until Keyword Succeeds  5x  100ms  Click Element  ${Inp_ContentCard_Addnew}
	# Better locators does not match correct element. For some reason only first is returned
	# So Only works for second content card. 
	Wait Until Keyword Succeeds  5x  100ms  Input Text   //input[contains(@data-drupal-selector, 'edit-field-content-1-subform-field-content-cards-content-1-target-id')]   ${contentname}
	
ContentCards Are Working Correctly
	${contentpageurl}=   Get Location
	Click Element   //a[contains(@href, '/fi/linkkiesimerkit')]
	${currenturl}=   Get Location
	Should Contain   ${currenturl}   linkkiesimerkit
	Go To   ${contentpageurl}
	Wait Until Element Is Clickable   //a[contains(@href, '/fi/esimerkkisivu')]
	Click Element   //a[contains(@href, '/fi/esimerkkisivu')]
	${currenturl}=   Get Location
	Should Contain   ${currenturl}   esimerkkisivu
	
	