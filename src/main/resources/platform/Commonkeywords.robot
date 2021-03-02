*** Settings ***
Documentation   Common Keywords referred by many testsuites. Platform side tests only
Library           SeleniumLibrary
Library           OperatingSystem
Resource		  ./variables/create_page.robot
Library 		   helfi.ta.PictureCompare
*** Variables ***
${URL_content_page}							https://helfi.docker.sh/fi/admin/content
${URL_media_page}							https://helfi.docker.sh/fi/admin/content/media							



*** Keywords ***
Get Admin Url
   [Documentation]   Gets URL needed in localhost testing.
   ${admin_url} =   Run  ${ADMIN_URL}
   Set Test Variable   ${admin_url}
   
Login And Go To Content Page
	[Documentation]   Preparatory action for platform tests: User logs in and then navigates to Content('Sisältö')
	...				  page. Also accepts cookies here.
	Get Admin Url
	Open Browser  ${admin_url}  ${BROWSER}
	Go To   ${URL_content_page}

Go To New Article Site
	Click Add Content
	Click Add Article

Go To New Page Site
	Click Add Content
	Click Add Page
	
Select Language
	[Arguments]     ${value}
	[Documentation]  fi = Finnish , sv = Swedish , en = English , ru = Russian
	Click Element  ${Ddn_SelectLanguage}
	Wait Until Keyword Succeeds  5x  200ms  Click Element  //option[contains(@value, '${value}')]


Click Add Content
	[Documentation]   Add Content ('Lisää sisältöä') in Content Menu
	Wait Until Keyword Succeeds  5x  200ms  Click Element  //a[contains(@href, '/fi/node/add')]
   
Click Add Page
	[Documentation]   Add Page ('Sivu') click in Add Content('Lisää sisältöä') -menu
	Wait Until Keyword Succeeds  5x  200ms  Click Element  //a[contains(@href, '/fi/node/add/page')]
	
Click Add Article
	[Documentation]   Add Article ('Artikkeli') click in Add Content('Lisää sisältöä') -menu
	Wait Until Keyword Succeeds  5x  200ms  Click Element  //a[contains(@href, '/fi/node/add/article')]
	
Delete Newly Created Item on Content Menu List
	[Documentation]   Deletes Created Item By assuming it is the topmost one in the list. Returns to content page afterwards.
	Click Button   ${Btn_Actions_Dropbutton}
	Click Element  ${Btn_Actions_ContentMenu_Deletebutton}
	Click Element  ${Btn_Actions_SelectedItem_Deletebutton}
	Go To   ${URL_content_page}
	
Delete Newly Created Item from Content Media List
	Go To   ${URL_media_page}
	Wait Until Keyword Succeeds  5x  200ms  Click Button   ${Btn_Actions_Dropbutton}
	Click Element  ${Btn_Actions_ContentMenu_Deletebutton}
	Click Element  ${Btn_Actions_SelectedItem_Deletebutton}
	Go To   ${URL_media_page}	
	
Input Text To Frame
	[Documentation]   Inserts text to given frame and returns to original content
	[Arguments]	   ${frame}   ${locator}   ${input}
	Select Frame   ${frame}
	Input Text   ${locator}   ${input}
	Unselect Frame
	
Compared Pictures Match
	[Documentation]   Tests that two pictures look same --> layout is not broken
	[Arguments]	   ${pic1}   ${pic2}
	${results}=  compare      ${pic1}   ${pic2}   ${EMPTY}
    Run keyword if  ${results}==False   fail    "Pictures are different"