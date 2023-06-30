$PBExportHeader$w_sheet_1.srw
forward
global type w_sheet_1 from window
end type
end forward

global type w_sheet_1 from window
integer width = 4754
integer height = 1980
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
end type
global w_sheet_1 w_sheet_1

on w_sheet_1.create
end on

on w_sheet_1.destroy
end on

event open;parentwindow().dynamic post function wf_enabled_smallbutton("Sort",True)
end event

