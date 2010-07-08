XIncludeFile "../RLibPlus.pb"
; TVM_GETNEXTITEM > Retrieves the tree-view item that bears the specified relationship To a specified item. You can send this message explicitly, by using the TreeView_GetNextItem Macro.
ProcedureDLL Tree_GetItemID(Gadget.l, Item.l)
  hwndTV=GadgetID(Gadget)
  hRoot.l = SendMessage_(hwndTV, #TVM_GETNEXTITEM, #TVGN_ROOT, 0)
  hItem = hRoot
  hParent.l = 0
  For Inc_a.l = 0 To Item-1
    hItem2.l = SendMessage_(hwndTV, #TVM_GETNEXTITEM, #TVGN_CHILD, hItem)
    Repeat
      If hItem2 = #Null
        hItem2 = SendMessage_(hwndTV, #TVM_GETNEXTITEM, #TVGN_NEXT, hItem)
      EndIf
      If hItem2 = #Null
        hItem2 = SendMessage_(hwndTV, #TVM_GETNEXTITEM, #TVGN_PARENT, hItem)
      EndIf
    Until hItem2 <> #Null
    hItem = hItem2
  Next Inc_a
  ProcedureReturn hItem
EndProcedure

; TVM_SETBKCOLOR > Sets the background color of the control. You can send this message explicitly Or by using the TreeView_SetBkColor Macro. 
ProcedureDLL Tree_SetBackgroundColor(Gadget.l, Color.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TVM_SETBKCOLOR ,0, Color)
EndProcedure
; TVM_GETBKCOLOR > Retrieves the current background color of the control. You can send this message explicitly Or by using the TreeView_GetBkColor Macro. 
ProcedureDLL Tree_GetBackgroundColor(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TVM_GETBKCOLOR ,0,0)
EndProcedure

; TVM_GETINDENT > Retrieves the amount, in pixels, that child items are indented relative To their parent items. You can send this message explicitly Or by using the TreeView_GetIndent Macro. 
ProcedureDLL Tree_GetIndentation(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TVM_GETINDENT ,0,0)
EndProcedure
; TVM_SETINDENT > Sets the width of indentation For a tree-view control And redraws the control To reflect the new width. You can send this message explicitly Or by using the TreeView_SetIndent Macro. 
ProcedureDLL Tree_SetIndentation(Gadget.l, Indentation.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TVM_SETINDENT,Indentation,0)
EndProcedure
ProcedureDLL Tree_GetMinIndentation(Gadget.l)
  val_init=SendMessage_(GadgetID(Gadget),#TVM_GETINDENT ,0,0)
  SendMessage_(GadgetID(Gadget),#TVM_SETINDENT,0,0)
  val_syst=SendMessage_(GadgetID(Gadget),#TVM_GETINDENT ,0,0)
  SendMessage_(GadgetID(Gadget),#TVM_SETINDENT,val_init,0)
  ProcedureReturn val_syst
EndProcedure

; TVM_DELETEITEM > Removes an item And all its children from a tree-view control. You can send this message explicitly Or by using the TreeView_DeleteItem Macro. 
ProcedureDLL Tree_RemoveItem(Gadget.l, Item.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TVM_DELETEITEM,0,Tree_GetItemID(Gadget, Item))
EndProcedure

; TVM_EXPAND > The TVM_EXPAND message expands Or collapses the list of child items associated With the specified parent item, If any. You can send this message explicitly Or by using the TreeView_Expand Macro. 
ProcedureDLL Tree_Item_ToggleItem(Gadget.l, Item.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TVM_EXPAND,#TVE_TOGGLE,Tree_GetItemID(Gadget,Item))
EndProcedure
ProcedureDLL Tree_Item_ExpandItem(Gadget.l, Item.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TVM_EXPAND,#TVE_EXPAND,Tree_GetItemID(Gadget,Item))
EndProcedure
ProcedureDLL Tree_Item_CollapseItem(Gadget.l, Item.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TVM_EXPAND,#TVE_COLLAPSE,Tree_GetItemID(Gadget,Item))
EndProcedure
ProcedureDLL Tree_ExpandAll(Gadget.l)
  hwndTV.l = GadgetID(gadget)
  hRoot.l = SendMessage_(hwndTV, #TVM_GETNEXTITEM, #TVGN_ROOT, 0)
  hItem.l = hRoot
  Repeat
    SendMessage_(hwndTV, #TVM_EXPAND, #TVE_EXPAND, hItem)
    hItem = SendMessage_(hwndTV, #TVM_GETNEXTITEM, #TVGN_NEXTVISIBLE , hItem)
  Until hItem = #Null
  ProcedureReturn SendMessage_(hwndTV, #TVM_ENSUREVISIBLE, 0, hRoot)
EndProcedure
ProcedureDLL Tree_CollapseAll(Gadget.l)
  hwndTV.l = GadgetID(gadget)
  hRoot.l = SendMessage_(hwndTV, #TVM_GETNEXTITEM, #TVGN_ROOT, 0)
  hItem.l = hRoot
  Repeat
    SendMessage_(hwndTV, #TVM_EXPAND, #TVE_COLLAPSE, hItem)
    hItem = SendMessage_(hwndTV, #TVM_GETNEXTITEM, #TVGN_NEXTVISIBLE , hItem)
  Until hItem = #Null
  ProcedureReturn SendMessage_(hwndTV, #TVM_ENSUREVISIBLE, 0, hRoot)
EndProcedure

; TVM_GETCOUNT  > Retrieves a count of the items in a tree-view control. You can send this message explicitly Or by using the TreeView_GetCount Macro. 
ProcedureDLL Tree_GetNumberItems(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TVM_GETCOUNT,0,0)
EndProcedure

; TVM_GETITEM > Retrieves some Or all of a tree-view item's attributes. You can send this message explicitly or by using the TreeView_GetItem macro.
ProcedureDLL Tree_IsNode(Gadget.l, Item.l)
  item_tv.TV_ITEM
  item_tv\mask=#TVIF_HANDLE|#TVIF_CHILDREN
  item_tv\hItem=Tree_GetItemID(Gadget,Item)
  SendMessage_(GadgetID(Gadget),#TVM_GETITEM,0,@item_tv)
  If item_tv\cChildren=0
    ProcedureReturn #False
  Else
    ProcedureReturn #True
  EndIf
EndProcedure
ProcedureDLL.s Tree_GetItemText(Gadget.l, Item.l)
  item_tv.TV_ITEM
  item_tv\mask=#TVIF_HANDLE|#TVIF_TEXT
  item_tv\hItem=Tree_GetItemID(Gadget,Item)
  text.s=Space(512)
  item_tv\pszText = @text
  item_tv\cchTextMax  =512
  SendMessage_(GadgetID(Gadget),#TVM_GETITEM,0,@item_tv)
  ProcedureReturn PeekS(item_tv\pszText)
EndProcedure
ProcedureDLL.s Tree_GetItemData(Gadget.l, Item.l)
  item_tv.TV_ITEM
  item_tv\mask=#TVIF_HANDLE|#TVIF_PARAM
  item_tv\hItem=Tree_GetItemID(Gadget,Item)
  SendMessage_(GadgetID(Gadget),#TVM_GETITEM,0,@item_tv)
  If item_tv\lParam <>0
    ProcedureReturn PeekS(item_tv\lParam)
  Else
    ProcedureReturn ""
  EndIf
EndProcedure

; TVM_GETITEMHEIGHT > Retrieves the current height of the each tree-view item. You can send this message explicitly Or by using the TreeView_GetItemHeight Macro. 
ProcedureDLL Tree_GetItemHeight(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TVM_GETITEMHEIGHT,0,0)
EndProcedure
; TVM_SETITEMHEIGHT > Sets the height of the tree-view items. You can send this message explicitly Or by using the TreeView_SetItemHeight Macro. 
ProcedureDLL Tree_SetItemHeight(Gadget.l, Height.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TVM_SETITEMHEIGHT,Height,0)
EndProcedure

; TVM_GETLINECOLOR  > The TVM_GETLINECOLOR message gets the current line color. 
ProcedureDLL Tree_Line_GetColor(Gadget.l)
    ProcedureReturn SendMessage_(GadgetID(Gadget),#TVM_GETLINECOLOR,0,0)
EndProcedure
; TVM_SETLINECOLOR  > The TVM_SETLINECOLOR message sets the current line color. 
ProcedureDLL Tree_Line_SetColor(Gadget.l, Color.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TVM_SETLINECOLOR,0,Color)
EndProcedure

; TVM_GETSCROLLTIME > Retrieves the maximum scroll time For the tree-view control. You can send this message explicitly Or by using the TreeView_GetScrollTime Macro. 
ProcedureDLL Tree_Scroll_GetTime(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TVM_GETSCROLLTIME,0,0)
EndProcedure
; TVM_SETSCROLLTIME > Sets the maximum scroll time For the tree-view control. You can send this message explicitly Or by using the TreeView_SetScrollTime Macro. 
ProcedureDLL Tree_Scroll_SetTime(Gadget.l, ScrollTime.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TVM_SETSCROLLTIME,ScrollTime,0)
EndProcedure

; TVM_GETTEXTCOLOR  > Retrieves the current text color of the control. You can send this message explicitly Or by using the TreeView_GetTextColor Macro. 
ProcedureDLL Tree_Text_GetColor(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TVM_GETTEXTCOLOR,0,0)
EndProcedure
; TVM_SETTEXTCOLOR  > Sets the text color of the control. You can send this message explicitly Or by using the TreeView_SetTextColor Macro. 
ProcedureDLL Tree_Text_SetColor(Gadget.l, Color.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TVM_SETTEXTCOLOR,0,Color)
EndProcedure

; TVM_GETTOOLTIPS > Retrieves the handle To the child ToolTip control used by a tree-view control. You can send this message explicitly Or by using the TreeView_GetToolTips Macro. 
ProcedureDLL Tree_GetTooltip(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TVM_GETTOOLTIPS,0,0)
EndProcedure
; TVM_SETTOOLTIPS > Sets a tree-view control's child ToolTip control. You can send this message explicitly or by using the TreeView_SetToolTips macro. 
ProcedureDLL Tree_SetTooltip(Gadget.l, TooltipID.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TVM_SETTOOLTIPS,TooltipID,0)
EndProcedure


; TVM_GETUNICODEFORMAT > Retrieves the Unicode character format flag For the control. You can send this message explicitly Or use the TreeView_GetUnicodeFormat Macro. 
ProcedureDLL Tree_IsUnicodeEncoded(Gadget.l)
  encoding = SendMessage_(GadgetID(Gadget),#TVM_GETUNICODEFORMAT,0,0)
  If encoding = #True
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Tree_IsAnsiEncoded(Gadget.l)
  encoding = SendMessage_(GadgetID(Gadget),#TVM_GETUNICODEFORMAT,0,0)
  If encoding = #False
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
; TVM_SETUNICODEFORMAT > Sets the Unicode character format flag For the control. This message allows you To change the character set used by the control at run time rather than having To re-create the control. You can send this message explicitly Or use the TreeView_SetUnicodeFormat Macro. 
ProcedureDLL Tree_SetUnicodeEncoded(Gadget.l, UnicodeActivate.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TVM_SETUNICODEFORMAT,UnicodeActivate,0)
EndProcedure

; TVM_GETVISIBLECOUNT >  Obtains the number of items that can be fully visible in the client window of a tree-view control. You can send this message explicitly Or by using the TreeView_GetVisibleCount Macro. 
ProcedureDLL Tree_GetVisibleItems(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TVM_GETVISIBLECOUNT,0,0)
EndProcedure

; TVM_HITTEST > Determines the location of the specified point relative To the client area of a tree-view control. You can send this message explicitly Or by using the TreeView_HitTest Macro. 
ProcedureDLL Tree_Click_GetX(Gadget.l)
  Protected var.TV_HITTESTINFO
  GetCursorPos_(@var\pt)
  ScreenToClient_(GadgetID(Gadget),@var\pt)
  SendMessage_(GadgetID(Gadget),#TVM_HITTEST,0,var)
  ProcedureReturn var\pt\x
EndProcedure
ProcedureDLL Tree_Click_GetY(Gadget.l)
  Protected var.TV_HITTESTINFO
  GetCursorPos_(@var.TV_HITTESTINFO\pt)
  ScreenToClient_(GadgetID(Gadget),@var.TV_HITTESTINFO\pt)
  SendMessage_(GadgetID(Gadget),#TVM_HITTEST,0,var)
  ProcedureReturn var\pt\y
EndProcedure
ProcedureDLL Tree_Click_GetItemID(Gadget.l)
  Protected var.TV_HITTESTINFO
  GetCursorPos_(@var.TV_HITTESTINFO\pt)
  ScreenToClient_(GadgetID(Gadget),@var.TV_HITTESTINFO\pt)
  SendMessage_(GadgetID(Gadget),#TVM_HITTEST,0,var)
  ProcedureReturn var\hItem
EndProcedure
ProcedureDLL Tree_Click_IsAbove(Gadget.l)
  Protected var.TV_HITTESTINFO
  GetCursorPos_(@var.TV_HITTESTINFO\pt)
  ScreenToClient_(GadgetID(Gadget),@var.TV_HITTESTINFO\pt)
  SendMessage_(GadgetID(Gadget),#TVM_HITTEST,0,var)
  If var\flags & #TVHT_ABOVE
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Tree_Click_IsBelow(Gadget.l)
  Protected var.TV_HITTESTINFO
  GetCursorPos_(@var.TV_HITTESTINFO\pt)
  ScreenToClient_(GadgetID(Gadget),@var.TV_HITTESTINFO\pt)
  SendMessage_(GadgetID(Gadget),#TVM_HITTEST,0,var)
  If var\flags & #TVHT_BELOW
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Tree_Click_IsNoWhere(Gadget.l)
  Protected var.TV_HITTESTINFO
  GetCursorPos_(@var.TV_HITTESTINFO\pt)
  ScreenToClient_(GadgetID(Gadget),@var.TV_HITTESTINFO\pt)
  SendMessage_(GadgetID(Gadget),#TVM_HITTEST,0,var)
  If var\flags & #TVHT_NOWHERE
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Tree_Click_IsOnItem(Gadget.l)
  Protected var.TV_HITTESTINFO
  GetCursorPos_(@var.TV_HITTESTINFO\pt)
  ScreenToClient_(GadgetID(Gadget),@var.TV_HITTESTINFO\pt)
  SendMessage_(GadgetID(Gadget),#TVM_HITTEST,0,var)
  If var\flags & #TVHT_ONITEM
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Tree_Click_IsOnItemButton(Gadget.l)
  Protected var.TV_HITTESTINFO
  GetCursorPos_(@var.TV_HITTESTINFO\pt)
  ScreenToClient_(GadgetID(Gadget),@var.TV_HITTESTINFO\pt)
  SendMessage_(GadgetID(Gadget),#TVM_HITTEST,0,var)
  If var\flags & #TVHT_ONITEMBUTTON
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Tree_Click_IsOnItemIcon(Gadget.l)
  Protected var.TV_HITTESTINFO
  GetCursorPos_(@var.TV_HITTESTINFO\pt)
  ScreenToClient_(GadgetID(Gadget),@var.TV_HITTESTINFO\pt)
  SendMessage_(GadgetID(Gadget),#TVM_HITTEST,0,var)
  If var\flags & #TVHT_ONITEMICON
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Tree_Click_IsOnItemIndent(Gadget.l)
  Protected var.TV_HITTESTINFO
  GetCursorPos_(@var.TV_HITTESTINFO\pt)
  ScreenToClient_(GadgetID(Gadget),@var.TV_HITTESTINFO\pt)
  SendMessage_(GadgetID(Gadget),#TVM_HITTEST,0,var)
  If var\flags & #TVHT_ONITEMINDENT
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Tree_Click_IsOnItemLabel(Gadget.l)
  Protected var.TV_HITTESTINFO
  GetCursorPos_(@var.TV_HITTESTINFO\pt)
  ScreenToClient_(GadgetID(Gadget),@var.TV_HITTESTINFO\pt)
  SendMessage_(GadgetID(Gadget),#TVM_HITTEST,0,var)
  If var\flags & #TVHT_ONITEMLABEL
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Tree_Click_IsOnItemRight(Gadget.l)
  Protected var.TV_HITTESTINFO
  GetCursorPos_(@var.TV_HITTESTINFO\pt)
  ScreenToClient_(GadgetID(Gadget),@var.TV_HITTESTINFO\pt)
  SendMessage_(GadgetID(Gadget),#TVM_HITTEST,0,var)
  If var\flags & #TVHT_ONITEMRIGHT
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Tree_Click_IsOnItemStateIcon(Gadget.l)
  Protected var.TV_HITTESTINFO
  GetCursorPos_(@var.TV_HITTESTINFO\pt)
  ScreenToClient_(GadgetID(Gadget),@var.TV_HITTESTINFO\pt)
  SendMessage_(GadgetID(Gadget),#TVM_HITTEST,0,var)
  If var\flags & #TVHT_ONITEMSTATEICON
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Tree_Click_IsToLeft(Gadget.l)
  Protected var.TV_HITTESTINFO
  GetCursorPos_(@var.TV_HITTESTINFO\pt)
  ScreenToClient_(GadgetID(Gadget),@var.TV_HITTESTINFO\pt)
  SendMessage_(GadgetID(Gadget),#TVM_HITTEST,0,var)
  If var\flags & #TVHT_TOLEFT
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Tree_Click_IsToRight(Gadget.l)
  Protected var.TV_HITTESTINFO
  GetCursorPos_(@var.TV_HITTESTINFO\pt)
  ScreenToClient_(GadgetID(Gadget),@var.TV_HITTESTINFO\pt)
  SendMessage_(GadgetID(Gadget),#TVM_HITTEST,0,var)
  If var\flags & #TVHT_TORIGHT
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure

; TVM_SELECTITEM > Selects the specified tree-view item, scrolls the item into view, Or redraws the item in the style used To indicate the target of a drag-And-drop operation. You can send this message explicitly Or by using the TreeView_Select, TreeView_SelectItem, Or TreeView_SelectDropTarget Macro. 
ProcedureDLL Tree_SetActiveItem(Gadget.l, Item.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TVM_SELECTITEM,#TVGN_CARET|#TVSI_NOSINGLEEXPAND,Tree_GetItemID(Gadget,Item))
EndProcedure

; TVM_SETINSERTMARKCOLOR  > Sets the color used To draw the insertion mark For the tree view. You can send this message explicitly Or by using the TreeView_SetInsertMarkColor Macro. 
; TVM_SETINSERTMARK > Sets the insertion mark in a tree-view control. You can send this message explicitly Or by using the TreeView_SetInsertMark Macro. 
ProcedureDLL Tree_SetMarkColor3(Gadget.l, Item.l, After.l, Color.l)
  SendMessage_(GadgetID(Gadget),#TVM_SETINSERTMARKCOLOR,0,Color)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TVM_SETINSERTMARK,After,Tree_GetItemID(Gadget, Item))
EndProcedure
ProcedureDLL Tree_SetMarkColor2(Gadget.l, Item.l, After.l)
  ProcedureReturn Tree_SetMarkColor3(Gadget.l, Item.l, After.l,RGB(0,0,0))
EndProcedure
ProcedureDLL Tree_SetMarkColor(Gadget.l, Item.l)
  ProcedureReturn Tree_SetMarkColor3(Gadget.l, Item.l, #True, RGB(0,0,0))
EndProcedure
; TVM_GETINSERTMARKCOLOR > Retrieves the color used To draw the insertion mark For the tree view. You can send this message explicitly Or by using the TreeView_GetInsertMarkColor Macro. 
ProcedureDLL Tree_GetMarkColor(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TVM_GETINSERTMARKCOLOR,0,0)
EndProcedure

; TVM_SORTCHILDREN > Sorts the child items of the specified parent item in a tree-view control. You can send this message explicitly Or by using the TreeView_SortChildren Macro.
ProcedureDLL Tree_SortNode(Gadget.l, Item.l)
  If Item=-1
    ProcedureReturn SendMessage_(GadgetID(Gadget),#TVM_SORTCHILDREN,#False,#TVI_ROOT)
  Else
    ProcedureReturn SendMessage_(GadgetID(Gadget),#TVM_SORTCHILDREN,#False,Tree_GetItemID(Gadget,Item))
  EndIf
EndProcedure

; TVM_EDITLABEL > Begins in-place editing of the specified item's text, replacing the text of the item with a single-line edit control containing the text. This message implicitly selects and focuses the specified item. You can send this message explicitly or by using the TreeView_EditLabel macro. 
ProcedureDLL Tree_EditItem_Start(Gadget.l, Item.l)
  options = GetWindowLong_(GadgetID(Gadget),#GWL_STYLE)
  If options & #TVS_EDITLABELS
    SetWindowLong_(GadgetID(Gadget),#GWL_STYLE, options)
  Else
    SetWindowLong_(GadgetID(Gadget),#GWL_STYLE, options| #TVS_EDITLABELS)
  EndIf
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TVM_EDITLABEL,0,GadgetItemID(Gadget.l, Item.l))
EndProcedure
; TVM_ENDEDITLABELNOW > Ends the editing of a tree-view item's label. You can send this message explicitly or by using the TreeView_EndEditLabelNow macro. 
ProcedureDLL Tree_EditItem_Stop(Gadget.l, Item.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TVM_EDITLABEL,0,#False)
EndProcedure

; TVM_ENSUREVISIBLE > Ensures that a tree-view item is visible, expanding the parent item Or scrolling the tree-view control, If necessary. You can send this message explicitly Or by using the TreeView_EnsureVisible Macro. 
ProcedureDLL Tree_SetVisibleItem(Gadget.l, Item.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget), #TVM_ENSUREVISIBLE, 0, GadgetItemID(Gadget, Item))
EndProcedure
; TVM_GETEDITCONTROL  > Retrieves the handle To the edit control being used To edit a tree-view item's text. You can send this message explicitly or by using the TreeView_GetEditControl macro. 
ProcedureDLL Tree_GetEditID(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(GadgetID),#TVM_GETEDITCONTROL,0,0)
EndProcedure

; TVM_GETITEMRECT > Retrieves the bounding rectangle For a tree-view item And indicates whether the item is visible. You can send this message explicitly Or by using the TreeView_GetItemRect Macro. 
ProcedureDLL Tree_Item_GetX(Gadget.l)
  Protected rc.RECT
  SendMessage_(GadgetID(Gadget), #TVM_GETITEMRECT, #True, @rc)
  ProcedureReturn rc\left
EndProcedure
ProcedureDLL Tree_Item_GetY(Gadget.l)
  Protected rc.RECT
  SendMessage_(GadgetID(Gadget), #TVM_GETITEMRECT, #True, @rc)
  ProcedureReturn rc\top
EndProcedure
ProcedureDLL Tree_Item_GetWidth(Gadget.l)
  Protected rc.RECT
  SendMessage_(GadgetID(Gadget), #TVM_GETITEMRECT, #True, @rc)
  ProcedureReturn rc\right - rc\left
EndProcedure
ProcedureDLL Tree_Item_GetHeight(Gadget.l)
    Protected rc.RECT
  SendMessage_(GadgetID(Gadget), #TVM_GETITEMRECT, #True, @rc)
  ProcedureReturn rc\bottom - rc\top
EndProcedure

; TVM_GETIMAGELIST  > Retrieves the handle To the normal Or state image list associated With a tree-view control. You can send this message explicitly Or by using the TreeView_GetImageList Macro. 
; TVM_SETIMAGELIST  > Sets the normal Or state image list For a tree-view control And redraws the control using the new images. You can send this message explicitly Or by using the TreeView_SetImageList Macro. 
; TVM_SETITEM > The TVM_SETITEM message sets some Or all of a tree-view item's attributes. You can send this message explicitly or by using the TreeView_SetItem macro.
ProcedureDLL Tree_Image_Create(Width.l, Height.l)
  ProcedureReturn ImageList_Create_(Width, Height, #ILC_COLOR32,0, 0)
EndProcedure
ProcedureDLL Tree_Image_Destroy(List.l)
  ProcedureReturn ImageList_Destroy_(List)
EndProcedure
ProcedureDLL Tree_Image_Count(List.l)
  ProcedureReturn ImageList_GetImageCount_(List)
EndProcedure
ProcedureDLL Tree_Image_GetWidth(List.l)
  Protected Width.l, Height.l
    ImageList_GetIconSize_(List, @Width, @Height)
  ProcedureReturn Width
EndProcedure
ProcedureDLL Tree_Image_GetHeight(List.l)
  Protected Width.l, Height.l
    ImageList_GetIconSize_(List, @Width, @Height)
  ProcedureReturn Height
EndProcedure
ProcedureDLL Tree_Image_AddItem(List.l, Image.l)
  ; si Image = 0 > pas d'image
  ProcedureReturn ImageList_Add_(List,ImageID(Image),0)
EndProcedure
ProcedureDLL Tree_Image_RemoveItem(List.l, Index.l)
  ProcedureReturn ImageList_Remove_(List,Index)
EndProcedure
ProcedureDLL Tree_Image_SetList(Gadget.l, List.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TVM_SETIMAGELIST,#TVSIL_STATE,List)
EndProcedure
ProcedureDLL Tree_Image_GetList(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TVM_GETIMAGELIST,#TVSIL_STATE,0)
EndProcedure
ProcedureDLL Tree_Image_SetItem(Gadget.l, Item.l, Index.l)
  Protected LPTVITEMEX.TVITEMEX
    hItem=GadgetItemID(Gadget,Item)
      LPTVITEMEX\mask=#TVIF_HANDLE|#TVIF_STATE
      LPTVITEMEX\hItem=hItem
      LPTVITEMEX\stateMask=#TVIS_STATEIMAGEMASK
      LPTVITEMEX\state=Index<<12
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TVM_SETITEM,0,LPTVITEMEX)
EndProcedure
ProcedureDLL Tree_Image_GetItem(Gadget.l, Item.l)
  Protected LPTVITEMEX.TVITEMEX
    hItem=GadgetItemID(Gadget,Item)
      LPTVITEMEX\mask=#TVIF_HANDLE|#TVIF_STATE
      LPTVITEMEX\hItem=hItem
      SendMessage_(GadgetID(Gadget),#TVM_GETITEM,0,LPTVITEMEX)
  ProcedureReturn LPTVITEMEX\state>>12
EndProcedure

ProcedureDLL Tree_Icon_Create(Width.l, Height.l)
  ProcedureReturn ImageList_Create_(Width, Height, #ILC_COLOR24|#ILC_MASK,0, 0)
EndProcedure
ProcedureDLL Tree_Icon_Destroy(List.l)
  ProcedureReturn ImageList_Destroy_(List)
EndProcedure
ProcedureDLL Tree_Icon_Count(List.l)
  ProcedureReturn ImageList_GetImageCount_(List)
EndProcedure
ProcedureDLL Tree_Icon_GetWidth(List.l)
  Protected Width.l, Height.l
    ImageList_GetIconSize_(List, @Width, @Height)
  ProcedureReturn Width
EndProcedure
ProcedureDLL Tree_Icon_GetHeight(List.l)
  Protected Width.l, Height.l
    ImageList_GetIconSize_(List, @Width, @Height)
  ProcedureReturn Height
EndProcedure
ProcedureDLL Tree_Icon_AddItem(List.l, Icon.l)
  Protected ICONINFO.ICONINFO
  If IsImage(Icon)
    GetIconInfo_(ImageID(Icon), @ICONINFO)
  EndIf
  ProcedureReturn ImageList_Add_(List,ICONINFO\hbmColor,ICONINFO\hbmMask)
EndProcedure
ProcedureDLL Tree_Icon_RemoveItem(List.l, Index.l)
  ProcedureReturn ImageList_Remove_(List,Index)
EndProcedure
ProcedureDLL Tree_Icon_SetItem(Gadget.l, Item.l, Index.l)
  Protected LPTVITEMEX.TVITEMEX
    LPTVITEMEX\mask=#TVIF_IMAGE|#TVIF_SELECTEDIMAGE|#TVIF_HANDLE
    LPTVITEMEX\hItem=GadgetItemID(Gadget, Item)
    LPTVITEMEX\iImage=Index
    LPTVITEMEX\iSelectedImage=Index     
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TVM_SETITEM,0,LPTVITEMEX)
EndProcedure
ProcedureDLL Tree_Icon_GetItem(Gadget.l, Item.l)
  Protected LPTVITEMEX.TVITEMEX
    LPTVITEMEX\mask=#TVIF_IMAGE|#TVIF_SELECTEDIMAGE|#TVIF_HANDLE
    LPTVITEMEX\hItem=GadgetItemID(Gadget,Item)
    SendMessage_(GadgetID(Gadget),#TVM_GETITEM,0,LPTVITEMEX)
  ProcedureReturn LPTVITEMEX\iImage
EndProcedure
ProcedureDLL Tree_Icon_SetList(Gadget.l, List.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TVM_SETIMAGELIST,#TVSIL_NORMAL,List)
EndProcedure
ProcedureDLL Tree_Icon_GetList(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TVM_GETIMAGELIST,#TVSIL_NORMAL,0)
EndProcedure


;- ???
; TVM_CREATEDRAGIMAGE > Creates a dragging bitmap For the specified item in a tree-view control. The message also creates an image list For the bitmap And adds the bitmap To the image list. An application can display the image when dragging the item by using the image list functions. You can send this message explicitly Or by using the TreeView_CreateDragImage Macro. 
; TVM_GETISEARCHSTRING  > Retrieves the incremental search string For a tree-view control. The tree-view control uses the incremental search string To Select an item based on characters typed by the user. You can send this message explicitly Or by using the TreeView_GetISearchString Macro. 
; TVM_GETITEMSTATE  > Retrieves some Or all of a tree-view item's state attributes. You can send this message explicitly or by using the TreeView_GetItemState macro. 
; TVM_INSERTITEM  > Inserts a new item in a tree-view control. You can send this message explicitly Or by using the TreeView_InsertItem Macro. 
; TVM_MAPACCIDTOHTREEITEM > Maps an accessibility ID To an HTREEITEM. 
; TVM_MAPHTREEITEMTOACCID > Maps an HTREEITEM To an accessibility ID.
; TVM_SORTCHILDRENCB  > Sorts tree-view items using an application-defined callback function that compares the items. You can send this message explicitly Or by using the TreeView_SortChildrenCB Macro. 
