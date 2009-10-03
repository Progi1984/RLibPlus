XIncludeFile "../RLibPlus.pb"
; TCM_DELETEALLITEMS  > Removes all items from a tab control. You can send this message explicitly Or by using the TabCtrl_DeleteAllItems Macro. 
ProcedureDLL Panel_RemoveAll(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TCM_DELETEALLITEMS,0,0)
EndProcedure
; TCM_DELETEITEM  > Removes an item from a tab control. You can send this message explicitly Or by using the TabCtrl_DeleteItem Macro. 
ProcedureDLL Panel_RemoveItem(Gadget.l, Item.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TCM_DELETEITEM,Item,0)
EndProcedure

; TCM_GETCURFOCUS > Returns the index of the item that has the focus in a tab control. You can send this message explicitly Or by using the TabCtrl_GetCurFocus Macro. 
  ; TCM_GETCURSEL > Determines the currently selected tab in a tab control. You can send this message explicitly Or by using the TabCtrl_GetCurSel Macro. 
ProcedureDLL Panel_GetState(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TCM_GETCURFOCUS,0,0)
EndProcedure
; TCM_SETCURFOCUS > Sets the focus To a specified tab in a tab control. You can send this message explicitly Or by using the TabCtrl_SetCurFocus Macro. 
  ; TCM_SETCURSEL > Selects a tab in a tab control. You can send this message explicitly Or by using the TabCtrl_SetCurSel Macro. 
ProcedureDLL Panel_SetState(Gadget.l, Item.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TCM_SETCURFOCUS,Item,0)
EndProcedure

; TCM_GETITEMCOUNT  > Retrieves the number of tabs in the tab control. You can send this message explicitly Or by using the TabCtrl_GetItemCount Macro. 
ProcedureDLL Panel_CountItems(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TCM_GETITEMCOUNT,0,0)
EndProcedure

; TCM_GETITEMRECT > Retrieves the bounding rectangle For a tab in a tab control. You can send this message explicitly Or by using the TabCtrl_GetItemRect Macro. 
ProcedureDLL Panel_GetItemX(Gadget.l, Item.l)
  Protected rc.RECT
  SendMessage_(GadgetID(Gadget),#TCM_GETITEMRECT,Item,@rc)
  ProcedureReturn rc\left
EndProcedure
ProcedureDLL Panel_GetItemY(Gadget.l, Item.l)
  Protected rc.RECT
  SendMessage_(GadgetID(Gadget),#TCM_GETITEMRECT,Item,@rc)
  ProcedureReturn rc\top
EndProcedure
ProcedureDLL Panel_GetItemWidth(Gadget.l, Item.l)
  Protected rc.RECT
  SendMessage_(GadgetID(Gadget),#TCM_GETITEMRECT,Item,@rc)
  ProcedureReturn rc\right - rc\left
EndProcedure
ProcedureDLL Panel_GetItemHeight(Gadget.l, Item.l)
  Protected rc.RECT
  SendMessage_(GadgetID(Gadget),#TCM_GETITEMRECT,Item,@rc)
  ProcedureReturn rc\bottom - rc\top
EndProcedure

; TCM_GETROWCOUNT > Retrieves the current number of rows of tabs in a tab control. You can send this message explicitly Or by using the TabCtrl_GetRowCount Macro. 
ProcedureDLL Panel_GetRows(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TCM_GETROWCOUNT,0,0)
EndProcedure

; TCM_GETTOOLTIPS > Retrieves the handle To the ToolTip control associated With a tab control. You can send this message explicitly Or by using the TabCtrl_GetToolTips Macro. 
ProcedureDLL Panel_GetTooltipID(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TCM_GETTOOLTIPS,0,0)
EndProcedure
; TCM_SETTOOLTIPS > Assigns a ToolTip control To a tab control. You can send this message explicitly Or by using the TabCtrl_SetToolTips Macro. 
ProcedureDLL Panel_SetTooltipID(Gadget.l, ToolTipID.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TCM_SETTOOLTIPS,ToolTipID,0)
EndProcedure

; TCM_GETUNICODEFORMAT  > Retrieves the Unicode character format flag For the control. You can send this message explicitly Or use the TabCtrl_GetUnicodeFormat Macro. 
ProcedureDLL Panel_GetUnicodeFormat(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TCM_GETUNICODEFORMAT,0,0)
EndProcedure
; TCM_SETUNICODEFORMAT  >Sets the Unicode character format flag For the control. This message allows you To change the character set used by the control at run time rather than having To re-create the control. You can send this message explicitly Or use the TabCtrl_SetUnicodeFormat Macro. 
ProcedureDLL Panel_SetUnicodeFormat(Gadget.l, State.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TCM_SETUNICODEFORMAT,State,0)
EndProcedure

; TCM_SETITEM > Sets some Or all of a tab's attributes. You can send this message explicitly or by using the TabCtrl_SetItem macro. 
; TCM_GETITEM > Retrieves information about a tab in a tab control. You can send this message explicitly Or by using the TabCtrl_GetItem Macro.
ProcedureDLL Panel_SetItemText(Gadget.l, Item.l, Text.s)
  Protected Pitem.TC_ITEM
  Pitem\mask        = #TCIF_TEXT
  Pitem\pszText     = @Text
  Pitem\cchTextMax  = Len(Text)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TCM_SETITEM,Item,@Pitem)
EndProcedure
ProcedureDLL.s Panel_GetItemText(Gadget.l, Item.l)
  Protected Pitem.TC_ITEM
  Pitem\mask        = #TCIF_TEXT
  text.s=Space(512)
  Pitem\pszText=@text
  Pitem\cchTextMax=512
  SendMessage_(GadgetID(Gadget),#TCM_GETITEM,Item,@Pitem)
  ProcedureReturn PeekS(Pitem\pszText)
EndProcedure

; TCM_SETIMAGELIST  > Assigns an image list To a tab control. You can send this message explicitly Or by using the TabCtrl_SetImageList Macro. 
; TCM_GETIMAGELIST  > Retrieves the image list associated With a tab control. You can send this message explicitly Or by using the TabCtrl_GetImageList Macro. 
; TCM_SETITEM > Sets some Or all of a tab's attributes. You can send this message explicitly or by using the TabCtrl_SetItem macro. 
; TCM_GETITEM > Retrieves information about a tab in a tab control. You can send this message explicitly Or by using the TabCtrl_GetItem Macro.
ProcedureDLL Panel_Icon_Create(Width.l, Height.l)
  ProcedureReturn ImageList_Create_(Width, Height, #ILC_COLOR32|#ILC_MASK,0, 0)
EndProcedure
ProcedureDLL Panel_Icon_Destroy(List.l)
  ProcedureReturn ImageList_Destroy_(List)
EndProcedure
ProcedureDLL Panel_Icon_Count(List.l)
  ProcedureReturn ImageList_GetImageCount_(List)
EndProcedure
ProcedureDLL Panel_Icon_GetWidth(List.l)
  Protected Width.l, Height.l
    ImageList_GetIconSize_(List, @Width, @Height)
  ProcedureReturn Width
EndProcedure
ProcedureDLL Panel_Icon_GetHeight(List.l)
  Protected Width.l, Height.l
    ImageList_GetIconSize_(List, @Width, @Height)
  ProcedureReturn Height
EndProcedure
ProcedureDLL Panel_Icon_AddItem(List.l, Image.l)
  ; si Image = 0 > pas d'image
  ProcedureReturn ImageList_Add_(List, ImageID(Image), 0)
EndProcedure
ProcedureDLL Panel_Icon_Remove(List.l, IndexImage.l)
  ProcedureReturn ImageList_Remove_(List, IndexImage)
EndProcedure
ProcedureDLL Panel_Icon_SetList(Gadget.l, List.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TVM_SETIMAGELIST,0,List)
EndProcedure
ProcedureDLL Panel_Icon_GetList(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TVM_GETIMAGELIST,0,0)
EndProcedure
ProcedureDLL Panel_Icon_SetItem(Gadget.l, Item.l, IndexImage.l)
  Protected Pitem.TC_ITEM
    Pitem\mask = #TCIF_IMAGE
    SendMessage_(GadgetID(Gadget), #TCM_GETITEM, 0, @Pitem)
    Pitem\iImage = IndexImage
  ProcedureReturn SendMessage_(GadgetID(Gadget), #TCM_SETITEM, Item, @Pitem)
EndProcedure
ProcedureDLL Panel_Icon_GetItem(Gadget.l, Item.l)
  Protected Pitem.TC_ITEM
    Pitem\mask = #TCIF_IMAGE
    SendMessage_(GadgetID(Gadget), #TCM_GETITEM, 0, @Pitem)
  ProcedureReturn Pitem\iImage
EndProcedure

; TCM_SETITEMSIZE > Sets the width And height of tabs in a fixed-width Or owner-drawn tab control. You can send this message explicitly Or by using the TabCtrl_SetItemSize Macro.
ProcedureDLL Panel_SetItemHeight(Gadget.l, Height.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TCM_SETITEMSIZE,0,MakeLong(Height,0))
EndProcedure
; TCM_SETMINTABWIDTH  > Sets the minimum width of items in a tab control. You can send this message explicitly Or by using the TabCtrl_SetMinTabWidth Macro. 
ProcedureDLL Panel_SetItemWidth(Gadget.l, Width.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TCM_SETMINTABWIDTH,0,Width)
EndProcedure

; TCM_HITTEST > Determines which tab, If any, is at a specified screen position. You can send this message explicitly Or by using the TabCtrl_HitTest Macro. 
ProcedureDLL Panel_Click_GetX(Gadget.l)
  Protected hit.TC_HITTESTINFO
  GetCursorPos_(@hit\pt)
  ScreenToClient_(GadgetID(Gadget),@hit\pt)
  SendMessage_(GadgetID(Gadget),#TCM_HITTEST,0,@hit)
  ProcedureReturn hit\pt\x
EndProcedure
ProcedureDLL Panel_Click_GetY(Gadget.l)
  Protected hit.TC_HITTESTINFO
  GetCursorPos_(@hit\pt)
  ScreenToClient_(GadgetID(Gadget),@hit\pt)
  SendMessage_(GadgetID(Gadget),#TCM_HITTEST,0,@hit)
  ProcedureReturn hit\pt\y
EndProcedure
ProcedureDLL Panel_Click_IsNoWhere(Gadget.l)
  Protected hit.TC_HITTESTINFO
  GetCursorPos_(@hit\pt)
  ScreenToClient_(GadgetID(Gadget),@hit\pt)
  SendMessage_(GadgetID(Gadget),#TCM_HITTEST,0,@hit)
  If hit\flags & #TCHT_NOWHERE    ; The position is Not over a tab.
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Panel_Click_IsOnItem(Gadget.l)
  Protected hit.TC_HITTESTINFO
  GetCursorPos_(@hit\pt)
  ScreenToClient_(GadgetID(Gadget),@hit\pt)
  SendMessage_(GadgetID(Gadget),#TCM_HITTEST,0,@hit)
  If hit\flags & #TCHT_ONITEM     ; The position is over a tab but Not over its icon Or its text. For owner-drawn tab controls, this value is specified If the position is anywhere over a tab.
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Panel_Click_IsOnItemIcon(Gadget.l)
  Protected hit.TC_HITTESTINFO
  GetCursorPos_(@hit\pt)
  ScreenToClient_(GadgetID(Gadget),@hit\pt)
  SendMessage_(GadgetID(Gadget),#TCM_HITTEST,0,@hit)
  If hit\flags & #TCHT_ONITEMICON ; The position is over a tab's icon.
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Panel_Click_IsOnItemLabel(Gadget.l)
  Protected hit.TC_HITTESTINFO
  GetCursorPos_(@hit\pt)
  ScreenToClient_(GadgetID(Gadget),@hit\pt)
  SendMessage_(GadgetID(Gadget),#TCM_HITTEST,0,@hit)
  If hit\flags & #TCHT_ONITEMLABEL; The position is over a tab's text. 
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure

