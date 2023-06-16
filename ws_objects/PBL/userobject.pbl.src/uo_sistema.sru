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
					is_pass,&
					is_token
					
Integer			ii_tienda,&
					ii_usuario,&
					ii_language
					
CrypterObject 	inv_CrypterObject					
end variables

forward prototypes
public function boolean uof_cargar_config (string as_path, ref string as_error)
public function boolean uof_request (string as_event, string as_proceso, string as_json, ref jsonpackage as_json_response, ref string as_error)
public function string uof_language (string as_ventana)
public function string uof_encrypt (string as_origen)
public function string uof_deencrypt (string as_origen)
public function boolean uof_window_active (string as_ventana)
end prototypes

public function boolean uof_cargar_config (string as_path, ref string as_error);string ls_dbparm
IF Fileexists(as_path) THEN
	ls_dbparm = "ConnectString='"  
	ls_dbparm = ls_dbparm + "DRIVER=SQLite3 ODBC Driver;"   
	ls_dbparm = ls_dbparm + "Database=" + as_path + "'"   
	ls_dbparm = ls_dbparm + "UID=" + "admin" + ";PWD="  
	ls_dbparm = ls_dbparm +  "'"   
	sqlca.DbParm=ls_dbparm   
	sqlca.autocommit = true
	sqlca.DBMS = "ODBC" 
	
	connect using sqlca;
	if sqlca.sqlcode <> 0 then
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

select url,email,password,language_id into :is_url,:is_mail,:is_pass,:ii_language
from setting a
using sqlca;

if IsNull(ii_language) or ii_language < 1 then &
	ii_language = 1

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
	as_error = uof_language('sistema_error_api')
	return false
elseif li_rc = -2 then
	as_error = uof_language('sistema_error_url')
	return false
elseif li_rc = -3 then
	as_error = uof_language('sistema_error_conn')
	return false
elseif li_rc = -1 then
	as_error = uof_language('sistema_error_time')
	return false
end if

destroy lnv_HttpClient
return true
end function

public function string uof_language (string as_ventana);string	ls_string

select 	value
into		:ls_string
from 		string
where 	upper(data) = upper(:as_ventana)
			and language_id = :ii_language
using sqlca;

if IsNull(ls_string) then &
	ls_string = ''
	
return ls_string
end function

public function string uof_encrypt (string as_origen);Blob	lblb_data,lblb_encrypt,lblb_key,lblb_iv


lblb_data = Blob(as_origen, EncodingANSI!)
lblb_key = Blob(mid(is_compania + fill('0',16),1,16), EncodingANSI!)
lblb_iv = Blob(mid(is_producto,1,9) + fill('0',9), EncodingANSI!)

lblb_encrypt = inv_CrypterObject.SymmetricEncrypt(AES!,lblb_data,lblb_key, OperationModeCBC!,lblb_iv,PKCSPadding!)

return String(lblb_encrypt)
end function

public function string uof_deencrypt (string as_origen);Blob	lblb_data,lblb_dencrypt,lblb_key,lblb_iv

lblb_key = Blob(mid(is_compania + fill('0',16),1,16), EncodingANSI!)
lblb_iv = Blob(mid(is_producto,1,9) + fill('0',9), EncodingANSI!)
lblb_data = Blob(as_origen)

lblb_dencrypt = inv_CrypterObject.SymmetricDecrypt(AES!,lblb_data,lblb_key, OperationModeCBC!,lblb_iv,PKCSPadding!)

return String(lblb_dencrypt,EncodingANSI!)
end function

public function boolean uof_window_active (string as_ventana);long	ll_find
select	count(*) into :ll_find
from sys_temp_vent_activa
where dsc_ventana = :as_ventana
using sqlca;



if ll_find > 0 then &
	return true
	
return false
end function

event constructor;string			ls_error
integer		li_rc
OleObject	ole_wsh

is_espacio			= string(char(13)) + string (char(10))
inv_CrypterObject = Create CrypterObject
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

