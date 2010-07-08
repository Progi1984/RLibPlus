XIncludeFile "../RLibPlus.pb"
; TTM_ADDTOOL > Registers a tool With a ToolTip control. 
ProcedureDLL ToolTip_CreateBalloon(Handle.l, Text.s)
  hToolTip = CreateWindowEx_(#WS_EX_TOPMOST, "Tooltips_Class32", 0,#TTS_ALWAYSTIP|#TTS_NOPREFIX|#WS_POPUP|#TTS_BUBBLE,#CW_USEDEFAULT,#CW_USEDEFAULT, #CW_USEDEFAULT,#CW_USEDEFAULT,GetParent_(Handle), 0, GetModuleHandle_(0), 0)
  Tool.TOOLINFO  
  Tool\cbSize   = SizeOf(TOOLINFO_)  
  Tool\uFlags   = #TTF_SUBCLASS|#TTF_IDISHWND  
  Tool\hwnd     = Handle  
  Tool\uID      = Handle  
  Tool\hInst    = GetModuleHandle_(0)  
  Tool\lpszText = @Text  
  SendMessage_(hToolTip,#TTM_ADDTOOL,0,@Tool)  
  ProcedureReturn hToolTip
EndProcedure
ProcedureDLL ToolTip_CreateSquare(Handle.l, Text.s)
  hToolTip = CreateWindowEx_(#WS_EX_TOPMOST, "Tooltips_Class32", 0,#TTS_ALWAYSTIP|#TTS_NOPREFIX|#WS_POPUP,#CW_USEDEFAULT,#CW_USEDEFAULT, #CW_USEDEFAULT,#CW_USEDEFAULT,GetParent_(Handle), 0, GetModuleHandle_(0), 0)
  Tool.TOOLINFO  
  Tool\cbSize   = SizeOf(TOOLINFO_)  
  Tool\uFlags   = #TTF_SUBCLASS|#TTF_IDISHWND  
  Tool\hwnd     = Handle  
  Tool\uID      = Handle  
  Tool\hInst    = GetModuleHandle_(0)  
  Tool\lpszText = @Text  
  SendMessage_(hToolTip,#TTM_ADDTOOL,0,@Tool)  
  ProcedureReturn hToolTip
EndProcedure

; TTM_ACTIVATE  > Activates Or deactivates a ToolTip control.
ProcedureDLL ToolTip_SetState(TooltipID.l, State.l)
  SendMessage_(TooltipID,#TTM_ACTIVATE,State,0)
  ProcedureReturn 
EndProcedure

; TTM_UPDATETIPTEXT > Sets the ToolTip text For a tool. 
ProcedureDLL ToolTip_SetText(TooltipID.l, Gadget.l, Text.s)
  update.TOOLINFO_
  update\cbSize     = SizeOf(TOOLINFO_)
  update\hWnd       = GadgetID(Gadget)
  update\uId        = GadgetID(Gadget)
  update\hInst      = GetModuleHandle_(0)
  update\lpszText   = @Text
  ProcedureReturn SendMessage_(TooltipID,#TTM_UPDATETIPTEXT,0, @update)
EndProcedure

; TTM_TRACKACTIVATE > Activates Or deactivates a tracking ToolTip.
; TTM_TRACKPOSITION > Sets the position of a tracking ToolTip.
ProcedureDLL ToolTip_Show2(TooltipID.l, GadgetID.l, WindowID.l, X.l, Y.l)
  show.TOOLINFO_
  show\cbSize = SizeOf(TOOLINFO_)
  show\hWnd = WindowID
  show\uId = GadgetID   
  SendMessage_(TooltipID, #TTM_TRACKACTIVATE, 1, show)
  SendMessage_(TooltipID, #TTM_TRACKPOSITION, 0, MakeLong(x,y))
  ProcedureReturn 0
EndProcedure
ProcedureDLL ToolTip_Show(TooltipID.l, GadgetID.l, WindowID.l)
  ProcedureReturn ToolTip_Show2(TooltipID.l, GadgetID.l, WindowID.l, WindowMouseX(GetActiveWindow()), WindowMouseY(GetActiveWindow()))
EndProcedure
ProcedureDLL ToolTip_Hide(TooltipID.l, GadgetID.l, WindowID.l)
  hide.TOOLINFO_
  hide\cbSize = SizeOf(TOOLINFO_)
  hide\hWnd = WindowID
  hide\uId = GadgetID
  SendMessage_(TooltipID, #TTM_TRACKACTIVATE, 0, @hide)
  ProcedureReturn 0
EndProcedure

;- Color
; TTM_GETTIPBKCOLOR > Retrieves the background color in a ToolTip window. 
ProcedureDLL ToolTip_GetBackColor(TooltipID.l)
  ProcedureReturn SendMessage_(TooltipID,#TTM_GETTIPBKCOLOR,0,0)
EndProcedure
; TTM_SETTIPBKCOLOR > Sets the background color in a ToolTip window. 
ProcedureDLL ToolTip_SetBackColor(TooltipID.l, Color.l)
  ProcedureReturn SendMessage_(TooltipID,#TTM_SETTIPBKCOLOR,Color,0)
EndProcedure
; TTM_GETTIPTEXTCOLOR > Retrieves the text color in a ToolTip window. 
ProcedureDLL ToolTip_GetTextColor(TooltipID.l)
  ProcedureReturn SendMessage_(TooltipID,#TTM_GETTIPTEXTCOLOR,0,0)
EndProcedure
; TTM_SETTIPTEXTCOLOR > Sets the text color in a ToolTip window. 
ProcedureDLL ToolTip_SetTextColor(TooltipID.l, Color.l)
  ProcedureReturn SendMessage_(TooltipID,#TTM_SETTIPTEXTCOLOR,Color,0)
EndProcedure

;-Title
; TTM_SETTITLE  > Adds a standard icon And title string To a ToolTip.
ProcedureDLL ToolTip_SetTitle2(TooltipID.l, Title.s, Type.l)
  ProcedureReturn SendMessage_(TooltipID, #TTM_SETTITLE, Type, @Title)
EndProcedure
ProcedureDLL ToolTip_SetTitle(TooltipID.l, Title.s)
  ; #TTI_NONE     = 0
  ; #TTI_INFO     = 1
  ; #TTI_WARNING  = 2
  ; #TTI_ERROR    = 3
  ProcedureReturn ToolTip_SetTitle2(TooltipID.l, Title.s, 0)
EndProcedure

;-Margins
; TTM_SETMARGIN > Sets the top, left, bottom, And right margins For a ToolTip window. A margin is the distance, in pixels, between the ToolTip window border And the text contained within the ToolTip window. 
ProcedureDLL ToolTip_SetMargin(TooltipID.l, MarginLeft.l, MarginTop.l, MarginRight.l, MarginBottom.l)
  Protected margin.RECT
    margin\left  = MarginLeft
    margin\top   = MarginTop
    margin\right = MarginRight
    margin\bottom= MarginBottom
  ProcedureReturn SendMessage_(TooltipID,#TTM_SETMARGIN,0,margin)
EndProcedure
; TTM_GETMARGIN > Retrieves the top, left, bottom, And right margins set For a ToolTip window. A margin is the distance, in pixels, between the ToolTip window border And the text contained within the ToolTip window. 
ProcedureDLL ToolTip_GetMarginLeft(TooltipID.l)
  Protected margin.RECT
  SendMessage_(TooltipID,#TTM_GETMARGIN,0,margin)
  ProcedureReturn margin\left
EndProcedure
ProcedureDLL ToolTip_GetMarginTop(TooltipID.l)
  Protected margin.RECT
  SendMessage_(TooltipID,#TTM_GETMARGIN,0,margin)
  ProcedureReturn margin\top
EndProcedure
ProcedureDLL ToolTip_GetMarginRight(TooltipID.l)
  Protected margin.RECT
  SendMessage_(TooltipID,#TTM_GETMARGIN,0,margin)
  ProcedureReturn margin\right
EndProcedure
ProcedureDLL ToolTip_GetMarginBottom(TooltipID.l)
  Protected margin.RECT
  SendMessage_(TooltipID,#TTM_GETMARGIN,0,margin)
  ProcedureReturn margin\bottom
EndProcedure
; TTM_SETMAXTIPWIDTH  > Sets the maximum width For a ToolTip window. 
ProcedureDLL ToolTip_SetMaxWidthLine(TooltipID.l, Width.l)
  ProcedureReturn SendMessage_(TooltipID,#TTM_SETMAXTIPWIDTH,0,Width)
EndProcedure
; TTM_GETMAXTIPWIDTH  > Retrieves the maximum width For a ToolTip window. 
ProcedureDLL ToolTip_GetMaxWidthLine(TooltipID.l)
  ProcedureReturn SendMessage_(TooltipID,#TTM_GETMAXTIPWIDTH,0,0)
EndProcedure

;- Time Delays
; TTDT_INITIAL    > Set the length of time a pointer must remain stationary within a tool's bounding rectangle before the ToolTip window appears. To return the initial delay time to its default value, set iTime to -1.
ProcedureDLL ToolTip_Time_SetInitialShow(TooltipID.l, TimeMs.l)
  SendMessage_(TooltipID,#TTM_SETDELAYTIME,#TTDT_INITIAL,MakeLong(TimeMs,0)) 
  ProcedureReturn 0
EndProcedure
; TTDT_AUTOMATIC  > Set all three delay times To Default proportions. The autopop time will be ten times the initial time And the reshow time will be one fifth the initial time. If this flag is set, use a positive value of iTime To specify the initial time, in milliseconds. Set iTime To a negative value To Return all three delay times To their Default values.
ProcedureDLL ToolTip_SetAllDefaultTime(TooltipID.l)
  SendMessage_(TooltipID,#TTM_SETDELAYTIME,#TTDT_AUTOMATIC,MakeLong(-1,0)) 
  ProcedureReturn 0
EndProcedure


