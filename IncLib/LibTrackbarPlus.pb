XIncludeFile "../RLibPlus.pb"
; TBM_CLEARTICS > Removes the current tick marks from a trackbar. This message does Not remove the first And last tick marks, which are created automatically by the trackbar.
ProcedureDLL Trackbar_ClearTicks(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget), #TBM_CLEARTICS ,#True ,0 )
EndProcedure
; TBM_GETNUMTICS  >  Retrieves the number of tick marks in a trackbar.
ProcedureDLL Trackbar_CountTicks(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget), #TBM_GETNUMTICS , 0, 0)
EndProcedure
; TBM_SETTIC > Sets a tick mark in a trackbar at the specified logical position.
ProcedureDLL Trackbar_SetTick(Gadget.l, TickMark.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TBM_SETTIC,0,TickMark)
EndProcedure
; TBM_SETTICFREQ >  Sets the interval frequency For tick marks in a trackbar. For example, If the frequency is set To two, a tick mark is displayed For every other increment in the trackbar's range. The default setting for the frequency is one; that is, every increment in the range is associated with a tick mark.
ProcedureDLL Trackbar_SetTickFrequency(Gadget.l, Frequency.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TBM_SETTICFREQ, Frequency,0)
EndProcedure

; TBM_GETBUDDY  > Retrieves the handle To a trackbar control buddy window at a given location. The specified location is relative To the control's orientation (horizontal or vertical).
ProcedureDLL Trackbar_GetGadgetID_Left(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget), #TBM_GETBUDDY , #True, 0)
EndProcedure
ProcedureDLL Trackbar_GetGadgetID_Right(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget), #TBM_GETBUDDY , #False, 0)
EndProcedure
; TBM_SETBUDDY >  Assigns a window As the buddy window For a trackbar control. Trackbar buddy windows are automatically displayed in a location relative To the control's orientation (horizontal or vertical).
ProcedureDLL Trackbar_SetGadgetID_Left(Gadget.l, GadgetID.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TBM_SETBUDDY,#True, GadgetID)
EndProcedure
ProcedureDLL Trackbar_SetGadgetID_Right(Gadget.l, GadgetID.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TBM_SETBUDDY,#False, GadgetID)
EndProcedure

; TBM_GETCHANNELRECT  >  Retrieves the size And position of the bounding rectangle For a trackbar's channel. (The channel is the area over which the slider moves. It contains the highlight when a range is selected.)
ProcedureDLL Trackbar_GetRectX(Gadget.l)
  Protected rc.RECT
  SendMessage_(GadgetID(Gadget), #TBM_GETCHANNELRECT , 0, @rc)
  ProcedureReturn GadgetX(Gadget) + rc\left
EndProcedure
ProcedureDLL Trackbar_GetRectY(Gadget.l)
  Protected rc.RECT
  SendMessage_(GadgetID(Gadget), #TBM_GETCHANNELRECT , 0, @rc)
  ProcedureReturn GadgetY(Gadget) + rc\top
EndProcedure
ProcedureDLL Trackbar_GetRectHeight(Gadget.l)
  Protected rc.RECT
  SendMessage_(GadgetID(Gadget), #TBM_GETCHANNELRECT , 0, @rc)
  ProcedureReturn rc\bottom - rc\top
EndProcedure
ProcedureDLL Trackbar_GetRectWidth(Gadget.l)
  Protected rc.RECT
  SendMessage_(GadgetID(Gadget), #TBM_GETCHANNELRECT , 0, @rc)
  ProcedureReturn rc\right - rc\left
EndProcedure

; TBM_GETPAGESIZE >  Retrieves the number of logical positions the trackbar's slider moves in response to keyboard input, such as the or keys, or mouse input, such as clicks in the trackbar's channel. The logical positions are the integer increments in the trackbar's range of minimum to maximum slider positions.
ProcedureDLL Trackbar_GetDelta(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget), #TBM_GETPAGESIZE , 0, 0)
EndProcedure
; TBM_SETPAGESIZE > Sets the number of logical positions the trackbar's slider moves in response to keyboard input, such as the or keys, or mouse input, such as clicks in the trackbar's channel. The logical positions are the integer increments in the trackbar's range of minimum to maximum slider positions.
ProcedureDLL Trackbar_SetDelta(Gadget.l, Delta.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TBM_SETPAGESIZE,0,Delta)
EndProcedure

; TBM_GETPOS > Retrieves the current logical position of the slider in a trackbar. The logical positions are the integer values in the trackbar's range of minimum to maximum slider positions. 
ProcedureDLL Trackbar_GetState(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget), #TBM_GETPOS ,0 ,0 )
EndProcedure
; TBM_SETPOS >  Sets the current logical position of the slider in a trackbar.
ProcedureDLL Trackbar_SetState(Gadget.l, Position.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TBM_SETPOS,#True,Position)
EndProcedure


; TBM_GETPTICS >  Retrieves the address of an array that contains the positions of the tick marks For a trackbar.
ProcedureDLL Trackbar_GetItemTick(Gadget.l, ItemTick.l)
  *table= SendMessage_(GadgetID(Gadget), #TBM_GETPTICS ,0 ,0 )
  
  If Item > Trackbar_CountTicks(Gadget)
    Item = Trackbar_CountTicks(Gadget)
  ElseIf Item < Trackbar_CountTicks(Gadget)
    Item = 1
  EndIf
  
  For Inc_a = 1 To Item
    ReturnValue = PeekL(*table)
    *table+SizeOf(Long)
  Next
  ProcedureReturn ReturnValue
EndProcedure

; TBM_SETRANGE >  Sets the range of minimum And maximum logical positions For the slider in a trackbar.
; TBM_GETRANGEMAX >  Retrieves the maximum position For the slider in a trackbar.
ProcedureDLL Trackbar_GetMax(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget), #TBM_GETRANGEMAX ,0 ,0 )
EndProcedure
; TBM_SETRANGEMAX > Sets the maximum logical position For the slider in a trackbar.
ProcedureDLL Trackbar_SetMax(Gadget.l, Maximum.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TBM_SETRANGEMAX,#True,Maximum)
EndProcedure
; TBM_GETRANGEMIN >  Retrieves the minimum position For the slider in a trackbar.
ProcedureDLL Trackbar_GetMin(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget), #TBM_GETRANGEMIN ,0 ,0 )
EndProcedure
; TBM_SETRANGEMIN > Sets the minimum logical position For the slider in a trackbar.
ProcedureDLL Trackbar_SetMin(Gadget.l, Minimum.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TBM_SETRANGEMIN,#True,Minimum)
EndProcedure

; TBM_GETTHUMBLENGTH >  Retrieves the length of the slider in a trackbar.
ProcedureDLL Trackbar_GetLengthSlider(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget), #TBM_GETTHUMBLENGTH , 0, 0)
EndProcedure

; TBM_GETTHUMBRECT > Retrieves the size And position of the bounding rectangle For the slider in a trackbar.
ProcedureDLL Trackbar_GetSliderX(Gadget.l)
  Protected rc.RECT
  SendMessage_(GadgetID(Gadget), #TBM_GETTHUMBRECT , 0, @rc)
  ProcedureReturn GadgetX(Gadget) + rc\left
EndProcedure
ProcedureDLL Trackbar_GetSliderY(Gadget.l)
  Protected rc.RECT
  SendMessage_(GadgetID(Gadget), #TBM_GETTHUMBRECT , 0, @rc)
  ProcedureReturn GadgetY(Gadget) + rc\top
EndProcedure
ProcedureDLL Trackbar_GetSliderHeight(Gadget.l)
  Protected rc.RECT
  SendMessage_(GadgetID(Gadget), #TBM_GETTHUMBRECT , 0, @rc)
  ProcedureReturn rc\bottom - rc\top
EndProcedure
ProcedureDLL Trackbar_GetSliderWidth(Gadget.l)
  Protected rc.RECT
  SendMessage_(GadgetID(Gadget), #TBM_GETTHUMBRECT , 0, @rc)
  ProcedureReturn rc\right - rc\left
EndProcedure

; TBM_GETTICPOS >  Retrieves the current physical position of a tick mark in a trackbar.
ProcedureDLL Trackbar_GetItemTickX(Gadget.l, ItemTick.l)
  Protected rc.RECT, ItemTickX.l
  If ItemTick = Trackbar_GetMin(Gadget.l)
    ProcedureReturn 0  
  ElseIf ItemTickX = Trackbar_GetMax(Gadget.l)
    ProcedureReturn GadgetX(Gadget) + Trackbar_GetRectWidth(Gadget.l)
  Else
    ProcedureReturn SendMessage_(GadgetID(Gadget),#TBM_GETTICPOS,ItemTick - 1,0)
  EndIf
  ProcedureReturn -1
EndProcedure
; TBM_GETTIC >  Retrieves the logical position of a tick mark in a trackbar. The logical position can be any of the integer values in the trackbar's range of minimum to maximum slider positions.
ProcedureDLL Trackbar_GetItemTickPos(Gadget.l, ItemTick.l)
  Protected rc.RECT, ItemTickX.l
  If ItemTick = Trackbar_GetMin(Gadget.l)
    ProcedureReturn Trackbar_GetMin(Gadget.l) 
  ElseIf ItemTickX = Trackbar_GetMax(Gadget.l)
    ProcedureReturn Trackbar_GetMax(Gadget.l)
  Else
    ProcedureReturn SendMessage_(GadgetID(Gadget),#TBM_GETTIC,ItemTick-1,0)
  EndIf
  ProcedureReturn -1
EndProcedure

; TBM_GETTOOLTIPS > Retrieves the handle To the ToolTip control assigned To the trackbar, If any.
ProcedureDLL Trackbar_GetTooltipID(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TBM_GETTOOLTIPS,0,0)
EndProcedure
; TBM_SETTIPSIDE > Positions a ToolTip control used by a trackbar control. Trackbar controls that use the TBS_TOOLTIPS style display ToolTips.
; TBM_SETTOOLTIPS > Assigns a ToolTip control To a trackbar control.
ProcedureDLL Trackbar_SetTooltipID(Gadget.l, TooltipID.l, Position.l)
  SendMessage_(GadgetID(Gadget),#TBM_SETTOOLTIPS,TooltipID,0)
  SendMessage_(GadgetID(Gadget),#TBM_SETTIPSIDE,Position,0)
  ProcedureReturn 
EndProcedure


; TBM_GETUNICODEFORMAT >  Retrieves the Unicode character format flag For the control.
ProcedureDLL Trackbar_GetUnicodeFormat(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#TBM_GETUNICODEFORMAT,0,0)
EndProcedure
; TBM_SETUNICODEFORMAT > Sets the Unicode character format flag For the control. This message allows you To change the character set used by the control at run time rather than having To re-create the control. 
ProcedureDLL Trackbar_SetUnicodeFormat(Gadget.l, Activate.l)
  ProcedureReturn SendMessage_(GadgetID(Activate),#TBM_SETUNICODEFORMAT,Activate,0)
EndProcedure
