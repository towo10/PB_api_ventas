$PBExportHeader$w_menubar.srw
forward
global type w_menubar from window
end type
type p_1 from picture within w_menubar
end type
type st_email_sign from statictext within w_menubar
end type
type dw_2 from uo_dw_titulo_botones within w_menubar
end type
type dw_1 from uo_dw_titulo within w_menubar
end type
end forward

global type w_menubar from window
integer x = 5
integer y = 1
integer width = 3173
integer height = 424
boolean border = false
windowtype windowtype = child!
long backcolor = 134217746
string icon = "AppIcon!"
p_1 p_1
st_email_sign st_email_sign
dw_2 dw_2
dw_1 dw_1
end type
global w_menubar w_menubar

type variables
boolean		ibo_activo =  false
string 		is_ventana_email
end variables

forward prototypes
public subroutine wf_resize (long an_width, long an_height)
public subroutine wf_activar_boton_reconectar ()
public subroutine wf_cerrar_ventanas ()
end prototypes

public subroutine wf_resize (long an_width, long an_height);width = an_width
height = an_height
end subroutine

public subroutine wf_activar_boton_reconectar ();string	ls_img

ls_img = dw_2.describe('p_7.filename')
/*
if guo_sistema.ibo_conectado then
	if ls_img = "..\img\desconectado_80px.png" then 
		//entro
		dw_2.modify('p_7.filename="..\img\conectado_80px.png"')
	end if
else
	if ls_img = "..\img\conectado_80px.png" then 
		//entro
		dw_2.modify('p_7.filename="..\img\desconectado_80px.png"')
	end if
end if
*/
end subroutine

public subroutine wf_cerrar_ventanas ();window w_window, w_window1
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

on w_menubar.create
this.p_1=create p_1
this.st_email_sign=create st_email_sign
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.p_1,&
this.st_email_sign,&
this.dw_2,&
this.dw_1}
end on

on w_menubar.destroy
destroy(this.p_1)
destroy(this.st_email_sign)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event resize;dw_1.resize(WorkSpaceWidth(),dw_1.height)
dw_2.resize(WorkSpaceWidth(),WorkSpaceHeight())
p_1.x = dw_1.width - p_1.width - 110
st_email_sign.x = dw_1.width - st_email_sign.width - 150 -p_1.width
if WorkSpaceWidth() < 4268 then 
	if st_email_sign.visible  then &
		st_email_sign.visible = false
else
	if st_email_sign.visible = false then &
		st_email_sign.visible = true	
end if
	
end event

event open;st_email_sign.backcolor = dw_1.il_color_normal
//ver si lo activamos
//timer(30)
end event

type p_1 from picture within w_menubar
integer x = 951
integer width = 73
integer height = 64
string pointer = "HyperLink!"
boolean originalsize = true
string picturename = "..\img\down_16px.bmp"
boolean focusrectangle = false
end type

event clicked;window lw_child
try
	if not isnull(is_ventana_email) then
		open(lw_child,is_ventana_email)
	else
		MessageBox('Perfil de Usuario','No se asigno ventana de perfil, envie mail a '+&
						guo_sistema.is_mail_error,StopSign!)
		return
	end if
catch (runtimeerror rt)
	MessageBox ("Falló Apertura", rt.getmessage()) //Handle the error or not
end try

end event

type st_email_sign from statictext within w_menubar
integer y = 4
integer width = 850
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 134217856
long backcolor = 16777215
boolean enabled = false
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_2 from uo_dw_titulo_botones within w_menubar
event ue_move_datawindow pbm_mousemove
event ue_proceso pbm_custom01
event ue_informacion pbm_uonexternal02
integer y = 88
integer width = 3141
integer height = 308
integer taborder = 20
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event ue_move_datawindow;dw_1.uf_desactivar_todo()

end event

event ue_proceso;string ls_path
//f_set_microhelpuno('ESTADO','Desconectando el servicio...')
disconnect using sqlca;
//guo_sistema.ibo_conectado = False
///f_set_microhelpuno('ESTADO','Reconectando el servicio...')
ls_path = GetCurrentDirectory() + '\info\data.db'
//if guo_sistema.uof_cargar_config(ls_path) then return
//if not guo_sistema.uof_conectar_servidor(sqlca) then 
	//f_set_microhelpuno('ESTADO','Cerrando ventanas...')
//	wf_cerrar_ventanas()
//	w_menubar.wf_activar_boton_reconectar()
	//f_set_microhelpuno('ESTADO','Listo')
//	f_mensaje('Reconectado','Se conecto correctamente.','','MSJ')
///end if
end event

event ue_informacion;//open(w_informacion)
end event

type dw_1 from uo_dw_titulo within w_menubar
integer width = 3109
integer height = 88
integer taborder = 10
end type

event constructor;call super::constructor;uf_insertar_titulo('Inicio'					,1,1)
uf_insertar_titulo('Ventas'				,2,1)
uf_insertar_titulo('Almacenamiento'	,3,3)
uf_insertar_titulo('Mantenimiento'		,4,3)
uf_insertar_titulo('Pagos y Cobranza'	,5,4)
uf_insertar_titulo('Reportes'				,6,2)
uf_insertar_titulo('Ayuda'					,7,1)
uf_iniciar_titulos()

uf_iniciar_pestana(1)
end event

event ue_activar;call super::ue_activar;dw_2.uf_reset()
string	ls_carpeta,ls_extra
ls_carpeta = '..\img\'


choose case is_name
	case 'd1' //inicio
		ls_extra	= 'usuario_mujer_80px.png'
/*		if guo_sistema.is_sexo = 'M' then
			ls_extra	= 'usuario_hombre_80px.png'
		else
			ls_extra	= 'usuario_mujer_80px.png'
		end if
		*/
		dw_2.uf_boton_grande	('Datos Personales'			,1,ls_carpeta+ls_extra,'w_usuario',true)
		dw_2.uf_boton_grande	('Datos de la Tienda'			,2,ls_carpeta+'tienda_40px.png','w_tienda_v2',true)
		dw_2.uf_boton_largo		('Grupo de Favoritos'			,3,ls_carpeta+'favorito_40px.png','w_favorito_grupo',true)
		dw_2.uf_boton_largo		('Especificar Impresora'		,4,ls_carpeta+'impresora_40px.png','printsetup',false)
		dw_2.uf_boton_largo		('Información de Conexión'	,5,ls_carpeta+'server_40px.png','w_sys_conexion',false)
		//dw_2.uf_boton_grande	('Crear Usuarios'				,6,ls_carpeta+'users_80px.png','w_crear_usuario',true)
		dw_2.uf_boton_grande	('Re-conectar'					,7,ls_carpeta+'conectado_80px.png','event:ue_proceso',false)
		//dw_2.uf_boton_grande	('Probar'							,8,ls_carpeta+'conectado_80px.png','w_padre_tab',true)
		dw_2.uf_iniciar_botones()
		return
	case 'd2'//ventas
		dw_2.uf_boton_grande	('Generar Venta'					,8,ls_carpeta+	'factura_40px.png','w_man_factura',true)
		dw_2.uf_boton_grande	('Generar Pre-Venta'				,9,ls_carpeta+	'preventa.png','w_man_proforma',true)
		dw_2.uf_boton_largo		('Tipo de Cambio'					,10,ls_carpeta+	'moneda.png','w_man_tipo_cambio',true)
		dw_2.uf_boton_largo		('Tipo de Factura'					,11,ls_carpeta+	'tipo_factura.png','w_mto_tipo_factura',true)
		//dw_2.uf_boton_largo		('Series y/o Facturas'		,9,ls_carpeta+	'serie.png','w_mto_fact_serie',true)
		dw_2.uf_boton_largo		('Tipo de documento'				,12,ls_carpeta+	'dni_80px.png','w_man_tipo_documento',true)
		dw_2.uf_boton_grande	('Moneda'							,13,ls_carpeta+	'moneda_40px.png','w_moneda',true)
		dw_2.uf_boton_grande	('Orden de Compra'				,14,ls_carpeta+	'orden_compra_30px.png','w_orden_compra',true)
		dw_2.uf_boton_largo		('Aprob./Recha. O. Compra'		,15,ls_carpeta+	'tipo_84px.png','w_orden_compra_aprob',true)
		dw_2.uf_iniciar_botones()
		return
	case 'd3'//almacenamiento
		dw_2.uf_boton_grande	('Ingreso de Productos'			,14,ls_carpeta+	'ingreso_40px.png','w_transaccion',true)
		dw_2.uf_boton_grande	('Salida de Productos'				,15,ls_carpeta+	'salida_40px.png','w_man_sal_transac',true)
		dw_2.uf_boton_largo		('Tipos de Transacciones'		,16,ls_carpeta+	'tipo_transaccion_40px.png','w_tipo_transaccion',true)
		dw_2.uf_boton_grande	('Productos Nuevos'				,17,ls_carpeta+	'producto_nuevo_30px.png','w_productos_nuevos',true)
		dw_2.uf_boton_grande	('Productos'							,18,ls_carpeta+	'producto_40px.png','w_producto',true)
		
		dw_2.uf_boton_largo		('Categoría'							,19,ls_carpeta+	'categoria_40px.png','w_categoria',true)
		dw_2.uf_boton_largo		('Sub-Categoría'					,20,ls_carpeta+	'subcategoria_40px.png','w_subcategoria',true)
		dw_2.uf_boton_largo		('Color'								,21,ls_carpeta+	'color_80px.png','w_color',true)
		dw_2.uf_boton_largo		('Unidad de Medida'				,22,ls_carpeta+	'um_40px.png','w_unidad_medida',true)
		dw_2.uf_boton_largo		('Talle'								,23,ls_carpeta+	'talla_40px.png','w_tallas',true)
		dw_2.uf_boton_largo		('Marca'								,24,ls_carpeta+	'marca_40px.png','w_marcas',true)
		dw_2.uf_boton_grande	('Periodo'							,25,ls_carpeta+	'periodo_40px.png','w_periodo',true)
		dw_2.uf_iniciar_botones()
		return
	case 'd4'//mantenimientos
		dw_2.uf_boton_grande	('Usuarios'							,6,ls_carpeta+'users_80px.png','w_crear_usuario',true)
		dw_2.uf_boton_grande	('Proveedor o Cliente'				,26,ls_carpeta+	'cliente.png','w_man_entidad',true)
		dw_2.uf_boton_largo		('Tipo Cliente o Provee.'			,27,ls_carpeta+	'tipo_usuario.png','w_man_tipo_entidad',true)
		dw_2.uf_boton_largo		('Area'								,28,ls_carpeta+	'area.png','w_mto_area',true)
		dw_2.uf_boton_largo		('Cargo'								,29,ls_carpeta+	'cargo.png','w_mto_cargo',true)
		dw_2.uf_boton_grande	('Contactos'							,30,ls_carpeta+	'contacto.png','w_man_contacto',true)
		dw_2.uf_boton_grande	('País'									,31,ls_carpeta+	'pais.png','w_man_pais',true)
		dw_2.uf_boton_grande	('Estado o Región'					,32,ls_carpeta+	'region.png','w_man_estado',true)
		dw_2.uf_boton_grande	('Ciudad'								,33,ls_carpeta+	'ciudad.png','w_man_ciudad',true)
		dw_2.uf_iniciar_botones()
		return
	case 'd5'//Pagos y Cobranza
		dw_2.uf_boton_grande	('Pagos o Cobranzas'				,34,ls_carpeta+	'moneda3.png','w_mto_pago_servicio',true)
		dw_2.uf_boton_largo		('Subtipo Pago/Cobranza'	,35,ls_carpeta+	'11-folder1.png','w_mto_tipo_pago_servicio',true)
		dw_2.uf_boton_grande	('Ventas Postnet'					,36,ls_carpeta+	'postnet.png','',true)
		dw_2.uf_iniciar_botones()
		return
	case 'd6'
		dw_2.uf_boton_grande	('kardex'			,34,ls_carpeta+	'kardex.png','w_rep_kardex',true)
		dw_2.uf_boton_grande	('Ventas'			,35,ls_carpeta+	'reporte_venta.png','w_rep_ventas',true)
		
		dw_2.uf_iniciar_botones()
		return
	case 'd7'
		dw_2.uf_boton_grande	('Información'				,36,ls_carpeta+	'help_40px.png','event:ue_informacion',true)
		dw_2.uf_iniciar_botones()
		return
end choose

end event

