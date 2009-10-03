Structure BUTTON_IMAGELIST
  hImageList.l
  margin.RECT
  uAlign.l
EndStructure

#BCM_FIRST        = $1600

#BCM_GETIDEALSIZE   = #BCM_FIRST + $0001
#BCM_SETIMAGELIST   = #BCM_FIRST + $0002
#BCM_GETIMAGELIST   = #BCM_FIRST + $0003
#BCM_SETTEXTMARGIN  = #BCM_FIRST + $0004
#BCM_GETTEXTMARGIN  = #BCM_FIRST + $0005

;BM_GETSTATE 
#BST_FOCUS=$8

#BS_TEXT             = $00000000
#BS_LEFT             = $00000100
#BS_RIGHT            = $00000200
#BS_CENTER           = $00000300
#BS_TOP              = $00000400
#BS_BOTTOM           = $00000800
#BS_VCENTER          = $00000C00
#BS_PUSHLIKE         = $00001000
#BS_MULTILINE        = $00002000
#BS_NOTIFY           = $00004000
; #BS_RIGHTBUTTON      = #BS_LEFTTEXT 
; IDE Options = PureBasic 4.10 (Windows - x86)
; CursorPosition = 27
; Folding = -