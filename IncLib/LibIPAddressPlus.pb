XIncludeFile "../RLibPlus.pb"
; IPM_CLEARADDRESS  > Clears the contents of the IP address control. 
ProcedureDLL IPAddress_Clear(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#IPM_CLEARADDRESS,0,0)
EndProcedure
; IPM_ISBLANK       > Determines If all fields in the IP address control are blank. 
ProcedureDLL IPAddress_IsClear(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#IPM_ISBLANK,0,0)
EndProcedure

; IPM_GETADDRESS    > Retrieves the address values For all four fields in the IP address control. 
ProcedureDLL IPAddress_GetItemValue(Gadget.l, Item.l)
  Protected address.l
  If Item > 3
    Item = 3
  EndIf
  If Item < 0
    Item = 0
  EndIf
  SendMessage_(GadgetID(Gadget),#IPM_GETADDRESS,0,@address)
  Select Item
    Case 0
      ProcedureReturn (address >> 00) & $FF
    Case 1
      ProcedureReturn (address >> 08) & $FF
    Case 2
      ProcedureReturn (address >> 16) & $FF
    Case 3
      ProcedureReturn (address >> 24) & $FF
  EndSelect
EndProcedure
; IPM_SETADDRESS    > Sets the address values For all four fields in the IP address control. 
ProcedureDLL IPAddress_SetItemValue(Gadget.l, Item.l, Value.l)
  Protected address.l
  If Item > 3
    Item = 3
  EndIf
  If Item < 0
    Item = 0
  EndIf
  SendMessage_(GadgetID(Gadget),#IPM_GETADDRESS,0,@address)
  Select Item
    Case 0
      ProcedureReturn SendMessage_(GadgetID(Gadget),#IPM_SETADDRESS,0,MakeIPAddress(Value,(address >> 08) & $FF,(address >> 16) & $FF,(address >> 24) & $FF))
    Case 1
      ProcedureReturn SendMessage_(GadgetID(Gadget),#IPM_SETADDRESS,0,MakeIPAddress((address >> 00),Value,(address >> 16) & $FF,(address >> 24) & $FF))
    Case 2
      ProcedureReturn SendMessage_(GadgetID(Gadget),#IPM_SETADDRESS,0,MakeIPAddress((address >> 00),(address >> 08) & $FF,Value,(address >> 24) & $FF))
    Case 3
      ProcedureReturn SendMessage_(GadgetID(Gadget),#IPM_SETADDRESS,0,MakeIPAddress((address >> 00),(address >> 08) & $FF,(address >> 16) & $FF,Value))
  EndSelect
EndProcedure

; IPM_SETFOCUS      > Sets the keyboard focus To the specified field in the IP address control. All of the text in that field will be selected. 
ProcedureDLL IPAddress_SetItemFocus(Gadget.l, Item.l)
  If Item > 3
    Item = 3
  EndIf
  If Item < 0
    Item = 0
  EndIf
  ProcedureReturn SendMessage_(GadgetID(Gadget),#IPM_SETFOCUS,Item,0)
EndProcedure

; IPM_SETRANGE      > Sets the valid range For the specified field in the IP address control.
ProcedureDLL IPAddress_SetItemRange(Gadget.l, Item.l, Minimum.l, Maximum.l)
  If Item > 3
    Item = 3
  EndIf
  If Item < 0
    Item = 0
  EndIf
  ProcedureReturn SendMessage_(GadgetID(Gadget),#IPM_SETRANGE,Item,MakeWord(Minimum,Maximum))
EndProcedure
