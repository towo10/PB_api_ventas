$PBExportHeader$w_login.srw
forward
global type w_login from window
end type
type sle_2 from singlelineedit within w_login
end type
type sle_1 from singlelineedit within w_login
end type
end forward

global type w_login from window
integer width = 4754
integer height = 1980
boolean titlebar = true
string title = "Inicio de Sesión"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
sle_2 sle_2
sle_1 sle_1
end type
global w_login w_login

on w_login.create
this.sle_2=create sle_2
this.sle_1=create sle_1
this.Control[]={this.sle_2,&
this.sle_1}
end on

on w_login.destroy
destroy(this.sle_2)
destroy(this.sle_1)
end on

event open;sle_1.text	= guo_sistema.is_computer+'@'+guo_sistema.is_computer_user
sle_2.text	= guo_sistema.is_computer_user
end event

type sle_2 from singlelineedit within w_login
integer x = 389
integer y = 588
integer width = 1682
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within w_login
integer x = 457
integer y = 332
integer width = 1591
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
end type

