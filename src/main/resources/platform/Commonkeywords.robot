*** Settings ***
Documentation   Common Keywords referred by many testsuites. Platform side tests only
Library           SeleniumLibrary
Library           OperatingSystem
Resource		  ./variables/create_page.robot

*** Keywords ***
Get Admin Url
   [Documentation]   Gets URL needed in localhost testing.
   ${admin_url} =   Run  ${ADMIN_URL}
   Set Test Variable   ${admin_url}
   
Login And Go To Content Site
	[Documentation]   Preparatory action for platform tests: User logs in and then navigates to Content('Sisältö')
	...				  site. Also accepts cookies here.	
	Get Admin Url
	Open Browser  ${admin_url}  ${BROWSER}
	Go To   https://helfi.docker.sh/fi/user/1
	Wait Until Keyword Succeeds  3x  200ms  Click Button  //button[contains(text(), 'Accept all cookies')]
	Wait Until Keyword Succeeds  3x  200ms  Click Element  //li[contains(@class, 'menu-item menu-item__system-admin_content')]

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