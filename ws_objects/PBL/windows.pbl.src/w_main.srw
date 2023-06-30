$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type mdi_1 from mdiclient within w_main
end type
type rbb_1 from ribbonbar within w_main
end type
end forward

global type w_main from window
integer width = 3209
integer height = 1768
boolean titlebar = true
string menuname = "m_dummy"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = mdi!
windowstate windowstate = maximized!
long backcolor = 16777215
string icon = "AppIcon!"
boolean center = true
windowdockoptions windowdockoptions = windowdockoptiondockedonly!
boolean tabbeddocumenttabcolorsusetheme = false
mdi_1 mdi_1
rbb_1 rbb_1
end type
global w_main w_main

type variables

end variables

forward prototypes
public function ribbonpanelitem wf_setpanelitem_pro (string as_text, string as_tag, string as_picturename, boolean abl_enabled)
public function ribbonmenuitem wf_setmenuitem_pro (string as_text, string as_tag, string as_picturename, boolean abl_enabled, string as_clicked, string as_type)
public function ribbongroupitem wf_setgroupitem_pro (string as_tag, boolean abl_enabled, boolean abl_newline)
public function ribbonlargebuttonitem wf_setlargetbuttonitem_pro (string as_text, string as_tag, string as_picturename, string as_clicked, boolean abl_enabled, string as_powertipstext, string as_powertipsdescription, string as_shortcut)
public function ribbonsmallbuttonitem wf_setsmallbuttonitem_pro (string as_text, string as_tag, string as_picturename, string as_clicked, boolean abl_enabled, string as_powertipstext, string as_powertipsdescription, string as_shortcut)
public function ribboncheckboxitem wf_setcheckboxitem_pro (string as_text, string as_tag, boolean abl_checked, boolean abl_enabled, string as_powertipstext, string as_powertipsdescription, boolean abl_thirdstate, boolean abl_threestate, string as_clicked, string as_selected)
public function ribboncomboboxitem wf_setcomboboxitem_pro (string as_text, string as_tag, string as_picturename, string as_label, boolean abl_allowedit, boolean abl_autoscale, boolean abl_autohscroll, boolean abl_enabled, string as_powertipstext, string as_powertipsdescription, boolean abl_hscrollbar, boolean abl_vscrollbar, integer ai_selectedindex, boolean abl_sorted, integer ai_boxheight, integer ai_boxwidth, integer ai_width, string as_modified, string as_selected, string as_selectionchanged)
public function ribbontabbuttonitem wf_settabbuttonitem_pro (string as_text, string as_tag, string as_picturename, string as_clicked, string as_powertiptext, string as_powertipdescription, boolean abl_checked, boolean abl_enabled, boolean abl_visible, string as_shortcut)
public function ribbontabbuttonitem wf_settabbuttonitem_pro (string as_text, string as_picturename, string as_clicked, string as_shortcut)
public subroutine wf_init_ribbonbar (ribbonbar arbb, boolean ab_loadxml)
public subroutine wf_enabled_smallbutton (string as_tag, boolean ab_enabled)
public subroutine wf_enabled_largebutton (string as_tag, boolean ab_enabled)
end prototypes

public function ribbonpanelitem wf_setpanelitem_pro (string as_text, string as_tag, string as_picturename, boolean abl_enabled);RibbonPanelItem	lrbb_PanelItem

lrbb_PanelItem.Text	=	as_Text
lrbb_PanelItem.Tag	=	as_Tag
lrbb_PanelItem.PictureName	=	as_PictureName
lrbb_PanelItem.Enabled	=	abl_Enabled

Return		lrbb_PanelItem

end function

public function ribbonmenuitem wf_setmenuitem_pro (string as_text, string as_tag, string as_picturename, boolean abl_enabled, string as_clicked, string as_type);RibbonMenuItem	lrbb_MenuItem

lrbb_MenuItem.Text	=	as_Text
lrbb_MenuItem.Tag	=	as_Tag
lrbb_MenuItem.PictureName	=	as_PictureName
lrbb_MenuItem.Enabled	=	abl_Enabled
lrbb_MenuItem.Clicked	=	as_Clicked
If	Trim(as_Type) <> ""	Then
	If	as_Type = "Separator!"	Then
		lrbb_MenuItem.ItemType	=	1
	Else
		lrbb_MenuItem.ItemType	=	0
	End	If
	
End	If

Return	lrbb_MenuItem
end function

public function ribbongroupitem wf_setgroupitem_pro (string as_tag, boolean abl_enabled, boolean abl_newline);RibbonGroupItem	lrbb_GrouItem

lrbb_GrouItem.Tag	=	as_Tag
lrbb_GrouItem.Enabled	=	abl_Enabled
lrbb_GrouItem.NewLine	=	abl_NewLine

Return	lrbb_GrouItem

end function

public function ribbonlargebuttonitem wf_setlargetbuttonitem_pro (string as_text, string as_tag, string as_picturename, string as_clicked, boolean abl_enabled, string as_powertipstext, string as_powertipsdescription, string as_shortcut);RibbonLargeButtonItem		lrbb_LargeButton

lrbb_LargeButton.Text	=	as_Text
lrbb_LargeButton.Tag		=	as_Tag
lrbb_LargeButton.PictureName	=	as_picturename
lrbb_LargeButton.Clicked		=	as_Clicked
lrbb_LargeButton.Enabled	=	abl_Enabled
lrbb_LargeButton.PowerTipText	=	as_PowerTipsText
lrbb_LargeButton.PowerTipDescription	=	as_PowerTipsDescription
lrbb_LargeButton.shortcut	=	as_Shortcut

Return	lrbb_LargeButton
end function

public function ribbonsmallbuttonitem wf_setsmallbuttonitem_pro (string as_text, string as_tag, string as_picturename, string as_clicked, boolean abl_enabled, string as_powertipstext, string as_powertipsdescription, string as_shortcut);RibbonSmallButtonItem		lrbb_SmallButton

lrbb_SmallButton.Text	=	as_Text
lrbb_SmallButton.Tag		=	as_Tag
lrbb_SmallButton.PictureName	=	as_picturename
lrbb_SmallButton.Clicked		=	as_Clicked
lrbb_SmallButton.Enabled	=	abl_Enabled
lrbb_SmallButton.PowerTipText	=	as_PowerTipsText
lrbb_SmallButton.PowerTipDescription	=	as_PowerTipsDescription
lrbb_SmallButton.ShortCut	=	as_shortCut
Return	lrbb_SmallButton
end function

public function ribboncheckboxitem wf_setcheckboxitem_pro (string as_text, string as_tag, boolean abl_checked, boolean abl_enabled, string as_powertipstext, string as_powertipsdescription, boolean abl_thirdstate, boolean abl_threestate, string as_clicked, string as_selected);RibbonCheckBoxItem	lrbb_CheckBoxItem

lrbb_CheckBoxItem.Text	=	as_Text
lrbb_CheckBoxItem.Tag	=	as_Tag
lrbb_CheckBoxItem.Checked	=	abl_Checked
lrbb_CheckBoxItem.Enabled	=	abl_Enabled
lrbb_CheckBoxItem.PowerTipText	=	as_PowerTipsText
lrbb_CheckBoxItem.PowerTipDescription	=	as_PowerTipsDescription
lrbb_CheckBoxItem.ThirdState	=	abl_thirdstate
lrbb_CheckBoxItem.ThreeState	=	abl_threestate
lrbb_CheckBoxItem.Clicked	=	as_Clicked
lrbb_CheckBoxItem.Selected	=	as_Selected


Return	lrbb_CheckBoxItem
end function

public function ribboncomboboxitem wf_setcomboboxitem_pro (string as_text, string as_tag, string as_picturename, string as_label, boolean abl_allowedit, boolean abl_autoscale, boolean abl_autohscroll, boolean abl_enabled, string as_powertipstext, string as_powertipsdescription, boolean abl_hscrollbar, boolean abl_vscrollbar, integer ai_selectedindex, boolean abl_sorted, integer ai_boxheight, integer ai_boxwidth, integer ai_width, string as_modified, string as_selected, string as_selectionchanged);RibbonComboBoxItem		lrbb_ComboBoxItem
lrbb_ComboBoxItem.Text =	as_Text
lrbb_ComboBoxItem.Tag	=	as_Tag
lrbb_ComboBoxItem.PictureName	=	as_PictureName
lrbb_ComboBoxItem.Label	=	as_Label
lrbb_ComboBoxItem.AllowEdit	=	abl_AllowEdit
lrbb_ComboBoxItem.AutoScale	=	abl_AutoScale
lrbb_ComboBoxItem.AutoHScroll	=	abl_AutoHScroll
lrbb_ComboBoxItem.Enabled	=	abl_Enabled
lrbb_ComboBoxItem.PowerTipText	=	as_PowerTipsText
lrbb_ComboBoxItem.PowerTipDescription	=	as_PowerTipsDescription
lrbb_ComboBoxItem.HScrollBar	=	abl_HScrollBar
lrbb_ComboBoxItem.VScrollBar	=	abl_VScrollBar
lrbb_ComboBoxItem.SelectItem(ai_SelectedIndex)
lrbb_ComboBoxItem.Sorted	=	abl_Sorted
lrbb_ComboBoxItem.BoxHeight	=	ai_BoxHeight
lrbb_ComboBoxItem.BoxWidth	=	ai_BoxWidth
lrbb_ComboBoxItem.Width	=	ai_Width
lrbb_ComboBoxItem.Modified	=	as_Modified
lrbb_ComboBoxItem.Selected	=	as_Selected
lrbb_ComboBoxItem.SelectionChanged	=	as_SelectionChanged

Return	lrbb_ComboBoxItem
end function

public function ribbontabbuttonitem wf_settabbuttonitem_pro (string as_text, string as_tag, string as_picturename, string as_clicked, string as_powertiptext, string as_powertipdescription, boolean abl_checked, boolean abl_enabled, boolean abl_visible, string as_shortcut);ribbonTabbuttonItem		lrbb_TabButton

lrbb_TabButton.Text	=	as_Text
lrbb_TabButton.Tag		=	as_Tag
lrbb_TabButton.PictureName	=	as_PictureName
lrbb_TabButton.Clicked		=	as_Clicked
lrbb_TabButton.PowerTipText	=	as_PowerTipText
lrbb_TabButton.PowerTipDescription	=	as_PowertipDescription
lrbb_TabButton.Checked	=	abl_Checked
lrbb_TabButton.Enabled	=	abl_Enabled
lrbb_TabButton.Visible	=	abl_Visible
lrbb_TabButton.ShortCut	=	as_shortCut
Return	lrbb_TabButton
end function

public function ribbontabbuttonitem wf_settabbuttonitem_pro (string as_text, string as_picturename, string as_clicked, string as_shortcut);ribbonTabbuttonItem		lrbb_TabButton

lrbb_TabButton.Text	=	as_Text
lrbb_TabButton.PictureName	=	as_PictureName
lrbb_TabButton.Clicked		=	as_Clicked
lrbb_TabButton.ShortCut	=	as_shortCut
Return	lrbb_TabButton
end function

public subroutine wf_init_ribbonbar (ribbonbar arbb, boolean ab_loadxml);If ab_LoadXML Then
	arbb.ImportFromXMLFile("..\PBL\menu.xml")
	return
end if

/*Iniciamos con el menu del sistema*/
ribbonapplicationbuttonitem	lrapp_item
ribbonapplicationmenu		lrapp_menu
ribbonmenuitem				lrm_item
long 								ll_index

lrapp_item.tag		= "ApplicationButton"
lrapp_item.text		= guo_sistema.uof_language('menu_aplication_text')

lrapp_menu.addmasterseparatoritem( )
lrm_item.tag 				= "UserInfo"
lrm_item.text 				= guo_sistema.uof_language('menu_aplication_usuario')
lrm_item.picturename	= "..\IMG\perfil_40px.png"
ll_index = lrapp_menu.insertmasteritemlast(lrm_item)

//Add User Info
lrapp_menu.addmasterseparatoritem( ll_index)//Insert separator
//Insert User List
lrm_item.tag = "UserList"
lrm_item.text = "User List"
lrm_item.clicked = "ue_userinfo"
lrm_item.picturename = ".\picture\userlist.png"
lrapp_menu.insertmasteritemlast( ll_index,lrm_item)
//Insert Group
lrm_item.tag = "Group"
lrm_item.text = "Group"
lrm_item.clicked = "ue_userinfo"
lrm_item.picturename = ".\picture\group.png"
lrapp_menu.insertmasteritemlast( ll_index,lrm_item)
//Maintain login user information
lrapp_menu.addmasterseparatoritem( ll_index)//Insert separator
lrm_item.tag = "Password"
lrm_item.text = "Password"
lrm_item.clicked = "ue_userinfo"
lrm_item.picturename = ".\picture\password.png"
lrapp_menu.insertmasteritemlast( ll_index,lrm_item)
//signout
lrm_item.tag = "Signout"
lrm_item.text = "Sign Out"
lrm_item.clicked = "ue_userinfo"
lrm_item.picturename = ".\picture\signout.png"
lrapp_menu.insertmasteritemlast( ll_index,lrm_item)
lrapp_menu.addmasterseparatoritem( ll_index)//Insert separator
//Setting values for About and Close buttons
lrapp_menu.addmasterseparatoritem( )
lrm_item.tag = "About"
lrm_item.text = "About"
lrm_item.clicked = "ue_about2"
lrm_item.picturename = ".\picture\about.png"
lrapp_menu.insertmasteritemlast(lrm_item)
lrm_item.tag = "Close"
lrm_item.text = "Close"
lrm_item.clicked = "ue_close2"
lrm_item.picturename = ".\picture\close.png"
lrapp_menu.insertmasteritemlast(lrm_item)
lrapp_menu.addmasterseparatoritem( )
//add RecentMenu
lrapp_menu.setrecenttitle( "Recent Windows")
lrapp_menu.insertrecentitemlast( "", "")
//setmenu
lrapp_item.setmenu( lrapp_menu)
arbb.setapplicationbutton( lrapp_item)



RibbonCategoryItem		lrbb_categoryItem
Long		ll_ItemHandle_Category,	ll_Itemhandle_Panel,ll_ItemHandle_Group
lrbb_categoryItem.Text	=	"Operation"
lrbb_categoryItem.Tag	=	"CategoryOperation"
lrbb_categoryItem.Enabled	=	True

ll_ItemHandle_Category	=	arbb.InsertCategoryFirst(lrbb_categoryItem)
If	ll_ItemHandle_Category <> -1	Then
	
	ll_Itemhandle_Panel	=	arbb.InsertPanelFirst( ll_ItemHandle_Category,  wf_SetPanelItem_pro( "Board",	"Board",	".\picture\orderview.png",	True))
	
	arbb.InsertLargeButtonFirst( ll_Itemhandle_Panel, wf_SetLargetButtonItem_Pro("Order View tests",	"OrderView",	".\picture\orderview.png",	"ue_orderview",	True,	"",	"", "ctrl+shift+O"))
	arbb.InsertLargeButtonLast( ll_Itemhandle_Panel, wf_SetLargetButtonItem_Pro("Customer Maintenance",	"CustomerMaintenance",	".\picture\customermaintenance.png",	"ue_cus_maintenance",	True,	"",	"","ctrl+shift+c"))
	arbb.InsertLargeButtonLast( ll_Itemhandle_Panel, wf_SetLargetButtonItem_Pro("Report by order",	"Reportbyorder",	".\picture\ordertype.png",	"ue_rep_ordertype_button",	True,	"",	"","ctrl+shift+r"))
		
	ll_Itemhandle_Panel	=	arbb.InsertPanelLast( ll_ItemHandle_Category,  wf_SetPanelItem_pro( "Action",	"Action",	".\picture\Actions.png",	True))
	
	ll_ItemHandle_Group	=	arbb.InsertGroupLast(ll_Itemhandle_Panel,	wf_SetGroupItem_Pro("",	True,	True))
	
	arbb.InsertSmallButtonLast(ll_ItemHandle_Group,	wf_SetSmallButtonItem_Pro('',	"Retrieve",	"RefreshSmall!",	"ue_retrieve",	True,	"Refresh",	"Refresh the DataWindow data","ctrl+R") )
	arbb.InsertSmallButtonLast(ll_ItemHandle_Group,	wf_SetSmallButtonItem_Pro('',	"InsertRow",	".\picture\InsertRow.png",	"ue_insertrow",	True,	"Insert Row",	"Insert a row to add new data","ctrl+I") )
	
	ll_ItemHandle_Group	=	arbb.InsertGroupLast(ll_Itemhandle_Panel,	wf_SetGroupItem_Pro("",	True,	True))
	
	arbb.InsertSmallButtonLast(ll_ItemHandle_Group,	wf_SetSmallButtonItem_Pro('',	"ModifyRow",	"ModifySmall!",	"ue_modify",	True,	"",	"Modify the currently selected Row","ctrl+M") )
	arbb.InsertSmallButtonLast(ll_ItemHandle_Group,	wf_SetSmallButtonItem_Pro('',	"DeleteRow",	".\picture\DeleteRow.png",	"ue_DeleteRow",	True,	"",	"Delete the currently selected row; not commit to the database yet","ctrl+D") )
	
	arbb.InsertLargeButtonLast( ll_Itemhandle_Panel, wf_SetLargetButtonItem_Pro("Save Data",	"SaveData",	"SaveBig!",	"ue_SaveData",	True,	"Save Data",	"Save the specified DataWindow data","ctrl+S"))
	
	ll_ItemHandle_Group	=	arbb.InsertGroupLast(ll_Itemhandle_Panel,	wf_SetGroupItem_Pro("",	True,	False))
	arbb.InsertSmallButtonLast(ll_ItemHandle_Group,	wf_SetSmallButtonItem_Pro("",	"First",	".\picture\NavFirstSmall.png",	"ue_first",	True,	"",	"Scroll to first row","") )
	
	ll_ItemHandle_Group	=	arbb.InsertGroupLast(ll_Itemhandle_Panel,	wf_SetGroupItem_Pro("",	True,	False))
	arbb.InsertSmallButtonLast(ll_ItemHandle_Group,	wf_SetSmallButtonItem_Pro("",	"Prior",	".\picture\NavPrevSmall.png",	"ue_prior",	True,	"",	"Scroll to prior row","") )
	
	ll_ItemHandle_Group	=	arbb.InsertGroupLast(ll_Itemhandle_Panel,	wf_SetGroupItem_Pro("",	True,	False))
	arbb.InsertSmallButtonLast(ll_ItemHandle_Group,	wf_SetSmallButtonItem_Pro("",	"Next",	".\picture\NavNextSmall.png",	"ue_next",	True,	"",	"Scroll to next row","") )
	
	ll_ItemHandle_Group	=	arbb.InsertGroupLast(ll_Itemhandle_Panel,	wf_SetGroupItem_Pro("",	True,	False))
	arbb.InsertSmallButtonLast(ll_ItemHandle_Group,	wf_SetSmallButtonItem_Pro("",	"Last",	".\picture\NavLastSmall.png",	"ue_last",	True,	"",	"Scroll to last row","") )
	
	ll_ItemHandle_Group	=	arbb.InsertGroupLast(ll_Itemhandle_Panel,	wf_SetGroupItem_Pro("",	True,	True))
	arbb.InsertSmallButtonLast(ll_ItemHandle_Group,	wf_SetSmallButtonItem_Pro("",	"Sort",	"SortSmall!",	"ue_Sort",	False,	"",	"Sort","") )
	arbb.InsertSmallButtonLast(ll_ItemHandle_Group,	wf_SetSmallButtonItem_Pro("",	"Filter",	"FilterSmall!",	"ue_filter",	True,	"",	"Filter","") )
	arbb.InsertSmallButtonLast(ll_ItemHandle_Group,	wf_SetSmallButtonItem_Pro("",	"Find",	".\picture\Find.png",	"ue_find",	True,	"",	"Find","ctrl+F") )
	arbb.InsertSmallButtonLast(ll_ItemHandle_Group,	wf_SetSmallButtonItem_Pro("",	"FindNext",	".\picture\FindNext.png",	"ue_FindNext",	True,	"",	"Find Next","ctrl+N") )
	
	//Export PDF panel
	ll_Itemhandle_Panel	=	arbb.InsertPanelLast( ll_ItemHandle_Category,  wf_SetPanelItem_pro( "Export PDF",	"ExportPDF",	"ExportBig!",	True))
	arbb.InsertLargeButtonLast( ll_Itemhandle_Panel, wf_SetLargetButtonItem_Pro("Export Data",	"ExportData",	"ExportBig!",	"ue_ExportPDF",	True,	"Export data",	"Export the specified DataWindow data to PDF",""))
	
	//Set LargeButton and menu item
	RibbonLargeButtonItem	lrbb_LargeButtonItem
	Ribbonmenu		lrbb_Menu
	//Insert MenuItem
	lrbb_Menu.Insertitemlast( wf_SetMenuItem_Pro("Distill",	"Distill",	"AppSmall!",	True,	"ue_ExportMethod_Menu",	""))
	lrbb_Menu.Insertitemlast( wf_SetMenuItem_Pro("NativePDF",	"NativePDF",	".\picture\NativePdfSmall.png",	True,	"ue_ExportMethod_Menu",	""))
	//set large button properties
	lrbb_LargeButtonItem	=	wf_SetLargetButtonItem_Pro("NativePDF",	"ExportMethod",	".\picture\NativePdfBig.png",	"",	True,	"Method",	"Export PDF Method", "")
	lrbb_LargeButtonItem.DefaultCommand=False
	//set large button menu
	lrbb_LargeButtonItem.SetMenu(lrbb_Menu)
	arbb.InsertLargeButtonLast( ll_Itemhandle_Panel, lrbb_LargeButtonItem)
	
	ll_ItemHandle_Group	=	arbb.InsertGroupLast(ll_Itemhandle_Panel,	wf_SetGroupItem_Pro("",	True,	False))
	//Insert CheckBox
	arbb.InsertCheckBoxLast(ll_ItemHandle_Group,wf_SetCheckboxItem_Pro("Distill Custom PostScript",	"DistillCustomPostScript",	False,	False,	"",	"",	False,	False,	"",	""))
	arbb.InsertCheckBoxLast(ll_ItemHandle_Group,wf_SetCheckboxItem_Pro("Print Using XSLFOP",	"PrintUsingXSLFOP",	False,	False,	"",	"",	False,	False,	"",	""))
	//Insert PDF Conformance list
	ll_ItemHandle_Group	=	arbb.InsertGroupLast(ll_Itemhandle_Panel,	wf_SetGroupItem_Pro("NativePDFOperation",	True,	True))
	RibbonComboBoxItem		lrbb_ComboBoxItem
	lrbb_ComboBoxItem	=	wf_SetcomboBoxItem_Pro("",	"PDFConformance",	"",	"",	False,	False,	True,	True,	"PDF Conformance",	"DataWindow.Export.PDF.NativePDF.PDFStandard",	False,	False,	1,	False,	600,	500,	500,	"",	"",	"")
	lrbb_ComboBoxItem.InsertItem("0-None",1)
	lrbb_ComboBoxItem.InsertItem("1-PDF/A-1a",2)
	lrbb_ComboBoxItem.InsertItem("2-PDF/A-1b",3)
	lrbb_ComboBoxItem.InsertItem("3-PDF/A-3a",4)
	lrbb_ComboBoxItem.InsertItem("4-PDF/A-3b",5)
	lrbb_ComboBoxItem.InsertItem("5-PDF/A-3u",6)
	lrbb_ComboBoxItem.SelectItem(1)	
	arbb.InsertComboBoxLast(ll_ItemHandle_Group,lrbb_ComboBoxItem)
	arbb.InsertCheckBoxLast(ll_ItemHandle_Group,wf_SetCheckboxItem_Pro("Use Special Print Settings",	"UseSpecialPrintSettings",	False,	True,	"",	"",	False,	False,	"ue_exportpdf_printspecialset",	""))
	//Insert ExportPaperSize
	ll_ItemHandle_Group	=	arbb.InsertGroupLast(ll_Itemhandle_Panel,	wf_SetGroupItem_Pro("",	True,	True))
	lrbb_ComboBoxItem	=	wf_SetcomboBoxItem_Pro("",	"ExportPaperSize",	"",	"",	False,	False,	True,	True,	"Paper Size",	"Paper size setting for exporting with NativePDF",	False,	False,	1,	False,	600,	600,	600,	"",	"",	"")
	lrbb_ComboBoxItem.InsertItem("0-Default",1)
	lrbb_ComboBoxItem.InsertItem("1-A1 594 x 841 mm",2)
	lrbb_ComboBoxItem.InsertItem("2-A2 420 x 594 mm",3)
	lrbb_ComboBoxItem.InsertItem("3-A3 297 x 420 mm",4)
	lrbb_ComboBoxItem.InsertItem("4-A4 210 x 297 mm",5)
	lrbb_ComboBoxItem.InsertItem("5-Letter 8 1/2 x 11 in",6)
	lrbb_ComboBoxItem.InsertItem("6-Legal 8 1/2 x 14 in",7)	
	lrbb_ComboBoxItem.SelectItem(1)	
	arbb.InsertComboBoxLast(ll_ItemHandle_Group,lrbb_ComboBoxItem)
	//Insert Export Orientation
	lrbb_ComboBoxItem	=	wf_SetcomboBoxItem_Pro("",	"ExportOrientation",	"",	"",	False,	False,	True,	True,	"Orientaion",	"Paper orientation setting for exporting with NativePDF",	False,	False,	1,	False,	600,	600,	620,	"",	"",	"")
	lrbb_ComboBoxItem.InsertItem("0-Default",1)
	lrbb_ComboBoxItem.InsertItem("1-Landscape",2)
	lrbb_ComboBoxItem.InsertItem("2-Portrait",3)	
	lrbb_ComboBoxItem.SelectItem(1)	
	arbb.InsertComboBoxLast(ll_ItemHandle_Group,lrbb_ComboBoxItem)
	
	//Insert Print panel
	ll_Itemhandle_Panel	=	arbb.InsertPanelLast( ll_ItemHandle_Category,  wf_SetPanelItem_pro( "Print",	"PrintPanel",	"PreviewSmall!",	True))
	//Insert Preview buttion
	arbb.InsertLargeButtonLast( ll_Itemhandle_Panel, wf_SetLargetButtonItem_Pro("Print Preview",	"PrintPreview",	"PreviewBig!",	"ue_printpreview",	True,	"Preview data",	"Preview the DataWindow data for printing","ctrl+V"))
	//Insert orientation buttion
	lrbb_LargeButtonItem	=	wf_SetLargetButtonItem_Pro("Orientation",	"Orientation",	"OrientationBig!",	"",	True,	"Print Orientation",	"Set the print orientation","")
	lrbb_LargeButtonItem.DefaultCommand	=	False
	lrbb_Menu.DeleteItem(2)
	lrbb_Menu.DeleteItem(1)
	lrbb_Menu.Insertitemlast( wf_SetMenuItem_Pro("Default",	"Default",	".\picture\Default.png",	True,	"ue_orientation_menu",	""))
	lrbb_Menu.Insertitemlast( wf_SetMenuItem_Pro("Portrait",	"Portrait",	".\picture\Portrait.png",	True,	"ue_orientation_menu",	""))
	lrbb_Menu.Insertitemlast( wf_SetMenuItem_Pro("Landscape",	"Landscape",	".\picture\Landscape.png",	True,	"ue_orientation_menu",	""))
	lrbb_LargeButtonItem.SetMenu(lrbb_Menu)
	arbb.InsertLargeButtonLast( ll_Itemhandle_Panel, lrbb_LargeButtonItem)
	
	ll_ItemHandle_Group	=	arbb.InsertGroupLast(ll_Itemhandle_Panel,	wf_SetGroupItem_Pro("",	True,	False))
	//Insert Print paper size list
	lrbb_ComboBoxItem	=	wf_SetcomboBoxItem_Pro("",	"PageSize",	"PageSizeSmall!",	"",	False,	False,	True,	True,	"Paper size",	"Choose the paper size from the dropdown list",	False,	True,	1,	False,	900,	650,	750,	"",	"",	"ue_selectionchanged_comb")
	lrbb_ComboBoxItem.InsertItem("0 -- Default paper size for the printer",1)
	lrbb_ComboBoxItem.InsertItem("1 -- Letter 8 1/2 x 11 in",2)
	lrbb_ComboBoxItem.InsertItem("2 -- LetterSmall 8 1/2 x 11 in",3)
	lrbb_ComboBoxItem.InsertItem("3 -- Tabloid 17 x 11 in",4)
	lrbb_ComboBoxItem.InsertItem("4 -- Ledger 17 x 11 in",5)
	lrbb_ComboBoxItem.InsertItem("5 -- Legal 8 1/2 x 14 in",6)
	lrbb_ComboBoxItem.InsertItem("6 -- Statement 5 1/2 x 8 1/2 in",7)
	lrbb_ComboBoxItem.InsertItem("7 -- Executive 7 1/4 x 10 1/2 in",8)
	lrbb_ComboBoxItem.InsertItem("8 -- A3 297 x 420 mm",9)
	lrbb_ComboBoxItem.InsertItem("9 --A4 210 x 297 mm",10)
	lrbb_ComboBoxItem.InsertItem("10 -- A4 Small 210 x 297 mm",11)
	lrbb_ComboBoxItem.InsertItem("11 -- A5 148 x 210 mm",12)
	lrbb_ComboBoxItem.InsertItem("12 -- B4 250 x 354 mm",13)
	lrbb_ComboBoxItem.InsertItem("13 -- B5 182 x 257 mm",14)	
	lrbb_ComboBoxItem.InsertItem("14 -- Folio 8 1/2 x 13 in",15)
	lrbb_ComboBoxItem.InsertItem("15 -- Quarto 215 x 275 mm",16)
	lrbb_ComboBoxItem.InsertItem("16 -- 10x14 in",17)
	lrbb_ComboBoxItem.InsertItem("17 -- 11x17 in",18)
	lrbb_ComboBoxItem.InsertItem("18 -- Note 8 1/2 x 11 in",19)
	lrbb_ComboBoxItem.InsertItem("19 -- Envelope #9 3 7/8 x 8 7/8",20)
	lrbb_ComboBoxItem.InsertItem("20 -- Envelope #10 4 1/8 x 9 1/2",21)
	lrbb_ComboBoxItem.InsertItem("21 -- Envelope #11 4 1/2 x 10 3/8",22)
	lrbb_ComboBoxItem.InsertItem("22 -- Envelope #12 4 x 11 1/276",23)
	lrbb_ComboBoxItem.InsertItem("23 -- Envelope #14 5 x 11 1/2",24)	
	lrbb_ComboBoxItem.SelectItem(1)	
	arbb.InsertComboBoxLast(ll_ItemHandle_Group,lrbb_ComboBoxItem)
	
	lrbb_ComboBoxItem	=	wf_SetcomboBoxItem_Pro("",	"Zoom",	"ZoomSmall!",	"",	True,	False,	True,	True,	"Zoom",	"Preview zoom setting",	False,	False,	1,	True,	600,	250,	250,	"ue_Modified_comb",	"",	"ue_selectionchanged_comb")
	lrbb_ComboBoxItem.InsertItem("100%",1)
	lrbb_ComboBoxItem.InsertItem("75%",2)
	lrbb_ComboBoxItem.InsertItem("50%",3)
	lrbb_ComboBoxItem.InsertItem("25%",4)	
	lrbb_ComboBoxItem.SelectItem(1)	
	arbb.InsertComboBoxLast(ll_ItemHandle_Group,lrbb_ComboBoxItem)
	//Insert Ruler
	arbb.InsertCheckBoxLast(ll_ItemHandle_Group,wf_SetCheckboxItem_Pro("Ruler",	"ShowRuler",	False,	True,	"Rulers",	"Show rulers in preview",	False,	False,	"ue_preview_rulers",	""))
	
	ll_ItemHandle_Group	=	arbb.InsertGroupLast(ll_Itemhandle_Panel,	wf_SetGroupItem_Pro("Margins",	True,	True))
	
	lrbb_ComboBoxItem	=	wf_SetcomboBoxItem_Pro("",	"MarginsTop",	".\picture\MarginsTop.png",	"",	True,	False,	True,	True,	"",	"",	False,	False,	1,	True,	600,	200,	300,	"ue_Modified_comb",	"",	"")
	lrbb_ComboBoxItem.InsertItem("50",1)		
	lrbb_ComboBoxItem.SelectItem(1)	
	arbb.InsertComboBoxLast(ll_ItemHandle_Group,lrbb_ComboBoxItem)
	
	lrbb_ComboBoxItem	=	wf_SetcomboBoxItem_Pro("",	"MarginsBottom",	".\picture\MarginsBottom.png",	"",	True,	False,	True,	True,	"",	"",	False,	False,	1,	True,	600,	200,	300,	"ue_Modified_comb",	"",	"")
	lrbb_ComboBoxItem.InsertItem("50",1)		
	lrbb_ComboBoxItem.SelectItem(1)	
	arbb.InsertComboBoxLast(ll_ItemHandle_Group,lrbb_ComboBoxItem)
	
	lrbb_ComboBoxItem	=	wf_SetcomboBoxItem_Pro("",	"MarginsLeft",	".\picture\MarginsLeft.png",	"",	True,	False,	True,	True,	"",	"",	False,	False,	1,	True,	600,	200,	300,	"ue_Modified_comb",	"",	"")
	lrbb_ComboBoxItem.InsertItem("50",1)		
	lrbb_ComboBoxItem.SelectItem(1)	
	arbb.InsertComboBoxLast(ll_ItemHandle_Group,lrbb_ComboBoxItem)
	
	lrbb_ComboBoxItem	=	wf_SetcomboBoxItem_Pro("",	"MarginsRight",	".\picture\MarginsRight.png",	"",	True,	False,	True,	True,	"",	"",	False,	False,	1,	True,	600,	200,	300,	"ue_Modified_comb",	"",	"")
	lrbb_ComboBoxItem.InsertItem("50",1)		
	lrbb_ComboBoxItem.SelectItem(1)	
	arbb.InsertComboBoxLast(ll_ItemHandle_Group,lrbb_ComboBoxItem)
	
	arbb.InsertLargeButtonLast( ll_Itemhandle_Panel, wf_SetLargetButtonItem_Pro("Print",	"Print",	".\picture\printbig.png",	"ue_print",	True,	"Print Data",	"Print preview datawidnow","ctrl+P"))
	arbb.InsertLargeButtonLast( ll_Itemhandle_Panel, wf_SetLargetButtonItem_Pro("Print Setup",	"PrintSetup",	"PrintSetupBig!",	"ue_print_setup",	True,	"Print setup",	"Open print option dialog before print",""))
	
End	If


long ll_handle,ll_category,ll_panel,ll_group
RibbonSmallButtonItem lrs_item
Ribbonmenu  lrm_menu
ribbonLargeButtonItem lrl_item
ribbongroupitem lrg_item
long ll_return,ll_tmp,ll_tmp2


lrbb_categoryItem.Text	=	"Customer"
lrbb_categoryItem.Tag	=	"CategoryCustomer"
lrbb_categoryItem.Enabled	=	True
ll_Category	=	arbb.InsertCategoryLast(lrbb_categoryItem)
//ll_category = arbb.insertcategorylast("Customer")//comment by liulihua repalce by prior row
ll_panel = arbb.insertpanellast( ll_category, "Customer",".\picture\Customer.png")
//LargeButton
arbb.insertLargebuttonlast(ll_panel,"New Customer",".\picture\newcustomer.png","ue_cus_new")

arbb.insertLargebuttonLast(ll_panel,"Customer Maintenance",".\picture\customermaintenance.png","ue_cus_maintenance")
arbb.insertLargebuttonLast(ll_panel,"Accounts Receivable",".\picture\accountsreceivable.png","ue_cus_account")

//category order
lrbb_categoryItem.Text	=	"Order&Product"
lrbb_categoryItem.Tag	=	"CategoryOrderProduct"
lrbb_categoryItem.Enabled	=	True
ll_Category	=	arbb.InsertCategoryLast(lrbb_categoryItem)

//ll_category = arbb.insertcategorylast("Order&Product")//comment by liulihua repalce by prior row
ll_panel = arbb.insertpanellast( ll_category, "Order",".\picture\ordertype.png")
//LargeButton
arbb.insertLargebuttonlast(ll_panel,"New Order",".\picture\neworder.png","ue_order_new")
arbb.insertLargebuttonLast(ll_panel,"Order Maintenance",".\picture\ordermaintenance.png","ue_order_maintenance")
arbb.insertLargebuttonLast(ll_panel,"Order Processing",".\picture\orderprocessing.png","ue_order_process")
arbb.insertLargebuttonLast(ll_panel,"Order Shipment",".\picture\ordershipment.png","ue_order_ship")
//product
ll_panel = arbb.insertpanellast( ll_category, "Product",".\picture\productcategory.png")
//LargeButton
arbb.insertLargebuttonlast(ll_panel,"New Product",".\picture\newproduct.png","ue_pro_new")
//Insert items in Catelog Manager group
lrm_menu.insertitemlast( "Categories", ".\picture\categories.png", "ue_pro_category")
lrm_menu.addseparatoritem( )
lrm_menu.insertitemlast("Products",".\picture\products.png","ue_pro_products")
lrl_item.text = "Catalog Manager"
lrl_item.picturename = ".\picture\catalogmanager.png"
lrl_item.clicked = ""
lrl_item.setmenu( lrm_menu)
arbb.insertLargebuttonLast(ll_panel,lrl_item)
arbb.insertLargebuttonlast(ll_panel,"View Catalog",".\picture\viewproductcatalog.png","ue_pro_viewcat")

//Report
lrbb_categoryItem.Text	=	"Report"
lrbb_categoryItem.Tag	=	"CategoryReport"
lrbb_categoryItem.Enabled	=	True
ll_Category	=	arbb.InsertCategoryLast(lrbb_categoryItem)

//ll_category = arbb.insertcategorylast("Report")//comment by liulihua repalce by prior row
ll_panel = arbb.insertpanellast( ll_category, "Report",".\picture\report small.png")
ll_return = lrm_menu.deleteitem(1)
ll_return = lrm_menu.deleteitem(2)
lrm_menu.insertitemlast( "By Order Type", ".\picture\ordertype.png", "ue_rep_ordertype")
lrm_menu.addseparatoritem( )
lrm_menu.insertitemlast("By Product Category",".\picture\productcategory.png","ue_rep_procat")
lrm_menu.addseparatoritem( )
lrm_menu.insertitemlast("By Customer",".\picture\customer.png","ue_rep_cus")
//Sales Reports
lrl_item.text = "Sales Reports"
lrl_item.picturename = ".\picture\salesreport.png"
lrl_item.clicked = ""
lrl_item.powertiptext="Report"
lrl_item.powertipdescription="Operations for report"
lrl_item.setmenu( lrm_menu)
arbb.insertLargebuttonLast(ll_panel,lrl_item)
//Add report styles
//Insert new group 1
ll_group = arbb.insertgrouplast(ll_panel)
ll_tmp = ll_group
lrs_item.tag = "2D Pie"
lrs_item.text = "2D Pie"
lrs_item.picturename = ".\picture\2dpie.png"
lrs_item.clicked = "ue_rep_style"
lrs_item.powertiptext="2D"
lrs_item.powertipdescription="2D Pie"
arbb.insertsmallbuttonlast(ll_group,lrs_item)

lrs_item.tag = "3D Column"
lrs_item.text = "3D Column"
lrs_item.picturename = ".\picture\3dcolumn.png"
lrs_item.clicked = "ue_rep_style"
lrs_item.powertiptext="3D"
lrs_item.powertipdescription="3D Column"
arbb.insertsmallbuttonlast(ll_group,lrs_item)
//comment by liulihua use Operation category's menu
//lrs_item.text = "Print"
//lrs_item.picturename = ".\picture\printsmall.png"
//lrs_item.clicked = "ue_rep_print"
//lrs_item.powertiptext = ""
//lrs_item.powertipdescription=""
//arbb.insertsmallbuttonlast(ll_group,lrs_item)
//coment end

//Insert new group 2
lrg_item.newline = true
ll_group = arbb.insertgroup(ll_panel,ll_group,lrg_item)
ll_tmp2 = ll_group

lrs_item.tag = "2D BarStacked"
lrs_item.text = "2D Bar"
lrs_item.picturename = ".\picture\2dbarstacked.png"
lrs_item.clicked = "ue_rep_style"
lrs_item.powertiptext="2D"
lrs_item.powertipdescription="2D Bar Stacked"
arbb.insertsmallbuttonlast(ll_group,lrs_item)

lrs_item.tag = "Grid Data"
lrs_item.text = "Grid Data"
lrs_item.picturename = ".\picture\griddata.png"
lrs_item.clicked = "ue_rep_style"
lrs_item.powertiptext=""
lrs_item.powertipdescription=""
arbb.insertsmallbuttonlast(ll_group,lrs_item)

//comment by liulihua use Operation category's menu
//lrs_item.text = "Refresh"
//lrs_item.picturename = "refresh.png"
//lrs_item.clicked = "ue_rep_refresh"
//lrs_item.powertiptext="Refresh"
//lrs_item.powertipdescription="Refresh the current report!"
//arbb.insertsmallbuttonlast(ll_group,lrs_item)
//comment end
arbb.insertLargebuttonlast(ll_panel,wf_SetLargetButtonItem_Pro("Customer Report",	"",	".\picture\customerreport.png",	"ue_rep_Report",	True,	"",	"", "ctrl+Shift+L")) //add by liulihua add shortcut 2019-12-27

//arbb.insertLargebuttonlast(ll_panel,"Customer Report",".\picture\customerreport.png","ue_rep_Report")//comment by liulihua add shortcut 2019-12-27

//Insert Close button
//arbb.inserttabbuttonfirst( "Close", ".\picture\close12.png", "ue_close")//comment by liulihua add the shortcut 2019-12-27
arbb.inserttabbuttonfirst( wf_SetTabButtonItem_Pro("Close",		".\picture\close12.png",	 "ue_close",		"ctrl+E")	)//add by liulihua 2019-12-27

arbb.inserttabbuttonfirst( "About", ".\picture\help.png", "ue_about")
//Insert Ribbon collapse button
arbb.inserttabbuttonfirst( "Up", ".\picture\up.png", "ue_up")



arbb.SetActiveCategory(ll_ItemHandle_Category)


end subroutine

public subroutine wf_enabled_smallbutton (string as_tag, boolean ab_enabled);Integer			li_Return
RibbonSmallButtonItem	lrlb_button

li_Return	= rbb_1.GetItemByTag(as_tag,lrlb_button)
If li_Return =	1	Then
	lrlb_button.enabled = ab_enabled
	rbb_1.SetSmallButton(lrlb_button.ItemHandle, lrlb_button)
end if
end subroutine

public subroutine wf_enabled_largebutton (string as_tag, boolean ab_enabled);Integer			li_Return
RibbonLargeButtonItem	lrlb_button

li_Return	= rbb_1.GetItemByTag(as_tag,lrlb_button)
If li_Return =	1	Then
	lrlb_button.enabled = ab_enabled
	rbb_1.SetLargeButton(lrlb_button.ItemHandle, lrlb_button)
end if
end subroutine

on w_main.create
if this.MenuName = "m_dummy" then this.MenuID = create m_dummy
this.mdi_1=create mdi_1
this.rbb_1=create rbb_1
this.Control[]={this.mdi_1,&
this.rbb_1}
end on

on w_main.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
destroy(this.rbb_1)
end on

event open;title	= guo_sistema.uof_language(ClassName()+'_title')
wf_init_ribbonbar(rbb_1,False)
end event

event resize;if newwidth <= 0 then
	newwidth = this.workspacewidth( )
end if
if newheight <=0 then
	newheight = this.workspaceheight( )
end if

rbb_1.move(0,newheight - this.workspaceheight()  )
rbb_1.width = newwidth
mdi_1.move(0,rbb_1.height +newheight -  this.workspaceheight())
mdi_1.resize(newwidth,newheight - rbb_1.height - ( newheight - this.workspaceheight()))

this.arrangesheets( layer!)
end event

type mdi_1 from mdiclient within w_main
long BackColor=268435456
end type

type rbb_1 from ribbonbar within w_main
event ue_userinfo ( long al_handle,  long al_index,  long al_subindex )
event ue_sec_user ( long al_handle )
event ue_orderview ( long al_handle )
event ue_selectionchanged_comb ( long al_itemhandle,  long al_index )
integer x = 5
integer width = 3168
integer height = 492
long backcolor = 15132390
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
end type

event ue_userinfo(long al_handle, long al_index, long al_subindex);ribbonmenuitem  lrbm_item,lrbm_subitem
ribbonapplicationbuttonitem lrapp_item
ribbonapplicationmenu lrapp_menu
long ll_return
//get button
ll_return = this.getapplicationbutton(lrapp_item)
if ll_return < 0 then return
//get application menu
ll_return = lrapp_item.getmenu(lrapp_menu)
if ll_return <0 then return

//get child menu
ll_return = lrapp_menu.getmasteritem( al_index, al_subindex, lrbm_subitem)
if ll_return < 0 then return
choose case lrbm_subitem.Tag
	case "UserList"
		triggerevent("ue_sec_user")
	case "Group"
		triggerevent("ue_sec_group")
	case "Password"
		triggerevent("ue_sec_password")
	case "Signout"
	//	f_open()
end choose
end event

event ue_sec_user(long al_handle);/*No se puede abrir una ventana hija en este evento*/
//open(w_sheet_1,parent)
OpenSheet(w_sheet_1,parent)
end event

event ue_orderview(long al_handle);/*No se puede abrir una ventana hija en este evento*/
//open(w_sheet_1,parent)
//OpenSheet(w_sheet_1,parent)
//OpenSheetWithParm(w_sheet_1,"titulo Wilder",parent,0,Layered!)
opensheet(w_sheet_1 , parent , 0 , Layered! )
end event

event ue_selectionchanged_comb(long al_itemhandle, long al_index);//Author: liulihua
//ue_selectionchanged_comb(long al_ItemHandle long al_Index) return none

RibbonComboBoxItem		lrbbcb_combox

If this.GetComboBox( al_itemhandle,	lrbbcb_combox ) <> 1 Then &
	Return
	
guo_message.uof_message('',lrbbcb_combox.text(al_index))
/*
window lw_ActiveSheet
Datawindow		ldw_Preview

lw_ActiveSheet = parent.GetActiveSheet()

//check the GetActiveSheet return window is valid
If	Not	IsValid(lw_ActiveSheet)	Then Return
RibbonComboBoxItem		lrbbcb_combox
If	this.GetComboBox( al_itemhandle,	lrbbcb_combox ) <> 1 Then Return

//a corrding the window name retrieve datawindow data
Choose Case lw_ActiveSheet.classname( )		
	
	Case "w_print_preview"		
		ldw_Preview=w_print_preview.dw_preview//
		
	Case else
		
End	Choose

If	Not	IsValid(ldw_Preview)	Then	Return

Integer		li_Pos
String			ls_Zoom

Choose	Case	lrbbcb_combox.Tag
		
	Case "PageSize"	
		ldw_Preview.Object.DataWindow.Print.Paper.Size= left( lrbbcb_combox.Text ,Pos( lrbbcb_combox.Text," ") - 1)
	Case "Zoom"
		//filter &
		li_Pos		=	Pos( lrbbcb_combox.Text,"%")
		If	li_Pos	<	1	Then
			ls_zoom	=	lrbbcb_combox.Text
		Else
			ls_zoom	=	Left(lrbbcb_combox.Text, li_Pos - 1 )
		End	If
		//check the input data
		If	IsNumber(ls_zoom) Then
			ldw_Preview.Object.DataWindow.Print.Preview.zoom= ls_zoom
		End	If
	Case ""
		
	Case Else
		
End Choose
*/
		
end event

