$PBExportHeader$uo_sistema.sru
forward
global type uo_sistema from nonvisualobject
end type
end forward

global type uo_sistema from nonvisualobject
end type
global uo_sistema uo_sistema

type variables
constant string	is_compania 				= 'SebaSoft',&
					is_mail_error 				= 'sebasoft.arg@gmail.com',& 
					is_mail_error_sistema	= 'sebasoft.error@gmail.com',&
					is_mail_contacto			= 'wildertn.arg@gmail.com',&
					is_nombre_sistema 		= 'Sistema Integral de Gestión de Ventas',&
					is_producto					= 'SIGVELite'

String				is_espacio,&
					is_computer,&
					is_computer_user,&
					is_url,&
					is_mail,&
					is_pass
			
Transaction		isqlcb
end variables

forward prototypes
public function boolean uof_cargar_config (string as_path, ref string as_error)
public function boolean uof_request (string as_event, string as_proceso, string as_json, ref jsonpackage as_json_response, ref string as_error)
end prototypes

public function boolean uof_cargar_config (string as_path, ref string as_error);string ls_dbparm
IF Fileexists(as_path) THEN
	ls_dbparm = "ConnectString='"  
	ls_dbparm = ls_dbparm + "DRIVER=SQLite3 ODBC Driver;"   
	ls_dbparm = ls_dbparm + "Database=" + as_path + "'"   
	ls_dbparm = ls_dbparm + "UID=" + "admin" + ";PWD="  
	ls_dbparm = ls_dbparm +  "'"   
	isqlcb.DbParm=ls_dbparm   
	isqlcb.autocommit = true
	isqlcb.DBMS = "ODBC" 
	
	connect using isqlcb;
	if isqlcb.sqlcode <> 0 then
		as_error	= 'No se puede iniciar el sistema de configuración, revise si instaló el '+&
		'driver: SQLite3 ODBC Driver.'
		return true
	end if
else
	as_error	= 'No se encontró el Archivo de Configuración, para volver a utilizar '+&
	'el sistema necesita reinstalarlo.~n~rfile: '+as_path
	return true
END IF 

/*Cargamos Datos Iniciales*/

select url,email,pass into :is_url,:is_mail,:is_pass
from servicio a
where  a.id = (select max(x.id) from servicio x)
using isqlcb;

return false

end function

public function boolean uof_request (string as_event, string as_proceso, string as_json, ref jsonpackage as_json_response, ref string as_error);Integer li_rc
String ls_string,ls_status
HttpClient lnv_HttpClient

lnv_HttpClient = Create HttpClient


lnv_HttpClient.SetRequestHeader("Content-Type", "application/json;charset=UTF-8")
li_rc = lnv_HttpClient.SendRequest(as_event, is_url+"/"+as_proceso, as_json, EncodingUTF8!)

if li_rc = 1 and lnv_HttpClient.GetResponseStatusCode() = 200 then
	lnv_HttpClient.GetResponseBody(ls_string)
	as_json_response.loadstring(ls_string)
elseif li_rc = -1 then
	as_error = 'Error general del ApiRest'
	return false
elseif li_rc = -2 then
	as_error = 'URL inválido'
	return false
elseif li_rc = -3 then
	as_error = 'No se puede conectar a Internet, verifique los datos de conección'
	return false
elseif li_rc = -1 then
	as_error = 'La consulta del Api demoró mas lo esperado, vuelva a intentarlo'
	return false
end if

destroy lnv_HttpClient
return true
end function

event constructor;string			ls_error
integer		li_rc
OleObject	ole_wsh

is_espacio		= string(char(13)) + string (char(10))
isqlcb				= create transaction
try
	ole_wsh = CREATE OleObject
	li_rc = ole_wsh.ConnectToNewObject ( "WScript.Network" )
	IF li_rc = 0 THEN
		is_computer_user	= ole_wsh.UserName
		is_computer			= ole_wsh.ComputerName
	END IF
catch (runtimeerror er)
	ls_error	= er.getmessage()
	is_computer_user	= 'Error'
	is_computer			= 'Error'
end try


end event

on uo_sistema.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_sistema.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;destroy isqlcb
end event

