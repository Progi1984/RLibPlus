XIncludeFile "../RLibPlus.pb"
; PBM_DELTAPOS  > Advances the current position of a progress bar by a specified increment And redraws the bar To reflect the new position.
ProcedureDLL ProgressBar_Up(Gadget.l, Delta.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#PBM_DELTAPOS,Delta,0)
EndProcedure
ProcedureDLL ProgressBar_Down(Gadget.l, Delta.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#PBM_DELTAPOS,Delta,0)
EndProcedure

; PBM_GETPOS  > Retrieves the current position of the progress bar.
ProcedureDLL ProgressBar_GetPosition(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#PBM_GETPOS,0,0)
EndProcedure
; PBM_SETPOS  > Sets the current position For a progress bar And redraws the bar To reflect the new position.
ProcedureDLL ProgressBar_SetPosition(Gadget.l, Position.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#PBM_SETPOS,Position,0)
EndProcedure


; PBM_GETRANGE  > Retrieves information about the current high And low limits of a given progress bar control.
ProcedureDLL ProgressBar_GetMinimum(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#PBM_GETRANGE,#True,0)
EndProcedure
ProcedureDLL ProgressBar_GetMaximum(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#PBM_GETRANGE,#False,0)
EndProcedure

; PBM_SETRANGE  > Sets the minimum And maximum values For a progress bar And redraws the bar To reflect the new range.
; PBM_SETRANGE32  > Sets the range of a progress bar control To a 32-bit value.
ProcedureDLL ProgressBar_SetMinimum(Gadget.l, Minimum.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#PBM_SETRANGE32,Minimum,ProgressBar_GetMaximum(Gadget.l))
EndProcedure
ProcedureDLL ProgressBar_SetMaximum(Gadget.l, Maximum.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#PBM_SETRANGE32,ProgressBar_GetMinimum(Gadget.l),Maximum)
EndProcedure

; PBM_SETBARCOLOR > Sets the color of the progress indicator bar in the progress bar control.
ProcedureDLL ProgressBar_SetBarColor(Gadget.l, Color.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#PBM_SETBARCOLOR,0,Color)
EndProcedure
; PBM_SETBKCOLOR  > Sets the background color in the progress bar.
ProcedureDLL ProgressBar_SetBackColor(Gadget.l, Color.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#PBM_SETBKCOLOR,0,Color)
EndProcedure

; PBM_SETSTEP > Specifies the Step increment For a progress bar. The Step increment is the amount by which the progress bar increases its current position whenever it receives a PBM_STEPIT message. By Default, the Step increment is set To 10.
ProcedureDLL ProgressBar_SetStep(Gadget.l, Steps.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#PBM_SETSTEP,Steps,0)
EndProcedure
; PBM_STEPIT  > Advances the current position For a progress bar by the Step increment And redraws the bar To reflect the new position. An application sets the Step increment by sending the PBM_SETSTEP message.  
ProcedureDLL ProgressBar_Step(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#PBM_STEPIT,0,0)
EndProcedure
