$PBExportHeader$uo_servicio_sesion.sru
forward
global type uo_servicio_sesion from nonvisualobject
end type
end forward

global type uo_servicio_sesion from nonvisualobject
end type
global uo_servicio_sesion uo_servicio_sesion

type variables
String						is_documentos
uo_traslado_sesion	iuo_traslado
uo_sistema				iuo_sistema
HttpClient 				inv_HttpClient
end variables
forward prototypes
public subroutine uof_iniciar_proceso (uo_traslado_sesion auo_traslado)
public subroutine uof_estado_conexion (string as_conectado)
public subroutine uof_consultando (string as_estado)
end prototypes

public subroutine uof_iniciar_proceso (uo_traslado_sesion auo_traslado);
JsonPackage json,json_response
String		ls_string,ls_status,ls_message
Integer	li_rc


iuo_traslado		= auo_traslado
json 				= Create JsonPackage

inv_HttpClient.SetRequestHeader("Content-Type", "application/json;charset=UTF-8")

uof_consultando('S')
li_rc = inv_HttpClient.SendRequest("GET", iuo_sistema.is_url+"/ping" , '' , EncodingUTF8!)
if li_rc = 1 and inv_HttpClient.GetResponseStatusCode() = 200 then
	inv_HttpClient.GetResponseBody(ls_string)
	json.loadstring(ls_string)
	
	ls_status = json.getvalue("ping")
	if ls_status = "pong" then
		uof_estado_conexion('S')
	else
		uof_estado_conexion('N')
	end if
else
	uof_estado_conexion('N')
end if
uof_consultando('N')
end subroutine

public subroutine uof_estado_conexion (string as_conectado);iuo_traslado.uof_estado_conexion(as_conectado)
end subroutine

public subroutine uof_consultando (string as_estado);iuo_traslado.uof_consultando(as_estado)
end subroutine

on uo_servicio_sesion.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_servicio_sesion.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;String		ls_path,ls_error
iuo_sistema			= create uo_sistema
ls_path 				= GetCurrentDirectory() + '\info\system.db'
is_documentos		= f_carpetas_personales(7)


iuo_sistema.uof_cargar_config(ls_path,ls_error)

inv_HttpClient 	= Create HttpClient

end event

event destructor;destroy iuo_sistema
destroy inv_HttpClient
end event

