#CB_GETCOMBOBOXINFO     = $0164 
#CBM_FIRST              = $1700
#CB_SETMINVISIBLE       = #CBM_FIRST + 1
#CB_GETMINVISIBLE       = #CBM_FIRST + 2

;--> ComboBoxEx Constants
#CBEIF_DI_SETITEM       = $10000000
#CBEIF_IMAGE            = 2
#CBEIF_INDENT           = $10
#CBEIF_LPARAM           = $20
#CBEIF_OVERLAY          = 8
#CBEIF_SELECTEDIMAGE    = 4
#CBEIF_TEXT             = 1
#CBEM_INSERTITEMA       = #WM_USER + 1
#CBEM_SETIMAGELIST      = #WM_USER + 2

#STATE_SYSTEM_INVISIBLE = $8000
#STATE_SYSTEM_PRESSED   = $8

Structure COMBOBOXINFO
  cbSize.l
  rcItem.RECT
  rcButton.RECT
  stateButton.l
  hwndCombo.l
  hwndItem.l
  hwndList.l
EndStructure 

; IDE Options = PureBasic v4.00 (Windows - x86)
; CursorPosition = 28
; Folding = -