XIncludeFile "../RLibPlus.pb"
; LB_ADDSTRING  > An application sends an LB_ADDSTRING message To add a string To a list box. If the list box does Not have the LBS_SORT style, the string is added To the End of the list. Otherwise, the string is inserted into the list And the list is sorted. 
  ; LB_ADDFILE  > An application sends an LB_ADDFILE message To add the specified filename To a list box that contains a directory listing. 
ProcedureDLL ListView_AddItem(Gadget.l, Text.s)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LB_ADDSTRING,0,@Text)
EndProcedure
; LB_DELETESTRING > An application sends an LB_DELETESTRING message To delete a string in a list box. 
ProcedureDLL ListView_RemoveItem(Gadget.l, Item.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LB_DELETESTRING,Item,0)
EndProcedure
; LB_INSERTSTRING > An application sends an LB_INSERTSTRING message To insert a string into a list box. Unlike the LB_ADDSTRING message, the LB_INSERTSTRING message does Not cause a list With the LBS_SORT style To be sorted. 
ProcedureDLL ListView_InsertItem(Gadget.l, Item.l, Text.s)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LB_INSERTSTRING,Item,@Text)
EndProcedure
; LB_GETCOUNT > An application sends an LB_GETCOUNT message To retrieve the number of items in a list box. 
  ; LB_GETLISTBOXINFO > An application sends an LB_GETLISTBOXINFO message To retrieve the number of items per column in a specified list box. 
ProcedureDLL ListView_CountItems(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LB_GETCOUNT,0,0)
EndProcedure
; LB_RESETCONTENT > An application sends an LB_RESETCONTENT message To remove all items from a list box. 
ProcedureDLL ListView_ClearItems(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LB_RESETCONTENT,0,0)
EndProcedure


; LB_DIR  > An application sends an LB_DIR message To a list box To add names To the list displayed by the list box. The message adds the names of directories And files that match a specified string And set of file attributes. LB_DIR can also add mapped drive letters To the list box.
ProcedureDLL ListView_AddListDrives(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LB_DIR,#DDL_DRIVES,@none)
EndProcedure
ProcedureDLL ListView_AddListDirectories(Gadget.l, Path.s)
  Path+"*"
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LB_DIR,#DDL_DIRECTORY,@Path)
EndProcedure
ProcedureDLL ListView_AddListArchives(Gadget.l, Path.s)
  Path+"*"
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LB_DIR,#DDL_ARCHIVE,@Path)
EndProcedure
ProcedureDLL ListView_AddListHidden(Gadget.l, Path.s)
  Path+"*"
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LB_DIR,#DDL_HIDDEN,@Path)
EndProcedure
ProcedureDLL ListView_AddListReadOnly(Gadget.l, Path.s)
  Path+"*"
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LB_DIR,#DDL_READONLY,@Path)
EndProcedure
ProcedureDLL ListView_AddListReadWrite(Gadget.l, Path.s)
  Path+"*"
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LB_DIR,#DDL_READWRITE,@Path)
EndProcedure
ProcedureDLL ListView_AddListSystem(Gadget.l, Path.s)
  Path+"*"
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LB_DIR,#DDL_SYSTEM,@Path)
EndProcedure

; LB_FINDSTRING > An application sends an LB_FINDSTRING message To find the first string in a list box that begins With the specified string. 
; LB_FINDSTRINGEXACT  > An application sends a LB_FINDSTRINGEXACT message To find the first list box string that exactly matches the specified string, except that the search is Not Case sensitive. 
ProcedureDLL ListView_Find2(Gadget.l, Text.s, BeginningItem.l, Exact.l)
  If Exact = #True
    ProcedureReturn SendMessage_(GadgetID(Gadget),#LB_FINDSTRINGEXACT,BeginningItem,@Text)
  Else
    ProcedureReturn SendMessage_(GadgetID(Gadget),#LB_FINDSTRING,BeginningItem,@Text)
  EndIf
EndProcedure
ProcedureDLL ListView_Find(Gadget.l, Text.s, BeginningItem.l)
  ProcedureReturn ListView_Find2(Gadget.l, Text.s, BeginningItem.l, #False)
EndProcedure

; LB_GETCARETINDEX  > An application sends an LB_GETCARETINDEX message To determine the index of the item that has the focus rectangle in a multiple-selection list box. The item may Or may Not be selected. 
  ; LB_GETCURSEL  > Send an LB_GETCURSEL message To retrieve the index of the currently selected item, If any, in a single-selection list box. 
ProcedureDLL ListView_GetState(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LB_GETCARETINDEX,0,0)
EndProcedure

; LB_GETITEMHEIGHT  > An application sends an LB_GETITEMHEIGHT message To retrieve the height of items in a list box. 
ProcedureDLL ListView_GetItemHeight(Gadget.l, Item.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LB_GETITEMHEIGHT,Item,0)
EndProcedure

; LB_GETITEMRECT  > An application sends an LB_GETITEMRECT message To retrieve the dimensions of the rectangle that bounds a list box item As it is currently displayed in the list box. 
ProcedureDLL ListView_Item_GetX(Gadget.l, Item.l)
  Protected rc.RECT
  SendMessage_(GadgetID(Gadget),#LB_GETITEMRECT,Item,rc)
  ProcedureReturn rc\left
EndProcedure
ProcedureDLL ListView_Item_GetY(Gadget.l, Item.l)
  Protected rc.RECT
  SendMessage_(GadgetID(Gadget),#LB_GETITEMRECT,Item,rc)
  ProcedureReturn rc\top
EndProcedure
ProcedureDLL ListView_Item_GetWidth(Gadget.l, Item.l)
  Protected rc.RECT
  SendMessage_(GadgetID(Gadget),#LB_GETITEMRECT,Item,rc)
  ProcedureReturn rc\right - rc\left
EndProcedure
ProcedureDLL ListView_Item_GetHeight(Gadget.l, Item.l)
  Protected rc.RECT
  SendMessage_(GadgetID(Gadget),#LB_GETITEMRECT,Item,rc)
  ProcedureReturn rc\bottom - rc\top
EndProcedure
; LB_ITEMFROMPOINT  > An application sends the LB_ITEMFROMPOINT message To retrieve the zero-based index of the item nearest the specified point in a list box.
ProcedureDLL ListView_Item_GetItem(Gadget.l, PosX.l, PosY.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LB_ITEMFROMPOINT,0,Makelong(PosY,PosX))
EndProcedure

; LB_GETLOCALE  > An application sends an LB_GETLOCALE message To retrieve the current locale of the list box. You can use the locale To determine the correct sorting order of displayed text (For list boxes With the LBS_SORT style) And of text added by the LB_ADDSTRING message. 
ProcedureDLL ListView_GetLanguageIdentifier(Gadget.l)
  ProcedureReturn LoWord(SendMessage_(GadgetID(Gadget),#LB_GETLOCALE,0,0))
EndProcedure
ProcedureDLL ListView_GetCountryCode(Gadget.l)
  ProcedureReturn HiWord(SendMessage_(GadgetID(Gadget),#LB_GETLOCALE,0,0))
EndProcedure
; LB_SETLOCALE  > An application sends an LB_SETLOCALE message To set the current locale of the list box. You can use the locale To determine the correct sorting order of displayed text (For list boxes With the LBS_SORT style) And of text added by the LB_ADDSTRING message. 
ProcedureDLL ListView_SetLanguageIdentifier(Gadget.l, LanguageIdentifier.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LB_SETLOCALE,Makelong(HiWord(SendMessage_(GadgetID(Gadget),#LB_GETLOCALE,0,0)),LanguageIdentifier),0)
EndProcedure
ProcedureDLL ListView_SetCountryCode(Gadget.l, CountryCode.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LB_SETLOCALE,Makelong(CountryCode,LoWord(SendMessage_(GadgetID(Gadget),#LB_GETLOCALE,0,0))),0)
EndProcedure


; LB_GETSEL > An application sends an LB_GETSEL message To retrieve the selection state of an item. 
ProcedureDLL ListView_Item_GetState(Gadget.l, Item.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LB_GETSEL,Item,0)
EndProcedure
; LB_SETCURSEL  > An application sends an LB_SETCURSEL message To Select a string And scroll it into view, If necessary. When the new string is selected, the list box removes the highlight from the previously selected string. 
ProcedureDLL ListView_Item_SetState(Gadget.l, Item.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LB_SETCURSEL,Item,0)
EndProcedure

; LB_GETTEXT  > An application sends an LB_GETTEXT message To retrieve a string from a list box. 
; LB_GETTEXTLEN > An application sends an LB_GETTEXTLEN message To retrieve the length of a string in a list box. 
ProcedureDLL.s ListView_Item_GetText(Gadget.l, Item.l)
  Protected Text.s
  Text.s = Space(SendMessage_(GadgetID(Gadget),#LB_GETTEXTLEN,Item,0))
  SendMessage_(GadgetID(Gadget),#LB_GETTEXT,Item,@Text)
  ProcedureReturn Text
EndProcedure

; LB_GETTOPINDEX  > An application sends an LB_GETTOPINDEX message To retrieve the index of the first visible item in a list box. Initially the item With index 0 is at the top of the list box, but If the list box contents have been scrolled another item may be at the top. 
ProcedureDLL ListView_GetFirstVisibleItem(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LB_GETTOPINDEX,0,0)
EndProcedure
; LB_SETTOPINDEX  > An application sends an LB_SETTOPINDEX message To ensure that a particular item in a list box is visible. 
  ; LB_SETCARETINDEX  > An application sends an LB_SETCARETINDEX message To set the focus rectangle To the item at the specified index in a multiple-selection list box. If the item is Not visible, it is scrolled into view. 
ProcedureDLL ListView_SetFirstVisibleItem(Gadget.l, Item.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LB_SETTOPINDEX,Item,0)
EndProcedure











































