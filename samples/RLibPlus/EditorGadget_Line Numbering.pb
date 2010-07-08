If OpenWindow(0, 0, 0, 520, 440, "LibEditorPlus - Example > LineNumbering", #PB_Window_SystemMenu | #PB_Window_ScreenCentered)
  ; Initialisation of linenumbering for this window
  Editor_LN_Start(0)
  ;{ Menus
    CreateMenu(1, WindowID(0))
    MenuTitle("EditorGadget")
      MenuItem(1, "Column > Background"+Chr(9)+"F1")
      MenuItem(2, "Column > Text"+Chr(9)+"F2")
      MenuItem(3, "Column > Size +"+Chr(9)+"F3")
      MenuItem(4, "Column > Size -"+Chr(9)+"F4")
      MenuItem(5, "Editor > Background"+Chr(9)+"F5")
      MenuItem(6, "Stop"+Chr(9)+"F6")
      MenuItem(7, "Begin"+Chr(9)+"F7")
      AddKeyboardShortcut(0,#PB_Shortcut_F1,1)
      AddKeyboardShortcut(0,#PB_Shortcut_F2,2)
      AddKeyboardShortcut(0,#PB_Shortcut_F3,3)
      AddKeyboardShortcut(0,#PB_Shortcut_F4,4)
      AddKeyboardShortcut(0,#PB_Shortcut_F5,5)
      AddKeyboardShortcut(0,#PB_Shortcut_F6,6)
      AddKeyboardShortcut(0,#PB_Shortcut_F7,7)
  ;}
  ;{ EditorGadget
    EditorGadget(4,10,10,250,400)
    ;Editor_LN_Start(4)
    Editor_LN_SetState(4,#True)
    Editor = EditorGadget(#PB_Any,260,10,250,400)
    Editor_LN_SetState(Editor,#True)
    For lInc = 0 To 100
      AddGadgetItem(4, lInc, "Line"+Str(lInc))
      AddGadgetItem(Editor, lInc, "Line"+Str(lInc))
    Next
  ;}
  Repeat
    Event = WaitWindowEvent()
    
    Editor_LN_Update()
    
    Select event
      Case #PB_Event_Menu
        Select EventMenu()
;           Case 1
;             Editor_LN_SetColorText(4,RGB(Random(255), Random(255), Random(255)))
;             Editor_LN_SetColorText(Editor,RGB(Random(255), Random(255), Random(255)))
;           Case 2
;             Editor_LN_SetColorBack(4,RGB(Random(255), Random(255), Random(255)))
;             Editor_LN_SetColorBack(Editor,RGB(Random(255), Random(255), Random(255)))
;           Case 3
;             Editor_LN_Resize(4,2)
;             Editor_LN_Resize(Editor,5)
;           Case 4
;             Editor_LN_Resize(4,-2)
;             Editor_LN_Resize(Editor,-5)
;           Case 5
;             Editor_RTF_SetColorBackground(4,RGB(Random(255), Random(255), Random(255)))
;             Editor_RTF_SetColorBackground(Editor,RGB(Random(255), Random(255), Random(255)))
;           Case 6
;             Editor_LN_SetState(4,#False)
;             Editor_LN_SetState(Editor,#False)
;           Case 7
;             Editor_LN_SetState(4,#True)
;             Editor_LN_SetState(Editor,#True)
        EndSelect
    EndSelect
  
  Until Event = #PB_Event_CloseWindow 
EndIf
End