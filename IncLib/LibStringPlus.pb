XIncludeFile "../RLibPlus.pb"
; EM_CANUNDO  > The EM_CANUNDO message determines whether there are any actions in an edit control's undo queue. You can send this message to either an edit control or a rich edit control.
ProcedureDLL String_CanUndo(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#EM_CANUNDO,0,0)
EndProcedure

; EM_EMPTYUNDOBUFFER  > The EM_EMPTYUNDOBUFFER message resets the undo flag of an edit control. The undo flag is set whenever an operation within the edit control can be undone. You can send this message To either an edit control Or a rich edit control.
ProcedureDLL String_EmptyUndoRedo(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#EM_EMPTYUNDOBUFFER,0,0)
EndProcedure

; EM_GETFIRSTVISIBLELINE  > The EM_GETFIRSTVISIBLELINE message retrieves the zero-based index of the uppermost visible line in a multiline edit control. You can send this message To either an edit control Or a rich edit control.
ProcedureDLL String_GetFirstCharacterVisible(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#EM_GETFIRSTVISIBLELINE,0,0)
EndProcedure

; EM_GETLIMITTEXT > The EM_GETLIMITTEXT message retrieves the current text limit For an edit control. You can send this message To either an edit control Or a rich edit control.
ProcedureDLL String_GetLimitText(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#EM_GETLIMITTEXT,0,0)
EndProcedure
; EM_SETLIMITTEXT > The EM_SETLIMITTEXT message sets the text limit of an edit control. The text limit is the maximum amount of text, in TCHARs, that the user can type into the edit control. You can send this message To either an edit control Or a rich edit control.For edit controls And Rich Edit 1.0, bytes are used. For Rich Edit 2.0 And later, characters are used.The EM_SETLIMITTEXT message is identical To the EM_LIMITTEXT message. 
; EM_LIMITTEXT  > The EM_LIMITTEXT message sets the text limit of an edit control. The text limit is the maximum amount of text, in TCHARs, that the user can type into the edit control. You can send this message To either an edit control Or a rich edit control. For edit controls And Microsoft® Rich Edit 1.0, bytes are used. For Rich Edit 2.0 And later, characters are used.
ProcedureDLL String_SetLimitText(Gadget.l, Limit.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#EM_LIMITTEXT,Limit,0)
EndProcedure


; EM_GETMARGINS > An application sends the EM_GETMARGINS message To retrieve the widths of the left And right margins For an edit control. 
ProcedureDLL String_GetMarginLeft(Gadget.l)
  ProcedureReturn LoWord(SendMessage_(GadgetID(Gadget),#EM_GETMARGINS,0,0))
EndProcedure
ProcedureDLL String_GetMarginRight(Gadget.l)
  ProcedureReturn HiWord(SendMessage_(GadgetID(Gadget),#EM_GETMARGINS,0,0))
EndProcedure
; EM_SETMARGINS > The EM_SETMARGINS message sets the widths of the left And right margins For an edit control. The message redraws the control To reflect the new margins. You can send this message To either an edit control Or a rich edit control.
ProcedureDLL String_SetMarginLeft(Gadget.l, MarginLeft.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#EM_SETMARGINS,#EC_LEFTMARGIN,MakeWord(0,MarginLeft))
EndProcedure
ProcedureDLL String_SetMarginRight(Gadget.l, MarginRight.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#EM_SETMARGINS,#EC_RIGHTMARGIN,MakeLong(MarginRight,0))
EndProcedure


; EM_GETMODIFY  > The EM_GETMODIFY message retrieves the state of an edit control's modification flag. The flag indicates whether the contents of the edit control have been modified. You can send this message to either an edit control or a rich edit control.
ProcedureDLL String_GetModifiedState(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#EM_GETMODIFY,0,0)
EndProcedure
; EM_SETMODIFY  > The EM_SETMODIFY message sets Or clears the modification flag For an edit control. The modification flag indicates whether the text within the edit control has been modified. You can send this message To either an edit control Or a rich edit control.
ProcedureDLL String_SetModifiedState(Gadget.l, State.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#EM_SETMODIFY,State,0)
EndProcedure


; EM_GETPASSWORDCHAR  > The EM_GETPASSWORDCHAR message retrieves the password character that an edit control displays when the user enters text. You can send this message To either an edit control Or a rich edit control.
ProcedureDLL.s String_GetPasswordChar(Gadget.l)
  ProcedureReturn Chr(SendMessage_(GadgetID(0),#EM_GETPASSWORDCHAR,0,0))
EndProcedure
; EM_SETPASSWORDCHAR  < The EM_SETPASSWORDCHAR message sets Or removes the password character For an edit control. When a password character is set, that character is displayed in place of the characters typed by the user. You can send this message To either an edit control Or a rich edit control.
ProcedureDLL String_SetPasswordCharA(Gadget.l, PasswordChar.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#EM_SETPASSWORDCHAR,PasswordChar,0)
EndProcedure
ProcedureDLL String_SetPasswordCharC(Gadget.l, PasswordChar.s)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#EM_SETPASSWORDCHAR,Asc(PasswordChar),0)
EndProcedure


; EM_GETRECT  > The EM_GETRECT message retrieves the formatting rectangle of an edit control. The formatting rectangle is the limiting rectangle into which the control draws the text. The limiting rectangle is independent of the size of the edit-control window. You can send this message To either an edit control Or a rich edit control.
ProcedureDLL String_GetEditX(Gadget.l)
  rc.RECT
  SendMessage_(GadgetID(Gadget),#EM_GETRECT,0,@rc)
  ProcedureReturn GadgetX(Gadget) + rc\left
EndProcedure
ProcedureDLL String_GetEditY(Gadget.l)
  rc.RECT
  SendMessage_(GadgetID(Gadget),#EM_GETRECT,0,@rc)
  ProcedureReturn GadgetY(Gadget) + rc\top
EndProcedure
ProcedureDLL String_GetEditWidth(Gadget.l)
  rc.RECT
  SendMessage_(GadgetID(Gadget),#EM_GETRECT,0,@rc)
  ProcedureReturn rc\right - rc\left
EndProcedure
ProcedureDLL String_GetEditHeight(Gadget.l)
  rc.RECT
  SendMessage_(GadgetID(Gadget),#EM_GETRECT,0,@rc)
  ProcedureReturn rc\bottom - rc\top
EndProcedure

; EM_GETSEL > The EM_GETSEL message retrieves the starting And ending character positions of the current selection in an edit control. You can send this message To either an edit control Or a rich edit control.
ProcedureDLL String_SelGetPosStart(Gadget.l)
  SendMessage_(GadgetID(Gadget),#EM_GETSEL,@Min,@Max)
  ProcedureReturn Min
EndProcedure
ProcedureDLL String_SelGetPosEnd(Gadget.l)
  SendMessage_(GadgetID(Gadget),#EM_GETSEL,@Min,@Max)
  ProcedureReturn Max
EndProcedure
; EM_SETSEL > The EM_SETSEL message selects a range of characters in an edit control. You can send this message To either an edit control Or a rich edit control.
ProcedureDLL String_SelSetSel(Gadget.l, SelStart.l, SelEnd.l)
  SendMessage_(GadgetID(Gadget),#EM_SETSEL,SelStart,SelEnd)
  SetActiveGadget(Gadget)
  ProcedureReturn 
EndProcedure


; EM_LINELENGTH > The EM_LINELENGTH message retrieves the length, in characters, of a line in an edit control. You can send this message To either an edit control Or a rich edit control.
ProcedureDLL String_GetLengthContent(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#EM_LINELENGTH,0,0)
EndProcedure

; EM_POSFROMCHAR  > The EM_POSFROMCHAR message retrieves the client area coordinates of a specified character in an edit control. You can send this message To either an edit control Or a rich edit control. 
ProcedureDLL String_GetPosX(Gadget.l, Position.l)
  ProcedureReturn LoWord(SendMessage_(GadgetID(Gadget),#EM_POSFROMCHAR,Position,0))
EndProcedure
ProcedureDLL String_GetPosY(Gadget.l, Position.l)
  ProcedureReturn HiWord(SendMessage_(GadgetID(Gadget),#EM_POSFROMCHAR,Position,0))
EndProcedure

; EM_REPLACESEL > The EM_REPLACESEL message replaces the current selection in an edit control With the specified text. You can send this message To either an edit control Or a rich edit control.
ProcedureDLL String_Insert(Gadget.l, Text.s)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#EM_REPLACESEL,#True,@Text)
EndProcedure

; EM_SETCUEBANNER > The EM_SETCUEBANNER message sets the textual cue, Or tip, that is displayed by the edit control To prompt the user For information. For more discussion of this, see the Remarks section.
ProcedureDLL String_SetCueBanner(Gadget.l, Text.s)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#EM_SETCUEBANNER,0,@Text)
EndProcedure
;-EM_GETCUEBANNER > The EM_GETCUEBANNER message retrieves the text that is displayed As the textual cue, Or tip, in an edit control.
ProcedureDLL.s String_GetCueBanner(Gadget.l)
  Text.s = Space(512)
  SendMessage_(GadgetID(Gadget),#EM_GETCUEBANNER,0,@Text)
  ProcedureReturn Text
EndProcedure

; EM_UNDO > The EM_UNDO message undoes the last edit control operation in the control's undo queue. You can send this message to either an edit control or a rich edit control.
; WM_UNDO > An application sends a WM_UNDO message To an edit control To undo the last operation. When this message is sent To an edit control, the previously deleted text is restored Or the previously added text is deleted. 
ProcedureDLL String_Undo(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#EM_UNDO,0,0)
EndProcedure

































































