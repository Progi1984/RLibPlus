Macro RuntimeError(line)
  MessageRequester("LibEditorPlus",line)
EndMacro
If OpenWindow(0,0,0,430,320,"LibEditorPlus - Example > Bidirectional",#PB_Window_ScreenCentered |#PB_Window_TitleBar|#PB_Window_SystemMenu)
  EditorGadget(1,10,10,300,300)
  ButtonGadget(2,320,10,100,300,"Informations about BiDirectional on Editorgadget",#PB_Button_MultiLine)
EndIf
Repeat
  Event  = WindowEvent()
  Gadget = EventGadget()
  Select Event
    Case #PB_Event_Gadget
      Select Gadget
        Case 2
          OptionsBidi=Editor_BIDI_GetOptions(1)
          sInfoBidi.s = ""
          If Editor_BIDI_IsContextAlignment(OptionsBidi)
            sInfoBidi + "Context alignment : Active" + Chr(13) + Chr(10)
          Else
            sInfoBidi + "Context alignment : Inactive" + Chr(13) + Chr(10)
          EndIf
          If Editor_BIDI_IsContextReading(OptionsBidi)
            sInfoBidi + "Context reading order : Active" + Chr(13) + Chr(10)
          Else
            sInfoBidi + "Context reading order : Inactive" + Chr(13) + Chr(10)
          EndIf
          If Editor_BIDI_IsDefault(OptionsBidi)
            sInfoBidi + "Default paragraph direction : Active" + Chr(13) + Chr(10)
          Else
            sInfoBidi + "Default paragraph direction : Inactive" + Chr(13) + Chr(10)
          EndIf
          If Editor_BIDI_IsNeutralLayout(OptionsBidi)
            sInfoBidi + "Overrides neutral layout : Active" + Chr(13) + Chr(10)
          Else
            sInfoBidi + "Overrides neutral layout : Inactive" + Chr(13) + Chr(10)
          EndIf
          If Editor_BIDI_IsPlainText(OptionsBidi)
            sInfoBidi + "Plain text layout : Active" + Chr(13) + Chr(10)
          Else
            sInfoBidi + "Plain text layout : Inactive" + Chr(13) + Chr(10)
          EndIf
          RuntimeError(sInfoBidi)
      EndSelect
  EndSelect
Until Event=#PB_Event_CloseWindow