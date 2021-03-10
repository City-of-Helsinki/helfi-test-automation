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
#SHARED
${Btn_File_Upload}					    	name:files[upload]
${Inp_Pic_Name}								css:[data-drupal-selector=edit-media-0-fields-name-0-value]
${Inp_Pic_AltText}							css:[data-drupal-selector=edit-media-0-fields-field-media-image-0-alt]
${Inp_Pic_Photographer}						css:[data-drupal-selector=edit-media-0-fields-field-photographer-0-value]
${Btn_Save_Pic}								//button[contains(text(),'Tallenna')]
${Btn_Insert_Pic}							//button[contains(text(),'Insert selected')]
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
#HERO
${Ddn_Hero_Alignment}						css:[data-drupal-selector=edit-field-hero-0-subform-field-hero-design]
${Opt_Hero_Alignment_Center}				css:[value=without-image-center]
${Opt_Hero_Picture_On_Right}				css:[value=with-image-right]
${Opt_Hero_Picture_On_Left}					css:[value=with-image-left]
${Opt_Hero_Picture_On_Bottom}				css:[value=with-image-bottom]
${Opt_Hero_Picture_On_Background}			css:[value=background-image]
${Opt_Hero_Diagonal}						css:[value=diagonal]
${Btn_Hero_Picture}							name:field_hero_image-media-library-open-button-field_hero-0-subform
${Btn_Hero_AddLink}						    name:field_hero_0_subform_field_hero_cta_link_add_more
${Inp_Hero_Link_URL}						css:[data-drupal-selector=edit-field-hero-0-subform-field-hero-cta-0-subform-field-link-link-0-uri]
${Inp_Hero_Link_Title}						css:[data-drupal-selector=edit-field-hero-0-subform-field-hero-cta-0-subform-field-link-link-0-title]
${Ddn_Hero_Link_Design}						css:[data-drupal-selector=edit-field-hero-0-subform-field-hero-cta-0-subform-field-link-design]
${Opt_Hero_Link_ButtonFullcolor}			css:[value=primary]
${Opt_Hero_Link_ButtonFramed}				css:[value=secondary]
${Opt_Hero_Link_ButtonTransparent}			css:[value=supplementary]
${Ddn_Hero_Color}							css:[data-drupal-selector=edit-field-hero-0-subform-field-hero-bg-color]

#COLUMNS
${Ddn_AddContent}							//ul[@data-drupal-selector='edit-field-content-add-more-operations']//li[2]/button
${Opt_AddColumns}						    name:field_content_columns_add_more
${Opt_AddImages}						    name:field_content_image_add_more
${Inp_Column_Title}	  						css:[data-drupal-selector=edit-field-content-1-subform-field-columns-title-0-value]
${Ddn_Column_Style}	  						css:[data-drupal-selector=edit-field-content-1-subform-field-columns-design]
${Ddn_Column_Left_AddContent}               //ul[@data-drupal-selector='edit-field-content-1-subform-field-columns-left-column-add-more-operations']//button
${Ddn_Column_Right_AddContent}				//ul[@data-drupal-selector='edit-field-content-1-subform-field-columns-right-column-add-more-operations']//button
${Opt_Column_Left_AddContent_Image}			//ul[@data-drupal-selector='edit-field-content-1-subform-field-columns-left-column-add-more-operations']//input[@name='field_content_1_subform_field_columns_left_column_image_add_more']
${Opt_Column_Left_AddContent_Text}			//ul[@data-drupal-selector='edit-field-content-1-subform-field-columns-left-column-add-more-operations']//input[@name='field_content_1_subform_field_columns_left_column_text_add_more']
${Opt_Column_Left_AddContent_ListOfLinks}	//ul[@data-drupal-selector='edit-field-content-1-subform-field-columns-left-column-add-more-operations']//input[@name='field_content_1_subform_field_columns_left_column_list_of_links_add_more']
${Opt_Column_Left_AddContent_Link}			//ul[@data-drupal-selector='edit-field-content-1-subform-field-columns-left-column-add-more-operations']//input[@name='field_content_1_subform_field_columns_left_column_link_add_more']
${Opt_Column_Right_AddContent_Link}			//ul[@data-drupal-selector='edit-field-content-1-subform-field-columns-right-column-add-more-operations']//input[@name='field_content_1_subform_field_columns_right_column_link_add_more']
${Opt_Column_Right_AddContent_Image}		//ul[@data-drupal-selector='edit-field-content-1-subform-field-columns-right-column-add-more-operations']//input[@name='field_content_1_subform_field_columns_right_column_image_add_more']
${Opt_Column_Right_AddContent_Text}			//ul[@data-drupal-selector='edit-field-content-1-subform-field-columns-right-column-add-more-operations']//input[@name='field_content_1_subform_field_columns_right_column_text_add_more']
${Btn_Column_Left_AddPicture}				name:field_image-media-library-open-button-field_content-1-subform-field_columns_left_column-0-subform
${Btn_Column_Right_AddPicture}				name:field_image-media-library-open-button-field_content-1-subform-field_columns_right_column-0-subform
${Frm_Column_Left_Text}						//div[contains(@id,'cke_edit-field-content-1-subform-field-columns-left-column-0-subform-field-text-0-value')]//iframe
${Frm_Column_Right_Text}					//div[contains(@id,'cke_edit-field-content-1-subform-field-columns-right-column-0-subform-field-text-0-value')]//iframe
${Btn_Column_Left_Picture}					name:field_image-media-library-open-button-field_content-1-subform-field_columns_left_column-0-subform
${Btn_Column_Right_Picture}					name:field_image-media-library-open-button-field_content-1-subform-field_columns_right_column-0-subform
${Btn_Column_Right_Edit}					name:field_content_1_subform_field_columns_right_column_0_edit
${Btn_Column_Left_Edit}						name:field_content_1_subform_field_columns_left_column_0_edit
${Inp_Column_Left_Picture_Caption}			css:[data-drupal-selector=edit-field-content-1-subform-field-columns-left-column-0-subform-field-image-caption-0-value]
${Inp_Column_Right_Picture_Caption}			css:[data-drupal-selector=edit-field-content-1-subform-field-columns-right-column-0-subform-field-image-caption-0-value]
${Swh_Column_Left_Picture_Orig_Aspect_Ratio}   css:[data-drupal-selector=edit-field-content-1-subform-field-columns-left-column-0-subform-field-original-aspect-ratio-value]
${Swh_Column_Right_Picture_Orig_Aspect_Ratio}   css:[data-drupal-selector=edit-field-content-1-subform-field-columns-right-column-0-subform-field-original-aspect-ratio-value]
${Inp_Column_Left_Link_Title}				css:[data-drupal-selector=edit-field-content-1-subform-field-columns-left-column-0-subform-field-link-link-0-title]
${Inp_Column_Right_Link_Title}				css:[data-drupal-selector=edit-field-content-1-subform-field-columns-right-column-0-subform-field-link-link-0-title]
${Inp_Column_Left_Link_URL}					css:[data-drupal-selector=edit-field-content-1-subform-field-columns-left-column-0-subform-field-link-link-0-uri]
${Inp_Column_Right_Link_URL}				css:[data-drupal-selector=edit-field-content-1-subform-field-columns-right-column-0-subform-field-link-link-0-uri]	
${Ddn_Column_Left_Link_Design}				css:[data-drupal-selector=edit-field-content-1-subform-field-columns-left-column-0-subform-field-link-design]
${Ddn_Column_Right_Link_Design}				css:[data-drupal-selector=edit-field-content-1-subform-field-columns-right-column-0-subform-field-link-design]	
${Opt_Column_Left_Link_ButtonFullcolor}		//select[@data-drupal-selector='edit-field-content-1-subform-field-columns-left-column-0-subform-field-link-design']//option[@value='primary']
${Opt_Column_Right_Link_ButtonFullcolor}	//select[@data-drupal-selector='edit-field-content-1-subform-field-columns-right-column-0-subform-field-link-design']//option[@value='primary']
${Opt_Column_Left_Link_ButtonFramed}		//select[@data-drupal-selector='edit-field-content-1-subform-field-columns-left-column-0-subform-field-link-design']//option[@value='secondary']
${Opt_Column_Right_Link_ButtonFramed}		//select[@data-drupal-selector='edit-field-content-1-subform-field-columns-right-column-0-subform-field-link-design']//option[@value='secondary']
${Opt_Column_Left_Link_ButtonTransparent}	//select[@data-drupal-selector='edit-field-content-1-subform-field-columns-left-column-0-subform-field-link-design']//option[@value='supplementary']
${Opt_Column_Right_Link_ButtonTransparent}	//select[@data-drupal-selector='edit-field-content-1-subform-field-columns-right-column-0-subform-field-link-design']//option[@value='supplementary']

