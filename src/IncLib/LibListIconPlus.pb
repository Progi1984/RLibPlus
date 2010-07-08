XIncludeFile "../RLibPlus.pb"
; AddGadgetItem
;  LVM_INSERTITEM  > Inserts a new item in a list-view control. You can send this message explicitly Or by using the ListView_InsertItem Macro.
; SetGadgetItemState
;  LVM_SETITEMSTATE  > Changes the state of an item in a list-view control. You can send this message explicitly Or by using the ListView_SetItemState Macro. 
; SetGadgetItemText
;  LVM_SETITEMTEXT > Changes the text of a list-view item Or subitem. You can send this message explicitly Or by using the ListView_SetItemText Macro. 
; ChangeListIconGadgetDisplay
;  LVM_SETVIEW > Sets the view of a list-view control.

; LVM_APPROXIMATEVIEWRECT > Calculates the approximate width And height required To display a given number of items. You can send this message explicitly Or use the ListView_ApproximateViewRect Macro.
ProcedureDLL ListIcon_GetPerfectWidth(Gadget.l)
  ProcedureReturn HiWord(SendMessage_(GadgetID(Gadget),#LVM_APPROXIMATEVIEWRECT,-1,MakeLong(-1,-1)))
EndProcedure
ProcedureDLL ListIcon_GetPerfectHeight(Gadget.l)
  ProcedureReturn LoWord(SendMessage_(GadgetID(Gadget),#LVM_APPROXIMATEVIEWRECT,-1,MakeLong(-1,-1)))
EndProcedure

; LVM_DELETEALLITEMS  > Removes all items from a list-view control. You can send this message explicitly Or by using the ListView_DeleteAllItems Macro. 
ProcedureDLL ListIcon_ClearItems(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LVM_DELETEALLITEMS,0,0)
EndProcedure


; LVM_DELETEITEM  > Removes an item from a list-view control. You can send this message explicitly Or by using the ListView_DeleteItem Macro. 
ProcedureDLL ListIcon_RemoveItem(Gadget.l, Item.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LVM_DELETEITEM,Item,0)
EndProcedure

; LVM_ENSUREVISIBLE > Ensures that a list-view item is either entirely Or partially visible, scrolling the list-view control If necessary. You can send this message explicitly Or by using the ListView_EnsureVisible Macro. 
ProcedureDLL ListIcon_SetFirstVisible(Gadget.l, Item.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LVM_ENSUREVISIBLE,Item,#True)
EndProcedure
; LVM_GETTOPINDEX > Retrieves the index of the topmost visible item when in list Or report view. You can send this message explicitly Or by using the ListView_GetTopIndex Macro. 
ProcedureDLL ListIcon_GetFirstVisible(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LVM_GETTOPINDEX,0,0)
EndProcedure
; LVM_SCROLL  > Scrolls the content of a list-view control. You can send this message explicitly Or by using the ListView_Scroll Macro. 
ProcedureDLL ListIcon_ScrollTo(Gadget.l, Item.l)
  Protected rc.RECT
    SendMessage_(GadgetID(Gadget),#LVM_GETITEMRECT,0,rc) 
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LVM_SCROLL,0,((rc\bottom - rc\top)*Item)) 
EndProcedure



; LVM_GETCOUNTPERPAGE > Calculates the number of items that can fit vertically in the visible area of a list-view control when in list Or report view. Only fully visible items are counted. You can send this message explicitly Or by using the ListView_GetCountPerPage Macro. 
ProcedureDLL ListIcon_GetCountItemsVisible(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LVM_GETCOUNTPERPAGE,0,0)
EndProcedure

; LVM_FINDITEM  > Searches For a list-view item With the specified characteristics. You can send this message explicitly Or by using the ListView_FindItem Macro. 
ProcedureDLL ListIcon_Find(Gadget.l, Position.l, Text.s, HighLight.l, Flags.l)
  ;Flags
  ; #LVFI_PARTIAL : commence par ce texte
  ; #LVFI_WRAP    : Recommence la recherche si aucun résultat
  ; #LVFI_STRING  : Searches based on the item text.
  Protected fItem.LV_FINDINFO 
  Protected pItem.POINT
  Protected sItem.LV_ITEM
  
  ; Trouve l'item
  fItem\flags   = Flags
  fItem\psz     = @Text
  itemNumber = SendMessage_(GadgetID(Gadget), #LVM_FINDITEM, Position, fItem)
   
  If HighLight = #True
    ; Obtient la position de l'item
    SendMessage_(GadgetID(Gadget), #LVM_GETITEMPOSITION, itemNumber , pItem) 
    ; Scrolle jusqu'à la position de l'item
    SendMessage_(GadgetID(Gadget), #LVM_SCROLL, pItem\x, pItem\y - 150) 
     
    ; Définit l'item comme sélectionné
    sItem\mask      = #LVIF_STATE 
    sItem\state     = #LVIS_SELECTED 
    sItem\stateMask = #LVIS_SELECTED 
    SendMessage_(GadgetID(Gadget), #LVM_SETITEMSTATE, itemNumber , sItem)    
  EndIf
  ProcedureReturn itemNumber
EndProcedure


; LVM_GETCALLBACKMASK > Retrieves the callback mask For a list-view control. You can send this message explicitly Or by using the ListView_GetCallbackMask Macro. 
ProcedureDLL ListIcon_GetCallbackedEvents(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LVM_GETCALLBACKMASK,0,0)
EndProcedure


;- Groupes
; Requires WinXP with Skins enabled
; LVM_ENABLEGROUPVIEW > Enables Or disables whether the items in a list-view control display As a group.
ProcedureDLL ListIcon_Group_SetActiveState(Gadget.l, State.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LVM_ENABLEGROUPVIEW,State,0)
EndProcedure
; LVM_INSERTGROUP > Inserts a group into a list-view control.
ProcedureDLL ListIcon_Group_Insert(Gadget.l, Group.l, Title.s, Alignment.l)
  Protected LVgroup.LV_GROUP
  LVgroup\cbSize = SizeOf(LV_GROUP)
  LVgroup\mask = #LVGF_HEADER | #LVGF_GROUPID | #LVGF_ALIGN
  
  sLen = MultiByteToWideChar_(#CP_ACP, 0, Title, -1, 0, 0)
  GroupName.s = Space(sLen*2)
  MultiByteToWideChar_(#CP_ACP, 0, Title, -1, @GroupName, sLen)
  LVgroup\pszHeader = @GroupName
  LVgroup\cchHeader = sLen*2
  LVgroup\iGroupId = Group
  Select Alignment
    Case 0
      LVgroup\uAlign = #LVGA_HEADER_LEFT
    Case 1
      LVgroup\uAlign = #LVGA_HEADER_CENTER
    Case 2
      LVgroup\uAlign = #LVGA_HEADER_RIGHT
    Default
      LVgroup\uAlign = #LVGA_HEADER_LEFT
  EndSelect
  ProcedureReturn SendMessage_(GadgetID(Gadget), #LVM_INSERTGROUP, Group, LVgroup)
EndProcedure
; LVM_REMOVEALLGROUPS > Removes all groups from a list-view control.
; LVM_REMOVEGROUP > Removes a group from a list-view control.
ProcedureDLL ListIcon_Group_Remove(Gadget.l, Group.l)
  If Group = -1
    ProcedureReturn SendMessage_(GadgetID(Gadget),#LVM_REMOVEALLGROUPS,0,0)
  Else
    ProcedureReturn SendMessage_(GadgetID(Gadget),#LVM_REMOVEALLGROUPS,Group,0)
  EndIf
EndProcedure
; LVM_SETGROUPMETRICS > Sets the metrics of a group.
ProcedureDLL ListIcon_Group_SetColor(Gadget.l, Color.l)
  Protected lvGM.LV_GROUPMETRICS
  lvGM\cbSize = SizeOf(LV_GROUPMETRICS)
  lvGM\mask = #LVGMF_TEXTCOLOR
  lvGM\crHeader = Color
  ProcedureReturn SendMessage_(GadgetID(Gadget), #LVM_SETGROUPMETRICS, 0, lvGM)
EndProcedure
; LVM_SETITEM > Sets some Or all of a list-view item's attributes. You can also send LVM_SETITEM to set the text of a subitem. You can send this message explicitly or by using the ListView_SetItem macro. 
ProcedureDLL ListIcon_Group_SetItem(Gadget.l, Group.l, Item.l)
  Protected LVItem.LVITEM
  LVItem\mask     = #LVIF_GROUPID
  LVItem\iItem    = Item
  LVItem\iGroupId = Group
  ProcedureReturn SendMessage_(GadgetID(Gadget), #LVM_SETITEM, Item, LVItem)
EndProcedure
; LVM_MOVEITEMTOGROUP > Moves an item specified by an index into a group.
ProcedureDLL ListIcon_Group_MoveItem(Gadget.l, Group.l, Item.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget), #LVM_MOVEITEMTOGROUP, Item, Group)
EndProcedure
; LVM_MOVEGROUP > Moves the group To the specified zero based index.
ProcedureDLL ListIcon_Group_Move(Gadget.l, Group.l, NewGroup.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget), #LVM_MOVEITEMTOGROUP, Group, NewGroup)
EndProcedure
; LVM_GETGROUPMETRICS > Retrieves the metrics of a group.
ProcedureDLL ListIcon_Group_GetColor(Gadget.l)
  Protected metrics.LV_GROUPMETRICS
  metrics\cbSize.l=SizeOf(LV_GROUPMETRICS)
  metrics\mask.l=#LVGMF_TEXTCOLOR
  SendMessage_(GadgetID(Gadget),#LVM_GETGROUPMETRICS,0,@metrics)
  ProcedureReturn metrics\crHeader.l
EndProcedure
; LVM_ISGROUPVIEWENABLED  > Checks whether the list-view control has group view enabled.
ProcedureDLL ListIcon_Group_GetActiveState(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LVM_ISGROUPVIEWENABLED,0,0)
EndProcedure



;- Colonnes
; LVM_GETCOLUMN > Retrieves the attributes of a list-view control's column. You can send this message explicitly or by using the ListView_GetColumn macro. col.LV_COLUMN
  ; LVM_GETCOLUMNWIDTH  > Retrieves the width of a column in report Or list view. You can send this message explicitly Or by using the ListView_GetColumnWidth Macro. 
ProcedureDLL ListIcon_GetColumnWidth(Gadget.l, Column.l)
  Protected col.LV_COLUMN
  col\mask.l = #LVCF_WIDTH
  SendMessage_(GadgetID(Gadget),#LVM_GETCOLUMN,Column,@col)
  ProcedureReturn col\cx.l
EndProcedure
ProcedureDLL.s ListIcon_GetColumnTitle(Gadget.l, Column.l)
  Protected col.LV_COLUMN
  Protected text.s
  col\mask.l = #LVCF_TEXT
    text.s = Space(512)
  col\pszText.l = @text
  col\cchTextMax.l = 512
  SendMessage_(GadgetID(Gadget),#LVM_GETCOLUMN,Column,@col)
  ProcedureReturn Trim(PeekS(col\pszText))
EndProcedure
ProcedureDLL ListIcon_GetColumnAlignment(Gadget.l, Column.l)
  Protected col.LV_COLUMN
  col\mask.l = #LVCF_FMT
  SendMessage_(GadgetID(Gadget),#LVM_GETCOLUMN,Column, @col)
  If col\fmt & #LVCFMT_CENTER
    ProcedureReturn 1
  ElseIf col\fmt & #LVCFMT_LEFT
    ProcedureReturn 0
  ElseIf col\fmt & #LVCFMT_RIGHT
    ProcedureReturn 2
  Else
    ProcedureReturn -1
  EndIf
EndProcedure
; LVM_SETCOLUMN > Sets the attributes of a list-view column. You can send this message explicitly Or by using the ListView_SetColumn Macro. 
  ; LVM_SETCOLUMNWIDTH  > Changes the width of a column in report-view mode Or the width of all columns in list-view mode. You can send this message explicitly Or use the ListView_SetColumnWidth Macro.
ProcedureDLL ListIcon_SetColumnWidth(Gadget.l, Column.l, Width.l)
  Protected col.LV_COLUMN  
  col\mask      = #LVCF_WIDTH
  col\cx        = Width
  col\iSubItem  = Column
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LVM_SETCOLUMN,Column,@col) 
EndProcedure
ProcedureDLL ListIcon_SetColumnTitle(Gadget.l, Column.l, Title.s)
  Protected col.LV_COLUMN  
  col\mask        = #LVCF_TEXT
  col\pszText     = @Title
  col\cchTextMax  = Len(Title)
  col\iSubItem    = Column
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LVM_SETCOLUMN,Column,@col) 
EndProcedure
ProcedureDLL ListIcon_SetColumnAlignment(Gadget.l, Column.l, Alignment.l)
  Protected col.LV_COLUMN  
  col\mask        = #LVCF_FMT
  Select Alignment
    Case 0
      col\fmt     = #LVCFMT_LEFT
    Case 1
      col\fmt     = #LVCFMT_CENTER
    Case 2
      col\fmt     = #LVCFMT_RIGHT
    Default
      col\fmt     = #LVCFMT_LEFT
  EndSelect
  col\iSubItem    = Column
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LVM_SETCOLUMN,Column,@col) 
EndProcedure
; LVM_GETSELECTEDCOLUMN > Retrieves an integer that specifies the selected column.
ProcedureDLL ListIcon_GetColumnSelected(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LVM_GETSELECTEDCOLUMN,0,0)
EndProcedure
; LVM_INSERTCOLUMN  > Inserts a new column in a list-view control. You can send this message explicitly Or by using the ListView_InsertColumn Macro. 
ProcedureDLL ListIcon_InsertColum(Gadget.l, Column.l, Title.s, Width.l, Alignment.l)
  Protected LVCOLUMNBis.LV_COLUMN
  LVCOLUMNBis\mask = #LVCF_TEXT|#LVCF_WIDTH|#LVCF_FMT
  Select Alignment
    Case 0
      LVCOLUMNBis\fmt = #LVCFMT_LEFT
    Case 1
      LVCOLUMNBis\fmt = #LVCFMT_CENTER
    Case 2
      LVCOLUMNBis\fmt = #LVCFMT_RIGHT
    Default
      LVCOLUMNBis\fmt = #LVCFMT_LEFT
  EndSelect
  LVCOLUMNBis\cx = Width
  LVCOLUMNBis\pszText = @Title
  LVCOLUMNBis\cchTextMax = Len(Title)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LVM_INSERTCOLUMN,Column,@LVCOLUMNBis)
EndProcedure
; LVM_DELETECOLUMN  > Removes a column from a list-view control. You can send this message explicitly Or by using the ListView_DeleteColumn Macro. 
ProcedureDLL ListIcon_RemoveColumn(Gadget.l, Column.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LVM_DELETECOLUMN,Column,0)
EndProcedure



; LVM_GETEXTENDEDLISTVIEWSTYLE  > Retrieves the extended styles that are currently in use For a given list-view control. You can send this message explicitly Or use the ListView_GetExtendedListViewStyle Macro. 
ProcedureDLL ListIcon_IsGridLinesUsed(Gadget.l)
  style = SendMessage_(GadgetID(Gadget),#LVM_GETEXTENDEDLISTVIEWSTYLE,0,0)
  If style & #LVS_EX_GRIDLINES
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL ListIcon_IsCheckBoxUsed(Gadget.l)
  style = SendMessage_(GadgetID(Gadget),#LVM_GETEXTENDEDLISTVIEWSTYLE,0,0)
  If style & #LVS_EX_CHECKBOXES
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL ListIcon_IsFlat(Gadget.l)
  style = SendMessage_(GadgetID(Gadget),#LVM_GETEXTENDEDLISTVIEWSTYLE,0,0)
  If style & #LVS_EX_FLATSB
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL ListIcon_IsFullRowSelect(Gadget.l)
  style = SendMessage_(GadgetID(Gadget),#LVM_GETEXTENDEDLISTVIEWSTYLE,0,0)
  If style & #LVS_EX_FULLROWSELECT
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL ListIcon_IsBorderSelect(Gadget.l)
  style = SendMessage_(GadgetID(Gadget),#LVM_GETEXTENDEDLISTVIEWSTYLE,0,0)
  If style & #LVS_EX_BORDERSELECT
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL ListIcon_IsHeaderDragNDrop(Gadget.l)
  style = SendMessage_(GadgetID(Gadget),#LVM_GETEXTENDEDLISTVIEWSTYLE,0,0)
  If style & #LVS_EX_HEADERDRAGDROP
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL ListIcon_IsToolTipUsed(Gadget.l)
  style = SendMessage_(GadgetID(Gadget),#LVM_GETEXTENDEDLISTVIEWSTYLE,0,0)
  If style & #LVS_EX_INFOTIP
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL ListIcon_IsSubItemImages(Gadget.l)
  style = SendMessage_(GadgetID(Gadget),#LVM_GETEXTENDEDLISTVIEWSTYLE,0,0)
  If style & #LVS_EX_SUBITEMIMAGES
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL ListIcon_IsTrackSelect(Gadget.l)
  style = SendMessage_(GadgetID(Gadget),#LVM_GETEXTENDEDLISTVIEWSTYLE,0,0)
  If style & #LVS_EX_TRACKSELECT
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL ListIcon_IsOneClickActivate(Gadget.l)
  style = SendMessage_(GadgetID(Gadget),#LVM_GETEXTENDEDLISTVIEWSTYLE,0,0)
  If style & #LVS_EX_ONECLICKACTIVATE
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL ListIcon_IsTwoClickActivate(Gadget.l)
  style = SendMessage_(GadgetID(Gadget),#LVM_GETEXTENDEDLISTVIEWSTYLE,0,0)
  If style & #LVS_EX_TWOCLICKACTIVATE
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL ListIcon_IsRegional(Gadget.l)
  style = SendMessage_(GadgetID(Gadget),#LVM_GETEXTENDEDLISTVIEWSTYLE,0,0)
  If style & #LVS_EX_REGIONAL
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL ListIcon_IsUnderlineHot(Gadget.l)
  style = SendMessage_(GadgetID(Gadget),#LVM_GETEXTENDEDLISTVIEWSTYLE,0,0)
  If style & #LVS_EX_UNDERLINEHOT
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL ListIcon_IsUnderlineCold(Gadget.l)
  style = SendMessage_(GadgetID(Gadget),#LVM_GETEXTENDEDLISTVIEWSTYLE,0,0)
  If style & #LVS_EX_UNDERLINECOLD
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL ListIcon_IsMultiWorkAreas(Gadget.l)
  style = SendMessage_(GadgetID(Gadget),#LVM_GETEXTENDEDLISTVIEWSTYLE,0,0)
  If style & #LVS_EX_MULTIWORKAREAS
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL ListIcon_IsLabelTip(Gadget.l)
  style = SendMessage_(GadgetID(Gadget),#LVM_GETEXTENDEDLISTVIEWSTYLE,0,0)
  If style & #LVS_EX_LABELTIP
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL ListIcon_IsDoubleBuffer(Gadget.l)
  style = SendMessage_(GadgetID(Gadget),#LVM_GETEXTENDEDLISTVIEWSTYLE,0,0)
  If style & #LVS_EX_DOUBLEBUFFER
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL ListIcon_IsHideLabels(Gadget.l)
  style = SendMessage_(GadgetID(Gadget),#LVM_GETEXTENDEDLISTVIEWSTYLE,0,0)
  If style & #LVS_EX_HIDELABELS
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL ListIcon_IsSingleRow(Gadget.l)
  style = SendMessage_(GadgetID(Gadget),#LVM_GETEXTENDEDLISTVIEWSTYLE,0,0)
  If style & #LVS_EX_SINGLEROW
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL ListIcon_IsSnapToGrid(Gadget.l)
  style = SendMessage_(GadgetID(Gadget),#LVM_GETEXTENDEDLISTVIEWSTYLE,0,0)
  If style & #LVS_EX_SNAPTOGRID
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL ListIcon_IsSimpleSelect(Gadget.l)
  style = SendMessage_(GadgetID(Gadget),#LVM_GETEXTENDEDLISTVIEWSTYLE,0,0)
  If style & #LVS_EX_SIMPLESELECT
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure

; LVM_GETHOTITEM  > Retrieves the index of the hot item. You can send this message explicitly Or use the ListView_GetHotItem Macro. 
ProcedureDLL ListIcon_GetItemUnderMouse(Window.l, Gadget.l)
  hChild = ChildWindowFromPoint_(WindowID(Window), WindowMouseX(Window) | (WindowMouseY(Window) << 32))
  If hChild=GadgetID(Gadget)
    lvRow.l = SendMessage_(GadgetID(Gadget), #LVM_GETHOTITEM, 0, 0)
    If lvRow < 0
      ProcedureReturn -1
    Else
      ProcedureReturn lvRow
    EndIf
  EndIf
EndProcedure
              
; LVM_GETBKCOLOR  > Retrieves the background color of a list-view control. You can send this message explicitly Or by using the ListView_GetBkColor Macro. 
ProcedureDLL ListIcon_GetBackColor(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LVM_GETBKCOLOR,0,0)
EndProcedure
; LVM_SETBKCOLOR  > Sets the background color of a list-view control. You can send this message explicitly Or by using the ListView_SetBkColor Macro. 
ProcedureDLL ListIcon_SetBackColor(Gadget.l, Color.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LVM_SETBKCOLOR,0,Color)
EndProcedure
; LVM_GETINSERTMARKCOLOR  > Retrieves the color of the insertion point.
ProcedureDLL ListIcon_GetInsertMarkColor(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LVM_GETINSERTMARKCOLOR,0,0)
EndProcedure
; LVM_SETINSERTMARKCOLOR  > Sets the color of the insertion point.
ProcedureDLL ListIcon_SetInsertMarkColor(Gadget.l, Color.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LVM_SETINSERTMARKCOLOR,0,Color)
EndProcedure
; LVM_GETOUTLINECOLOR > Retrieves the color of the border of a list-view control If the LVS_EX_BORDERSELECT extended window style is set.
ProcedureDLL ListIcon_GetBorderColor(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LVM_GETOUTLINECOLOR,0,0)
EndProcedure
; LVM_SETOUTLINECOLOR > Sets the color of the border of a list-view control If the LVS_EX_BORDERSELECT extended window style is set.
ProcedureDLL ListIcon_SetBorderColor(Gadget.l, Color.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LVM_SETOUTLINECOLOR,0,Color)
EndProcedure
; LVM_GETTEXTBKCOLOR  > Retrieves the text background color of a list-view control. You can send this message explicitly Or by using the ListView_GetTextBkColor Macro. 
ProcedureDLL ListIcon_GetTextBackColor(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LVM_GETTEXTBKCOLOR,0,0)
EndProcedure
; LVM_SETTEXTBKCOLOR  > Sets the background color of text in a list-view control. You can send this message explicitly Or by using the ListView_SetTextBkColor Macro. 
ProcedureDLL ListIcon_SetTextBackColor(Gadget.l, Color.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LVM_SETTEXTBKCOLOR,0,Color)
EndProcedure
; LVM_GETTEXTCOLOR  > Retrieves the text color of a list-view control. You can send this message explicitly Or by using the ListView_GetTextColor Macro. 
ProcedureDLL ListIcon_GetTextColor(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LVM_GETTEXTCOLOR,0,0)
EndProcedure
; LVM_SETTEXTCOLOR  > Sets the text color of a list-view control. You can send this message explicitly Or by using the ListView_SetTextColor Macro. 
ProcedureDLL ListIcon_SetTextColor(Gadget.l, Color.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LVM_SETTEXTCOLOR,0,Color)
EndProcedure

; LVM_GETITEMCOUNT  > Retrieves the number of items in a list-view control. You can send this message explicitly Or by using the ListView_GetItemCount Macro. 
ProcedureDLL ListIcon_CountItems(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LVM_GETITEMCOUNT,0,0)
EndProcedure
; LVM_GETSELECTEDCOUNT  > Determines the number of selected items in a list-view control. You can send this message explicitly Or by using the ListView_GetSelectedCount Macro. 
ProcedureDLL ListIcon_CountItemsSelected(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LVM_GETSELECTEDCOUNT,0,0)
EndProcedure


; LVM_GETITEMPOSITION > Retrieves the position of a list-view item. You can send this message explicitly Or by using the ListView_GetItemPosition Macro. 
; ProcedureDLL ListIcon_GetItemX(Gadget.l, Item.l)
;   Protected pt.POINT
;   SendMessage_(GadgetID(Gadget),#LVM_GETITEMPOSITION,Item,@pt)
;   ProcedureReturn pt\x
; EndProcedure
; ProcedureDLL ListIcon_GetItemY(Gadget.l, Item.l)
;   Protected pt.POINT
;   SendMessage_(GadgetID(Gadget),#LVM_GETITEMPOSITION,Item,@pt)
;   ProcedureReturn pt\y
; EndProcedure
; LVM_GETITEMTEXT > Retrieves the text of a list-view item Or subitem. You can send this message explicitly Or by using the ListView_GetItemText Macro.
ProcedureDLL.s ListIcon_GetItemText(Gadget.l, Item.l)
  Protected LI_Item.LVITEM
  Protected Text.s
  LI_Item\iSubItem=0
  Text.s=Space(512)
  LI_Item\pszText     = @Text
  LI_Item\cchTextMax  = 512
  SendMessage_(GadgetID(Gadget),#LVM_GETITEMTEXT,Item,@LI_Item)
  ProcedureReturn PeekS(LI_Item\pszText)
EndProcedure

; LVM_GETITEMRECT > Retrieves the bounding rectangle For all Or part of an item in the current view. You can send this message explicitly Or by using the ListView_GetItemRect Macro.
ProcedureDLL ListIcon_GetItemLabelX(Gadget.l, Item.l)
  Protected LI_item.RECT
  LI_item\left = #LVIR_LABEL
  SendMessage_(GadgetID(Gadget),#LVM_GETITEMRECT,Item,@LI_item)
  ProcedureReturn LI_item\left
EndProcedure
ProcedureDLL ListIcon_GetItemLabelY(Gadget.l, Item.l)
  Protected LI_item.RECT
  LI_item\left = #LVIR_LABEL
  SendMessage_(GadgetID(Gadget),#LVM_GETITEMRECT,Item,@LI_item)
  ProcedureReturn LI_item\top
EndProcedure
ProcedureDLL ListIcon_GetItemLabelWidth(Gadget.l, Item.l)
  Protected LI_item.RECT
  LI_item\left = #LVIR_LABEL
  SendMessage_(GadgetID(Gadget),#LVM_GETITEMRECT,Item,@LI_item)
  ProcedureReturn LI_item\right - LI_item\left
EndProcedure
ProcedureDLL ListIcon_GetItemLabelHeight(Gadget.l, Item.l)
  Protected LI_item.RECT
  LI_item\left = #LVIR_LABEL
  SendMessage_(GadgetID(Gadget),#LVM_GETITEMRECT,Item,@LI_item)
  ProcedureReturn LI_item\bottom - LI_item\top
EndProcedure
ProcedureDLL ListIcon_GetItemIconX(Gadget.l, Item.l)
  Protected LI_item.RECT
  LI_item\left = #LVIR_ICON
  SendMessage_(GadgetID(Gadget),#LVM_GETITEMRECT,Item,@LI_item)
  ProcedureReturn LI_item\left
EndProcedure
ProcedureDLL ListIcon_GetItemIconY(Gadget.l, Item.l)
  Protected LI_item.RECT
  LI_item\left = #LVIR_ICON
  SendMessage_(GadgetID(Gadget),#LVM_GETITEMRECT,Item,@LI_item)
  ProcedureReturn LI_item\top
EndProcedure
ProcedureDLL ListIcon_GetItemIconWidth(Gadget.l, Item.l)
  Protected LI_item.RECT
  LI_item\left = #LVIR_ICON
  SendMessage_(GadgetID(Gadget),#LVM_GETITEMRECT,Item,@LI_item)
  ProcedureReturn LI_item\right - LI_item\left
EndProcedure
ProcedureDLL ListIcon_GetItemIconHeight(Gadget.l, Item.l)
  Protected LI_item.RECT
  LI_item\left = #LVIR_ICON
  SendMessage_(GadgetID(Gadget),#LVM_GETITEMRECT,Item,@LI_item)
  ProcedureReturn LI_item\bottom - LI_item\top
EndProcedure
ProcedureDLL ListIcon_GetItemX(Gadget.l, Item.l)
  Protected LI_item.RECT
  LI_item\left = #LVIR_BOUNDS
  SendMessage_(GadgetID(Gadget),#LVM_GETITEMRECT,Item,@LI_item)
  ProcedureReturn LI_item\left
EndProcedure
ProcedureDLL ListIcon_GetItemY(Gadget.l, Item.l)
  Protected LI_item.RECT
  LI_item\left = #LVIR_BOUNDS
  SendMessage_(GadgetID(Gadget),#LVM_GETITEMRECT,Item,@LI_item)
  ProcedureReturn LI_item\top
EndProcedure
ProcedureDLL ListIcon_GetItemWidth(Gadget.l, Item.l)
  Protected LI_item.RECT
  LI_item\left = #LVIR_BOUNDS
  SendMessage_(GadgetID(Gadget),#LVM_GETITEMRECT,Item,@LI_item)
  ProcedureReturn LI_item\right - LI_item\left
EndProcedure
ProcedureDLL ListIcon_GetItemHeight(Gadget.l, Item.l)
  Protected LI_item.RECT
  LI_item\left = #LVIR_BOUNDS
  SendMessage_(GadgetID(Gadget),#LVM_GETITEMRECT,Item,@LI_item)
  ProcedureReturn LI_item\bottom - LI_item\top
EndProcedure

; LVM_GETITEMSPACING  > Determines the spacing between items in a list-view control. You can send this message explicitly Or by using the ListView_GetItemSpacing Macro. 
ProcedureDLL ListIcon_GetSpacingVertical(Gadget.l, SmallIconViewState.l)
  ProcedureReturn HiWord(SendMessage_(GadgetID(Gadget),#LVM_GETITEMSPACING,SmallIconViewState,0))
EndProcedure
ProcedureDLL ListIcon_GetSpacingHorizontal(Gadget.l, SmallIconViewState.l)
  ProcedureReturn HiWord(SendMessage_(GadgetID(Gadget),#LVM_GETITEMSPACING,SmallIconViewState,0))
EndProcedure

; LVM_GETTOOLTIPS > Retrieves the ToolTip control that the list-view control uses To display ToolTips. You can send this message explicitly Or use the ListView_GetToolTips Macro. 
ProcedureDLL ListIcon_GetTooltipID(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LVM_GETTOOLTIPS,0,0)
EndProcedure

; LVM_GETUNICODEFORMAT  > Retrieves the UNICODE character format flag For the control. You can send this message explicitly Or use the ListView_GetUnicodeFormat Macro. 
ProcedureDLL ListIcon_GetUnicodeFormat(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LVM_GETUNICODEFORMAT,0,0)
EndProcedure
; LVM_SETUNICODEFORMAT  > Sets the UNICODE character format flag For the control. This message allows you To change the character set used by the control at run time rather than having To re-create the control. You can send this message explicitly Or use the ListView_SetUnicodeFormat Macro. 
ProcedureDLL ListIcon_SetUnicodeFormat(Gadget.l, Activate.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LVM_SETUNICODEFORMAT,Activate,0)
EndProcedure


; LVM_GETVIEW > Retrieves the current view of a list-view control.
ProcedureDLL ListIcon_GetListIconGadgetDisplay(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#LVM_GETVIEW,0,0)
EndProcedure
























































; IDE Options = PureBasic 4.10 (Windows - x86)
; CursorPosition = 252
; FirstLine = 70
; Folding = AAAAAAAAAAAAAAAAAA9
; EnableXP