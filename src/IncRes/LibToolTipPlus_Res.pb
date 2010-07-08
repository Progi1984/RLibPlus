Structure TOOLINFO_
  cbSize.l
  uFlags.l
  hwnd.l
  uID.l
  rect.RECT
  hInst.l
  lpszText.l
  lParam.l
EndStructure
Structure TT_GETTITLE
  dwSize.l
  uTitleBitmap.l
  cch.l
  pszTitle.l
EndStructure

#TTS_BUBBLE              = $40

#TTI_NONE                = 0
#TTI_INFO                = 1
#TTI_WARNING             = 2
#TTI_ERROR               = 3

#TTF_IDISHWND            = $1
#TTF_CENTERTIP           = $2
#TTF_RTLREADING          = $4
#TTF_SUBCLASS            = $10
#TTF_TRACK               = $20
#TTF_ABSOLUTE            = $80
#TTF_TRANSPARENT         = $100
#TTF_PARSELINKS          = $1000
#TTF_DI_SETITEM          = $8000
; IDE Options = PureBasic v4.00 (Windows - x86)
; Folding = -
; EnableXP