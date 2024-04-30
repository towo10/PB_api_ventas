$PBExportHeader$w_xplistbar.srw
forward
global type w_xplistbar from window
end type
type st_1 from statictext within w_xplistbar
end type
type dw_proceso from datawindow within w_xplistbar
end type
type dw_1 from u_dw_xplistbar within w_xplistbar
end type
end forward

global type w_xplistbar from window
integer x = 5
integer width = 1134
integer height = 2424
boolean border = false
windowtype windowtype = child!
long backcolor = 15780518
string icon = "AppIcon!"
event ue_clicked ( string as_text )
event ue_agregar pbm_custom01
st_1 st_1
dw_proceso dw_proceso
dw_1 dw_1
end type
global w_xplistbar w_xplistbar

type variables
long		il_row
end variables

forward prototypes
public subroutine wf_nuevo_menu (string as_imagen, string as_descripcion, string as_evento)
public subroutine wf_activar_menu ()
public subroutine wf_post_resize ()
public subroutine wf_reiniciar ()
public subroutine wf_mm_boton (long an_row)
public subroutine wf_mm_reset ()
public subroutine wf_activar_check_boton (string as_evento, boolean abo_activar)
public subroutine wf_activar_cambio_img_boton (string as_evento, string as_imagen)
end prototypes

event ue_agregar;//opensheet(w_man_cat_favor,w_principal,gi_pto_ventana,original!)
end event

public subroutine wf_nuevo_menu (string as_imagen, string as_descripcion, string as_evento);long	ll_insert
ll_insert	= dw_proceso.insertrow(0)

dw_proceso.setitem(ll_insert,'id',ll_insert)
dw_proceso.setitem(ll_insert,'imagen',as_imagen)
dw_proceso.setitem(ll_insert,'descripcion',as_descripcion)
dw_proceso.setitem(ll_insert,'evento',as_evento)
dw_proceso.setitem(ll_insert,'tipo',1)


end subroutine

public subroutine wf_activar_menu ();if this.width < 1244 then this.width = 1244
end subroutine

public subroutine wf_post_resize ();if dw_1.height <> height - 20  then
	dw_1.height = height - 20
	dw_proceso.height = dw_1.height
end if
end subroutine

public subroutine wf_reiniciar ();dw_proceso.reset( )
end subroutine

public subroutine wf_mm_boton (long an_row);if dw_proceso.GetItemNumber(an_row,'tipo') = 1 then
	wf_mm_reset()
	dw_proceso.SetItem(an_row,'tipo',2)
end if
end subroutine

public subroutine wf_mm_reset ();long	ll_x
for ll_x = 1 to dw_proceso.rowcount( )
	if dw_proceso.GetItemNumber(ll_x,'tipo') = 2 then
		dw_proceso.SetItem(ll_x,'tipo',1)
	end if
next

end subroutine

public subroutine wf_activar_check_boton (string as_evento, boolean abo_activar);integer	li_x

for li_x = 1 to dw_proceso.rowcount( )
	if dw_proceso.GetItemString(li_x,'evento') = as_evento then
		if abo_activar then
			dw_proceso.setitem(li_x,'tipo',3)	
		else
			dw_proceso.setitem(li_x,'tipo',1)	
		end if
	end if
next
end subroutine

public subroutine wf_activar_cambio_img_boton (string as_evento, string as_imagen);integer	li_x

for li_x = 1 to dw_proceso.rowcount( )
	if dw_proceso.GetItemString(li_x,'evento') = as_evento then dw_proceso.SetItem(li_x,'imagen',as_imagen)
next
end subroutine

on w_xplistbar.create
this.st_1=create st_1
this.dw_proceso=create dw_proceso
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.dw_proceso,&
this.dw_1}
end on

on w_xplistbar.destroy
destroy(this.st_1)
destroy(this.dw_proceso)
destroy(this.dw_1)
end on

event open;BackColor	= 67108864

end event

event resize;
post wf_post_resize()
end event

type st_1 from statictext within w_xplistbar
integer x = 119
integer y = 152
integer width = 709
integer height = 844
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 8421504
long backcolor = 16777215
boolean enabled = false
string text = "Para agregar categorías del Menú Favoritos, puede dar click derecho en esta area."
alignment alignment = center!
boolean focusrectangle = false
end type

event rbuttondown;
gdw_activo = dw_1
m_detalle NewMenu
NewMenu = CREATE m_detalle
NewMenu.m_buscar.visible = False
NewMenu.m_0.visible = False
NewMenu.m_2.visible = False
NewMenu.m_comentario.visible = False
NewMenu.m_eliminar.visible = False
NewMenu.PopMenu(w_main.PointerX(), w_main.PointerY())
destroy NewMenu
end event

type dw_proceso from datawindow within w_xplistbar
event uo_movedw pbm_dwnmousemove
integer x = 896
integer y = 12
integer width = 224
integer height = 2400
integer taborder = 20
string title = "none"
string dataobject = "d_sys_procesos"
boolean border = false
end type

event uo_movedw;choose case dwo.name
	case 'imagen_t'
		wf_mm_boton(row)
	case 'datawindow','t_bg'
		wf_mm_reset()
end choose
end event

event clicked;string	ls_evento
choose case dwo.name
	case 'imagen_t'
		ls_evento = GetItemString(row,'evento')
		if not f_cadena_vacio_nulo(ls_evento) then 
			il_row = row
			gw_activo.triggerevent(ls_evento)
			gw_activo.setfocus( )
		end if
end choose
end event

event doubleclicked;string	ls_evento
choose case dwo.name
	case 'imagen_t'
		ls_evento = GetItemString(row,'evento')
		if not f_cadena_vacio_nulo(ls_evento) then 
			il_row = row
			gw_activo.triggerevent(ls_evento)
			
		end if
end choose
end event

type dw_1 from u_dw_xplistbar within w_xplistbar
event eu_clicked ( string as_text )
event ue_agregar pbm_custom01
event ue_detagregar pbm_custom01
integer x = 27
integer y = 8
integer width = 864
integer height = 2404
integer taborder = 10
boolean vscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event ue_agregar;//TODO: agregar la ventana
//opensheet(w_favorito_grupo,w_principal,0,original!)
end event

event ue_detagregar;//TODO: agregar nueva ventana
//opensheet(w_favorito_grupo,w_principal,0,original!)
end event

event constructor;call super::constructor;long ll_cod,ll_cat,ll_cat1
string ls_cat,ls_est,ls_fav,ls_ico

Declare lc_categoria Cursor For 
	select		num_categoria,	dsc_categoria,flg_estado 
	from		sys_categoria_favorito 
	where	flg_estado = 'REG' and email = :guo_sistema.is_mail
	order by num_categoria
	using sqlca;
Declare lc_fav Cursor For 
	select		cod_favorito,dsc_icono,num_categoria 
	from 		sys_vent_favorito 
	where 	email = :guo_sistema.is_mail 
	order by num_orden
	using sqlca;	
	
Open lc_categoria; 
Fetch lc_categoria Into:ll_cod,:ls_cat,:ls_est; 
DO While sqlca.SqlCode<>100 
	
	ll_cat1 = of_AddItem('header',ls_cat+'  ',0,'')
	Open lc_fav; 
	Fetch lc_fav Into:ls_fav,:ls_ico,:ll_cat;
	DO While sqlca.SqlCode<>100 
		if ll_cod = ll_cat then & 
			of_AddItem('child',ls_fav+'  ',ll_cat1,ls_ico)
	Fetch lc_fav Into:ls_fav,:ls_ico,:ll_cat; 
	Loop 
	Close lc_fav; 
Fetch lc_categoria Into:ll_cod,:ls_cat,:ls_est; 
Loop 

Close lc_categoria; 

if RowCount() = 0 then
	st_1.visible = True
else
	st_1.visible = False
end if








//Long ll_parent
//ll_parent = of_AddItem('header','Registros',0,'')
//of_AddItem('child','Usuario',ll_parent,'iconos\ou_empresa.gif')
//of_AddItem('child','Productos',ll_parent,'iconos\g_productos.gif')
//of_AddItem('child','Suministro',ll_parent,'Iconos\menuregister.bmp')
//of_AddItem('child','Cobranza',ll_parent,'Iconos menu\ou_selcliente.gif')
//of_AddItem('child','Kardex',ll_parent,'Iconos menu\ou_selcliente.gif')
//
//ll_parent = of_AddItem('header','Reportes ',0,'')
//of_AddItem('child','Reporte 1',ll_parent,'iconos\ou_empresa.gif')
//of_AddItem('child','Reporte 2',ll_parent,'Iconos menu\ou_selcliente.gif')
//ll_parent = of_AddItem('header','Herramientas ',0,'')
//of_AddItem('child','Operador Telefónico',ll_parent,'iconos\ou_empresa.gif')
//of_AddItem('child','Tipo de Cambio',ll_parent,'Iconos menu\ou_selcliente.gif')
//of_AddItem('child','Detalle de Kardex',ll_parent,'Iconos menu\ou_selcliente.gif')
//of_AddItem('child','Comprobante',ll_parent,'Iconos menu\ou_selcliente.gif')







end event

event ue_clicked;call super::ue_clicked;window lw_sheet
string ls_ventana,ls_fav
long ll_activo
ls_fav = lower(trim(as_text))

try 
	select		dsc_ventana,num_activo
	into 		:ls_ventana,:ll_activo
	from 		sys_vent_favorito
	where 	ltrim(rtrim(lower(cod_favorito))) = :ls_fav and
				email = :guo_sistema.is_mail
	using sqlca;


	if isnull(ll_activo) or ll_activo = 0 then
		if not guo_sistema.uof_window_active(ls_ventana) then
			opensheet(lw_sheet,ls_ventana,w_main,0,original!)
		end if
	end if

catch (runtimeerror rt)
	guo_message.uof_message(guo_sistema.uof_language(ClassName()+'_error_title'),&
	guo_sistema.uof_language(ClassName()+'_error_message')+&
	guo_sistema.uof_language(ClassName()+'_error_message_t'),'err')
end try











end event

event rbuttondown;call super::rbuttondown;choose case dwo.name
	case 'datawindow','t_botton','t_space'
		gdw_activo = this
		m_detalle NewMenu
		NewMenu = CREATE m_detalle
		NewMenu.m_buscar.visible = False
		NewMenu.m_0.visible = False
		NewMenu.m_2.visible = False
		NewMenu.m_comentario.visible = False
		NewMenu.m_eliminar.visible = False
		NewMenu.PopMenu(w_main.PointerX(), w_main.PointerY())
		destroy NewMenu
end choose

end event

