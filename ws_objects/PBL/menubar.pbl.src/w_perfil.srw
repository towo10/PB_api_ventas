$PBExportHeader$w_perfil.srw
forward
global type w_perfil from window
end type
type dw_1 from datawindow within w_perfil
end type
end forward

global type w_perfil from window
integer width = 1417
integer height = 1168
windowtype windowtype = popup!
long backcolor = 12632256
string icon = "AppIcon!"
windowanimationstyle openanimation = toproll!
windowanimationstyle closeanimation = bottomroll!
dw_1 dw_1
end type
global w_perfil w_perfil

type variables
boolean abo_procesando
end variables

forward prototypes
public subroutine wf_cerrar_ventana ()
end prototypes

public subroutine wf_cerrar_ventana ();window w_window, w_window1
boolean lb_valid

w_window1 = w_main.GetFirstSheet( )
IF IsValid(w_window1) THEN
 lb_Valid = True
 DO
  w_window = w_main.GetNextSheet(w_window1)
  IF IsValid(w_window) THEN
   close(w_window)
   lb_valid = True
  ELSE
   lb_valid = False
  END IF
 LOOP WHILE lb_Valid
 close(w_window1)
END IF
end subroutine

on w_perfil.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_perfil.destroy
destroy(this.dw_1)
end on

event deactivate;if not abo_procesando then
	close(this)
end if
end event

event open;//
y = 180
x =  guo_sistema.il_width - width - 150
end event

type dw_1 from datawindow within w_perfil
integer y = 8
integer width = 2921
integer height = 1344
integer taborder = 10
string title = "none"
string dataobject = "d_perfil_local"
boolean border = false
boolean livescroll = true
end type

event constructor;string	ls_password
settransobject(sqlca)
retrieve(guo_sistema.is_mail)


ls_password = getitemstring(1,'password')
//setitem(1,'password',f_desencriptar(ls_password))
end event

event buttonclicked;integer	li_autosign,li_autosignx,li_exists,li_estado
string		ls_email,ls_password,ls_null,ls_remember
boolean	abo_sign = false
setnull(ls_null)
dw_1.accepttext( )

choose case dwo.name
	case 'b_1'
		abo_procesando = true
		li_autosign = dw_1.getitemnumber(1,'autosign')
		ls_remember = dw_1.getitemstring(1,'remember')
		ls_email = dw_1.getitemstring(1,'email')
		ls_password = dw_1.getitemstring(1,'password')
		
		if ls_remember = 'S' then
			
			if li_autosign = 1 then
				if f_cadena_vacio_nulo(ls_password) then
					MessageBox('Perfil','Tiene que ingresar password para validar cambios')
					return
				end if
				abo_sign = true
			end if
			
			DECLARE p_inicio_sesion PROCEDURE FOR sp_iniciar_sesion (:ls_email,:ls_password)
			USING SQLCA;
			
			EXECUTE p_inicio_sesion;
			FETCH p_inicio_sesion INTO :li_estado;
			close p_inicio_sesion;
			
			if sqlca.sqlcode <> 0 then 
				MessageBox('Inicio de Sesión','No se puede iniciar sesión por ahora, intentelo nuevamente~n~r'+&
								'o mande un mail a '+guo_sistema.is_mail_error,StopSign!)
				return
			end if
			if li_estado = -1 then
				MessageBox('Inicio de Sesión','Email y/o Password inválido.',StopSign!)
				return
			end if
			
			guo_sistema.is_mail = ls_email
			if abo_sign then
				////setitem(1,'password',f_encriptar(ls_password))
			else
				setitem(1,'password',ls_null)
			end if
			
			if update( ) = 1 then
				commit using sqlca;
			else
				rollback using sqlca;
				Messagebox('Perfil','No se puede actualizar el perfil.')
				return
			end if
			//guo_sistema.uof_cargar_usuario(ls_email)
			//f_set_microhelpuno('USUARIO',guo_sistema.is_nombres+'  '+guo_sistema.is_apellidos)
			w_menubar.st_email_sign.text = guo_sistema.is_mail
			w_xplistbar.dw_1.reset()
			w_xplistbar.dw_1.event constructor( )
			wf_cerrar_ventana()
		else
			delete from user using sqlca;
			commit using sqlca;
		end if
		abo_procesando = false
		close(parent)
end choose
end event

