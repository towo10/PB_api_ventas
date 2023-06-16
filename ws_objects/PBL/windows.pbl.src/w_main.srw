$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type mdi_1 from mdiclient within w_main
end type
end forward

global type w_main from window
integer width = 2130
integer height = 1296
boolean titlebar = true
string menuname = "m_dummy"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = mdi!
windowstate windowstate = maximized!
long backcolor = 268435456
string icon = "AppIcon!"
boolean center = true
mdi_1 mdi_1
end type
global w_main w_main

on w_main.create
if this.MenuName = "m_dummy" then this.MenuID = create m_dummy
this.mdi_1=create mdi_1
this.Control[]={this.mdi_1}
end on

on w_main.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

event open;if IsValid(w_login_v2) then &
	close(w_login_v2)

title	= guo_sistema.uof_language(ClassName()+'_title')
open(w_xplistbar,this)
w_xplistbar.x = 10
w_xplistbar.y = 10
w_xplistbar.height = WorkSpaceHeight()
end event

type mdi_1 from mdiclient within w_main
long BackColor=268435456
end type

