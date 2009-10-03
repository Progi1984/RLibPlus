Macro RuntimeError(line)
  MessageRequester("LibEditorPlus",line)
EndMacro

If OpenWindow(0,0,0,530,320,"LibEditorPlus - Example > IME (Input Method Editor)",#PB_Window_ScreenCentered |#PB_Window_TitleBar|#PB_Window_SystemMenu)
  EditorGadget(1,10,10,300,300)
  ButtonGadget(2,320,010,100,100,"Management of the Indian Support ?",#PB_Button_MultiLine)
  ButtonGadget(3,320,110,100,100,"IME Reconversion",#PB_Button_MultiLine)
  ButtonGadget(4,320,210,100,100,"Mode of the IME",#PB_Button_MultiLine)
  ButtonGadget(5,420,010,100,100,"Options of the IME",#PB_Button_MultiLine)
  ButtonGadget(6,420,110,100,200,"Options of the Language of the IME",#PB_Button_MultiLine)
EndIf
Repeat
  Event  = WindowEvent()
  Gadget = EventGadget()
  Select Event
    Case #PB_Event_Gadget
      Select Gadget
        Case 2
          If Editor_IME_IsIME(1)
            RuntimeError("Gestion du Support Asiatique : #True")
          Else
            RuntimeError("Gestion du Support Asiatique : #False")
          EndIf
        Case 3
          Editor_IME_Reconversion(1)
        Case 4
          Select Editor_IME_GetMode(1) 
            Case #ICM_NOTOPEN
              RuntimeError("Input Method Editor (IME) is not open.")
            Case #ICM_LEVEL3
              RuntimeError("True inline mode.")
            Case #ICM_LEVEL2
              RuntimeError("Level 2.")
            Case #ICM_LEVEL2_5
              RuntimeError("Level 2.5")
            Case #ICM_LEVEL2_SUI
              RuntimeError("Special user interface (UI).")
            Case #ICM_CTF
              RuntimeError("")
          EndSelect
        Case 5
          OptionsIME=Editor_IME_GetOptions(1)
          InfosIME.s=""
          If Editor_IME_IsCloseStatusWindow(OptionsIME)
            InfosIME + "IMF_CLOSESTATUSWINDOW : Active" + Chr(13) + Chr(10)
          Else
            InfosIME + "IMF_CLOSESTATUSWINDOW : Inactive" + Chr(13) + Chr(10)
          EndIf
          If Editor_IME_IsForceActive(OptionsIME)
            InfosIME + "IMF_FORCEACTIVE : Active" + Chr(13) + Chr(10)
          Else
            InfosIME + "IMF_FORCEACTIVE : Inactive" + Chr(13) + Chr(10)
          EndIf
          If Editor_IME_IsForceDisable(OptionsIME)
            InfosIME + "IMF_FORCEDISABLE : Active" + Chr(13) + Chr(10)
          Else
            InfosIME + "IMF_FORCEDISABLE : Inactive" + Chr(13) + Chr(10)
          EndIf
          If Editor_IME_IsForceEnable(OptionsIME)
            InfosIME + "IMF_FORCEENABLE : Active" + Chr(13) + Chr(10)
          Else
            InfosIME + "IMF_FORCEENABLE : Inactive" + Chr(13) + Chr(10)
          EndIf
          If Editor_IME_IsForceInactive(OptionsIME)
            InfosIME + "IMF_FORCEINACTIVE : Active" + Chr(13) + Chr(10)
          Else
            InfosIME + "IMF_FORCEINACTIVE : Inactive" + Chr(13) + Chr(10)
          EndIf
          If Editor_IME_IsForceNone(OptionsIME)
            InfosIME + "IMF_FORCENONE : Active" + Chr(13) + Chr(10)
          Else
            InfosIME + "IMF_FORCENONE : Inactive" + Chr(13) + Chr(10)
          EndIf
          If Editor_IME_IsForceRemember(OptionsIME)
            InfosIME + "IMF_FORCEREMEMBER : Active" + Chr(13) + Chr(10)
          Else
            InfosIME + "IMF_FORCEREMEMBER : Inactive" + Chr(13) + Chr(10)
          EndIf
          If Editor_IME_IsMultipleEdit(OptionsIME)
            InfosIME + "IMF_MULTIPLEEDIT : Active" + Chr(13) + Chr(10)
          Else
            InfosIME + "IMF_MULTIPLEEDIT : Inactive" + Chr(13) + Chr(10)
          EndIf
          RuntimeError(InfosIME)
        Case 6
          LangOptionsIME= Editor_IME_GetLangOptions(1)
          InfosLangIME.s=""
          If Editor_IME_IsAutoFont(LangOptionsIME)
            InfosLangIME + "IMF_AUTOFONT : Active" + Chr(13) + Chr(10)
          Else
            InfosLangIME + "IMF_AUTOFONT : Inactive" + Chr(13) + Chr(10)
          EndIf
          If Editor_IME_IsAutoFontSizeAdjust(LangOptionsIME)
            InfosLangIME + "IMF_AUTOFONTSIZEADJUST : Active" + Chr(13) + Chr(10)
          Else
            InfosLangIME + "IMF_AUTOFONTSIZEADJUST : Inactive" + Chr(13) + Chr(10)
          EndIf
          If Editor_IME_IsAutoKeyboard(LangOptionsIME)
            InfosLangIME + "IMF_AUTOKEYBOARD : Active" + Chr(13) + Chr(10)
          Else
            InfosLangIME + "IMF_AUTOKEYBOARD : Inactive" + Chr(13) + Chr(10)
          EndIf
          If Editor_IME_IsDualFont(LangOptionsIME)
            InfosLangIME + "IMF_DUALFONT : Active" + Chr(13) + Chr(10)
          Else
            InfosLangIME + "IMF_DUALFONT : Inactive" + Chr(13) + Chr(10)
          EndIf
          If Editor_IME_IsAlwaysSendNotify(LangOptionsIME)
            InfosLangIME + "IMF_IMEALWAYSSENDNOTIFY : Active" + Chr(13) + Chr(10)
          Else
            InfosLangIME + "IMF_IMEALWAYSSENDNOTIFY : Inactive" + Chr(13) + Chr(10)
          EndIf
          If Editor_IME_IsCancelComplete(LangOptionsIME)
            InfosLangIME + "IMF_IMECANCELCOMPLETE : Active" + Chr(13) + Chr(10)
          Else
            InfosLangIME + "IMF_IMECANCELCOMPLETE : Inactive" + Chr(13) + Chr(10)
          EndIf
          If Editor_IME_IsUIFonts(LangOptionsIME)
            InfosLangIME + "IMF_UIFONTS : Active" + Chr(13) + Chr(10)
          Else
            InfosLangIME + "IMF_UIFONTS : Inactive" + Chr(13) + Chr(10)
          EndIf
          RuntimeError(InfosLangIME)
      EndSelect
  EndSelect
Until Event=#PB_Event_CloseWindow