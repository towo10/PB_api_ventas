﻿$PBExportHeader$uo_sistema.sru
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
					is_token,&
					is_user_local
					
Integer			ii_tienda,&
					ii_usuario,&
					ii_language = 1,&
					ii_exists_offline,&
					ii_exists_online,&
					ii_autologin,&
					ii_autologin_local
					
Long				il_height,&
					il_width,il_width_child,il_height_child,il_child_x,il_child_y
					
					
CrypterObject 	inv_CrypterObject					
end variables
forward prototypes
public function boolean uof_cargar_config (string as_path, ref string as_error)
public function boolean uof_request (string as_event, string as_proceso, string as_json, ref jsonpackage as_json_response, ref string as_error)
public function string uof_language (string as_ventana)
public function string uof_encrypt (string as_origen)
public function string uof_deencrypt (string as_origen)
public function boolean uof_window_active (string as_ventana)
public subroutine uof_set_autolocal (integer an_autolocal)
public function boolean uof_begin_session (string as_url, string as_email, string as_pass, ref integer an_error, ref string as_error)
public function boolean uof_begin_local_session (string as_user, string as_pass, ref integer an_error, ref string as_error)
public subroutine uof_set_resize_system (long an_width, long an_height)
public subroutine uof_set_height_child (long an_height)
public subroutine uof_set_width_child (long an_width)
public subroutine uof_set_x_child (long an_x)
public subroutine uof_set_y_child (long an_y)
end prototypes

public function boolean uof_cargar_config (string as_path, ref string as_error);string 	ls_dbparm

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
		as_error	= uof_language('sistema_error_driver')
		return true
	end if
else
	as_error	= uof_language('sistema_error_path')+as_path
	return true
END IF 
/*User*/
select	count(*) into :ii_exists_offline
from	user using sqlca;
/*Setting*/
select	count(*) into :ii_exists_online
from	setting using sqlca;

if ii_exists_online > 0 then
	/*Cargamos Datos Iniciales*/
	select		url,email,ifnull(language_id,1),case when password is null then 0 else 1 end
	into 		:is_url,:is_mail,:ii_language,:ii_autologin
	from		setting a
	where	a.id = 1
	using sqlca;
end if
if ii_exists_offline > 0 then
	select		user,ifnull(auto,0)
	into 		:is_user_local,:ii_autologin_local
	from		user
	where	id = 1
	using sqlca;
end if
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
	destroy lnv_HttpClient
	return false
elseif li_rc = -2 then
	as_error = uof_language('sistema_error_url')
	destroy lnv_HttpClient
	return false
elseif li_rc = -3 then
	as_error = uof_language('sistema_error_conn')
	destroy lnv_HttpClient
	return false
elseif li_rc = -4 then
	as_error = uof_language('sistema_error_time')
	destroy lnv_HttpClient
	return false
else
	as_error = string(li_rc)+','+string(lnv_HttpClient.GetResponseStatusCode())
	destroy lnv_HttpClient
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

public subroutine uof_set_autolocal (integer an_autolocal);Integer	li_find
Long		ll_code
String		ls_error


select	count(*) into:li_find 
from	setting
using sqlca;

if li_find = 0 then
	insert into setting(id,autologin_local)
	values(1,:an_autolocal)
	using sqlca;	
	if f_ok_transaccion(sqlca,ll_code,ls_error) then 
		commit using sqlca;
	end if
else
	update setting
	set autologin_local = :an_autolocal
	where id = 1
	using sqlca;	
	if f_ok_transaccion(sqlca,ll_code,ls_error) then
		commit using sqlca;
	end if
end if
end subroutine

public function boolean uof_begin_session (string as_url, string as_email, string as_pass, ref integer an_error, ref string as_error);String				ls_json,ls_error,ls_status
JsonPackage	json_response,json_result
json_response	= create JsonPackage
json_result		= create JsonPackage
SetPointer(HourGlass!)

ls_json	= '{"user" : "'+as_email+'",'+&
    				'"password" :"'+as_pass+'"}'
is_url = as_url
if not uof_request('POST','auth',ls_json,json_response,ls_error) then
	an_error = -1
	as_error = ls_error
	destroy json_response
	destroy json_result
	return false
end if

ls_status 	= json_response.getvalue("status")
json_result.loadstring(json_response.getvalue("result"))

if not Isnull(ls_status) and ls_status = 'ok' then
	is_token = json_result.getvalue("token")
	ii_tienda = Integer(json_result.getvalue("idtienda"))
	ii_usuario = Integer(json_result.getvalue("idusuario"))
	destroy json_response
	destroy json_result
	return true
else
	as_error = Trim(json_result.getvalue("error_message"))
	an_error = 1
	destroy json_response
	destroy json_result
	return false
end if
end function

public function boolean uof_begin_local_session (string as_user, string as_pass, ref integer an_error, ref string as_error);Integer	li_count

select		count(*)
into		:li_count
from		user
where 	user = :as_user
			and password = :as_pass
using sqlca;

if li_count = 0 then
	an_error	= 1
	as_error	= uof_language('sistema_error_login')
	return false
end if

return true
end function

public subroutine uof_set_resize_system (long an_width, long an_height);if il_width <> an_width then &
	il_width = an_width

if il_height <> an_height then &
	il_height = an_height

end subroutine

public subroutine uof_set_height_child (long an_height);if il_height_child = an_height then return
il_height_child = an_height
end subroutine

public subroutine uof_set_width_child (long an_width);if il_width_child = an_width then return
il_width_child = an_width
end subroutine

public subroutine uof_set_x_child (long an_x);if il_child_x = an_x then return
il_child_x = an_x
end subroutine

public subroutine uof_set_y_child (long an_y);if il_child_y = an_y then return
il_child_y = an_y
end subroutine

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

