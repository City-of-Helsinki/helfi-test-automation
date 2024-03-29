*** Settings ***
Resource        ../../../robotframework-keywords/platform/Paragraphs/List_Of_Links.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	
Force Tags		PAGE   LISTOFLINKS
*** Variables ***

*** Test Cases ***
Without Picture
	[Tags]
	Given User Goes To New Page -Site
	And User Creates List Of Links Without Picture
	And User Adds Second Link For Esimerkkisivu Content
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed
	And List Of Links Should Work Correctly

With Picture
	[Tags]  CRITICAL
	Given User Goes To New Page -Site
	And User Creates List Of Links With Picture
	And User Adds Second Link For Esimerkkisivu Content
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed
	And List Of Links Should Work Correctly

Without Picture And Description
	[Tags] 
	Given User Goes To New Page -Site
	And User Creates List Of Links Without Picture And Description
	And User Adds Second Link For Esimerkkisivu Content
	When User Submits The New Page
	And User Opens Created Content
	Then Layout Should Not Have Changed
	And List Of Links Should Work Correctly
	
*** Keywords ***
User Creates List Of Links ${style}
	Create Page With List Of Links ${style}

User Goes To New Page -Site		Go To New Page Site
User Submits The New Page
	Submit The New Page

User Adds Second Link For ${content} Content
	Add Second Link For Content

List Of Links Should Work Correctly
	List Of Links Is Working Correctly
	
User Opens Created Content
	 Open Created Content
	 Take Screenshot Of Content
	 
Layout Should Not Have Changed
	${originalpic} =  Set Variable   ${SCREENSHOTS_PATH}/${BROWSER}/${language}_short_PAGE_LISTOFLINKS_${style}_${BROWSER}.png
	${comparisonpic}=  Set Variable  ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}.png
	Compare Pictures And Handle PictureData   ${originalpic}   ${comparisonpic}