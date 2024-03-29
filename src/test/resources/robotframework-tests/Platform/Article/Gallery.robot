*** Settings ***
Documentation   Testing Gallery. Actually just checking that layout is not broken. No functional testing of the gallery
...			    component atm.
Resource        ../../../robotframework-keywords/platform/Paragraphs/Gallery.robot
Test Setup      Login And Go To Content Page
Test Teardown   Cleanup and Close Browser	
Force Tags		ARTICLE   GALLERY

*** Test Cases ***
Browse Gallery Images
	[Tags]  CRITICAL
	Given User Goes To New Article Site
	And User Starts Creating Page With Gallery
	When User Submits The New Article
	And User Opens Created Content
	Then Layout Should Not Have Changed
	And Moving Between Gallery Images Works
	
*** Keywords ***    						
User Submits The New Article
	Submit The New Article
	 		
User Starts Creating Page With Gallery  Start Creating Article With Gallery
	 						
User Goes To New Article Site  Go To New Article Site

User Opens Created Content
	 Open Created Content
	 Gallery.Take Screenshot Of Content

Layout Should Not Have Changed
	${originalpic} =  Set Variable   ${SCREENSHOTS_PATH}/${BROWSER}/${language}_short_ARTICLE_GALLERY_${BROWSER}.png
	${comparisonpic}=  Set Variable  ${REPORTS_PATH}/${BROWSER}_TESTRUN-${SUITE NAME}-${TEST NAME}_${language}.png
	Copy Original Screenshot To Reports Folder   ${originalpic}
	Compared Pictures Match   ${originalpic}    ${comparisonpic}