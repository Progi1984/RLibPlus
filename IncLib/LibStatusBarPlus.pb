XIncludeFile "../RLibPlus.pb"
; SB_GETBORDERS > Retrieves the current widths of the horizontal And vertical borders of a status window. 
ProcedureDLL StatusBar_GetWidthHorizontalBorder(StatusBar.l)
  Protected Dim borders.l(3)
  SendMessage_(StatusBarID(StatusBar),#SB_GETBORDERS,0,@borders())
  ProcedureReturn borders(0)
EndProcedure
ProcedureDLL StatusBar_GetWidthVerticalBorder(StatusBar.l)
  Protected Dim borders.l(3)
  SendMessage_(StatusBarID(StatusBar),#SB_GETBORDERS,0,@borders())
  ProcedureReturn borders(1)
EndProcedure
ProcedureDLL StatusBar_GetWidthInnerBorder(StatusBar.l)
  Protected Dim borders.l(3)
  SendMessage_(StatusBarID(StatusBar),#SB_GETBORDERS,0,@borders())
  ProcedureReturn borders(2)
EndProcedure

; SB_GETPARTS > Retrieves a count of the parts in a status window. The message also retrieves the coordinate of the right edge of the specified number of parts. 
ProcedureDLL StatusBar_GetNumberParts(StatusBar.l)
  Protected Dim parts.l(0)
  ProcedureReturn SendMessage_(StatusBarID(StatusBar),#SB_GETPARTS,0,@parts())
EndProcedure

; SB_GETRECT  > Retrieves the bounding rectangle of a part in a status window. 
ProcedureDLL StatusBar_StatusBarField_GetX(StatusBar.l, StatusBarField.l)
  Protected rc.RECT
  SendMessage_(StatusBarID(StatusBar),#SB_GETRECT,StatusBarField,@rc)
  ProcedureReturn rc\left
EndProcedure
ProcedureDLL StatusBar_StatusBarField_GetY(StatusBar.l, StatusBarField.l)
  Protected rc.RECT
  SendMessage_(StatusBarID(StatusBar),#SB_GETRECT,StatusBarField,@rc)
  ProcedureReturn rc\top
EndProcedure
ProcedureDLL StatusBar_StatusBarField_GetWidth(StatusBar.l, StatusBarField.l)
  Protected rc.RECT
  SendMessage_(StatusBarID(StatusBar),#SB_GETRECT,StatusBarField,@rc)
  ProcedureReturn rc\right - rc\left
EndProcedure
ProcedureDLL StatusBar_StatusBarField_GetHeight(StatusBar.l, StatusBarField.l)
  Protected rc.RECT
  SendMessage_(StatusBarID(StatusBar),#SB_GETRECT,StatusBarField,@rc)
  ProcedureReturn rc\bottom - rc\top
EndProcedure
; SB_SETPARTS > Sets the number of parts in a status window And the coordinate of the right edge of each part. 
ProcedureDLL StatusBar_StatusBarField_SetWidth(StatusBar.l, StatusBarField.l, Width.l)
  Protected NumParts = StatusBar_GetNumberParts(StatusBar.l)
  Protected Dim SetParts.l(NumParts-1)
  Protected Dim GetParts.l(NumParts-1)
  SendMessage_(StatusBarID(StatusBar),#SB_GETPARTS,NumParts,@GetParts())
  SendMessage_(StatusBarID(StatusBar),#SB_GETPARTS,NumParts,@SetParts())
  SetParts.l(StatusBarField) = Width
  For Inc_a = StatusBarField+1 To NumParts
    SetParts.l(Inc_a) = GetParts(Inc_a) - GetParts(Inc_a - 1)
  Next
  SendMessage_(StatusBarID(StatusBar),#SB_SETPARTS,NumParts,@SetParts())
  ProcedureReturn 
EndProcedure
; SB_SETTEXT  > The SB_SETTEXT message sets the text in the specified part of a status window.
ProcedureDLL StatusBar_StatusBarField_SetText(StatusBar.l, StatusBarField.l, Text.s)
  ProcedureReturn SendMessage_(StatusBarID(StatusBar),#SB_SETTEXT,StatusBarField,@Text)
EndProcedure
; SB_GETTEXT  > The SB_GETTEXT message retrieves the text from the specified part of a status window. 
ProcedureDLL.s StatusBar_StatusBarField_GetText(StatusBar.l, StatusBarField.l)
  Text.s=Space(Loword(SendMessage_(StatusBarID(StatusBar),#SB_GETTEXTLENGTH,StatusBarField,0)))
  SendMessage_(StatusBarID(StatusBar),#SB_GETTEXT,StatusBarField,@Text)
  ProcedureReturn Text
EndProcedure
; SB_GETTEXTLENGTH  > The SB_GETTEXTLENGTH message retrieves the length, in characters, of the text from the specified part of a status window. 
ProcedureDLL StatusBar_StatusBarField_GetTextLength(StatusBar.l, StatusBarField.l)
  ProcedureReturn Loword(SendMessage_(StatusBarID(StatusBar),#SB_GETTEXTLENGTH,StatusBarField,0))
EndProcedure

; SB_GETUNICODEFORMAT > Retrieves the Unicode character format flag For the control. 
ProcedureDLL StatusBar_GetUnicodeFormat(StatusBar.l)
  ProcedureReturn SendMessage_(StatusBarID(StatusBar),#SB_GETUNICODEFORMAT,0,0)
EndProcedure
; SB_SETUNICODEFORMAT > Sets the Unicode character format flag For the control. This message allows you To change the character set used by the control at run time rather than having To re-create the control. 
ProcedureDLL StatusBar_SetUnicodeFormat(StatusBar.l, State.l)
  ProcedureReturn SendMessage_(StatusBarID(StatusBar),#SB_SETUNICODEFORMAT,State,0)
EndProcedure

; SB_ISSIMPLE > Checks a status bar control To determine If it is in simple mode. 
ProcedureDLL StatusBar_GetSimpleMode(StatusBar.l)
  ProcedureReturn SendMessage_(StatusBarID(StatusBar),#SB_ISSIMPLE,0,0)
EndProcedure
; SB_SIMPLE > Specifies whether a status window displays simple text Or displays all window parts set by a previous SB_SETPARTS message. 
ProcedureDLL StatusBar_SetSimpleMode(StatusBar.l, SimpleMode.l)
  ProcedureReturn SendMessage_(StatusBarID(StatusBar),#SB_SIMPLE,SimpleMode,0)
EndProcedure

; SB_SETBKCOLOR > Sets the background color in a status bar. 
; désactiver le support des thèmes XP
ProcedureDLL StatusBar_SetBackColor(StatusBar.l, Color.l)
  ProcedureReturn SendMessage_(StatusBarID(StatusBar),#SB_SETBKCOLOR,0,Color)
EndProcedure

; SB_GETICON  > Retrieves the icon For a part in a status bar. 
ProcedureDLL StatusBar_GetIconID(StatusBar.l, StatusBarField.l)
  ProcedureReturn SendMessage_(StatusBarID(StatusBar),#SB_GETICON,StatusBarField,0)
EndProcedure
; SB_SETICON  > Sets the icon For a part in a status bar. 
ProcedureDLL StatusBar_SetIcon(StatusBar.l, StatusBarField.l, IconID.l)
  ProcedureReturn SendMessage_(StatusBarID(StatusBar),#SB_SETICON,StatusBarField,IconID)
EndProcedure


























; IDE Options = PureBasic v4.00 (Windows - x86)
; CursorPosition = 48
; Folding = AMA9
; EnableXP