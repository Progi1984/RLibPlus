Macro RuntimeError(line)
  MessageRequester("LibEditorPlus",line)
EndMacro
If OpenWindow(0,0,0,430,320,"LibEditorPlus - Example > Selection",#PB_Window_ScreenCentered |#PB_Window_TitleBar|#PB_Window_SystemMenu)
  EditorGadget(1,10,10,300,300)
  ButtonGadget(2,320,10,100,150,"Informations about the Selection",#PB_Button_MultiLine)
  ButtonGadget(3,320,160,100,150,"Select All")
  For Inc_a=0 To 13
    AddGadgetItem(1,Inc_a,Left("LibEditorPlus",Inc_a)+" "+Right("LibEditorPlus",Inc_a))
  Next
EndIf
Repeat
  Event  = WindowEvent()
  Gadget = EventGadget()
  Menu   = EventMenu()
  Select Event
    Case #PB_Event_Gadget
      Select Gadget
        Case 2
          Editor_SelSetSel(1,8,38)
          info.s="Position of the start of the Selection : "   + Str(Editor_SelGetPosStart(1))          + Chr(13) + Chr(10)
          info + "Position of the end of the Selection : "     + Str(Editor_SelGetPosEnd(1))            + Chr(13) + Chr(10)
          info + "Length of the Selection : "                  + Str(Editor_SelGetLength(1))            + Chr(13) + Chr(10)
          info + "Start of the word (Position 11) : "          + Str(Editor_SelGetWordStart(1,11))      + Chr(13) + Chr(10)
          info + "End of the word (Position 11) : "            + Str(Editor_SelGetWordEnd(1,11))        + Chr(13) + Chr(10)
          info + "Start of the next word (Position 11) : "     + Str(Editor_SelGetNextWordStart(1,11))  + Chr(13) + Chr(10)
          info + "Start of the previous word  (Position 11) : "+ Str(Editor_SelGetPrevWordStart(1,11))  + Chr(13) + Chr(10)
          If Editor_SelIsEmpty(1)
            info + "Type of the Selection : Empty"                    + Chr(13) + Chr(10)
          ElseIf Editor_SelIsText(1)
            info + "Type of the Selection : Text"                     + Chr(13) + Chr(10)
          ElseIf Editor_SelIsObject(1)
            info + "Type of the Selection : Object COM"               + Chr(13) + Chr(10)
          EndIf
          If Editor_SelIsMultiChar(1)
            info + "Quantity of the Selection : Many characters"+ Chr(13) + Chr(10)
          ElseIf Editor_SelIsMultiObject(1)
            info + "Quantity of the Selection : Many objects COM"+ Chr(13) + Chr(10)
          EndIf
          info + "Text of the selection : "               + Editor_SelGetText(1)
          RuntimeError(info)
        Case 3
          Editor_SelectAll(1)
      EndSelect
  EndSelect
Until Event=#PB_Event_CloseWindow