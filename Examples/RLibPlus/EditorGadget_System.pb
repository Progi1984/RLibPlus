Macro RuntimeError(line)
  MessageRequester("LibEditorPlus",line)
EndMacro
If OpenWindow(0,0,0,830,320,"LibEditorPlus - Example > EditorGagdet",#PB_Window_ScreenCentered |#PB_Window_TitleBar|#PB_Window_SystemMenu)
  EditorGadget(1,10,10,300,300)
  ButtonGadget(2,320,10,100,100,"Mode ReadOnly : Off",#PB_Button_Toggle|#PB_Button_MultiLine)
  ButtonGadget(3,320,110,100,100,"Mode SelectionBar : Off",#PB_Button_Toggle|#PB_Button_MultiLine)
  ButtonGadget(4,320,210,100,100,"Mode Vertical Scrolling : Off",#PB_Button_Toggle|#PB_Button_MultiLine)
  
  ButtonGadget(5,420,10,100,100,"Mode Horizontal Scrolling : Off",#PB_Button_Toggle|#PB_Button_MultiLine)
  ButtonGadget(6,420,110,100,100,"Mode Flat Border : Off",#PB_Button_Toggle|#PB_Button_MultiLine)
  ButtonGadget(7,420,210,100,100,"Mode Text : On",#PB_Button_Toggle|#PB_Button_MultiLine)

  ButtonGadget(8,520,10,100,100,"Informations about EditorGadget",#PB_Button_MultiLine)
  ButtonGadget(9,520,110,100,100,"Mode Multiple Code Page : On",#PB_Button_Toggle|#PB_Button_MultiLine)
  ButtonGadget(10,520,210,100,100,"Mode Multiple Level UNDO : On",#PB_Button_Toggle|#PB_Button_MultiLine)

  ButtonGadget(11,620,10,100,100,"Mode Undo : On",#PB_Button_Toggle|#PB_Button_MultiLine)
  ButtonGadget(12,620,110,100,100,"Standard",#PB_Button_Toggle|#PB_Button_MultiLine)
  ButtonGadget(13,620,210,100,100,"Content of the EditorGadget",#PB_Button_MultiLine)

  ButtonGadget(14,720,10,100,100,"Randomize the size of tabulation",#PB_Button_MultiLine)
  ButtonGadget(15,720,110,100,100,"Activation of the Selection",#PB_Button_Toggle|#PB_Button_MultiLine)
  ButtonGadget(16,720,210,100,100,"LineBreak",#PB_Button_Toggle|#PB_Button_MultiLine)

  For Inc_a=0 To 50
    AddGadgetItem(1,Inc_a, "Line "+Str(Inc_a))
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
          Editor_SetReadOnly(1,GetGadgetState(2))
          If Editor_GetReadOnly(1)
            SetGadgetText(2,"Mode ReadOnly : On")
          Else
            SetGadgetText(2,"Mode ReadOnly : Off")
          EndIf
        Case 3
          Editor_SetSelectionBar(1,GetGadgetState(3))
          If Editor_GetSelectionBar(1)
            SetGadgetText(3,"Mode SelectionBar : On")
          Else
            SetGadgetText(3,"Mode SelectionBar : Off")
          EndIf
        Case 4
          Editor_SetAutoVScroll(1,GetGadgetState(4))
          If Editor_GetAutoVScroll(1)
            SetGadgetText(4,"Mode Vertical Scrolling : On")
          Else
            SetGadgetText(4,"Mode Vertical Scrolling : Off")
          EndIf
        Case 5
          Editor_SetAutoHScroll(1,GetGadgetState(5))
          If Editor_GetAutoHScroll(1)
            SetGadgetText(5,"Mode Horizontal Scrolling : On")
          Else
            SetGadgetText(5,"Mode Horizontal Scrolling : Off")
          EndIf
        Case 6
          Editor_SetFlatBorder(1,GetGadgetState(6))
          If Editor_GetFlatBorder(1)
            SetGadgetText(6, "Mode Flat Border : On")
          Else
            SetGadgetText(6, "Mode Flat Border : Off")
          EndIf
        Case 7
          Editor_SetTextMode(1,GetGadgetState(7))
          If Editor_IsRichText(1)
            SetGadgetText(7, "Mode RichEdit : On")
          ElseIf Editor_IsPlainText(1)
            SetGadgetText(7, "Mode Text : On")
          EndIf
        Case 8
          info.s=""
          If Editor_IsPlainText(1)
            info + "Mode PlainText : On" + Chr(13)+ Chr(10)
          Else
            info + "Mode PlainText : Off" + Chr(13)+ Chr(10)
          EndIf
          If Editor_IsRichText(1)
            info + "Mode RichText : On" + Chr(13)+ Chr(10)
          Else
            info + "Mode RichText : Off" + Chr(13)+ Chr(10)
          EndIf
          If Editor_IsSingleCodePage(1)
            info + "Mode SingleCodePage : On" + Chr(13)+ Chr(10)
          Else
            info + "Mode SingleCodePage : Off" + Chr(13)+ Chr(10)
          EndIf
          If Editor_IsMultiCodePage(1)
            info + "Mode MultiCodePage : On" + Chr(13)+ Chr(10)
          Else
            info + "Mode MultiCodePage : Off" + Chr(13)+ Chr(10)
          EndIf
          If Editor_IsSingleLevelUndo(1)
            info + "Mode Single Level Undo : On" + Chr(13)+ Chr(10)
          Else
            info + "Mode Single Level Undo : Off" + Chr(13)+ Chr(10)
          EndIf
          If Editor_IsMultiLevelUndo(1)
            info + "Mode Multi Level Undo : On" + Chr(13)+ Chr(10)
          Else
            info + "Mode Multi Level Undo : Off" + Chr(13)+ Chr(10)
          EndIf
          RuntimeError(info)
        Case 9
          Editor_SetCodePage(1,GetGadgetState(9))
          If Editor_IsMultiCodePage(1)
            SetGadgetText(9,"Mode MultiCodePage : On")
          ElseIf Editor_IsSingleCodePage(1)
            SetGadgetText(9,"Mode MultiCodePage : On")
          EndIf
        Case 10
          Editor_SetLevelUndo(1,GetGadgetState(10))
          If Editor_IsSingleLevelUndo(1)
            SetGadgetText(10,"Mode Single Level Undo : On")
          ElseIf Editor_IsMultiLevelUndo(1)
            SetGadgetText(10,"Mode Single Level Undo : On")
          EndIf 
        Case 11
          Editor_SetMaxLevelUndo(1,GetGadgetState(11))
          If GetGadgetState(11)=0
            ; Activation of the UNDO/REDO on no level = Desactivation of the UNDO/REDO
            SetGadgetText(11,"Mode Undo : Off")
          Else
            ; Activation of the UNDO/REDO on a level
            SetGadgetText(11,"Mode Undo : On")
          EndIf
        Case 12
          If GetGadgetState(12)
            Editor_SetEditorFlags(1,#SES_UPPERCASE)
            SetGadgetText(12, "All input are in capitals")
          Else
            Editor_SetEditorFlags(1,#SES_LOWERCASE)
            SetGadgetText(12, "All input are in small letters")
          EndIf
        Case 13
          RuntimeError(Editor_GetGadgetText(1))
        Case 14
          Editor_SetTabulationSize(1,Random(30))
        Case 15
          Editor_SetActiveSel(1, GetGadgetState(15))
          Editor_SelSetSel(1,8,38)
          If GetGadgetState(15)
            SetGadgetText(15,"Mode Show Selection : Off")
          Else
            SetGadgetText(15,"Mode Show Selection : On")
          EndIf
        Case 16
          Editor_SetLineBreakSimple(1,GetGadgetState(16))
          If Editor_GetLineBreakAdvanced(1)
            SetGadgetText(16, "LineBreak : Advanced")
          ElseIf Editor_GetLineBreakSimple(1)
            SetGadgetText(16, "LineBreak : Simple")
          EndIf
      EndSelect
  EndSelect
Until Event=#PB_Event_CloseWindow