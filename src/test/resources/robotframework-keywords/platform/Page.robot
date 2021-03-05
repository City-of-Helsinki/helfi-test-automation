*** Settings ***
Documentation   New Page creation spesific keywords here
Resource        Commonkeywords.robot

*** Variables ***
${submitted}								false
${picalign} 		 						${EMPTY}

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
	
Cleanup and Close Browser
	[Documentation]  Deletes content created by testcases. Page , if created and picture if added.
	Run Keyword If  '${submitted}'!='false'  Wait Until Keyword Succeeds  2x  200ms  Delete Newly Created Item on Content Menu List
	Run Keyword If  '${picalign}'!='${EMPTY}'  Wait Until Keyword Succeeds  2x  200ms 	Delete Newly Created Item from Content Media List
	Close Browser	