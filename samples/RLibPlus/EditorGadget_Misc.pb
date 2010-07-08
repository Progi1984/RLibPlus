If OpenWindow(0,0,0,430,320,"LibEditorPlus - Exemple > Misc",#PB_Window_ScreenCentered |#PB_Window_TitleBar|#PB_Window_SystemMenu)
  EditorGadget(1,10,10,300,300)
  ButtonGadget(2,320,10,100,150,"Auto Detection of URLs : Off",#PB_Button_Toggle|#PB_Button_MultiLine)
  ButtonGadget(3,320,160,100,150,"Limitation in characters",#PB_Button_MultiLine)
EndIf
Repeat
  Event  = WindowEvent()
  Gadget = EventGadget()
  Select Event
    Case #PB_Event_Gadget
      Select Gadget
        Case 2
          Editor_SetAutoDetectURL(1,GetGadgetState(2))
          If Editor_GetAutoDetectURL(1)
            SetGadgetText(2,"Auto Detection of URLs : On")
          Else
            SetGadgetText(2,"Auto Detection of URLs : Off")
          EndIf
        Case 3
          ValeurS.s=InputRequester("Limit", "Maximal number of characters ?","")
          ValeurL=Val(ValeurS)
          Editor_SetLimitText(1,ValeurL)
      EndSelect
  EndSelect
Until Event=#PB_Event_CloseWindow