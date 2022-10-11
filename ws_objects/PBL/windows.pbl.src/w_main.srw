$PBExportHeader$w_main.srw
forward
global type w_main from window
end type
type p_1 from picture within w_main
end type
type wb_1 from webbrowser within w_main
end type
type cb_1 from commandbutton within w_main
end type
type sle_1 from singlelineedit within w_main
end type
end forward

global type w_main from window
integer width = 4754
integer height = 1980
boolean titlebar = true
string title = "tienda"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
p_1 p_1
wb_1 wb_1
cb_1 cb_1
sle_1 sle_1
end type
global w_main w_main

forward prototypes
public function string wf_find_image ()
end prototypes

public function string wf_find_image ();Integer li_rc, li_StatusCode
String ls_ContentType, ls_body, ls_string
String ls_file
Blob lblb_blob
HttpClient lnv_HttpClient
lnv_HttpClient = CREATE HttpClient

// Send request using GET method
li_rc = lnv_HttpClient.SendRequest("GET",sle_1.text)

// Obtain the response message
IF li_rc = 1 THEN
    // Obtain the response status
    li_StatusCode = lnv_HttpClient.GetResponseStatusCode()
    IF li_StatusCode = 200 THEN
        // Obtain the header
        ls_ContentType = lnv_HttpClient.GetResponseHeader("Content-Type")

        // Obtain the response data
        lnv_HttpClient.GetResponseBody(lblb_blob)
  
        Long ll_file, ll_FileLen, ll_Loops, ll_Step
/*
        n_cst_pbus_string lnv_string
        ls_file = lnv_string.of_GlobalReplace(as_url, "/", "_")
        ls_file = lnv_string.of_GlobalReplace(ls_file, ".", "_")
        ls_file = lnv_string.of_GlobalReplace(ls_file, "?", "_")
        ls_file = lnv_string.of_GlobalReplace(ls_file, "&", "_")
        ls_file = lnv_string.of_GlobalReplace(ls_file, "=", "_")
        ls_file = lnv_string.of_GlobalReplace(ls_file, "\", "_")
        ls_file = lnv_string.of_GlobalReplace(ls_file, ":", "_")
        ls_file = lnv_string.of_GlobalReplace(ls_file, "%", "_")
  */
        ls_ContentType = Lower(ls_ContentType)
	ls_file = 'archivo'
  
        IF Pos(ls_ContentType, "png", 1) > 0 THEN
	    ls_file = ls_file + ".png"
        ELSEIF Pos(ls_ContentType, "jpg", 1) > 0 THEN
			 ls_file = ls_file + ".jpg"
		ELSEIF Pos(ls_ContentType, "jpeg", 1) > 0 THEN
            ls_file = ls_file + ".jpeg"
        ELSEIF Pos(ls_ContentType, "ico", 1) > 0 THEN
	    ls_file = ls_file + ".ico"
        END IF

        ls_file = f_carpetas_personales(7)+'\' + ls_file

        ll_file = FileOpen(ls_file, StreamMode!, Write!, LockWrite!, Append!)
  
        IF ll_file > 0 THEN
            FileWriteEx(ll_file,lblb_blob) 
        ELSE
            //log the error, or handle
        END IF
        
        FileClose(ll_file)
  
    END IF
END IF

DESTROY lnv_HttpClient

RETURN ls_file
end function

on w_main.create
this.p_1=create p_1
this.wb_1=create wb_1
this.cb_1=create cb_1
this.sle_1=create sle_1
this.Control[]={this.p_1,&
this.wb_1,&
this.cb_1,&
this.sle_1}
end on

on w_main.destroy
destroy(this.p_1)
destroy(this.wb_1)
destroy(this.cb_1)
destroy(this.sle_1)
end on

type p_1 from picture within w_main
integer x = 1248
integer y = 280
integer width = 809
integer height = 592
boolean focusrectangle = false
end type

type wb_1 from webbrowser within w_main
integer x = 73
integer y = 272
integer width = 1134
integer height = 604
end type

type cb_1 from commandbutton within w_main
integer x = 3502
integer y = 128
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Ver"
end type

event clicked;wb_1.Navigate(sle_1.text)
p_1.Picturename = wf_find_image()
end event

type sle_1 from singlelineedit within w_main
integer x = 453
integer y = 120
integer width = 2912
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "URL"
borderstyle borderstyle = stylelowered!
end type

