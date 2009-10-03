Structure SCROLLBARINFO
  cbSize.l
  rcScrollBar.RECT
  dxyLineButton.l
  xyThumbTop.l
  xyThumbBottom.l
  reserved.l
  rgstate.l[6]
EndStructure

#SBM_GETSCROLLBARINFO        = $EB
; IDE Options = PureBasic v4.00 (Windows - x86)
; CursorPosition = 10
; Folding = -
; EnableXP