#############################     Naming Conventions    #######################
#
#				 Dropdown   = Ddn
#				 Option		= Opt
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
${Frm_Content}							    css:#cke_1_contents > iframe
${Frm_Content_Description}				    css:#cke_58_contents > iframe
${Btn_Submit}							    //input[@id='edit-submit--2']		
${Mtm_Content}								//li[contains(@class, 'menu-item menu-item__system-admin_content')]
${Btn_Actions_Dropbutton}					//button[@class='dropbutton__toggle']
${Btn_Actions_ContentMenu_Deletebutton}		//li[contains(@class, 'delete dropbutton')]/child::a
${Btn_Actions_SelectedItem_Deletebutton}	//input[@id='edit-submit']
${Ddn_Hero_Alignment}						css:[data-drupal-selector=edit-field-hero-0-subform-field-hero-design]
${Opt_Hero_Alignment_Center}				css:[value=without-image-center]
${Opt_Hero_Picture_On_Right}				css:[value=with-image-right]
${Opt_Hero_Picture_On_Left}					css:[value=with-image-left]
${Opt_Hero_Picture_On_Bottom}				css:[value=with-image-bottom]
${Opt_Hero_Picture_On_Background}			css:[value=background-image]
${Opt_Hero_Diagonal}						css:[value=diagonal]
${Btn_Hero_Picture}							name:field_hero_image-media-library-open-button-field_hero-0-subform
${Btn_Hero_File_Upload}					    name:files[upload]
${Inp_Hero_Pic_Name}						css:[data-drupal-selector=edit-media-0-fields-name-0-value]
${Inp_Hero_Pic_AltText}						css:[data-drupal-selector=edit-media-0-fields-field-media-image-0-alt]
${Inp_Hero_Pic_Photographer}				css:[data-drupal-selector=edit-media-0-fields-field-photographer-0-value]
${Btn_Hero_Save_Pic}						//button[contains(text(),'Tallenna')]
${Btn_Hero_Insert_Pic}						//button[contains(text(),'Insert selected')]
${Btn_Hero_AddLink}						    name:field_hero_0_subform_field_hero_cta_link_add_more
${Inp_Hero_Link_URL}						css:[data-drupal-selector=edit-field-hero-0-subform-field-hero-cta-0-subform-field-link-link-0-uri]
${Inp_Hero_Link_Title}						css:[data-drupal-selector=edit-field-hero-0-subform-field-hero-cta-0-subform-field-link-link-0-title]
${Ddn_Hero_Link_Design}						css:[data-drupal-selector=edit-field-hero-0-subform-field-hero-cta-0-subform-field-link-design]
${Opt_Hero_Link_ButtonFullcolor}			css:[value=primary]
${Opt_Hero_Link_ButtonFramed}				css:[value=secondary]
${Opt_Hero_Link_ButtonTransparent}			css:[value=supplementary]