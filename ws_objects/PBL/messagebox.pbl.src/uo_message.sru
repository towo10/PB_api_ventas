$PBExportHeader$uo_message.sru
forward
global type uo_message from nonvisualobject
end type
end forward

global type uo_message from nonvisualobject
end type
global uo_message uo_message

type variables
String		is_espacio,is_sok,is_scancel,is_scopy,is_stechnical,is_syes,is_sno
Long		il_child_x=0,&
			il_child_y=0,&
			il_width_child=0,&
			il_height_child=0

end variables
forward prototypes
public subroutine uof_workspace (long an_x, long an_y, long an_width, long an_height)
public function integer uof_message (string as_title, string as_message, string as_technical)
public function integer uof_message (string as_title, string as_message)
public subroutine uof_set_language_string (string as_ok, string as_cancel, string as_copy, string as_technical, string as_yes, string as_no)
public function integer uof_message (string as_title, string as_message, string as_technical, string as_type)
end prototypes

public subroutine uof_workspace (long an_x, long an_y, long an_width, long an_height);il_child_x			= an_x
il_child_y			= an_y
il_width_child	= an_width
il_height_child	= an_height
end subroutine

public function integer uof_message (string as_title, string as_message, string as_technical);st_message		lst_message

lst_message.title						= as_title
lst_message.message				= as_message
lst_message.auto_center 			= false
lst_message.show_technical		= true

choose case upper(as_technical)
	case 'ERR','ERROR','MSG','MSJ','MENSAJE','MESSAGE','PRG','PREGUNTA','QUS','QUESTION','ADV','ADVERTENCIA','WAR','WARNING'
		lst_message.show_technical		= false
		lst_message.type_message 			= as_technical
		lst_message.technical_message	= ''
	case else
		lst_message.show_technical		= true
		lst_message.type_message 			= 'msj'
		lst_message.technical_message	= as_technical
end choose
if il_width_child = 0 then &
	lst_message.auto_center = true
	
openwithparm(w_message,lst_message)

return message.doubleparm	

end function

public function integer uof_message (string as_title, string as_message);st_message		lst_message

lst_message.title						= as_title
lst_message.message				= as_message
lst_message.technical_message	= ''
lst_message.type_message 			= 'msj'
lst_message.auto_center 			= false
lst_message.show_technical		= false	
if il_width_child = 0 then &
	lst_message.auto_center = true
	
openwithparm(w_message,lst_message)

return message.doubleparm	

end function

public subroutine uof_set_language_string (string as_ok, string as_cancel, string as_copy, string as_technical, string as_yes, string as_no);/*El Idioma por defecto es el Ingles*/
if IsNull(as_ok) or Len(Trim(as_ok))=0 then
	is_sok = '&Ok'
else
	is_sok	 = '&'+as_ok
end if
if IsNull(as_cancel) or Len(Trim(as_cancel))=0 then
	is_scancel = '&Cancel'
else
	is_scancel = '&'+as_cancel
end if
if IsNull(as_copy) or Len(Trim(as_copy))=0 then
	is_scopy = 'Copy the technical information'
else
	is_scopy = as_copy
end if
if IsNull(as_technical) or Len(Trim(as_technical))=0 then
	is_stechnical = 'Technical information'
else
	is_stechnical = as_technical
end if
if IsNull(as_yes) or Len(Trim(as_yes))=0 then
	is_syes = 'Yes'
else
	is_syes = as_yes
end if
if IsNull(as_no) or Len(Trim(as_no))=0 then
	is_sno = 'No'
else
	is_sno = as_no
end if

end subroutine

public function integer uof_message (string as_title, string as_message, string as_technical, string as_type);st_message		lst_message

lst_message.title						= as_title
lst_message.message				= as_message
lst_message.technical_message	= as_technical
lst_message.auto_center 			= false
lst_message.show_technical		= true
lst_message.type_message			= as_type

if il_width_child = 0 then &
	lst_message.auto_center = true
	
openwithparm(w_message,lst_message)

return message.doubleparm	

end function

event constructor;is_espacio		= string(char(13)) + string (char(10))
end event

on uo_message.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_message.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

