$PBExportHeader$ventas.sra
$PBExportComments$Generated Application Object
forward
global type ventas from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global type ventas from application
string appname = "ventas"
string appruntimeversion = "19.2.0.2779"
end type
global ventas ventas

on ventas.create
appname = "ventas"
message = create message
sqlca = create transaction
sqlda = create dynamicdescriptionarea
sqlsa = create dynamicstagingarea
error = create error
end on

on ventas.destroy
destroy( sqlca )
destroy( sqlda )
destroy( sqlsa )
destroy( error )
destroy( message )
end on

