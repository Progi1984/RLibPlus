If OpenWindow(0,0,0,430,320,"LibEditorPlus - Example > Table ",#PB_Window_ScreenCentered |#PB_Window_TitleBar|#PB_Window_SystemMenu)
  EditorGadget(1,10,10,300,300)
  ButtonGadget(2,320,10,100,300,"Insert two tables",#PB_Button_MultiLine)
EndIf
Repeat
  Event  = WindowEvent()
  Gadget = EventGadget()
  Menu   = EventMenu()
  Select Event
    Case #PB_Event_Gadget
      Select Gadget
        Case 2
          MyTable=Editor_Table_Create()

            MyTable=Editor_Table_LineOpen(MyTable,100)
              MyTable=Editor_Table_CellOpen(MyTable,1000)
                MyTable=Editor_Table_CellContent(MyTable,"123456789")
              MyTable=Editor_Table_CellClose(MyTable)
              MyTable=Editor_Table_CellOpen(MyTable,2000)
                MyTable=Editor_Table_CellContent(MyTable,"abcd")
              MyTable=Editor_Table_CellClose(MyTable)
            MyTable=Editor_Table_LineClose(MyTable)
  
            MyTable=Editor_Table_LineOpen(MyTable,100)
              MyTable=Editor_Table_CellOpen(MyTable,2000)
                MyTable=Editor_Table_CellContent(MyTable,"efgh")
              MyTable=Editor_Table_CellClose(MyTable)
            MyTable=Editor_Table_LineClose(MyTable)
            
            MyTable=Editor_Table_LineOpen(MyTable,100)
              MyTable=Editor_Table_CellOpen(MyTable,600)
                MyTable=Editor_Table_CellContent(MyTable,"ijkl")
              MyTable=Editor_Table_CellClose(MyTable)
              MyTable=Editor_Table_CellOpen(MyTable,1200)
                MyTable=Editor_Table_CellContent(MyTable,"mnop")
              MyTable=Editor_Table_CellClose(MyTable)
              MyTable=Editor_Table_CellOpen(MyTable,2000)
                MyTable=Editor_Table_CellContent(MyTable,"uvwx")
              MyTable=Editor_Table_CellClose(MyTable)
            MyTable=Editor_Table_LineClose(MyTable)
            
          MyTable=Editor_Table_Close(MyTable)

          Editor_Table_Insert(1,-1,MyTable)
          Editor_Table_Insert(1,-1,MyTable)
          Editor_Table_Clear(MyTable)
      EndSelect
  EndSelect
Until Event=#PB_Event_CloseWindow