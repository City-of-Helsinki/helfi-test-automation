#############################     Naming Conventions    #######################
#
#				 Dropdown   = Ddn
#				 Text		= Txt
#				 Switch     = Swh
#				 Frame      = Frm
#				 Input      = Inp
#				 Button     = Btn
#				 Menu-item  = Mtm

*** Variables ***
${Ddn_SelectLanguage}						//select[@id='edit-langcode-0-value']
${Inp_Title}								//input[@id='edit-title-0-value']
${Inp_Hero_Title}							//input[contains(@id, 'edit-field-hero-0-subform')]
${Swh_HeroOnOff}						    //input[@id='edit-field-has-hero-value']
${Frm_Content}							    //iframe[@class='cke_wysiwyg_frame cke_reset']
${Btn_Submit}							    //input[@id='edit-submit--2']		
${Mtm_Content}								//li[contains(@class, 'menu-item menu-item__system-admin_content')]
${Btn_Actions_Dropbutton}					//button[@class='dropbutton__toggle']
${Btn_Actions_ContentMenu_Deletebutton}		//li[contains(@class, 'delete dropbutton')]/child::a
${Btn_Actions_SelectedItem_Deletebutton}	//input[@id='edit-submit']

