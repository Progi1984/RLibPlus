If OpenWindow(0,0,0,430,335,"LibEditorPlus - Example > Cursor",#PB_Window_ScreenCentered |#PB_Window_TitleBar|#PB_Window_SystemMenu)
  EditorGadget(1,10,10,300,300)
  ButtonGadget(2,320,10,100,300,"Randomize the position of the cursor",#PB_Button_MultiLine)
  If CreateStatusBar(0, WindowID(0))
      AddStatusBarField(40)
      AddStatusBarField(40)
      AddStatusBarField(80)
  EndIf
  StatusBarText(0, 0, "X : ")
  StatusBarText(0, 1, "Y : ")
  StatusBarText(0, 2, "Position : ")
  
  For i=0 To 13
    AddGadgetItem(1,i,Left("LibEditorPlus",i))
  Next
EndIf
Repeat
  Event  = WindowEvent()
  Gadget = EventGadget()
  Select Event
    Case #PB_Event_Gadget
      Select Gadget
        Case 1
          StatusBarText(0, 0, "X : "+Str(Editor_GetCursorX(1)))
          StatusBarText(0, 1, "Y : "+Str(Editor_GetCursorY(1)))
          StatusBarText(0, 2, "Position : "+Str(Editor_GetCursorPos(1)))
        Case 2
          Editor_SetCursorPos(1,Random(Editor_GetNumberChar(1)))
          Editor_Activate(1)
      EndSelect
  EndSelect
Until Event=#PB_Event_CloseWindow