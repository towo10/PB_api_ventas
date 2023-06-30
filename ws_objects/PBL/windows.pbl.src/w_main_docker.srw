$PBExportHeader$w_main_docker.srw
forward
global type w_main_docker from window
end type
type mdi_1 from mdiclient within w_main_docker
end type
end forward

global type w_main_docker from window
integer width = 4754
integer height = 2056
boolean titlebar = true
string title = "Untitled"
string menuname = "m_dummy"
boolean minbox = true
boolean resizable = true
windowtype windowtype = mdidock!
long backcolor = 67108864
string icon = "AppIcon!"
windowanimationstyle openanimation = leftroll!
windowanimationstyle closeanimation = leftslide!
mdi_1 mdi_1
end type
global w_main_docker w_main_docker

on w_main_docker.create
if this.MenuName = "m_dummy" then this.MenuID = create m_dummy
this.mdi_1=create mdi_1
this.Control[]={this.mdi_1}
end on

on w_main_docker.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

event open;window win[]

//OpenSheetWithParmDocked(win[1], "1", "w_sheet_any", this, WindowDockTop!, "")
OpenSheetWithParmFromDockingState ( win[1],"1","w_sheet_any", this, "" )

//OpenSheetWithParmAsDocument(win[1], "1", "w_sheet_any", this, "")
//OpenSheetWithParmInTabGroup(win[2], "2", "w_sheet_any", win[1], "")
//OpenSheetWithParmInTabGroup(win[4], "4", "w_sheet_any", win[1], "")

/*WindowDockTop
OpenSheetWithParmDocked(win[1], "1", "w_sheet_any", this, WindowDockLeft!, "")
OpenSheetWithParmInTabGroup(win[2], "2", "w_sheet_any", this, "")
OpensheetWithParmInTabGroup(win[3], "3", "w_sheet_any", win[1], "")
OpenSheetWithParmAsDocument(win[4], "4", "w_sheet_any", this, "")
OpenSheetWithParmAsDocument(win[5], "5", "w_sheet_any", win[4], "")
OpenSheetWithParmAsDocument(win[6], "6", "w_sheet_any", this, "", false)
OpenSheetWithParmAsDocument(win[7], "7", "w_sheet_any", win[5],  "")
OpenSheetWithParmAsDocument(win[8], "8", "w_sheet_any", win[6],  "")

*/
end event

type mdi_1 from mdiclient within w_main_docker
long BackColor=268435456
end type

