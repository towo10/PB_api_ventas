$PBExportHeader$uo_traslado_sesion.sru
forward
global type uo_traslado_sesion from nonvisualobject
end type
end forward

global type uo_traslado_sesion from nonvisualobject
end type
global uo_traslado_sesion uo_traslado_sesion

type variables
st_matriz		ist_matriz
end variables

forward prototypes
public subroutine uof_setdatos (st_matriz ast_matriz)
public subroutine uof_estado_conexion (string as_conectado)
public subroutine uof_consultando (string as_estado)
end prototypes

public subroutine uof_setdatos (st_matriz ast_matriz);ist_matriz = ast_matriz
end subroutine

public subroutine uof_estado_conexion (string as_conectado);string	ls_conectado

ist_matriz.adw_matriz[1].SetItem(1,'flg_conectado',as_conectado)
end subroutine

public subroutine uof_consultando (string as_estado);ist_matriz.adw_matriz[1].SetItem(1,'flg_consultando',as_estado)
end subroutine

on uo_traslado_sesion.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_traslado_sesion.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

