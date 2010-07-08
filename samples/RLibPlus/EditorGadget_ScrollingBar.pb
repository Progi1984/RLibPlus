If OpenWindow(0,0,0,380,340,"LibEditorPlus - Example > ScrollingBar",#PB_Window_ScreenCentered |#PB_Window_TitleBar|#PB_Window_SystemMenu)
  EditorGadget(1,10,10,150,300)
  ButtonGadget(2,170,10,100,100,"Informations about the ScrollingBar",#PB_Button_MultiLine)
  ButtonGadget(3,170,110,100,100,"Position of the ScrollingBar in 50,50",#PB_Button_MultiLine)
  ButtonGadget(4,170,210,100,100,"Mode ScrollingBar X",#PB_Button_Toggle|#PB_Button_MultiLine)
  ButtonGadget(5,270,10,100,300,"Mode ScrollingBar Y",#PB_Button_Toggle|#PB_Button_MultiLine)
  For Inc_a=0 To 13
    AddGadgetItem(1,Inc_a,Left("LibEditorPlus",Inc_a)+" - "+Right("LibEditorPlus",Inc_a)+" - "+Right("LibEditorPlus",Inc_a)+" - "+Left("LibEditorPlus",Inc_a))
  Next
  For Inc_a=14 To 27
    AddGadgetItem(1,Inc_a,Right("LibEditorPlus",27-Inc_a)+" - "+Left("LibEditorPlus",27-Inc_a)+" - "+Left("LibEditorPlus",27-Inc_a)+" - "+Right("LibEditorPlus",27-Inc_a))
  Next
  If CreateStatusBar(0,WindowID(0))
    ;{ Création de Champs
      AddStatusBarField(80)
      AddStatusBarField(80)
    ;}
    ;{ Tooltips
      StatusBarText(0,0,"Position X : "+Str(Editor_GetScrollBarX(1)))
      StatusBarText(0,1,"Position Y : "+Str(Editor_GetScrollBarY(1)))
    ;}
  EndIf
EndIf
Repeat
  Event  = WindowEvent()
  Gadget = EventGadget()
  Select Event
    Case #PB_Event_Gadget
      Select Gadget
        Case 2
          StatusBarText(0,0,"Position X : "+Str(Editor_GetScrollBarX(1)))
          StatusBarText(0,1,"Position Y : "+Str(Editor_GetScrollBarY(1)))
        Case 3
          Editor_SetScrollBar(1,50,50)
        Case 4
          StateX=GetGadgetState(4)
          Editor_SetHScrollBarVisible(1,StateX)
          If StateX
            SetGadgetText(4,"Mode ScrollingBar X : Active")
          Else
            SetGadgetText(4,"Mode ScrollingBar X : Inactive")
          EndIf
        Case 5
          StateY=GetGadgetState(5)
          Editor_SetVScrollBarVisible(1,StateY)
          If StateY
            SetGadgetText(5,"Mode ScrollingBar Y : Active")
          Else
            SetGadgetText(5,"Mode ScrollingBar Y : Inactive")
          EndIf
      EndSelect
  EndSelect
Until Event=#PB_Event_CloseWindow