Global ToolBarActive=1
Global MarginLeft=0
Macro RuntimeError(line)
  MessageRequester("LibEditorPlus",line)
EndMacro

Procedure Editor_Callback(hWnd, uMsg, wParam, lParam)
  result = #PB_ProcessPureBasicEvents
  Select uMsg
    Case #WM_NOTIFY
      *el.ENLINK = lParam
      If *el\nmhdr\code=#EN_LINK
        If *el\msg=#WM_LBUTTONDOWN
          StringBuffer = AllocateMemory(4)
          txt.TEXTRANGE
          txt\chrg\cpMin = *el\chrg\cpMin
          txt\chrg\cpMax = *el\chrg\cpMax
          txt\lpstrText = StringBuffer
          SendMessage_(GadgetID(1), #EM_GETTEXTRANGE, 0, txt)
          RuntimeError("Link > " + PeekS(StringBuffer))
          If StringBuffer
            FreeMemory(StringBuffer)
          EndIf
        EndIf
      EndIf
  EndSelect
  ProcedureReturn result
EndProcedure

Procedure SetToolbarActive()
  If IsToolBar(ToolBarActive)
    FreeToolBar(ToolBarActive)
  EndIf
  If ToolBarActive=0
    If CreateToolBar(1,WindowID(0))
      ;{ Toolbar
      ToolbarIcon_17 = LoadImage(#PB_Any,"..\Images\17.png")
      ResizeImage(ToolbarIcon_17,16,16,#PB_Image_Raw)
      ToolBarImageButton(100,ImageID(ToolbarIcon_17))
      
      ToolbarIcon_18 = LoadImage(#PB_Any,"..\Images\18.png")
      ResizeImage(ToolbarIcon_18,16,16,#PB_Image_Raw)
      ToolBarImageButton(101,ImageID(ToolbarIcon_18))
      ToolBarSeparator()
      ToolbarIcon_19 = LoadImage(#PB_Any,"..\Images\19.png")
      ResizeImage(ToolbarIcon_19,16,16,#PB_Image_Raw)
      ToolBarImageButton(102,ImageID(ToolbarIcon_19))
      
      ToolbarIcon_20 = LoadImage(#PB_Any,"..\Images\20.png")
      ResizeImage(ToolbarIcon_20,16,16,#PB_Image_Raw)
      ToolBarImageButton(103,ImageID(ToolbarIcon_20))
      
      ToolbarIcon_21 = LoadImage(#PB_Any,"..\Images\21.png")
      ResizeImage(ToolbarIcon_21,16,16,#PB_Image_Raw)
      ToolBarImageButton(104,ImageID(ToolbarIcon_21))
      ToolBarSeparator()
      ToolbarIcon_23 = LoadImage(#PB_Any,"..\Images\23.png")
      ResizeImage(ToolbarIcon_23,16,16,#PB_Image_Raw)
      ToolBarImageButton(105,ImageID(ToolbarIcon_23))
      
      ToolbarIcon_24 = LoadImage(#PB_Any,"..\Images\24.png")
      ResizeImage(ToolbarIcon_24,16,16,#PB_Image_Raw)
      ToolBarImageButton(106,ImageID(ToolbarIcon_24))
      ToolBarSeparator()
      ToolbarIcon_25 = LoadImage(#PB_Any,"..\Images\25.png")
      ResizeImage(ToolbarIcon_25,16,16,#PB_Image_Raw)
      ToolBarImageButton(107,ImageID(ToolbarIcon_25))
      
      ToolbarIcon_26 = LoadImage(#PB_Any,"..\Images\26.png")
      ResizeImage(ToolbarIcon_26,16,16,#PB_Image_Raw)
      ToolBarImageButton(108,ImageID(ToolbarIcon_26))
      
      ToolbarIcon_27 = LoadImage(#PB_Any,"..\Images\27.png")
      ResizeImage(ToolbarIcon_27,16,16,#PB_Image_Raw)
      ToolBarImageButton(109,ImageID(ToolbarIcon_27))
      
      ToolbarIcon_28 = LoadImage(#PB_Any,"..\Images\28.png")
      ResizeImage(ToolbarIcon_28,16,16,#PB_Image_Raw)
      ToolBarImageButton(110,ImageID(ToolbarIcon_28))
      
      ToolbarIcon_29 = LoadImage(#PB_Any,"..\Images\29.png")
      ResizeImage(ToolbarIcon_29,16,16,#PB_Image_Raw)
      ToolBarImageButton(111,ImageID(ToolbarIcon_29))
      ToolBarSeparator()
      ToolbarIcon_30 = LoadImage(#PB_Any,"..\Images\30.png")
      ResizeImage(ToolbarIcon_30,16,16,#PB_Image_Raw)
      ToolBarImageButton(112,ImageID(ToolbarIcon_30))
      ToolBarSeparator()
      ;}
      ;{ Tooltips
        ToolBarToolTip(1,100,"Decrease the left margin")
        ToolBarToolTip(1,101,"Increase the left margin")
        ToolBarToolTip(1,102,"Space after the line")
        ToolBarToolTip(1,103,"Space before the line")
        ToolBarToolTip(1,104,"Interline")
        ToolBarToolTip(1,105,"Subscript")
        ToolBarToolTip(1,106,"Superscript")
        ToolBarToolTip(1,107,"Mode Disabled")
        ToolBarToolTip(1,108,"Text Background Color by default")
        ToolBarToolTip(1,109,"Text Color by default")
        ToolBarToolTip(1,110,"Hidden")
        ToolBarToolTip(1,111,"Capitals")
        ToolBarToolTip(1,112,"Insertion of RTF Code")
      ;}
    EndIf
    ToolBarActive=1
  Else
    If CreateToolBar(0, WindowID(0))
        ;{ Toolbar
        ; Operations > Files
        ToolBarStandardButton(0, #PB_ToolBarIcon_New)
        ToolBarStandardButton(1, #PB_ToolBarIcon_Open)
        ToolBarStandardButton(2, #PB_ToolBarIcon_Save)
        ToolBarStandardButton(3, #PB_ToolBarIcon_Print)
        ToolBarSeparator()
        ; Operations > Edition
        ToolBarStandardButton(4, #PB_ToolBarIcon_Find)
        ToolBarStandardButton(5, #PB_ToolBarIcon_Replace)
        ToolBarStandardButton(6, #PB_ToolBarIcon_Cut)
        ToolBarStandardButton(7, #PB_ToolBarIcon_Copy)
        ToolBarStandardButton(8, #PB_ToolBarIcon_Paste)
        ToolBarStandardButton(9, #PB_ToolBarIcon_Delete)
        ToolBarSeparator()
        ; Operations > Actions Story
        ToolBarStandardButton(10, #PB_ToolBarIcon_Undo)
        ToolBarStandardButton(11, #PB_ToolBarIcon_Redo)
        ToolBarStandardButton(12, #PB_ToolBarIcon_Properties)
        ToolBarSeparator()
        ; Operations > Style
        ToolBarImageButton(13,ImageID(LoadImage(#PB_Any,"..\Images\0.ico")))
        ToolBarImageButton(14,ImageID(LoadImage(#PB_Any,"..\Images\1.ico")))
        ToolBarImageButton(15,ImageID(LoadImage(#PB_Any,"..\Images\2.ico")))
        ToolbarIcon_UnderlineDouble = LoadImage(#PB_Any,"..\Images\22.png")
        ResizeImage(ToolbarIcon_UnderlineDouble,16,16,#PB_Image_Raw)
        ToolBarImageButton(30,ImageID(ToolbarIcon_UnderlineDouble))
        ToolBarImageButton(16,ImageID(LoadImage(#PB_Any,"..\Images\3.ico")))
        ToolBarSeparator()
        ; Operations > Alignment
        ToolBarImageButton(17,ImageID(LoadImage(#PB_Any,"..\Images\4.ico")))
        ToolBarImageButton(18,ImageID(LoadImage(#PB_Any,"..\Images\5.ico")))
        ToolBarImageButton(19,ImageID(LoadImage(#PB_Any,"..\Images\6.ico")))
        ToolBarImageButton(20,ImageID(LoadImage(#PB_Any,"..\Images\7.ico")))
        ToolBarSeparator()
        ; Operations > Lists
        ToolBarImageButton(21,ImageID(LoadImage(#PB_Any,"..\Images\8.ico")))
        ToolBarImageButton(22,ImageID(LoadImage(#PB_Any,"..\Images\9.ico")))
        ToolBarImageButton(29,ImageID(LoadImage(#PB_Any,"..\Images\16.ico")))
        ToolBarSeparator()
        ; Operations > Misc
        ToolBarImageButton(23,ImageID(LoadImage(#PB_Any,"..\Images\10.ico")))
        ToolBarImageButton(24,ImageID(LoadImage(#PB_Any,"..\Images\11.ico")))
        ToolBarImageButton(25,ImageID(LoadImage(#PB_Any,"..\Images\12.ico")))
        ToolBarImageButton(26,ImageID(LoadImage(#PB_Any,"..\Images\13.ico")))
        ToolbarIcon_31 = LoadImage(#PB_Any,"..\Images\31.png")
        ResizeImage(ToolbarIcon_31,16,16,#PB_Image_Raw)
        ToolBarImageButton(31,ImageID(ToolbarIcon_31))
        ToolBarImageButton(27,ImageID(LoadImage(#PB_Any,"..\Images\14.ico")))
        ToolBarSeparator()
        ToolBarImageButton(28,ImageID(LoadImage(#PB_Any,"..\Images\15.ico")))
        ;}
        ;{ Tooltips
        ToolBarToolTip(0,0, "New")
        ToolBarToolTip(0,1, "Open")
        ToolBarToolTip(0,2, "Save")
        ToolBarToolTip(0,3, "Print")
        ToolBarToolTip(0,4, "Find")
        ToolBarToolTip(0,5, "Replace")
        ToolBarToolTip(0,6, "Cut")
        ToolBarToolTip(0,7, "Copy")
        ToolBarToolTip(0,8, "Paste")
        ToolBarToolTip(0,9, "Delete")
        ToolBarToolTip(0,10, "Undo")
        ToolBarToolTip(0,11, "Redo")
        ToolBarToolTip(0,12, "Properties about UNDO and REDO")
        ToolBarToolTip(0,13, "Bold")
        ToolBarToolTip(0,14, "Italic")
        ToolBarToolTip(0,15, "Underline")
        ToolBarToolTip(0,16, "Strikeout")
        ToolBarToolTip(0,17, "Center")
        ToolBarToolTip(0,18, "Justify")
        ToolBarToolTip(0,19, "Aligned on Right")
        ToolBarToolTip(0,20, "Aligned on Left")
        ToolBarToolTip(0,21, "Liste : Number")
        ToolBarToolTip(0,22, "Liste : Chip")
        ToolBarToolTip(0,23, "HyperLink")
        ToolBarToolTip(0,24, "Background Color of the Editor")
        ToolBarToolTip(0,25, "Background Color of the Text")
        ToolBarToolTip(0,26, "Font")
        ToolBarToolTip(0,27, "Font Properties")
        ToolBarToolTip(0,28, "RTF Code")
        ToolBarToolTip(0,29, "Properties about list")
        ToolBarToolTip(0,30, "Special Underline")
        ;}
    EndIf
    ToolBarActive=0
  EndIf
EndProcedure

UsePNGImageDecoder()

If OpenWindow(0,0,0,800,360,"LibEditorPlus - Example > RichEdit",#PB_Window_ScreenCentered |#PB_Window_TitleBar|#PB_Window_SystemMenu)
  SetWindowCallback(@Editor_Callback())
  EditorGadget(1,10,30,660,300)
    Editor_SetEditorFlags(1,Editor_GetEditorFlags(1)|#EN_LINK)
  ButtonGadget(2,680,30,100,300,"Toogle the toolbar",#PB_Button_MultiLine)
  SetToolbarActive()
  If CreateStatusBar(0,WindowID(0))
      AddStatusBarField(30)
      AddStatusBarField(50)
      AddStatusBarField(50)
      AddStatusBarField(40)
      AddStatusBarField(60)
      AddStatusBarField(130)
      AddStatusBarField(135)
      AddStatusBarField(60)
      AddStatusBarField(30)
      AddStatusBarField(55)
      AddStatusBarField(120)
  EndIf
  For i=0 To 13
    AddGadgetItem(1,i,Left("LibEditorPlus",i))
  Next
EndIf
Repeat
  Event  = WindowEvent()
  Gadget = EventGadget()
  Menu   = EventMenu()
  Select Event
    Case #PB_Event_Gadget
      Select Gadget
        Case 1
          If IsToolBar(0)
            ; Can we paste some text ?
            If Editor_CanPaste(1,#CF_TEXT)<>0
              DisableToolBarButton(0,8,#False)
            Else
              DisableToolBarButton(0,8,#True)
            EndIf
            ; Can we do an Undo ?
            If Editor_CanUndo(1)
              DisableToolBarButton(0,9,#False)
            Else
              DisableToolBarButton(0,9,#True)
            EndIf
            ; Can we do an Redo ?
            If Editor_CanRedo(1)
              DisableToolBarButton(0,10,#False)
            Else
              DisableToolBarButton(0,10,#True)
            EndIf         
          EndIf
          Formats = Editor_RTF_GetFormat(1)
          If Editor_RTF_IsBold(Formats)
            StatusBarText(0,0,"Bold")
          Else
            StatusBarText(0,0,"")
          EndIf
          If Editor_RTF_IsItalic(Formats)
            StatusBarText(0,1,"Italic")
          Else
            StatusBarText(0,1,"")
          EndIf
          If Editor_RTF_IsUnderline(Formats)
            StatusBarText(0,2,"Underline")
          Else
            StatusBarText(0,2,"")
          EndIf
          If Editor_RTF_IsStrikeout(Formats)
            StatusBarText(0,3,"Strikeout")
          Else
            StatusBarText(0,3,"")
          EndIf
          If Editor_RTF_IsAllCaps(Formats)
            StatusBarText(0,4,"Capitals")
          Else
            StatusBarText(0,4,"")
          EndIf
          If Editor_RTF_IsAutoBackColor(Formats)
            StatusBarText(0,5,"System Background Color")
          Else
            StatusBarText(0,5,"")
          EndIf
          If Editor_RTF_IsAutoTextColor(Formats)
            StatusBarText(0,6,"System Text Color")
          Else
            StatusBarText(0,6,"")
          EndIf
          If Editor_RTF_IsDisabled(Formats)
            StatusBarText(0,7,"Disabled")
          Else
            StatusBarText(0,7,"")
          EndIf
          If Editor_RTF_IsLink(Formats)
            StatusBarText(0,8,"Link")
          Else
            StatusBarText(0,8,"")
          EndIf

          If Editor_RTF_IsSubScript(1)
            StatusBarText(0,9,"Subscript")
          ElseIf Editor_RTF_IsSuperScript(1)
            StatusBarText(0,9,"SuperScript")
          Else
            StatusBarText(0,9,"")
          EndIf
          
          Alignment=Editor_RTF_GetAlignment(1)
          If Editor_RTF_IsCenter(Alignment)
            StatusBarText(0,10,"Alignment : Center")
          ElseIf Editor_RTF_IsJustify(Alignment)
            StatusBarText(0,10,"Alignment : Justify")
          ElseIf Editor_RTF_IsLeft(Alignment)
            StatusBarText(0,10,"Alignment : Left")
          ElseIf Editor_RTF_IsRight(Alignment)
            StatusBarText(0,10,"Alignment : Right")
          Else
            StatusBarText(0,10,"Alignement : ")
          EndIf
        Case 2
          SetToolbarActive()
      EndSelect
    Case #PB_Event_Menu
      Select Menu
        ;{ Toolbar 0
        Case 0
          SetGadgetText(1,"")
        Case 1
          File.s = OpenFileRequester("Choose a file to load", "", "Text (*.txt)|*.txt|File RTF (*.rtf)|*.rtf|All files (*.*)|*.*", 0)
          If File
            If LCase(GetExtensionPart(File))="txt"
              Editor_LoadText(1,File)
            ElseIf LCase(GetExtensionPart(File))="rtf"
              Editor_LoadRTF(1,File,#True)
            Else
              Editor_LoadText(1,File)
            EndIf
          EndIf
        Case 2
          File.s= SaveFileRequester("Choose a file to save" , "", "Text (*.txt)|*.txt|File RTF (*.rtf)|*.rtf|All files (*.*)|*.*", 0)
          If File
            If LCase(GetExtensionPart(File))="txt"
              Editor_SaveText(1,File)
            ElseIf LCase(GetExtensionPart(File))="rtf"
              Editor_SaveRTF(1,File)
            ElseIf LCase(GetExtensionPart(File))=""
              Editor_SaveRTF(1,File+".rtf")
            Else
              Editor_SaveText(1,File)
            EndIf
          EndIf          
        Case 3
          Resultat = MessageRequester("LibEditorPlus","Mode Inchs (else Millimeters) :",#PB_MessageRequester_YesNo)
          If Resultat = 6     ; Oui
            ; Mode : Inchs
            Editor_Print(1,"LibEditorPlus - Example - RichText",#True,0.39,0.39,0.39,0.39)
          Else                ; Non
            ; Mode : Millimeters
            Editor_Print(1,"LibEditorPlus - Example - RichText",#False,10,10,10,10)
          EndIf        
        Case 4
          Flags=0
          StrSearch.s=InputRequester("LibEditorPlus","Word to find :","")
          If StrSearch > ""
            Resultat = MessageRequester("LibEditorPlus","Matchcase ?",#PB_MessageRequester_YesNo)
            If Resultat = 6     ; Oui
              Flags|#FR_MATCHCASE
            EndIf
            Resultat = MessageRequester("LibEditorPlus","From Selection to down ?",#PB_MessageRequester_YesNo)
            If Resultat = 6     ; Oui
              Flags|#FR_DOWN
            EndIf 
            Resultat = MessageRequester("LibEditorPlus","Only whole words ?",#PB_MessageRequester_YesNo)
            If Resultat = 6     ; Oui
              Flags|#FR_WHOLEWORD
            EndIf 
            FindPos=Editor_Find(1,0,"Lib",#True,Flags)
            Repeat
              Follow=MessageRequester("LibEditorPlus","Next word ?",#PB_MessageRequester_YesNo)
              If Follow=6
                FindPos=Editor_Find(1,FindPos,"Lib",#True,Flags)
              Else
                Break
              EndIf
            Until FindPos = -1
          EndIf
        Case 5
          Flags=0
          StrSearch.s=InputRequester("LibEditorPlus","Word to find :","")
          StrReplace.s=InputRequester("LibEditorPlus","Word to replace :","")
          If StrSearch > ""
            Resultat = MessageRequester("LibEditorPlus","Matchcase ?",#PB_MessageRequester_YesNo)
            If Resultat = 6     ; Oui
              Flags|#FR_MATCHCASE
            EndIf
            Resultat = MessageRequester("LibEditorPlus","From Selection to down ?",#PB_MessageRequester_YesNo)
            If Resultat = 6     ; Oui
              Flags|#FR_DOWN
            EndIf 
            Resultat = MessageRequester("LibEditorPlus","Only whole words ?",#PB_MessageRequester_YesNo)
            If Resultat = 6     ; Oui
              Flags|#FR_WHOLEWORD
            EndIf 
            FindPos=Editor_Find(1,0,"Lib",#True,Flags)
            Editor_Insert(1,StrReplace)
            Repeat
              Follow=MessageRequester("LibEditorPlus","Next word ?",#PB_MessageRequester_YesNo)
              If Follow=6
                FindPos=Editor_Find(1,FindPos,"Lib",#True,Flags)
                Editor_Insert(1,StrReplace)
              Else
                Break
              EndIf
            Until FindPos = -1
          EndIf
        Case 6
          Editor_Cut(1)
        Case 7
          Editor_Copy(1)
        Case 8
          Editor_Paste(1)
        Case 9
          Editor_Undo(1)
        Case 10
          Editor_Redo(1)
        Case 11
          Editor_Delete(1)
        Case 12
          info.s=""
          If Editor_CanUndo(1)
            Select Editor_GetTypeUndo(1)
              Case 0
                info + "The type of undo action is Unknown." + Chr(13) + Chr(10)
              Case 1
                info + "The type of undo action is Typing." + Chr(13) + Chr(10)
              Case 2
                info + "The type of undo action is Delete." + Chr(13) + Chr(10)
              Case 3
                info + "The type of undo action is Drag 'n Drop." + Chr(13) + Chr(10)
              Case 4
                info + "The type of undo action is Cut." + Chr(13) + Chr(10)
              Case 5
                info + "The type of undo action is Paste." + Chr(13) + Chr(10)
            EndSelect
          EndIf
          If Editor_CanRedo(1)
            Select Editor_GetTypeRedo(1)
              Case 0
                info + "The type of redo action is Unknown." + Chr(13) + Chr(10)
              Case 1
                info + "The type of redo action is Typing." + Chr(13) + Chr(10)
              Case 2
                info + "The type of redo action is Delete." + Chr(13) + Chr(10)
              Case 3
                info + "The type of redo action is Drag 'n Drop." + Chr(13) + Chr(10)
              Case 4
                info + "The type of redo action is Cut." + Chr(13) + Chr(10)
              Case 5
                info + "The type of redo action is Paste." + Chr(13) + Chr(10)
            EndSelect
          EndIf         
          RuntimeError(info)
        Case 13
          If Editor_RTF_IsBold(Editor_RTF_GetFormat(1))
            Editor_RTF_RemoveFormat(1,#CFE_BOLD)
          Else
            Editor_RTF_AddFormat(1,#CFE_BOLD)
          EndIf
        Case 14
          If Editor_RTF_IsItalic(Editor_RTF_GetFormat(1))
            Editor_RTF_RemoveFormat(1,#CFE_ITALIC)
          Else
            Editor_RTF_AddFormat(1,#CFE_ITALIC)
          EndIf
        Case 15
          If Editor_RTF_IsUnderline(Editor_RTF_GetFormat(1))
            Editor_RTF_RemoveFormat(1,#CFE_UNDERLINE)
          Else
            Editor_RTF_AddFormat(1,#CFE_UNDERLINE)
          EndIf
        Case 16
          If Editor_RTF_IsStrikeout(Editor_RTF_GetFormat(1))
            Editor_RTF_RemoveFormat(1,#CFE_STRIKEOUT)
          Else
            Editor_RTF_AddFormat(1,#CFE_STRIKEOUT)
          EndIf
        Case 17
          Editor_RTF_SetAlignment(1,#PFA_CENTER)
        Case 18
          Editor_RTF_SetAlignment(1,#PFA_JUSTIFY)
        Case 19
          Editor_RTF_SetAlignment(1,#PFA_RIGHT)
        Case 20
          Editor_RTF_SetAlignment(1,#PFA_LEFT)
        Case 21
          Editor_RTF_SetList(1,2,1,$100,5)
        Case 22
          Editor_RTF_SetList(1,1,0,0,10)
        Case 23
          If Editor_RTF_IsLink(Editor_RTF_GetFormat(1))
            Editor_RTF_SetLink(1,#False)
          Else
            Editor_RTF_SetLink(1,#True)
          EndIf
        Case 24
          Editor_RTF_SetColorBackground(1,Random($FFFFFF))
        Case 25
          Editor_RTF_SetColorBack(1,Random($FFFFFF))
        Case 26
          Resultat = FontRequester("Arial", 12, #PB_FontRequester_Effects)
          If Resultat
            Editor_RTF_SetFont(1,SelectedFontName())
            Editor_RTF_SetFontSize(1,SelectedFontSize())
            Editor_RTF_SetColorText(1,SelectedFontColor())
            Format=0
            If SelectedFontStyle() & #PB_Font_Bold
              Format|#CFE_BOLD
            EndIf
            If SelectedFontStyle() & #PB_Font_StrikeOut
              Format|#CFE_STRIKEOUT
            EndIf
            If SelectedFontStyle() & #PB_Font_Underline
              Format|#CFE_UNDERLINE
            EndIf
            If SelectedFontStyle() & #PB_Font_Italic
              Format|#CFE_ITALIC
            EndIf
            Editor_RTF_SetFormat(1,Format)
          EndIf
        Case 27
          info.s="FontName : "+ Editor_RTF_GetFont(1)+Chr(13)+Chr(10)
          info + "FontSize : "+ Str(Editor_RTF_GetFontSize(1)) +Chr(13)+Chr(10)
          info + "Font Color :"+ Str(Editor_RTF_GetColorText(1)) +Chr(13)+Chr(10)
          info + "Background Color : "+ Str(Editor_RTF_GetColorBack(1)) +Chr(13)+Chr(10)
          RuntimeError(info)
        Case 28
          RuntimeError(Editor_RTF_GetRTFCode(1))
        Case 29
          info.s="Type : "+ Str(Editor_RTF_GetListType(1))+Chr(13)+Chr(10)
          info + "Start Number : "+ Str(Editor_RTF_GetListNumStart(1)) +Chr(13)+Chr(10)
          info + "Style :"+ Hex(Editor_RTF_GetListStyle(1)) +Chr(13)+Chr(10)
          info + "Tab : "+ Str(Editor_RTF_GetListTab(1)) +Chr(13)+Chr(10)
          RuntimeError(info)
        Case 30
          Editor_RTF_SetSpecialUnderline(1,Random(18))
          SUnderline=Editor_RTF_GetSpecialUnderline(1)
          If Editor_RTF_IsUnderlineThickLongDash(SUnderline)
            RuntimeError("UnderlineThickLongDash")
          ElseIf Editor_RTF_IsUnderlineThickDotted(SUnderline)
            RuntimeError("UnderlineThickDotted")
          ElseIf Editor_RTF_IsUnderlineThickDashDotDot(SUnderline)
            RuntimeError("UnderlineThickDashDotDot")
          ElseIf Editor_RTF_IsUnderlineThickDashDot(SUnderline)
            RuntimeError("UnderlineThickDashDot")
          ElseIf Editor_RTF_IsUnderlineThickDash(SUnderline)
            RuntimeError("UnderlineThickDash")
          ElseIf Editor_RTF_IsUnderlineLongDash(SUnderline)
            RuntimeError("UnderlineLongDash")
          ElseIf Editor_RTF_IsUnderlineHeavyWave(SUnderline)
            RuntimeError("UnderlineHeavyWave")
          ElseIf Editor_RTF_IsUnderlineDoubleWave(SUnderline)
            RuntimeError("UnderlineDoubleWave")
          ElseIf Editor_RTF_IsUnderlineHairLine(SUnderline)
            RuntimeError("UnderlineHairLine")
          ElseIf Editor_RTF_IsUnderlineThick(SUnderline)
            RuntimeError("UnderlineThick")
          ElseIf Editor_RTF_IsUnderlineWave(SUnderline)
            RuntimeError("UnderlineWave")
          ElseIf Editor_RTF_IsUnderlineDashDotDot(SUnderline)
            RuntimeError("UnderlineDashDotDot")
          ElseIf Editor_RTF_IsUnderlineDashDot(SUnderline)
            RuntimeError("UnderlineDashDot")
          ElseIf Editor_RTF_IsUnderlineDash(SUnderline)
            RuntimeError("UnderlineDash")
          ElseIf Editor_RTF_IsUnderlineDotted(SUnderline)
            RuntimeError("UnderlineDotted")
          ElseIf Editor_RTF_IsUnderlineDouble(SUnderline)
            RuntimeError("UnderlineDouble")
          ElseIf Editor_RTF_IsUnderlineWord(SUnderline)
            RuntimeError("UnderlineWord")
          ElseIf Editor_RTF_IsUnderlineLine(SUnderline)
            RuntimeError("UnderlineLine")
          ElseIf Editor_RTF_IsUnderlineNone(SUnderline)
            RuntimeError("UnderlineNone")
          EndIf
        Case 31
          If Random(1)
            FontStep= Random(10)
          Else
            FontStep= - Random(10)
          EndIf
          Editor_RTF_SetFontSizeStep(1,FontStep)
        ;}
        ;{ Toolbar 1
        Case 100
          Editor_SetMargin(1,MarginLeft-5,0)
          MarginLeft-5
          If MarginLeft <0
            MarginLeft =0
          EndIf
        Case 101
          Editor_SetMargin(1,MarginLeft+5,0)
          MarginLeft+5
        Case 102
          Result.s=InputRequester("Space after the line", "Size : ",Str(Editor_RTF_GetSpaceAfter(1)))
          If Result
            Editor_RTF_SetSpaceAfter(1,Val(Result))
          EndIf
        Case 103
          Result.s=InputRequester("Space before the line", "Size : ",Str(Editor_RTF_GetSpaceBefore(1)))
          If Result
            Editor_RTF_SetSpaceBefore(1,Val(Result))
          EndIf
        Case 104
          Result.s=InputRequester("Interline", "Size : ",Str(Editor_RTF_GetInterline(1)))
          If Result
            Editor_RTF_SetInterline(1,Val(Result))
          EndIf
        Case 105
          Editor_RTF_SetScript(1,-50)
        Case 106
          Editor_RTF_SetScript(1,50)
        Case 107
          Editor_RTF_AddFormat(1,#CFE_DISABLED)
        Case 108
          Editor_RTF_AddFormat(1,#CFE_AUTOBACKCOLOR)
        Case 109
          Editor_RTF_AddFormat(1,#CFE_AUTOCOLOR)
        Case 110
          Editor_RTF_AddFormat(1,#CFE_HIDDEN)
        Case 111
          Editor_RTF_AddFormat(1,#CFE_ALLCAPS)
        Case 112
          Editor_RTF_InsertRTFCode(1,"\plain \ql \li100 \b TEXT IN RTF FORMAT\par")
        ;}
      EndSelect
  EndSelect
Until Event=#PB_Event_CloseWindow