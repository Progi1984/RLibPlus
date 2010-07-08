XIncludeFile "../RLibPlus.pb"
; AddGadgetItem
;   CB_ADDSTRING                An application sends a CB_ADDSTRING message To add a string To the list box of a combo box. If the combo box does Not have the CBS_SORT style, the string is added To the End of the list. Otherwise, the string is inserted into the list, And the list is sorted.
;   CB_INSERTSTRING             An application sends a CB_INSERTSTRING message To insert a string into the list box of a combo box. Unlike the CB_ADDSTRING message, the CB_INSERTSTRING message does Not cause a list With the CBS_SORT style To be sorted.
; RemoveGadgetItem
;   CB_DELETESTRING             An application sends a CB_DELETESTRING message To delete a string in the list box of a combo box.
; CountGadgetItems
;   CB_GETCOUNT                 An application sends a CB_GETCOUNT message To retrieve the number of items in the list box of a combo box.
; GetGadgetState
;   CB_GETCURSEL                An application sends a CB_GETCURSEL message To retrieve the index of the currently selected item, If any, in the list box of a combo box.
; SetGadgetState
;   CB_SETCURSEL    An application sends a CB_SETCURSEL message To Select a string in the list of a combo box. If necessary, the list scrolls the string into view. The text in the edit control of the combo box changes To reflect the new selection, And any previous selection in the list is removed.
; GetGadgetX
;   CB_GETDROPPEDCONTROLRECT    An application sends a CB_GETDROPPEDCONTROLRECT message To retrieve the screen coordinates of a combo box in its dropped-down state.
; GetGadgetY
;   CB_GETDROPPEDCONTROLRECT    An application sends a CB_GETDROPPEDCONTROLRECT message To retrieve the screen coordinates of a combo box in its dropped-down state.
; GetGadgetWidth
;   CB_GETDROPPEDCONTROLRECT    An application sends a CB_GETDROPPEDCONTROLRECT message To retrieve the screen coordinates of a combo box in its dropped-down state.
; GetGadgetHeight
;   CB_GETDROPPEDCONTROLRECT    An application sends a CB_GETDROPPEDCONTROLRECT message To retrieve the screen coordinates of a combo box in its dropped-down state.
; GetGadgetItemText
;   CB_GETLBTEXT                An application sends a CB_GETLBTEXT message To retrieve a string from the list of a combo box.
; ClearGadgetItemList
;   CB_RESETCONTENT             An application sends a CB_RESETCONTENT message To remove all items from the list box And edit control of a combo box.


; CB_DIR    An application sends a CB_DIR message To a combo box To add names To the list displayed by the combo box. The message adds the names of directories And files that match a specified string And set of file attributes. CB_DIR can also add mapped drive letters To the list.
ProcedureDLL ComboBox_AddListDrives(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#CB_DIR,#DDL_DRIVES,@none)
EndProcedure
ProcedureDLL ComboBox_AddListDirectories(Gadget.l, Path.s)
  Path+"*"
  ProcedureReturn SendMessage_(GadgetID(Gadget),#CB_DIR,#DDL_DIRECTORY,@Path)
EndProcedure
ProcedureDLL ComboBox_AddListArchives(Gadget.l, Path.s)
  Path+"*"
  ProcedureReturn SendMessage_(GadgetID(Gadget),#CB_DIR,#DDL_ARCHIVE,@Path)
EndProcedure
ProcedureDLL ComboBox_AddListHidden(Gadget.l, Path.s)
  Path+"*"
  ProcedureReturn SendMessage_(GadgetID(Gadget),#CB_DIR,#DDL_HIDDEN,@Path)
EndProcedure
ProcedureDLL ComboBox_AddListReadOnly(Gadget.l, Path.s)
  Path+"*"
  ProcedureReturn SendMessage_(GadgetID(Gadget),#CB_DIR,#DDL_READONLY,@Path)
EndProcedure
ProcedureDLL ComboBox_AddListReadWrite(Gadget.l, Path.s)
  Path+"*"
  ProcedureReturn SendMessage_(GadgetID(Gadget),#CB_DIR,#DDL_READWRITE,@Path)
EndProcedure
ProcedureDLL ComboBox_AddListSystem(Gadget.l, Path.s)
  Path+"*"
  ProcedureReturn SendMessage_(GadgetID(Gadget),#CB_DIR,#DDL_SYSTEM,@Path)
EndProcedure

; CB_FINDSTRING    An application sends a CB_FINDSTRING message To search the list box of a combo box For an item beginning With the characters in a specified string.
; CB_FINDSTRINGEXACT    An application sends a CB_FINDSTRINGEXACT message To find the first list box string in a combo box that matches the string specified in the lParam parameter.
; CB_SELECTSTRING    An application sends a CB_SELECTSTRING message To search the list of a combo box For an item that begins With the characters in a specified string. If a matching item is found, it is selected And copied To the edit control.
ProcedureDLL ComboBox_Find(Gadget.l, Position.l, Text.s, Highlight.l, Exact.l)
  If Exact = #True
    If Highlight = #True
      SendMessage_(GadgetID(Gadget),#CB_FINDSTRINGEXACT,Position, Text)
      ProcedureReturn SendMessage_(GadgetID(Gadget), #CB_SELECTSTRING , -1 , Text)
    Else
      ProcedureReturn SendMessage_(GadgetID(Gadget),#CB_FINDSTRINGEXACT,Position, Text)
    EndIf      
  Else
    If Highlight = #True
      SendMessage_(GadgetID(Gadget),#CB_FINDSTRING,Position, Text)
      ProcedureReturn SendMessage_(GadgetID(Gadget), #CB_SELECTSTRING , -1 , Text)
    Else
      ProcedureReturn SendMessage_(GadgetID(Gadget),#CB_FINDSTRING,Position, Text)
    EndIf
  EndIf
EndProcedure

; CB_GETCOMBOBOXINFO    An application sends the CB_GETCOMBOBOXINFO message To retrieve information about the specified combo box.
ProcedureDLL ComboBox_GetEditX(Gadget.l)
  Protected pt.COMBOBOXINFO
  pt\cbSize=SizeOf(COMBOBOXINFO)
  SendMessage_(GadgetID(Gadget),#CB_GETCOMBOBOXINFO,0,pt)
  ProcedureReturn pt\rcItem\left
EndProcedure
ProcedureDLL ComboBox_GetEditY(Gadget.l)
  Protected pt.COMBOBOXINFO
  pt\cbSize=SizeOf(COMBOBOXINFO)
  SendMessage_(GadgetID(Gadget),#CB_GETCOMBOBOXINFO,0,pt)
  ProcedureReturn pt\rcItem\top
EndProcedure
ProcedureDLL ComboBox_GetEditWidth(Gadget.l)
  Protected pt.COMBOBOXINFO
  pt\cbSize=SizeOf(COMBOBOXINFO)
  SendMessage_(GadgetID(Gadget),#CB_GETCOMBOBOXINFO,0,pt)
  ProcedureReturn pt\rcItem\right - pt\rcItem\left
EndProcedure
ProcedureDLL ComboBox_GetEditHeight(Gadget.l)
  Protected pt.COMBOBOXINFO
  pt\cbSize=SizeOf(COMBOBOXINFO)
  SendMessage_(GadgetID(Gadget),#CB_GETCOMBOBOXINFO,0,pt)
  ProcedureReturn pt\rcItem\bottom - pt\rcItem\top
EndProcedure
ProcedureDLL ComboBox_GetEditID(Gadget.l)
  Protected pt.COMBOBOXINFO
  pt\cbSize=SizeOf(COMBOBOXINFO)
  SendMessage_(GadgetID(Gadget),#CB_GETCOMBOBOXINFO,0,pt)
  ProcedureReturn pt\hwndItem
EndProcedure
; CB_SETITEMHEIGHT    An application sends a CB_SETITEMHEIGHT message To set the height of list items Or the selection field in a combo box.
ProcedureDLL ComboBox_SetEditHeight(Gadget.l, Height.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget), #CB_SETITEMHEIGHT , -1, Height)
EndProcedure

; CB_GETCOMBOBOXINFO    An application sends the CB_GETCOMBOBOXINFO message To retrieve information about the specified combo box.
ProcedureDLL ComboBox_GetButtonX(Gadget.l)
  Protected pt.COMBOBOXINFO
  pt\cbSize=SizeOf(COMBOBOXINFO)
  SendMessage_(GadgetID(Gadget),#CB_GETCOMBOBOXINFO,0,pt)
  ProcedureReturn pt\rcButton\left
EndProcedure
ProcedureDLL ComboBox_GetButtonY(Gadget.l)
  Protected pt.COMBOBOXINFO
  pt\cbSize=SizeOf(COMBOBOXINFO)
  SendMessage_(GadgetID(Gadget),#CB_GETCOMBOBOXINFO,0,pt)
  ProcedureReturn pt\rcButton\top
EndProcedure
ProcedureDLL ComboBox_GetButtonWidth(Gadget.l)
  Protected pt.COMBOBOXINFO
  pt\cbSize=SizeOf(COMBOBOXINFO)
  SendMessage_(GadgetID(Gadget),#CB_GETCOMBOBOXINFO,0,pt)
  ProcedureReturn pt\rcButton\right - pt\rcButton\left
EndProcedure
ProcedureDLL ComboBox_GetButtonHeight(Gadget.l)
  Protected pt.COMBOBOXINFO
  pt\cbSize=SizeOf(COMBOBOXINFO)
  SendMessage_(GadgetID(Gadget),#CB_GETCOMBOBOXINFO,0,pt)
  ProcedureReturn pt\rcButton\bottom - pt\rcButton\top
EndProcedure
ProcedureDLL ComboBox_GetButtonState(Gadget.l)
  Protected pt.COMBOBOXINFO
  pt\cbSize=SizeOf(COMBOBOXINFO)
  SendMessage_(GadgetID(Gadget),#CB_GETCOMBOBOXINFO,0,pt)
  Select pt\stateButton
    Case 0
      ProcedureReturn 0
    Case #STATE_SYSTEM_INVISIBLE
      ProcedureReturn 1
    Case #STATE_SYSTEM_PRESSED
      ProcedureReturn 2
    Default
      ProcedureReturn 0
  EndSelect
EndProcedure

ProcedureDLL ComboBox_GetDropDownID(Gadget.l)
  Protected pt.COMBOBOXINFO
  pt\cbSize=SizeOf(COMBOBOXINFO)
  SendMessage_(GadgetID(Gadget),#CB_GETCOMBOBOXINFO,0,pt)
  ProcedureReturn pt\hwndList
EndProcedure

; CB_GETDROPPEDSTATE    An application sends a CB_GETDROPPEDSTATE message To determine whether the list box of a combo box is dropped down.
ProcedureDLL ComboBox_GetDropDownState(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget), #CB_GETDROPPEDSTATE ,0 ,0 )
EndProcedure
; CB_SHOWDROPDOWN    An application sends a CB_SHOWDROPDOWN message To show Or hide the list box of a combo box that has the CBS_DROPDOWN Or CBS_DROPDOWNLIST style. 
ProcedureDLL ComboBox_SetDropDownState(Gadget.l, State.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget), #CB_SHOWDROPDOWN , State, 0)
EndProcedure

; CB_SETDROPPEDWIDTH    An application sends the CB_SETDROPPEDWIDTH message To set the maximum allowable width, in pixels, of the list box of a combo box With the CBS_DROPDOWN Or CBS_DROPDOWNLIST style.
ProcedureDLL ComboBox_SetDropDownWidth(Gadget.l, Width.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget), #CB_SETDROPPEDWIDTH, Width, 0)
EndProcedure
; CB_GETDROPPEDWIDTH    An application sends the CB_GETDROPPEDWIDTH message To retrieve the minimum allowable width, in pixels, of the list box of a combo box With the CBS_DROPDOWN Or CBS_DROPDOWNLIST style.
ProcedureDLL ComboBox_GetDropDownWidth(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget), #CB_SETDROPPEDWIDTH, 0, 0)
EndProcedure


; CB_GETEDITSEL    An application sends a CB_GETEDITSEL message To get the starting And ending character positions of the current selection in the edit control of a combo box.
ProcedureDLL ComboBox_GetSelStart(Gadget.l)
  Protected debut.l, fin.l
  SendMessage_(GadgetID(Gadget), #CB_GETEDITSEL ,@debut ,@fin )
  ProcedureReturn debut
EndProcedure
ProcedureDLL ComboBox_GetSelEnd(Gadget.l)
  Protected debut.l, fin.l
  SendMessage_(GadgetID(Gadget), #CB_GETEDITSEL ,@debut ,@fin )
  ProcedureReturn fin
EndProcedure
; CB_SETEDITSEL    An application sends a CB_SETEDITSEL message To Select characters in the edit control of a combo box.
ProcedureDLL ComboBox_SetSel(Gadget.l, SStart.l, SEnd.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget), #CB_SETEDITSEL , 0, MakeLong(SStart,SEnd))
EndProcedure

; CB_GETITEMDATA    An application sends a CB_GETITEMDATA message To a combo box To retrieve the application-supplied value associated With the specified item in the combo box.
ProcedureDLL ComboBox_GetGadgetItemData(Gadget.l, Item.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget), #CB_GETITEMDATA , Item, 0)
EndProcedure
; CB_SETITEMDATA    An application sends a CB_SETITEMDATA message To set the value associated With the specified item in a combo box.
ProcedureDLL ComboBox_SetGadgetItemData(Gadget.l, Item.l, Value.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget), #CB_SETITEMDATA , Item, Value)
EndProcedure


; CB_GETITEMHEIGHT    An application sends a CB_GETITEMHEIGHT message To determine the height of list items Or the selection field in a combo box.
ProcedureDLL ComboBox_GetHeightItem(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget), #CB_GETITEMHEIGHT , 0, 0)
EndProcedure
; CB_SETITEMHEIGHT    An application sends a CB_SETITEMHEIGHT message To set the height of list items Or the selection field in a combo box.
ProcedureDLL ComboBox_SetHeightItem(Gadget.l, Height.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget), #CB_SETITEMHEIGHT , 0, Height)
EndProcedure


; CB_GETLBTEXTLEN    An application sends a CB_GETLBTEXTLEN message To retrieve the length, in characters, of a string in the list of a combo box.
ProcedureDLL ComboBox_GetGadgetItemLen(Gadget.l, Item.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget), #CB_GETLBTEXTLEN , Item, 0)
EndProcedure

;http://msdn.microsoft.com/library/default.asp?url=/library/en-us/intl/nls_238z.asp
; CB_GETLOCALE    An application sends a CB_GETLOCALE message To retrieve the current locale of the combo box. The locale is used To determine the correct sorting order of displayed text For combo boxes With the CBS_SORT style And text added by using the CB_ADDSTRING message.
ProcedureDLL.s ComboBox_GetLanguageIdentifier(Gadget.l)
  ProcedureReturn Hex((SendMessage_(GadgetID(Gadget), #CB_GETLOCALE , 0, 0) & $FFFF))
EndProcedure
ProcedureDLL.s ComboBox_GetCountryCode(Gadget.l)
  ProcedureReturn Hex((SendMessage_(GadgetID(Gadget), #CB_GETLOCALE , 0, 0) >> 16) & $FFFF)
EndProcedure
; CB_SETLOCALE    An application sends a CB_SETLOCALE message To set the current locale of the combo box. If the combo box has the CBS_SORT style And strings are added using CB_ADDSTRING, the locale of a combo box affects how list items are sorted.
ProcedureDLL ComboBox_SetLanguageIdentifier(Gadget.l, LanguageIdentifier.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#CB_SETLOCALE,Makelong(HiWord(SendMessage_(GadgetID(Gadget),#CB_GETLOCALE,0,0)),LanguageIdentifier),0)
EndProcedure
ProcedureDLL ComboBox_SetCountryCode(Gadget.l, CountryCode.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#CB_SETLOCALE,Makelong(CountryCode,LoWord(SendMessage_(GadgetID(Gadget),#CB_GETLOCALE,0,0))),0)
EndProcedure



; CB_GETMINVISIBLE    An application sends a CB_GETMINVISIBLE message To get the minimum number of visible items in the drop-down list of a combo box.
ProcedureDLL ComboBox_GetMinVisibleItems(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget), #CB_GETMINVISIBLE , 0, 0)
EndProcedure

; CB_GETTOPINDEX    An application sends the CB_GETTOPINDEX message To retrieve the zero-based index of the first visible item in the list box portion of a combo box. Initially, the item With index 0 is at the top of the list box, but If the list box contents have been scrolled, another item may be at the top.
ProcedureDLL ComboBox_GetFirstVisible(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget), #CB_GETTOPINDEX , 0, 0)
EndProcedure
; CB_SETTOPINDEX    An application sends the CB_SETTOPINDEX message To ensure that a particular item is visible in the list box of a combo box. The system scrolls the list box contents so that either the specified item appears at the top of the list box Or the maximum scroll range has been reached.
ProcedureDLL ComboBox_SetFirstVisible(Gadget.l, Item.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget), #CB_SETTOPINDEX , Item, 0)
EndProcedure


; CB_LIMITTEXT    An application sends a CB_LIMITTEXT message To limit the length of the text the user may type into the edit control of a combo box.
ProcedureDLL ComboBox_SetLimitText(Gadget.l, Limit.l)
  ; 0 => limit = $7FFFFFFE 
  ProcedureReturn SendMessage_(GadgetID(Gadget), #CB_LIMITTEXT , Limit, 0)
EndProcedure


; CB_SETEXTENDEDUI    An application sends a CB_SETEXTENDEDUI message To Select either the Default user Interface Or the extended user Interface For a combo box that has the CBS_DROPDOWN Or CBS_DROPDOWNLIST style.
ProcedureDLL ComboBox_SetDropDownKey(Gadget.l, Key.l)
  ; Key
  ; #True   : fleche du bas
  ; #False  : F4
  ProcedureReturn SendMessage_(GadgetID(Gadget), #CB_SETEXTENDEDUI , Key, 0)
EndProcedure
; CB_GETEXTENDEDUI    An application sends a CB_GETEXTENDEDUI message To determine whether a combo box has the Default user Interface Or the extended user Interface. If the combo box has the extended user interface, the return value is TRUE; otherwise, it is FALSE. By default, the F4 key opens or closes the list and the DOWN ARROW changes the current selection. In a combo box with the extended user interface, the F4 key is disabled and pressing the DOWN ARROW key opens the drop-down list.
ProcedureDLL ComboBox_GetDropDownKey(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget), #CB_GETEXTENDEDUI , 0, 0)
EndProcedure

;- Couleurs
Procedure ComboBox_ColorCallBack( hWnd.l, Message.l, wParam.l, lParam.l ) 
  skin.l = GetWindowLong_( hWnd, #GWL_USERDATA ) 
  Result.l = CallWindowProc_( PeekL(skin+16), hWnd, Message, wParam, lParam ) 
  If (Message = #WM_DESTROY) 
    DeleteObject_( PeekL(skin+12) ) 
    GlobalFree_( skin ) 
    PostQuitMessage_(0) 
  ElseIf (Message = #WM_CTLCOLOREDIT) Or (Message = #WM_CTLCOLORLISTBOX) 
    SetTextColor_( wParam, PeekL(skin+0) ) 
    SetBkColor_  ( wParam, PeekL(skin+4) ) 
    SetBkMode_   ( wParam, PeekL(skin+8) ) 
    Result = PeekL(skin+12) 
  EndIf 
  ProcedureReturn Result 
EndProcedure 
ProcedureDLL ComboBox_SetColor(Gadget.l, TextColor.l, BackTextColor.l, BackGroundColor.l)
  Protected skin.l
  skin.l = GlobalAlloc_(#Null,5*4) 
  SetWindowLong_(GadgetID(Gadget), #GWL_USERDATA, skin ) 
  PokeL(skin+ 0, TextColor) 
  PokeL(skin+ 4, BackTextColor) 
  PokeL(skin+ 8, 2) 
  PokeL(skin+12, CreateSolidBrush_(BackGroundColor)) 
  PokeL(skin+16, SetWindowLong_(GadgetID(Gadget), #GWL_WNDPROC, @ComboBox_ColorCallBack())) 
  ProcedureReturn 
EndProcedure

ProcedureDLL ComboBox_SetPasswordChar(Gadget.l, Char.l)
  ProcedureReturn SendMessage_(GetWindow_(GadgetID(Gadget), #GW_CHILD), #EM_SETPASSWORDCHAR, Char, 0)
EndProcedure




































































