$PBExportHeader$w_message.srw
forward
global type w_message from window
end type
type pb_copy from picturebutton within w_message
end type
type cb_cancelar from commandbutton within w_message
end type
type cb_aceptar from commandbutton within w_message
end type
type dw_1 from datawindow within w_message
end type
end forward

global type w_message from window
accessiblerole accessiblerole = defaultrole!
integer x = 0
integer y = 0
integer width = 2048
integer height = 448
boolean enabled = true
boolean titlebar = true
boolean controlmenu = true
boolean minbox = false
boolean maxbox = false
boolean hscrollbar = false
boolean vscrollbar = false
boolean resizable = false
boolean border = true
windowtype windowtype = response!
windowstate windowstate = normal!
long backcolor = 67108864
string icon = "AppIcon!"
integer unitsperline = 0
integer linesperpage = 0
integer unitspercolumn = 0
integer columnsperpage = 0
boolean bringtotop = false
boolean toolbarvisible = true
toolbaralignment toolbaralignment = alignattop!
integer toolbarx = 0
integer toolbary = 0
integer toolbarwidth = 0
integer toolbarheight = 0
boolean righttoleft = false
boolean keyboardicon = true
boolean clientedge = false
boolean palettewindow = false
boolean contexthelp = false
boolean center = false
integer transparency = 0
windowanimationstyle openanimation = noanimation!
windowanimationstyle closeanimation = noanimation!
integer animationtime = 200
windowdockoptions windowdockoptions = windowdockoptionall!
windowdockstate windowdockstate = windowdockstatedocked!
long tabbeddocumenttabsareacolor = 1073741824
long tabbeddocumenttabsareagradientcolor = 1073741824
boolean tabbeddocumenttabsareagradientvert = false
long tabbedwindowtabsareacolor = 1073741824
long tabbedwindowtabsareagradientcolor = 1073741824
boolean tabbedwindowtabsareagradientvert = false
long titlebaractivecolor = 134217730
long titlebaractivegradientcolor = 134217730
boolean titlebaractivegradientvert = false
long titlebaractivetextcolor = 0
long titlebarinactivecolor = 134217731
long titlebarinactivegradientcolor = 134217731
boolean titlebarinactivegradientvert = false
long titlebarinactivetextcolor = 0
windowdocktabshape tabbeddocumenttabshape = windowdocktabrectangular!
windowdocktabclosebutton tabbeddocumenttabclosebutton = windowdocktabclosebuttononactive!
boolean tabbeddocumenttabicon = true
boolean tabbeddocumenttabscroll = false
windowdocktabshape tabbedwindowtabshape = windowdocktabrectangular!
windowdocktabclosebutton tabbedwindowtabclosebutton = windowdocktabclosebuttonnone!
boolean tabbedwindowtabicon = true
boolean tabbedwindowtabscroll = false
boolean tabbeddocumenttabcolorsusetheme = true
long tabbeddocumentactivetabbackcolor = 1073741824
long tabbeddocumentactivetabgradientbackcolor = 1073741824
long tabbeddocumentactivetabtextcolor = 0
long tabbeddocumentinactivetabbackcolor = 67108864
long tabbeddocumentinactivetabgradientbackcolor = 67108864
long tabbeddocumentinactivetabtextcolor = 0
long tabbeddocumentmouseovertabbackcolor = 67108864
long tabbeddocumentmouseovertabgradientbackcolor = 67108864
long tabbeddocumentmouseovertabtextcolor = 0
boolean tabbedwindowtabcolorsusetheme = true
long tabbedwindowactivetabbackcolor = 1073741824
long tabbedwindowactivetabgradientbackcolor = 1073741824
long tabbedwindowactivetabtextcolor = 0
long tabbedwindowinactivetabbackcolor = 67108864
long tabbedwindowinactivetabgradientbackcolor = 67108864
long tabbedwindowinactivetabtextcolor = 0
long tabbedwindowmouseovertabbackcolor = 67108864
long tabbedwindowmouseovertabgradientbackcolor = 67108864
long tabbedwindowmouseovertabtextcolor = 0
boolean toolbarinsheet = false
pb_copy pb_copy
cb_cancelar cb_cancelar
cb_aceptar cb_aceptar
dw_1 dw_1
end type
global w_message w_message

type variables
st_message	ist_message
integer 		il_respuesta = 0


end variables
on w_message.create
this.pb_copy=create pb_copy
this.cb_cancelar=create cb_cancelar
this.cb_aceptar=create cb_aceptar
this.dw_1=create dw_1
this.Control[]={this.pb_copy,&
this.cb_cancelar,&
this.cb_aceptar,&
this.dw_1}
end on

on w_message.destroy
destroy(this.pb_copy)
destroy(this.cb_cancelar)
destroy(this.cb_aceptar)
destroy(this.dw_1)
end on

event open;backcolor	= 67108864

ist_message	= message.powerobjectparm

title			= ist_message.title
Center		= ist_message.auto_center
cb_cancelar.visible = false
if not ist_message.auto_center then
	x = guo_message.il_child_x + 275 + ((guo_message.il_width_child * 0.5) - (width / 2))
	y = guo_message.il_child_y + 105 + ((guo_message.il_height_child * 0.5) - (height / 2))
end if
dw_1.InsertRow(0)
/*Change Language*/
cb_aceptar.text				= guo_message.is_sok
cb_cancelar.text			= guo_message.is_scancel
pb_copy.PowerTipText	= guo_message.is_scopy
dw_1.Modify('t_title_technical.text="'+guo_message.is_stechnical+'"')
dw_1.SetItem(1,'s_mensaje',ist_message.message)
dw_1.SetItem(1,'s_mensaje_extra',ist_message.technical_message)

/*ShowMessageTechnical*/
if ist_message.show_technical then
	dw_1.Modify('t_title_technical.visible=true')
	height				= 990
	cb_aceptar.y	= 752
	cb_cancelar.y	= 752
	dw_1.height		= 744
	pb_copy.y		= 756
else
	dw_1.Modify('t_title_technical.visible=false')	
	height				= 470
	cb_aceptar.y	= 236
	cb_cancelar.y	= 236
	dw_1.height		= 208
	pb_copy.y		= 240
end if
/*Type Message*/
choose case upper(ist_message.type_message)
	case 'ERR','ERROR'
		dw_1.modify('p_1.filename= "..\img\error.png"')
	case 'MSG','MSJ','MENSAJE','MESSAGE'
		dw_1.modify('p_1.filename= "..\img\mensaje.png"')
	case 'PRG','PREGUNTA','QUS','QUESTION'
		cb_cancelar.visible = true
		cb_aceptar.Text = '&'+guo_message.is_syes
		cb_cancelar.text = '&'+guo_message.is_sno
		dw_1.modify('p_1.filename= "..\img\pregunta.png"')
	case 'ADV','ADVERTENCIA','WAR','WARNING'
		dw_1.modify('p_1.filename= "..\img\advertencia.png"')
end choose

end event

event close;closewithreturn(this,il_respuesta)
end event

type pb_copy from picturebutton within w_message
integer x = 27
integer y = 240
integer width = 110
integer height = 96
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean originalsize = true
string picturename = "Copy1!"
alignment htextalign = left!
end type

event clicked;String	ls_copy,ls_separador

ls_separador	= '========================================'
ls_copy = 	ls_separador+guo_message.is_espacio+&
				ist_message.title+guo_message.is_espacio+&
				ls_separador+guo_message.is_espacio+&
				ist_message.message

if ist_message.show_technical then &
	ls_copy	+= guo_message.is_espacio+ls_separador+guo_message.is_espacio+&
					ist_message.technical_message
					
::Clipboard(ls_copy)
end event

type cb_cancelar from commandbutton within w_message
integer x = 1211
integer y = 236
integer width = 402
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Cancelar"
end type

event clicked;il_respuesta = 2
close(parent)

end event

type cb_aceptar from commandbutton within w_message
integer x = 1623
integer y = 236
integer width = 402
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Aceptar"
boolean default = true
end type

event clicked;il_respuesta = 1
close(parent)

end event

type dw_1 from datawindow within w_message
integer width = 2830
integer height = 208
integer taborder = 10
string title = "none"
string dataobject = "d_message"
boolean border = false
boolean livescroll = true
end type

event constructor;modify('datawindow.Color='+string(parent.backcolor))
modify('t_title_technical.background.color='+string(parent.backcolor))


end event

