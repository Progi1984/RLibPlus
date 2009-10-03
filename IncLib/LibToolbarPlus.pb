XIncludeFile "../RLibPlus.pb"
;* Common
; TB_COMMANDTOINDEX > Retrieves the zero-based index For the button associated With the specified command identifier. 
Procedure Toolbar_GetIndex(ToolbarID.l, CommandIdentifier.l)
  ProcedureReturn SendMessage_(ToolBarID,#TB_COMMANDTOINDEX,CommandIdentifier,0)
EndProcedure


; TB_AUTOSIZE > Causes a toolbar To be resized. 
ProcedureDLL Toolbar_AutoResize(ToolbarID.l)
  ProcedureReturn SendMessage_(ToolBarID,#TB_AUTOSIZE,0,0)
EndProcedure

; TB_BUTTONCOUNT  > Retrieves a count of the buttons currently in the toolbar. 
ProcedureDLL Toolbar_CountItems(ToolbarID.l)
  ProcedureReturn SendMessage_(ToolBarID,#TB_BUTTONCOUNT,0,0)
EndProcedure

; TB_CHANGEBITMAP > Changes the bitmap For a button in a toolbar.
ProcedureDLL Toolbar_SetIcon(ToolbarID.l, Item.l, IconeButton.l)
  ProcedureReturn SendMessage_(ToolBarID,#TB_CHANGEBITMAP,Toolbar_GetIndex(ToolbarID, Item),IconeButton)
EndProcedure
; TB_GETBITMAP  > Retrieves the index of the bitmap associated With a button in a toolbar. 
ProcedureDLL Toolbar_GetIcon(ToolbarID.l, Item.l)
  ProcedureReturn SendMessage_(ToolBarID,#TB_GETBITMAP,Toolbar_GetIndex(ToolbarID, Item),0)
EndProcedure

; TB_DELETEBUTTON < Deletes a button from the toolbar. 
ProcedureDLL Toolbar_RemoveItem(ToolbarID.l, Item.l)
  ProcedureReturn SendMessage_(ToolBarID,#TB_DELETEBUTTON,Toolbar_GetIndex(ToolbarID, Item),0)
EndProcedure

; TB_GETBUTTONSIZE  > Retrieves the current width And height of toolbar buttons, in pixels. 
ProcedureDLL Toolbar_GetWidthButton(ToolbarID.l)
  ProcedureReturn LoWord(SendMessage_(ToolBarID,#TB_GETBUTTONSIZE,0,0))
EndProcedure
ProcedureDLL Toolbar_GetHeightButton(ToolbarID.l)
  ProcedureReturn HiWord(SendMessage_(ToolBarID,#TB_GETBUTTONSIZE,0,0))
EndProcedure

; TB_GETBUTTONTEXT  > Retrieves the display text of a button on a toolbar.
ProcedureDLL.s Toolbar_GetItemText(ToolbarID.l, Item.l)
  Protected taille.l
  taille= SendMessage_(ToolBarID,#TB_GETBUTTONTEXT,Toolbar_GetIndex(ToolbarID, Item),0)
  If taille > 0
    Space.s=Space(taille)
    SendMessage_(ToolBarID,#TB_GETBUTTONTEXT,Toolbar_GetIndex(ToolbarID, Item),@Space)
    ProcedureReturn Space
  Else
    ProcedureReturn ""
  EndIf
EndProcedure

; TB_GETITEMRECT  > Retrieves the bounding rectangle of a button in a toolbar. 
ProcedureDLL Toolbar_GetItemX(ToolbarID.l, Item.l)
  Protected TB_GETITEMRECT.RECT
    SendMessage_(ToolBarID,#TB_GETITEMRECT,Item,TB_GETITEMRECT)
  ProcedureReturn TB_GETITEMRECT\left
EndProcedure
ProcedureDLL Toolbar_GetItemY(ToolbarID.l, Item.l)
  Protected TB_GETITEMRECT.RECT
    SendMessage_(ToolBarID,#TB_GETITEMRECT,Item,TB_GETITEMRECT)
  ProcedureReturn TB_GETITEMRECT\top

EndProcedure
ProcedureDLL Toolbar_GetItemWidth(ToolbarID.l, Item.l)
  Protected TB_GETITEMRECT.RECT
    SendMessage_(ToolBarID,#TB_GETITEMRECT,Item,TB_GETITEMRECT)
  ProcedureReturn TB_GETITEMRECT\right - TB_GETITEMRECT\left
EndProcedure
ProcedureDLL Toolbar_GetItemHeight(ToolbarID.l, Item.l)
  Protected TB_GETITEMRECT.RECT
    SendMessage_(ToolBarID,#TB_GETITEMRECT,Item,TB_GETITEMRECT)
  ProcedureReturn TB_GETITEMRECT\bottom - TB_GETITEMRECT\top
EndProcedure

; TB_GETMAXSIZE > Retrieves the total size of all of the visible buttons And separators in the toolbar. 
ProcedureDLL Toolbar_GetWidth(ToolbarID.l)
  Protected TB_GETMAXSIZE.SIZE
  SendMessage_(ToolBarID,#TB_GETMAXSIZE,0,TB_GETMAXSIZE)
  ProcedureReturn TB_GETMAXSIZE\cx
EndProcedure
ProcedureDLL Toolbar_GetHeight(ToolbarID.l)
  Protected TB_GETMAXSIZE.SIZE
  SendMessage_(ToolBarID,#TB_GETMAXSIZE,0,TB_GETMAXSIZE)
  ProcedureReturn TB_GETMAXSIZE\cy
EndProcedure

; TB_GETROWS  > Retrieves the number of rows of buttons in a toolbar With the TBSTYLE_WRAPABLE style. 
ProcedureDLL Toolbar_GetRows(ToolbarID.l)
  ProcedureReturn SendMessage_(ToolBarID,#TB_GETROWS,0,0)
EndProcedure
; TB_SETROWS  > Sets the number of rows of buttons in a toolbar.
ProcedureDLL Toolbar_SetRows(ToolbarID.l, Rows.l)
  ProcedureReturn SendMessage_(ToolBarID,#TB_SETROWS,MakeWord(Rows,#True),0)
EndProcedure


; TB_GETSTATE > Retrieves information about the state of the specified button in a toolbar, such As whether it is enabled, pressed, Or checked. 
  ; The button is being clicked.
ProcedureDLL Toolbar_GetPressedState(ToolbarID.l, Item.l)
  state = SendMessage_(ToolBarID,#TB_GETSTATE,Toolbar_GetIndex(ToolbarID, Item),0)
  If state & #TBSTATE_PRESSED
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
; TB_ISBUTTONPRESSED  > Determines whether the specified button in a toolbar is pressed. 
;  SendMessage_(ToolBarID,#TB_ISBUTTONPRESSED,Toolbar_GetIndex(ToolbarID, Item),0)
; TB_PRESSBUTTON  > Presses Or releases the specified button in a toolbar.
ProcedureDLL Toolbar_SetPressedState(ToolbarID.l, Item.l, State.l)
  ProcedureReturn SendMessage_(ToolBarID,#TB_PRESSBUTTON,Toolbar_GetIndex(ToolbarID, Item), State)
EndProcedure


; TB_GETSTATE > Retrieves information about the state of the specified button in a toolbar, such As whether it is enabled, pressed, Or checked. 
  ; The button is Not visible And cannot receive user input.
ProcedureDLL Toolbar_GetHiddenState(ToolbarID.l, Item.l)
  state = SendMessage_(ToolBarID,#TB_GETSTATE,Toolbar_GetIndex(ToolbarID, Item),0)
  If state & #TBSTATE_HIDDEN
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
; TB_HIDEBUTTON > Hides Or shows the specified button in a toolbar.
ProcedureDLL Toolbar_SetHiddenState(ToolbarID.l, Item.l, State.l)
  ProcedureReturn SendMessage_(ToolBarID,#TB_HIDEBUTTON,Toolbar_GetIndex(ToolbarID, Item),State)
EndProcedure
; TB_ISBUTTONHIDDEN > Determines whether the specified button in a toolbar is hidden. 
;  SendMessage_(ToolBarID,#TB_ISBUTTONHIDDEN,Toolbar_GetIndex(ToolbarID, Item),0)

; TB_GETSTATE > Retrieves information about the state of the specified button in a toolbar, such As whether it is enabled, pressed, Or checked. 
  ; The button is grayed.
ProcedureDLL Toolbar_GetGrayedState(ToolbarID.l, Item.l)
  state = SendMessage_(ToolBarID,#TB_GETSTATE,Toolbar_GetIndex(ToolbarID, Item),0)
  If state & #TBSTATE_INDETERMINATE
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
; TB_INDETERMINATE  > Sets Or clears the indeterminate state of the specified button in a toolbar.
ProcedureDLL Toolbar_SetGrayedState(ToolbarID.l, Item.l, State.l)
  ProcedureReturn SendMessage_(ToolBarID(0),#TB_INDETERMINATE,Toolbar_GetIndex(ToolbarID, Item),MakeLong(State,0))
EndProcedure
; TB_ISBUTTONINDETERMINATE  > Determines whether the specified button in a toolbar is indeterminate. 
;  SendMessage_(ToolBarID,#TB_ISBUTTONINDETERMINATE,Toolbar_GetIndex(ToolbarID, Item),0)


; TB_GETSTATE > Retrieves information about the state of the specified button in a toolbar, such As whether it is enabled, pressed, Or checked. 
  ; The button is followed by a line break. The button must also have the TBSTATE_ENABLED state.
ProcedureDLL Toolbar_GetLineBreakState(ToolbarID.l, Item.l)
  state = SendMessage_(ToolBarID,#TB_GETSTATE,Toolbar_GetIndex(ToolbarID, Item),0)
  If state & #TBSTATE_WRAP
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure

; TB_GETSTATE > Retrieves information about the state of the specified button in a toolbar, such As whether it is enabled, pressed, Or checked. 
  ; Version 4.70. The button's text is cut off and an ellipsis is displayed.
ProcedureDLL Toolbar_GetEllipsedState(ToolbarID.l, Item.l)
  state = SendMessage_(ToolBarID,#TB_GETSTATE,Toolbar_GetIndex(ToolbarID, Item),0)
  If state & #TBSTATE_ELLIPSES
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure

; TB_GETSTATE > Retrieves information about the state of the specified button in a toolbar, such As whether it is enabled, pressed, Or checked. 
  ; Version 4.71. The button is marked. The interpretation of a marked item is dependent upon the application. 
ProcedureDLL Toolbar_GetMarkedState(ToolbarID.l, Item.l)
  state = SendMessage_(ToolBarID,#TB_GETSTATE,Toolbar_GetIndex(ToolbarID, Item),0)
  If state & #TBSTATE_MARKED
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
; TB_MARKBUTTON > Sets the highlight state of a given button in a toolbar control.
ProcedureDLL Toolbar_SetMarkedState(ToolbarID.l, Item.l, State.l)
  ProcedureReturn SendMessage_(ToolBarID,#TB_MARKBUTTON,Toolbar_GetIndex(ToolbarID, Item),MakeLong(State,0))
EndProcedure


; TB_ENABLEBUTTON > Enables Or disables the specified button in a toolbar.
ProcedureDLL Toolbar_SetActiveState(ToolbarID.l, Item.l, State.l)
  ProcedureReturn SendMessage_(ToolBarID,#TB_ENABLEBUTTON,Toolbar_GetIndex(ToolbarID, Item),State)
EndProcedure
; TB_GETSTATE > Retrieves information about the state of the specified button in a toolbar, such As whether it is enabled, pressed, Or checked. 
  ; The button accepts user input. A button that doesn't have this state is grayed.
ProcedureDLL Toolbar_GetActiveState(ToolbarID.l, Item.l)
  state = SendMessage_(ToolBarID,#TB_GETSTATE,Toolbar_GetIndex(ToolbarID, Item),0)
  If state & #TBSTATE_ENABLED
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure        
; TB_ISBUTTONENABLED  > Determines whether the specified button in a toolbar is enabled. 
;  SendMessage_(ToolBarID,#TB_ISBUTTONENABLED,Toolbar_GetIndex(ToolbarID, Item),0)

; TB_CHECKBUTTON  > Checks Or unchecks a given button in a toolbar.
ProcedureDLL Toolbar_SetCheckState(ToolbarID.l, Item.l, State.l)
  ProcedureReturn SendMessage_(ToolBarID,#TB_CHECKBUTTON,Toolbar_GetIndex(ToolbarID, Item),State)
EndProcedure
; TB_GETSTATE > Retrieves information about the state of the specified button in a toolbar, such As whether it is enabled, pressed, Or checked. 
  ; The button has the TBSTYLE_CHECK style And is being clicked.
ProcedureDLL Toolbar_GetCheckState(ToolbarID.l, Item.l)
  state = SendMessage_(ToolBarID,#TB_GETSTATE,Toolbar_GetIndex(ToolbarID, Item),0)
  If state & #TBSTATE_CHECKED
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
; TB_ISBUTTONCHECKED  > Determines whether the specified button in a toolbar is checked. 
;  SendMessage_(ToolBarID,#TB_ISBUTTONCHECKED,Toolbar_GetIndex(ToolbarID, Item),0)

; TB_ISBUTTONHIGHLIGHTED  > Checks the highlight state of a toolbar button. 
;  SendMessage_(ToolBarID,#TB_ISBUTTONHIGHLIGHTED,Toolbar_GetIndex(ToolbarID, Item),0)
ProcedureDLL Toolbar_GetHighlightedState(ToolbarID.l, Item.l)
  ProcedureReturn SendMessage_(ToolBarID,#TB_ISBUTTONHIGHLIGHTED,Toolbar_GetIndex(ToolbarID, Item),0)
EndProcedure


; TB_GETSTYLE > Retrieves the styles currently in use For a toolbar control. 
ProcedureDLL Toolbar_GetAltDragState(ToolbarID.l)
  style = SendMessage_(ToolBarID,#TB_GETSTYLE,0,0)
  If style & #TBSTYLE_ALTDRAG ; Allows users To change a toolbar button's position by dragging it while holding down the ALT key. If this style is not specified, the user must hold down the SHIFT key while dragging a button. Note that the CCS_ADJUSTABLE style must be specified to enable toolbar buttons to be dragged.
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Toolbar_GetCustomEraseState(ToolbarID.l)
  style = SendMessage_(ToolBarID,#TB_GETSTYLE,0,0)
  If style & #TBSTYLE_CUSTOMERASE ; Version 4.70. Generates NM_CUSTOMDRAW notification messages when the toolbar processes WM_ERASEBKGND messages.
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure 
ProcedureDLL Toolbar_GetFlatState(ToolbarID.l)
  style = SendMessage_(ToolBarID,#TB_GETSTYLE,0,0)
  If style & #TBSTYLE_FLAT ; Version 4.70. Creates a flat toolbar. In a flat toolbar, both the toolbar And the buttons are transparent And hot-tracking is enabled. Button text appears under button bitmaps. To prevent repainting problems, this style should be set before the toolbar control becomes visible. 
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Toolbar_GetListState(ToolbarID.l)
  style = SendMessage_(ToolBarID,#TB_GETSTYLE,0,0)
  If style & #TBSTYLE_LIST ; Version 4.70. Creates a flat toolbar With button text To the right of the bitmap. Otherwise, this style is identical To TBSTYLE_FLAT. To prevent repainting problems, this style should be set before the toolbar control becomes visible.
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure 
ProcedureDLL Toolbar_GetDragNDropState(ToolbarID.l)
  style = SendMessage_(ToolBarID,#TB_GETSTYLE,0,0)
  If style & #TBSTYLE_REGISTERDROP ; Version 4.71. Generates TBN_GETOBJECT notification messages To request drop target objects when the cursor passes over toolbar buttons.
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Toolbar_GetTooltipsState(ToolbarID.l)
  style = SendMessage_(ToolBarID,#TB_GETSTYLE,0,0)
  If style & #TBSTYLE_TOOLTIPS ; Creates a ToolTip control that an application can use To display descriptive text For the buttons in the toolbar.
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure 
ProcedureDLL Toolbar_GetTransparentState(ToolbarID.l)
  style = SendMessage_(ToolBarID,#TB_GETSTYLE,0,0)
  If style & #TBSTYLE_TRANSPARENT ; Version 4.71. Creates a transparent toolbar. In a transparent toolbar, the toolbar is transparent but the buttons are Not. Button text appears under button bitmaps. To prevent repainting problems, this style should be set before the toolbar control becomes visible.
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Toolbar_GetWrapableState(ToolbarID.l)
  style = SendMessage_(ToolBarID,#TB_GETSTYLE,0,0)
  If style & #TBSTYLE_WRAPABLE ; Creates a toolbar that can have multiple lines of buttons. Toolbar buttons can "wrap" To the Next line when the toolbar becomes too narrow To include all buttons on the same line. When the toolbar is wrapped, the Break will occur on either the rightmost separator Or the rightmost button If there are no separators on the bar. This style must be set To display a vertical toolbar control when the toolbar is part of a vertical rebar control.
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure

; TB_GETTEXTROWS  > Retrieves the maximum number of text rows that can be displayed on a toolbar button. 
ProcedureDLL Toolbar_GetMaxTextRows(ToolbarID.l)
  ProcedureReturn SendMessage_(ToolBarID,#TB_GETTEXTROWS,0,0)
EndProcedure
; TB_SETMAXTEXTROWS > Sets the maximum number of text rows displayed on a toolbar button. 
ProcedureDLL Toolbar_SetMaxTextRows(ToolbarID.l, MaxTextRows.l)
  ProcedureReturn SendMessage_(ToolBarID,#TB_SETMAXTEXTROWS,MaxTextRows,0)
EndProcedure


; TB_GETTOOLTIPS  > Retrieves the handle To the ToolTip control, If any, associated With the toolbar. 
ProcedureDLL Toolbar_GetTooltipID(ToolbarID.l)
  ProcedureReturn SendMessage_(ToolBarID,#TB_GETTOOLTIPS,0,0)
EndProcedure
; TB_SETTOOLTIPS  > Associates a ToolTip control With a toolbar. 
ProcedureDLL Toolbar_SetTooltipID(ToolbarID.l, TooltipID.l)
  ProcedureReturn SendMessage_(ToolBarID,#TB_SETTOOLTIPS,TooltipID,0)
EndProcedure


; TB_GETUNICODEFORMAT > Retrieves the Unicode character format flag For the control. 
ProcedureDLL Toolbar_GetUnicodeFormat(ToolbarID.l)
  ProcedureReturn SendMessage_(ToolBarID,#TB_GETUNICODEFORMAT,0,0)
EndProcedure
; TB_SETUNICODEFORMAT > Sets the Unicode character format flag For the control. This message allows you To change the character set used by the control at run time rather than having To re-create the control. 
ProcedureDLL Toolbar_SetUnicodeFormat(ToolbarID.l, Activate.l)
  ProcedureReturn SendMessage_(ToolBarID,#TB_SETUNICODEFORMAT,Activate,0)
EndProcedure

; TB_SETINDENT  > Sets the indentation For the first button in a toolbar control. 
ProcedureDLL Toolbar_SetIndentation(ToolbarID.l, Indentation.l)
  ProcedureReturn SendMessage_(ToolBarID,#TB_SETINDENT,Indentation,0)
EndProcedure
ProcedureDLL Toolbar_GetIndentation(ToolbarID.l)
  ProcedureReturn Toolbar_GetItemX(ToolbarID, 0)
EndProcedure

          























































