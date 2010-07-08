XIncludeFile "../RLibPlus.pb"
; SBM_ENABLE_ARROWS > An application sends the SBM_ENABLE_ARROWS message To enable Or disable one Or both arrows of a scroll bar control.
  ; #ESB_DISABLE_LTUP  > Disables the left arrow on a horizontal scroll bar Or the up arrow on a vertical scroll bar.
  ; #ESB_DISABLE_BOTH  > Disables both arrows on a scroll bar.
ProcedureDLL Scrollbar_DisableBothArrow(ScrollbarID.l)
  ProcedureReturn SendMessage_(ScrollbarID,#SBM_ENABLE_ARROWS,#ESB_DISABLE_BOTH,0)
EndProcedure
  ; #ESB_DISABLE_DOWN  > Disables the down arrow on a vertical scroll bar.
ProcedureDLL Scrollbar_DisableDownArrow(ScrollbarID.l)
  ProcedureReturn SendMessage_(ScrollbarID,#SBM_ENABLE_ARROWS,#ESB_DISABLE_DOWN,0)
EndProcedure
  ; #ESB_DISABLE_LEFT  > Disables the left arrow on a horizontal scroll bar.
ProcedureDLL Scrollbar_DisableLeftArrow(ScrollbarID.l)
  ProcedureReturn SendMessage_(ScrollbarID,#SBM_ENABLE_ARROWS,#ESB_DISABLE_LEFT,0)
EndProcedure
  ; #ESB_DISABLE_RTDN  > Disables the right arrow on a horizontal scroll bar Or the down arrow on a vertical scroll bar.
ProcedureDLL Scrollbar_DisableRightArrow(ScrollbarID.l)
  ProcedureReturn SendMessage_(ScrollbarID,#SBM_ENABLE_ARROWS,#ESB_DISABLE_RTDN,0)
EndProcedure
  ; #ESB_DISABLE_UP    > Disables the up arrow on a vertical scroll bar.
ProcedureDLL Scrollbar_DisableUpArrow(ScrollbarID.l)
  ProcedureReturn SendMessage_(ScrollbarID,#SBM_ENABLE_ARROWS,#ESB_DISABLE_UP,0)
EndProcedure
  ; #ESB_ENABLE_BOTH   > Enables both arrows on a scroll bar.
ProcedureDLL Scrollbar_EnableBothArrow(ScrollbarID.l)
  ProcedureReturn SendMessage_(ScrollbarID,#SBM_ENABLE_ARROWS,#ESB_ENABLE_BOTH,0)
EndProcedure

; SBM_GETPOS  > The SBM_GETPOS message is sent To retrieve the current position of the scroll box of a scroll bar control. The current position is a relative value that depends on the current scrolling range. For example, If the scrolling range is 0 through 100 And the scroll box is in the middle of the bar, the current position is 50. 
ProcedureDLL Scrollbar_GetPosition(ScrollbarID.l)
  ProcedureReturn SendMessage_(ScrollbarID,#SBM_GETPOS,0,0)
EndProcedure
; SBM_SETPOS  > The SBM_SETPOS message is sent To set the position of the scroll Box (thumb) And, If requested, redraw the scroll bar To reflect the new position of the scroll box. 
ProcedureDLL Scrollbar_SetPosition(ScrollbarID.l, Position.l)
  ProcedureReturn SendMessage_(ScrollbarID,#SBM_SETPOS,Position,#True)
EndProcedure


; SBM_GETRANGE  > The SBM_GETRANGE message is sent To retrieve the minimum And maximum position values For the scroll bar control. 
ProcedureDLL Scrollbar_GetMinimum(ScrollbarID.l)
  Protected Minimum, Maximum
  SendMessage_(ScrollbarID,#SBM_GETRANGE,@Minimum,@Maximum)
  ProcedureReturn Minimum
EndProcedure
ProcedureDLL Scrollbar_GetMaximum(ScrollbarID.l)
  Protected Minimum, Maximum
  SendMessage_(ScrollbarID,#SBM_GETRANGE,@Minimum,@Maximum)
  ProcedureReturn Maximum
EndProcedure

; SBM_SETRANGE  > The SBM_SETRANGE message is sent To set the minimum And maximum position values For the scroll bar control. 
; SBM_SETRANGEREDRAW  > An application sends the SBM_SETRANGEREDRAW message To a scroll bar control To set the minimum And maximum position values And To redraw the control. 
ProcedureDLL Scrollbar_SetMinimum(ScrollbarID.l, Minimum.l)
  ProcedureReturn SendMessage_(ScrollbarID,#SBM_SETRANGEREDRAW,Minimum,Scrollbar_GetMaximum(ScrollbarID.l))
EndProcedure
ProcedureDLL Scrollbar_SetMaximum(ScrollbarID.l, Maximum.l)
  ProcedureReturn SendMessage_(ScrollbarID,#SBM_SETRANGEREDRAW,Scrollbar_GetMinimum(ScrollbarID.l),Maximum)
EndProcedure


; SBM_GETSCROLLINFO > The SBM_GETSCROLLINFO message is sent To retrieve the parameters of a scroll bar. 
ProcedureDLL Scrollbar_GetPageSize(ScrollbarID.l)
  Protected info.SCROLLINFO
  info\cbSize   = SizeOf(SCROLLINFO)
  info\fMask    = #SIF_ALL
  SendMessage_(ScrollbarID,#SBM_GETSCROLLINFO,0,@info)
  ProcedureReturn info\nPage
EndProcedure
; SBM_SETSCROLLINFO > The SBM_SETSCROLLINFO message is sent To set the parameters of a scroll bar. 
ProcedureDLL Scrollbar_SetPageSize(ScrollbarID.l, PageSize.l)
  Protected info.SCROLLINFO
  info\cbSize   = SizeOf(SCROLLINFO)
  info\fMask    = #SIF_ALL
  SendMessage_(ScrollbarID,#SBM_GETSCROLLINFO,0,@info)
  info\nPage    = PageSize
  ProcedureReturn SendMessage_(ScrollbarID,#SBM_SETSCROLLINFO,#True,@info)
EndProcedure



