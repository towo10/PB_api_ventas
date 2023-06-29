$PBExportHeader$w_login.srw
forward
global type w_login from window
end type
type dw_1 from datawindow within w_login
end type
end forward

global type w_login from window
integer width = 2885
integer height = 1976
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
long backcolor = 32896
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
end type
global w_login w_login

type variables
Integer	ii_select = 0
Boolean	ibo_autologin = false,&
			ibo_autologin_local = false,&
			ibo_new_user = false
end variables

forward prototypes
public subroutine wf_set_language_string (long an_language)
public subroutine wf_change_local ()
public subroutine wf_change_online ()
public subroutine wf_back ()
public subroutine wf_login_online ()
public subroutine wf_login_offline ()
public subroutine wf_save_setting (string as_url, string as_email, string as_pass, integer an_remember, integer an_auto)
public subroutine wf_load_setting ()
public subroutine wf_load_user ()
public function boolean wf_save_user (string as_user, string as_pass, integer an_autologin)
end prototypes

public subroutine wf_set_language_string (long an_language);guo_sistema.ii_language = an_language
title	= guo_sistema.uof_language('w_login_v2_title')

choose case ii_select
	case 0
		dw_1.Modify('t_online.text="'+guo_sistema.uof_language(Classname( )+'_access')+'"')
		dw_1.Modify('t_local.text="'+guo_sistema.uof_language(Classname( )+'_local')+'"')
	case 1,2
		dw_1.Modify('t_back.text="'+guo_sistema.uof_language(ClassName()+'_back')+'"')
		dw_1.Modify('flg_inicio.checkbox.text="'+guo_sistema.uof_language(Classname( )+'_v2_autologin')+'"')		
		if ii_select = 1 then
			dw_1.Modify('flg_recordar.checkbox.text="'+guo_sistema.uof_language(Classname( )+'_v2_remenber')+'"')
			dw_1.Modify('t_login.text="'+guo_sistema.uof_language(Classname( )+'_v2_title')+'"')
		else
			dw_1.Modify('t_login_local.text="'+guo_sistema.uof_language(Classname( )+'_v2_title')+'"')
		end if
end choose

dw_1.Modify('language_t.text="'+guo_sistema.uof_language('d_login_v2_language')+':"')
dw_1.SetItem(1,'author',guo_sistema.is_compania+' ® '+guo_sistema.uof_language(Classname( )+'_v2_author'))
/*Set the selected language for the message system*/
guo_message.uof_set_language_string(guo_sistema.uof_language('message_ok'),&
													guo_sistema.uof_language('message_cancel'),&
													guo_sistema.uof_language('message_copy'),&
													guo_sistema.uof_language('message_technical'),&
													guo_sistema.uof_language('message_yes'),&
													guo_sistema.uof_language('message_no'))

end subroutine

public subroutine wf_change_local ();ii_select = 2
dw_1.Reset()
dw_1.DataObject = 'd_login_offline'
dw_1.SetTransObject(sqlca)
dw_1.InsertRow(0)
dw_1.SetItem(1,'language',guo_sistema.ii_language)
wf_load_user()
wf_set_language_string(guo_sistema.ii_language)
if ibo_autologin_local then &
	post wf_login_offline()
end subroutine

public subroutine wf_change_online ();ii_select = 1
dw_1.Reset()
dw_1.DataObject = 'd_login_online'
dw_1.SetTransObject(sqlca)
dw_1.InsertRow(0)
dw_1.SetItem(1,'language',guo_sistema.ii_language)
wf_load_setting()
wf_set_language_string(guo_sistema.ii_language)
if ibo_autologin then &
	post wf_login_online()
end subroutine

public subroutine wf_back ();ii_select = 0
dw_1.reset()
dw_1.DataObject = 'd_login_select'
dw_1.SetTransObject(SQLCA)
dw_1.InsertRow(0)
dw_1.SetItem(1,'language',guo_sistema.ii_language)
wf_set_language_string(guo_sistema.ii_language)
end subroutine

public subroutine wf_login_online ();String		ls_url,ls_email,ls_pass,ls_error
Integer	li_remember,li_auto,li_return,li_error
/*error checking*/
dw_1.accepttext( )
ls_url				= dw_1.GetItemString(1,'url')
ls_email			= dw_1.GetItemString(1,'email')
ls_pass			= dw_1.GetItemString(1,'password')
li_remember	= dw_1.GetItemNumber(1,'flg_recordar')
li_auto			= dw_1.GetItemNumber(1,'flg_inicio')

if f_cadena_vacio_nulo(ls_url) then
	guo_message.uof_message(title,guo_sistema.uof_language(Classname( )+'_v2_error_url'),'err')
	return
end if
if f_cadena_vacio_nulo(ls_email) then
	guo_message.uof_message(title,guo_sistema.uof_language(Classname( )+'_v2_error_email'),'err')
	return
end if
if f_cadena_vacio_nulo(ls_pass) then
	guo_message.uof_message(title,guo_sistema.uof_language(Classname( )+'_v2_error_pass'),'err')
	return
end if
/*Begin Session*/

if guo_sistema.uof_begin_session(ls_url,ls_email,ls_pass,li_error,ls_error) then
	wf_save_setting(ls_url,ls_email,ls_pass,li_remember,li_auto)
	open(w_main)
	close(this)
else
	if li_error = -1 then
		if f_cadena_vacio_nulo(Trim(ls_error)) then
			guo_message.uof_message(title,guo_sistema.uof_language('sistema_error_api'),'err')
		else
			guo_message.uof_message(title,guo_sistema.uof_language('sistema_error_api'),ls_error,'err')
		end if
	else
		guo_message.uof_message(title,guo_sistema.uof_language(Classname( )+'_v2_error_session'),ls_error,'err')
	end if
end if
end subroutine

public subroutine wf_login_offline ();String		ls_user,ls_pass,ls_error
Integer	li_auto,li_error

dw_1.accepttext( )
ls_user			= dw_1.GetItemString(1,'user')
ls_pass			= dw_1.GetItemString(1,'password')
li_auto			= dw_1.GetItemNumber(1,'flg_inicio')

if f_cadena_vacio_nulo(ls_user) then
	guo_message.uof_message(title,guo_sistema.uof_language(Classname( )+'_error_user'),'err')
	return
end if
if f_cadena_vacio_nulo(ls_pass) then
	guo_message.uof_message(title,guo_sistema.uof_language(Classname( )+'_error_password'),'err')
	return
end if

if not ibo_new_user then
	if not guo_sistema.uof_begin_local_session(ls_user,guo_sistema.uof_encrypt(ls_pass),li_error,ls_error) then
		guo_message.uof_message(title,ls_error,'err')
		return
	end if
end if
if wf_save_user(ls_user,ls_pass,li_auto) then
	open(w_main)
	close(this)
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

public subroutine wf_load_setting ();String	ls_url,ls_email,ls_pass

select		url,email,password
into		:ls_url,:ls_email,:ls_pass
from		setting
where	id = 1
using sqlca;

if sqlca.sqlcode <> 0 then &
	return

if not f_cadena_vacio_nulo(ls_url) then
	dw_1.SetItem(1,'url',ls_url)
	dw_1.SetColumn('email')
end if
if not f_cadena_vacio_nulo(ls_pass) then
	ibo_autologin	= true
	ls_pass 			= guo_sistema.uof_deencrypt(ls_pass)
	dw_1.SetItem(1,'flg_inicio',1)
	dw_1.SetItem(1,'password',ls_pass)
	
end if
if not f_cadena_vacio_nulo(ls_email) then
	dw_1.SetItem(1,'email',ls_email)
	dw_1.SetItem(1,'flg_recordar',1)
	dw_1.SetColumn('password')	
end if

dw_1.SetFocus( )
end subroutine

public subroutine wf_load_user ();String	ls_user,ls_pass
Integer	li_auto

select		user,password,ifnull(auto,0)
into		:ls_user,:ls_pass,:li_auto
from		user
where	id = 1
using sqlca;

if sqlca.sqlcode <> 0 then
	ibo_new_user	= true	
	guo_message.uof_message(title,guo_sistema.uof_language(ClassName()+'_user_new'))
	return
end if
if not f_cadena_vacio_nulo(ls_user) then
	dw_1.SetItem(1,'user',ls_user)
	dw_1.SetColumn('password')
end if
if not f_cadena_vacio_nulo(ls_pass) then &	
	ls_pass 	= guo_sistema.uof_deencrypt(ls_pass)	

if li_auto = 1 then
	dw_1.SetItem(1,'flg_inicio',1)
	dw_1.SetItem(1,'password',ls_pass)
	ibo_autologin_local = true
end if
	
dw_1.SetFocus( )
end subroutine

public function boolean wf_save_user (string as_user, string as_pass, integer an_autologin);string		ls_pass,ls_error
long		ll_code

ls_pass	= guo_sistema.uof_encrypt(as_pass)

if ibo_new_user then
	insert into user(id,user,password,auto)
	values(1,:as_user,:ls_pass,:an_autologin)
	using sqlca;
else
	update	user
	set			user = :as_user,
				password = :ls_pass,
				auto = :an_autologin
	where	id = 1
	using sqlca;
end if


if f_ok_transaccion(sqlca,ll_code,ls_error) then
	commit using sqlca;
else
	guo_message.uof_message(title,guo_sistema.uof_language(ClassName()+'_user_save'),ls_error,'err')		
	return false
end if
return true
end function

on w_login.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_login.destroy
destroy(this.dw_1)
end on

event open;if guo_sistema.ii_exists_online = 0 and guo_sistema.ii_exists_offline = 0 then
	wf_back()
elseif guo_sistema.ii_exists_online = 1 and guo_sistema.ii_exists_offline = 1 then
	if guo_sistema.ii_autologin = 1 then
		wf_change_online()
	elseif guo_sistema.ii_autologin_local = 1 then
		wf_change_local()
	else
		wf_back()
	end if
elseif guo_sistema.ii_exists_online > 0 then
	wf_change_online()	
else
	wf_change_local()	
end if
end event

type dw_1 from datawindow within w_login
event uo_mm pbm_dwnmousemove
integer width = 3218
integer height = 1980
integer taborder = 10
string title = "none"
string dataobject = "d_login_offline"
boolean border = false
boolean livescroll = true
end type

event uo_mm;long	ll_color
choose case dwo.name
	case 't_local','rr_local'
		ll_color	= long(describe('rr_local.brush.color'))
		if ll_color <> 0 then
			modify('rr_local.brush.color=0')
			modify('t_local.color=32896')
		end if
	case 'rr_online','t_online'
		ll_color	= long(describe('rr_online.brush.color'))
		if ll_color <> 0 then
			modify('rr_online.brush.color=0')
			modify('t_online.color=32896')
		end if
	case 'rr_login','t_login'
		ll_color	= long(describe('rr_login.brush.color'))
		if ll_color <> 0 then
			modify('rr_login.brush.color=0')
			modify('t_login.color=32896')
		end if
	case 'rr_login_local','t_login_local'
		ll_color	= long(describe('rr_login_local.brush.color'))
		if ll_color <> 0 then
			modify('rr_login_local.brush.color=0')
			modify('t_login_local.color=32896')
		end if
	case else
		if ii_select = 0 then
			ll_color	= long(describe('rr_online.brush.color'))
			if ll_color <> 32896 then
				modify('rr_online.brush.color=32896')
				modify('t_online.color=0')
				modify('rr_local.brush.color=32896')
				modify('t_local.color=0')
			end if
			ll_color	= long(describe('rr_local.brush.color'))
			if ll_color <> 32896 then
				modify('rr_local.brush.color=32896')
				modify('t_local.color=0')
			end if
		elseif ii_select = 1 then
			ll_color	= long(describe('rr_login.brush.color'))
			if ll_color <> 32896 then
				modify('rr_login.brush.color=32896')
				modify('t_login.color=0')
			end if
		elseif ii_select = 2 then
			ll_color	= long(describe('rr_login_local.brush.color'))
			if ll_color <> 32896 then
				modify('rr_login_local.brush.color=32896')
				modify('t_login_local.color=0')
			end if
		end if
end choose
end event

event itemchanged;choose case dwo.name
	case 'language'
		wf_set_language_string(Long(data))
end choose
end event

event clicked;choose case dwo.name
	case 't_local','rr_local'
		wf_change_local()
	case 'rr_online','t_online'
		wf_change_online()
	case 't_back','p_back'
		wf_back()
	case 't_login','rr_login'
		wf_login_online()
	case 't_login_local','rr_login_local'
		wf_login_offline()
end choose
end event

