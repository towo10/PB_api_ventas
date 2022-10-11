$PBExportHeader$w_login.srw
forward
global type w_login from window
end type
type dw_1 from datawindow within w_login
end type
end forward

global type w_login from window
integer width = 2853
integer height = 1664
boolean border = false
windowtype windowtype = popup!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
end type
global w_login w_login

type variables
uo_traslado_sesion	iuo_traslado
uo_servicio_sesion		iuo_servicio
string		is_consultando
end variables

forward prototypes
public subroutine wf_verificar_servicio ()
public subroutine wf_iniciar_sesion (boolean abo_automatico)
end prototypes

public subroutine wf_verificar_servicio ();st_matriz			lst_matriz

iuo_traslado	= create uo_traslado_sesion
iuo_servicio = create uo_servicio_sesion

lst_matriz.adw_matriz[1] = dw_1

iuo_traslado.uof_setdatos(lst_matriz)

SharedObjectRegister("uo_servicio_sesion", "iuo_servicio") 
SharedObjectGet("iuo_servicio",iuo_servicio)
iuo_servicio.post function uof_iniciar_proceso(iuo_traslado)
SharedObjectUnRegister('iuo_servicio') 
end subroutine

public subroutine wf_iniciar_sesion (boolean abo_automatico);String				ls_servicio,ls_json,ls_mail,ls_pass,ls_error,ls_status

dw_1.accepttext( )
ls_servicio	= dw_1.GetItemString(1,'flg_conectado')
ls_mail		= dw_1.GetItemString(1,'dsc_correo')
ls_pass		= dw_1.GetItemString(1,'dsc_contrasena')


if ls_servicio = 'N' and not abo_automatico then
	MessageBox('Error de Conexión','El servicio no se encuentra disponible, verifique la configuración de conección o contactenos a '+&
	guo_sistema.is_mail_error_sistema,StopSign!)
	return
end if

JsonPackage	json_response,json_result
json_response	= create JsonPackage
json_result		= create JsonPackage

ls_json	= '{"user" : "'+ls_mail+'",'+&
    				'"password" :"'+ls_pass+'"}'

if not guo_sistema.uof_request('POST','auth',ls_json,json_response,ls_error) then
	MessageBox('Error Iniciando Sesión',ls_error,StopSign!)
	return
end if

ls_status 	= json_response.getvalue("status")
json_result.loadstring(json_response.getvalue("result"))

if ls_status = 'ok' then
	guo_sistema.is_token = json_result.getvalue("token")
	guo_sistema.ii_tienda = Integer(json_result.getvalue("idtienda"))
	guo_sistema.ii_usuario = Integer(json_result.getvalue("idusuario"))
	open(w_main)
	close(w_login)
	return
else
	MessageBox('Error',json_result.getvalue("error_message"))
end if
end subroutine

on w_login.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_login.destroy
destroy(this.dw_1)
end on

event open;timer(1)

if not f_cadena_vacio_nulo(guo_sistema.is_mail) then
	dw_1.SetItem(1,'dsc_correo',guo_sistema.is_mail)
	dw_1.SetItem(1,'flg_recordar','S')	
end if

if not f_cadena_vacio_nulo(guo_sistema.is_pass) then
	dw_1.SetItem(1,'dsc_contrasena',guo_sistema.is_pass)
	dw_1.SetItem(1,'flg_sesion_auto','S')	
	
	post wf_iniciar_sesion(true)
end if

end event

event timer;is_consultando	= dw_1.GetItemString(1,'flg_consultando')
if is_consultando = 'N' then &
	wf_verificar_servicio()
end event

event close;destroy iuo_traslado
destroy iuo_servicio
end event

type dw_1 from datawindow within w_login
integer width = 2862
integer height = 1668
integer taborder = 30
string title = "none"
string dataobject = "d_login"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;InsertRow(0)
end event

event clicked;choose case dwo.name
	case 'p_iniciar'
		wf_iniciar_sesion(false)
	case 'p_herramienta'
		
	case 'p_close'
		close(parent)
end choose
end event

