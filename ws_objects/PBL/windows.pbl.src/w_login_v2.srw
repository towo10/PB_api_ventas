$PBExportHeader$w_login_v2.srw
forward
global type w_login_v2 from window
end type
type dw_1 from datawindow within w_login_v2
end type
end forward

global type w_login_v2 from window
integer width = 2912
integer height = 2000
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
end type
global w_login_v2 w_login_v2

type variables

end variables

forward prototypes
public subroutine wf_init_language ()
public subroutine wf_set_language_string (long an_language)
public subroutine wf_login ()
end prototypes

public subroutine wf_init_language ();/*
string ls_language
long	ll_id,ll_x=0

DECLARE lc_language CURSOR FOR 
	select id,name from language
	where state = 1
	order by id asc
	using sqlca;
OPEN lc_language;

if SQLCA.sqlcode < 0 then
	MessageBox("Open Cursor language",SQLCA.sqlerrtext)
end if

DO WHILE SQLCA.sqlcode = 0
	FETCH lc_language INTO :ll_id,:ls_language;
	if SQLCA.sqlcode < 0 then
		MessageBox("Fetch Error",SQLCA.sqlerrtext)
	elseif SQLCA.sqlcode = 0 then
		ll_x++
		ddlb_1.addItem(ls_language)		
		if ll_id = guo_sistema.ii_language then &
			ddlb_1.selectitem(ll_x)
	end if
LOOP

CLOSE lc_language;
*/
end subroutine

public subroutine wf_set_language_string (long an_language);guo_sistema.ii_language = an_language
title	= guo_sistema.uof_language(Classname( )+'_title')
dw_1.Modify('flg_recordar.checkbox.text="'+guo_sistema.uof_language(Classname( )+'_remenber')+'"')
dw_1.Modify('flg_inicio.checkbox.text="'+guo_sistema.uof_language(Classname( )+'_autologin')+'"')
dw_1.Modify('language_t.text="'+guo_sistema.uof_language('d_login_v2_language')+':"')
dw_1.Modify('t_login.text="'+guo_sistema.uof_language(Classname( )+'_title')+'"')

end subroutine

public subroutine wf_login ();String		ls_url,ls_email,ls_pass

/*review*/
dw_1.accepttext( )
ls_url		= dw_1.GetItemString(1,'url')
ls_email	= dw_1.GetItemString(1,'email')
ls_pass	= dw_1.GetItemString(1,'password')

if f_cadena_vacio_nulo(ls_url) then
	//TODO cambiar estos mensajes por el que construimos	
	MessageBox(title,guo_sistema.uof_language(Classname( )+'_error_url'))
	return
end if

/*Begin Session*/
end subroutine

on w_login_v2.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_login_v2.destroy
destroy(this.dw_1)
end on

event open;dw_1.SetTransObject(SQLCA)
dw_1.InsertRow(0)
dw_1.SetItem(1,'language',guo_sistema.ii_language)
wf_set_language_string(guo_sistema.ii_language)




end event

type dw_1 from datawindow within w_login_v2
event ue_mm pbm_dwnmousemove
integer width = 3218
integer height = 1980
integer taborder = 20
string title = "none"
string dataobject = "d_login_v2"
boolean border = false
boolean livescroll = true
end type

event ue_mm;long	ll_color
choose case dwo.name
	case 'rr_login','t_login'
		ll_color	= long(describe('rr_login.brush.color'))
		if ll_color <> 0 then
			modify('rr_login.brush.color=0')
			modify('t_login.color=32896')
		end if
	case else
		ll_color	= long(describe('rr_login.brush.color'))
		if ll_color <> 32896 then
			modify('rr_login.brush.color=32896')
			modify('t_login.color=0')
		end if
end choose
end event

event itemchanged;choose case dwo.name
	case 'language'
		wf_set_language_string(Long(data))
end choose
end event

event clicked;choose case dwo.name
	case 'rr_login','t_login'
		wf_login()
end choose
end event

