*** Settings ***
Documentation   Testing Hero Block Settings in Platform
Resource        ../../../../../main/resources/platform/Commonkeywords.robot
Test Setup      Login And Go To Content Site
Test Teardown	Close Browser

*** Test Cases ***

Browse Content Item
	[Tags]  HERO 
	When User Creates a Page With Hero Block
	
   
*** Keywords ***
User Creates a Page With Hero Block
	Go To New Page Site
	Select Language   en
	Input Text  ${Txt_Title}  Test Automation: User Creates a Page With Hero Block

	
	
