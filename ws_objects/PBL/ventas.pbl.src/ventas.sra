﻿$PBExportHeader$ventas.sra
$PBExportComments$Generated Application Object
forward
global type ventas from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables
uo_sistema 			guo_sistema
datawindow			gdw_activo
window				gw_activo,gw_mdi
end variables

global type ventas from application
string appname = "ventas"
string themepath = "C:\Program Files (x86)\Appeon\PowerBuilder 19.0\IDE\theme"
string themename = "Do Not Use Themes"
boolean nativepdfvalid = false
boolean nativepdfincludecustomfont = false
string nativepdfappname = ""
long richtextedittype = 2
long richtexteditx64type = 3
long richtexteditversion = 1
string richtexteditkey = ""
string appicon = ""
string appruntimeversion = "19.2.0.2779"
end type
global ventas ventas

on ventas.create
appname="ventas"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on ventas.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;string ls_path,ls_error

guo_sistema 	= create uo_sistema
ls_path 			= GetCurrentDirectory() + '\info\system.db'

if guo_sistema.uof_cargar_config(ls_path,ls_error) then 
	MessageBox('Carga de Configuración',ls_error,StopSign!)
	return
end if
open(w_login)
end event

event close;destroy guo_sistema
end event

