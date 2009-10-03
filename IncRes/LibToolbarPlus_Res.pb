Macro MakeLong(HiWord, LoWord)
  (HiWord << 16 | LoWord)
EndMacro
Macro HiWord(Long)
  ((Long >> 16) & $FFFF)
EndMacro
Macro LoWord(Long)
  (Long & $FFFF)
EndMacro
Macro MakeWord(HiByte, LoByte)
  (HiByte << 8 | LoByte)
EndMacro

Structure COLORSCHEME 
  dwSize.l
  clrBtnHighlight.l
  clrBtnShadow.l
EndStructure
Structure TBINSERTMARK 
  iButton.l
  dwFlags.l
EndStructure
Structure TBMETRICS
  cbSize.l
  dwMask.l
  cxPad.l
  cyPad.l
  cxBarPad.l
  cyBarPad.l
  cxButtonSpacing.l
  cyButtonSpacing.l
EndStructure

#TBSTYLE_EX_DRAWDDARROWS             = $1
#TBSTYLE_EX_MIXEDBUTTONS             = $8
#TBSTYLE_EX_HIDECLIPPEDBUTTONS       = $10
#TBSTYLE_EX_DOUBLEBUFFER             = $80

#TBMF_PAD                            = $1
#TBMF_BARPAD                         = $2
#TBMF_BUTTONSPACING                  = $4

#TBSTATE_CHECKED                     = $01
#TBSTATE_PRESSED                     = $02
#TBSTATE_ENABLED                     = $04
#TBSTATE_HIDDEN                      = $08
#TBSTATE_INDETERMINATE               = $10
#TBSTATE_WRAP                        = $20
#TBSTATE_ELLIPSES                    = $40
#TBSTATE_MARKED                      = $80

#TBIMHT_AFTER                        = $1
#TBIMHT_BACKGROUND                   = $2

#IDB_STD_SMALL_COLOR                 = $0
#IDB_STD_LARGE_COLOR                 = $1
#IDB_VIEW_SMALL_COLOR                = $4
#IDB_VIEW_LARGE_COLOR                = $5
#IDB_HIST_SMALL_COLOR                = $8
#IDB_HIST_LARGE_COLOR                = $9

#TBSTYLE_BUTTON                      = $0
#TBSTYLE_SEP                         = $1
#TBSTYLE_CHECK                       = $2
#TBSTYLE_GROUP                       = $4
#TBSTYLE_CHECKGROUP                  = (#TBSTYLE_GROUP | #TBSTYLE_CHECK)
#TBSTYLE_DROPDOWN                    = $8
#TBSTYLE_AUTOSIZE                    = $10
#TBSTYLE_NOPREFIX                    = $20
#TBSTYLE_TOOLTIPS                    = $100
#TBSTYLE_WRAPABLE                    = $200
#TBSTYLE_ALTDRAG                     = $400
#TBSTYLE_FLAT                        = $800
#TBSTYLE_LIST                        = $1000
#TBSTYLE_CUSTOMERASE                 = $2000
#TBSTYLE_REGISTERDROP                = $4000
#TBSTYLE_TRANSPARENT                 = $8000
#TBSTYLE_EX_DRAWDDARROWS             = $1
#TBSTYLE_EX_UNDOC1                   = $4
#TBSTYLE_EX_MIXEDBUTTONS             = $8
#TBSTYLE_EX_HIDECLIPPEDBUTTONS       = $10
#TBSTYLE_EX_DOUBLEBUFFER             = $80

#BTNS_BUTTON                         = #TBSTYLE_BUTTON
#BTNS_SEP                            = #TBSTYLE_SEP
#BTNS_CHECK                          = #TBSTYLE_CHECK
#BTNS_GROUP                          = #TBSTYLE_GROUP
#BTNS_CHECKGROUP                     = #TBSTYLE_CHECKGROUP
#BTNS_DROPDOWN                       = #TBSTYLE_DROPDOWN
#BTNS_AUTOSIZE                       = #TBSTYLE_AUTOSIZE
#BTNS_NOPREFIX                       = #TBSTYLE_NOPREFIX
#BTNS_SHOWTEXT                       = $40
#BTNS_WHOLEDROPDOWN                  = $80

#TB_MARKBUTTON                       = #WM_USER + 6
#TB_ISBUTTONHIGHLIGHTED              = #WM_USER + 14
#TB_GETMETRICS                       = #WM_USER + 101
#TB_SETMETRICS                       = #WM_USER + 102
#CCM_SETWINDOWTHEME                  = #CCM_FIRST + $b
#TB_SETWINDOWTHEME                   = #CCM_SETWINDOWTHEME

#TBN_DROPDOWN                        = -710
; IDE Options = PureBasic v4.00 (Windows - x86)
; CursorPosition = 32
; Folding = A+
; EnableXP