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
Boolean	ibo_autologin = false
end variables
forward prototypes
public subroutine wf_init_language ()
public subroutine wf_set_language_string (long an_language)
public subroutine wf_login ()
public subroutine wf_save_setting (string as_url, string as_email, string as_pass, integer an_remember, integer an_auto)
public subroutine wf_load_setting ()
public function boolean wf_begin_session (string as_url, string as_email, string as_pass)
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
dw_1.SetItem(1,'author',guo_sistema.is_compania+' ® '+guo_sistema.uof_language(Classname( )+'_author'))
/*Set the selected language for the message system*/
guo_message.uof_set_language_string(guo_sistema.uof_language('message_ok'),&
													guo_sistema.uof_language('message_cancel'),&
													guo_sistema.uof_language('message_copy'),&
													guo_sistema.uof_language('message_technical'),&
													guo_sistema.uof_language('message_yes'),&
													guo_sistema.uof_language('message_no'))

end subroutine

public subroutine wf_login ();String		ls_url,ls_email,ls_pass
Integer	li_remember,li_auto
/*error checking*/
dw_1.accepttext( )
ls_url				= dw_1.GetItemString(1,'url')
ls_email			= dw_1.GetItemString(1,'email')
ls_pass			= dw_1.GetItemString(1,'password')
li_remember	= dw_1.GetItemNumber(1,'flg_recordar')
li_auto			= dw_1.GetItemNumber(1,'flg_inicio')

if f_cadena_vacio_nulo(ls_url) then
	guo_message.uof_message(title,guo_sistema.uof_language(Classname( )+'_error_url'),'err')
	return
end if
if f_cadena_vacio_nulo(ls_email) then
	guo_message.uof_message(title,guo_sistema.uof_language(Classname( )+'_error_email'),'err')
	return
end if
if f_cadena_vacio_nulo(ls_pass) then
	guo_message.uof_message(title,guo_sistema.uof_language(Classname( )+'_error_pass'),'err')
	return
end if
/*Begin Session*/
if wf_begin_session(ls_url,ls_email,ls_pass) then
	wf_save_setting(ls_url,ls_email,ls_pass,li_remember,li_auto)
	open(w_main)
end if

end subroutine

public subroutine wf_save_setting (string as_url, string as_email, string as_pass, integer an_remember, integer an_auto);Integer	li_find
String		ls_null,ls_email,ls_pass,ls_error
long		ll_code

SetNull(ls_null)
select	count(*) into:li_find 
from	setting
using sqlca;

ls_email	= as_email
ls_pass	= guo_sistema.uof_encrypt(as_pass)
if an_remember = 0 then &
	ls_email = ls_null
if an_auto = 0 then &
	ls_pass = ls_null

if li_find = 0 then
	insert into setting(id,url,email,password,language_id)
	values(1,:as_url,:ls_email,:ls_pass,:guo_sistema.ii_language)
	using sqlca;
	
	if f_ok_transaccion(sqlca,ll_code,ls_error) then
		commit using sqlca;
	else
		guo_message.uof_message(title,guo_sistema.uof_language(ClassName()+'_error_setting'),ls_error,'err')		
		return
	end if
else
	update setting
	set url = :as_url,
	email = :ls_email,
	password = :ls_pass,
	language_id = :guo_sistema.ii_language
	where id = 1
	using sqlca;
	
	if f_ok_transaccion(sqlca,ll_code,ls_error) then
		commit using sqlca;
	else
		guo_message.uof_message(title,guo_sistema.uof_language(ClassName()+'_error_setting'),ls_error,'err')		
		return
	end if
end if
end subroutine

public subroutine wf_load_setting ();//insert into setting(id,url,email,password,language_id)
String	ls_url,ls_email,ls_pass

select		url,email,password
into		:ls_url,:ls_email,:ls_pass
from		setting
where	id = 1
using sqlca;

if not f_cadena_vacio_nulo(ls_url) then &
	dw_1.SetColumn('email')
if not f_cadena_vacio_nulo(ls_pass) then
	ls_pass = guo_sistema.uof_deencrypt(ls_pass)
	dw_1.SetItem(1,'flg_inicio',1)
	ibo_autologin = true
end if
if not f_cadena_vacio_nulo(ls_email) then
	dw_1.SetColumn('password')
	dw_1.SetItem(1,'flg_recordar',1)
end if
dw_1.SetItem(1,'url',ls_url)
dw_1.SetItem(1,'email',ls_email)
dw_1.SetItem(1,'password',ls_pass)


dw_1.SetFocus( )
end subroutine

public function boolean wf_begin_session (string as_url, string as_email, string as_pass);String				ls_json,ls_error,ls_status
JsonPackage	json_response,json_result
json_response	= create JsonPackage
json_result		= create JsonPackage
SetPointer(HourGlass!)

ls_json	= '{"user" : "'+as_email+'",'+&
    				'"password" :"'+as_pass+'"}'
guo_sistema.is_url = as_url
if not guo_sistema.uof_request('POST','auth',ls_json,json_response,ls_error) then
	guo_message.uof_message(title,guo_sistema.uof_language(ClassName()+'_error_session'),ls_error,'err')
	return false
end if

ls_status 	= json_response.getvalue("status")
json_result.loadstring(json_response.getvalue("result"))

if ls_status = 'ok' then
	guo_sistema.is_token = json_result.getvalue("token")
	guo_sistema.ii_tienda = Integer(json_result.getvalue("idtienda"))
	guo_sistema.ii_usuario = Integer(json_result.getvalue("idusuario"))
	return true
else
	guo_message.uof_message(title,guo_sistema.uof_language(ClassName()+'_error_session'),&
									json_result.getvalue("error_message"),'err')
	return false
end if
end function

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
wf_load_setting()




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

