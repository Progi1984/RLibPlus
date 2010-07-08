Global OldZoom.l = 6
Macro RuntimeError(line)
  MessageRequester("LibEditorPlus",line)
EndMacro

If OpenWindow(0,0,0,770,480,"LibEditorPlus - Example > Main",#PB_Window_SystemMenu|#PB_Window_ScreenCentered)
  EditorGadget (30,8,8,400,460) 
  TextGadget(43, 610, 420, 160, 20,"Zoom :")
  ComboBoxGadget(44, 605, 440, 160, 20)
    AddGadgetItem(44,0,"0.01587301678956% = (1/63)")
    AddGadgetItem(44,1,"3,125% = (1/32)")
    AddGadgetItem(44,2,"6,25% = (1/16)")
    AddGadgetItem(44,3,"12,5% = (1/8)")
    AddGadgetItem(44,4,"25% = (1/4)")
    AddGadgetItem(44,5,"50% = (1/2)")
    AddGadgetItem(44,6,"100% = (1/1)")
    AddGadgetItem(44,7,"200% = (2/1)")
    AddGadgetItem(44,8,"400% = (4/1)")
    AddGadgetItem(44,9,"800% = (8/1)")
    AddGadgetItem(44,10,"1600% = (16/1)")
    AddGadgetItem(44,11,"3200% = (32/1)")
    AddGadgetItem(44,12,"6300% = (63/1)")
    SetGadgetState(44,6)
  Editor_RTF_SetFont(30,"Comic Sans MS")
  Editor_RTF_SetFontSize(30,16)
  For a=0 To 5 
    If a=0 Or a=5
      Editor_RTF_SetFormat(30,#CFE_ITALIC)    
    EndIf
    If a=1 Or a=4
      Editor_RTF_SetFormat(30,#CFE_UNDERLINE|#CFE_BOLD)
    EndIf
    If a=2 Or a=3
      Editor_RTF_SetFormat(30,0)
    EndIf
    AddGadgetItem(30,a,"Line "+Str(a))
  Next
  Editor_RTF_SetFormat(30,0)
  ButtonGadget(1,440,10,150,50,"Change the background color",#PB_Button_MultiLine)
  ButtonGadget(2,610,10,150,50,"Change the text color",#PB_Button_MultiLine)
  ButtonGadget(3,440,60,150,50,"Copy the two first lines and paste them at the end",#PB_Button_MultiLine)
  ButtonGadget(4,610,60,150,50,"Find the position of cursor (Relative - X - Y)",#PB_Button_MultiLine)
  ButtonGadget(5,440,110,150,50,"Cut the content of clipboard and paste it at the end",#PB_Button_MultiLine)
  ButtonGadget(6,610,110,150,50,"Selection of the line 1 to 3 And Delete of the selection",#PB_Button_MultiLine)
  ButtonGadget(7,440,160,150,50,"Undo",#PB_Button_MultiLine)
  ButtonGadget(8,610,160,150,50,"Redo",#PB_Button_MultiLine)
  ButtonGadget(9,440,210,150,50,"Set the focus on the EditorGadget",#PB_Button_MultiLine)
  ButtonGadget(11,440,260,150,50,"Add 100 lines, go to to the last line and go back to the first line",#PB_Button_MultiLine)
  ButtonGadget(12,610,260,150,50,"Print the content of the EditorGadget",#PB_Button_MultiLine)
  ButtonGadget(13,440,310,150,50,"Paste a defined text",#PB_Button_MultiLine)
  ButtonGadget(14,610,310,150,50,"Open a file",#PB_Button_MultiLine)
  ButtonGadget(15,440,360,150,50,"Save the content",#PB_Button_MultiLine)
  ButtonGadget(16,610,360,150,50,"Get informations about the format at the cursor",#PB_Button_MultiLine)
  ButtonGadget(17,440,410,150,50,"Version of LibEditorPlus",#PB_Button_MultiLine)  
  Repeat 
    EventID = WaitWindowEvent()
    If EventID = #PB_Event_Gadget    
      Select EventGadget()
        Case 1
          RVB=RGB(Random(255),Random(255),Random(255))
          Editor_RTF_SetColorBackground(30,RVB)
          SetGadgetText(1,"Background (RGB) : "+Str(Red(RVB))+","+Str(Green(RVB))+","+Str(Blue(RVB)))
        Case 2
          RVB=RGB(Random(255),Random(255),Random(255))
          Editor_Select(30,0,1,4,-1)
          Editor_RTF_SetColorText(30,RVB)
          SetGadgetText(2,"Text (RGB) : "+Str(Red(RVB))+","+Str(Green(RVB))+","+Str(Blue(RVB)))
        Case 3
          SetActiveGadget(30)
          Editor_Select(30,0,1,1,-1)
          Editor_Cut(30)
          Editor_Locate(30,-1,-1)
          Editor_Paste(30)
        Case 4
          Cursor_Pos=Editor_GetCursorPos(30)
          Cursor_X=Editor_GetCursorX(30)
          Cursor_Y=Editor_GetCursorY(30)
          SetGadgetText(4,"Position : Pos-"+Str(Cursor_Pos)+" - X-"+Str(Cursor_X)+" - Y-"+Str(Cursor_Y))
        Case 5
          Editor_Select(30,1,1,1,-1)
          Editor_Cut(30)
          Editor_Locate(30,-1,-1)
          Editor_Paste(30)
        Case 6
          Editor_Select(30,1,1,3,-1)
          Editor_Delete(30)
        Case 7
          If Editor_CanUndo(30)
            Editor_Undo(30)
          Else
            RuntimeError("Impossible de faire un Undo")
          EndIf 
        Case 8
          If Editor_CanRedo(30)
            Editor_Redo(30)
          Else
            RuntimeError("Impossible de faire un Redo")
          EndIf
        Case 9
          Editor_Activate(30)
        Case 11
          For i = 0 To 100 
            AddGadgetItem(30,-1,"Line "+RSet(Str(i),4,"0")) 
          Next
          For i = 0 To 100 
            Editor_Down(30)
            Delay(40) 
            While WindowEvent():Wend 
          Next i 
          For i = 0 To 100 
            Editor_Up(30)
            Delay(100) 
            While WindowEvent():Wend 
          Next i 
        Case 12
          Resultat = MessageRequester("LibEditorPlus","Mode Inchs (else Millimeters) :",#PB_MessageRequester_YesNo)
          If Resultat = 6     ; yes
            ; Mode : Inchs
            Editor_Print(30,"LibEditorPlus - Example - Main",#True,0.39,0.39,0.39,0.39)
          Else                ; No
            ; Mode : Millimeters
            Editor_Print(30,"LibEditorPlus - Example - Main",#False,10,10,10,10)
          EndIf        
        Case 13
          Editor_Insert(30, "PureBasic, it's so cool ! Use LibEditorPlus !")
        Case 14
          file$=OpenFileRequester("Choose the file to open in the EditorGadget","","All files (*.*)|*.*",0)
          If file$
            filextension.s=GetExtensionPart(file$)
            If filextension="rtf"
              Editor_LoadRTF(30,file$,0)
            Else
              Editor_LoadText(30,file$)
            EndIf
          Else
            MessageRequester("Information", "Vous devez choisir un fichier à ouvrir.", 0) 
          EndIf
        Case 15
          file$=SaveFileRequester("Choose the file to save","","Text (*.txt)|*.txt|RTF (*.rtf)|*.rtf|All files (*.*)|*.*",0)
          If file$
            filextension.s=GetExtensionPart(file$)
            If filextension="rtf"
              file_res=Editor_SaveRTF(30,file$)
            Else
              file_res=Editor_SaveText(30,file$)
            EndIf
          EndIf
        Case 16
          info.s="Font Name : "+Editor_RTF_GetFont(30)+Chr(10)
          info+"Font Size : "+Str(Editor_RTF_GetFontSize(30))+Chr(10)
          info+"Text Color : R"+Str(Red(Editor_RTF_GetColorText(30)))+"-G:"+Str(Green(Editor_RTF_GetColorText(30)))+"-B:"+Str(Blue(Editor_RTF_GetColorText(30)))+Chr(10)
          info+"Background Color : R"+Str(Red(Editor_RTF_GetColorBack(30)))+"-G:"+Str(Green(Editor_RTF_GetColorBack(30)))+"-B:"+Str(Blue(Editor_RTF_GetColorBack(30)))
          RuntimeError(info)
        Case 17
          RuntimeError(RLibPlus_Editor_Version())
        Case 44
          Select GetGadgetState(44)
            Case 0
              Rtr = Editor_SetZoom(30,1,63)
            Case 1
              Rtr = Editor_SetZoom(30,1,32)
            Case 2
              Rtr = Editor_SetZoom(30,1,16)
            Case 3
              Rtr = Editor_SetZoom(30,1,8)
            Case 4
              Rtr = Editor_SetZoom(30,1,4)
            Case 5  
              Rtr = Editor_SetZoom(30,1,2)
            Case 6
              Rtr = Editor_SetZoom(30,1,1)
            Case 7
              Rtr = Editor_SetZoom(30,2,1)
            Case 8
              Rtr = Editor_SetZoom(30,4,1)
            Case 9
              Rtr = Editor_SetZoom(30,8,1)
            Case 10
              Rtr = Editor_SetZoom(30,16,1)
            Case 11
              Rtr = Editor_SetZoom(30,32,1)
            Case 12
              Rtr = Editor_SetZoom(30,63,1)
          EndSelect
          If OldZoom <> GetGadgetState(44)
            OldZoom = GetGadgetState(44)
            sInfo.s = "Denominator : "+Str(Editor_GetZoomDenominator(30))+Chr(10)
            sInfo + "Numerator : "+Str(Editor_GetZoomNumerator(30))+Chr(10)
            sInfo + "Zoom : "+StrF(Editor_GetZoomCurrent(30))
            RuntimeError(sInfo)
            If Rtr = 0 
              RuntimeError( "Error : Can't Zoom" )
            EndIf 
          EndIf
      EndSelect
    EndIf
  Until EventID=#PB_Event_CloseWindow 
  End 
EndIf 
