;http://msdn.microsoft.com/library/default.asp?url=/library/en-us/shellcc/platform/commctls/buttons/buttons.asp
XIncludeFile "../RLibPlus.pb"
;- Images & Icones
; BCM_SETIMAGELIST > The BCM_SETIMAGELIST message assigns an image list To a button control.
ProcedureDLL Button_SetIcon2(Gadget.l, PathImage.s, Alignment.l, Right.l, Left.l, Top.l, Bottom.l)
  ; Alignement
    ; $0000 left
    ; $0001 droite
    ; $0002 haut
    ; $0003 bas
    ; $0004 centre 
  Protected Width.l, hImg.l
  Protected Image.BUTTON_IMAGELIST
  
  ;récupération de la largeur
  LoadImage(0, PathImage)
    Width=ImageWidth(0)
  FreeImage(0)
  
  ;chargement système de l'image
  hImg = ImageList_LoadImage_(#Null,PathImage,Width,1,#CLR_NONE,#IMAGE_BITMAP,#LR_LOADFROMFILE)
  
  Image\hImageList = hImg
  Image\uAlign = Alignment 
  Image\margin\left   = Left
  Image\margin\top    = Top
  Image\margin\bottom = Bottom
  Image\margin\Right  = Right
  SendMessage_(GadgetID(Gadget),#BCM_SETIMAGELIST,0,Image)
  ProcedureReturn 
EndProcedure
ProcedureDLL Button_SetIcon(Gadget.l, PathImage.s, Alignment.l)
  Button_SetIcon2(Gadget.l, PathImage.s, Alignment.l, 0, 0, 0, 0)
EndProcedure
; BCM_GETIMAGELIST > The BCM_GETIMAGELIST message retrieves the BUTTON_IMAGELIST Structure that describes the image list assigned To a button control. 
ProcedureDLL Button_GetIconAlignment(Gadget.l)
  Protected pt.BUTTON_IMAGELIST
  SendMessage_(GadgetID(Gadget),#BCM_GETIMAGELIST,0,pt)
  ProcedureReturn pt\ualign
EndProcedure
ProcedureDLL Button_GetIconMarginBottom(Gadget.l)
  Protected pt.BUTTON_IMAGELIST
  SendMessage_(GadgetID(Gadget),#BCM_GETIMAGELIST,0,pt)
  ProcedureReturn pt\margin\bottom
EndProcedure
ProcedureDLL Button_GetIconMarginLeft(Gadget.l)
  Protected pt.BUTTON_IMAGELIST
  SendMessage_(GadgetID(Gadget),#BCM_GETIMAGELIST,0,pt)
  ProcedureReturn pt\margin\left
EndProcedure
ProcedureDLL Button_GetIconMarginRight(Gadget.l)
  Protected pt.BUTTON_IMAGELIST
  SendMessage_(GadgetID(Gadget),#BCM_GETIMAGELIST,0,pt)
  ProcedureReturn pt\margin\right
EndProcedure
ProcedureDLL Button_GetIconMarginTop(Gadget.l)
  Protected pt.BUTTON_IMAGELIST
  SendMessage_(GadgetID(Gadget),#BCM_GETIMAGELIST,0,pt)
  ProcedureReturn pt\margin\top
EndProcedure
; BM_GETIMAGE > An application sends a BM_GETIMAGE message To retrieve a handle To the image (icon Or bitmap) associated With the button.
ProcedureDLL Button_GetImage(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#BM_GETIMAGE,#IMAGE_BITMAP,0)
EndProcedure
; BM_SETIMAGE > An application sends a BM_SETIMAGE message To associate a new image (icon Or bitmap) With the button.
ProcedureDLL Button_SetImage(Gadget.l, ImageID.l)
  Protected active.l, options.l
  If ImageID=#Null
    options=GetWindowLong_(GadgetID(Gadget), #GWL_STYLE)
    If options & #BS_BITMAP
      options - #BS_BITMAP
    EndIf
    SetWindowLong_(GadgetID(Gadget), #GWL_STYLE, options)
    active=GetActiveGadget()
    SetActiveGadget(Gadget)
    SetActiveGadget(active)
  Else
    SetWindowLong_(GadgetID(Gadget), #GWL_STYLE,GetWindowLong_(GadgetID(Gadget), #GWL_STYLE) | #BS_BITMAP)
    SendMessage_(GadgetID(Gadget),#BM_SETIMAGE,#IMAGE_BITMAP,ImageID)
  EndIf
  ProcedureReturn 
EndProcedure

;- Styles visuels
ProcedureDLL Button_SetFlatState(Gadget.l, State.l)
  If state=#True
    style.l=GetWindowLong_(GadgetID(Gadget),#GWL_STYLE)
    If style & #BS_FLAT
      style-#BS_FLAT
    EndIf
    SetWindowLong_(GadgetID(Gadget),#GWL_STYLE,style|#BS_FLAT)
  Else
    style.l=GetWindowLong_(GadgetID(Gadget),#GWL_STYLE)
    If style & #BS_FLAT
      style-#BS_FLAT
    EndIf
    SetWindowLong_(GadgetID(Gadget),#GWL_STYLE,style)
  EndIf
  ProcedureReturn 
EndProcedure
ProcedureDLL Button_GetFlatState(Gadget.l)
  style.l=GetWindowLong_(GadgetID(Gadget),#GWL_STYLE)
  If style & #BS_FLAT
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure


; BCM_GETIDEALSIZE > The BCM_GETIDEALSIZE message retrieves the size of the button that best fits its text And image, If an image list is present. 
ProcedureDLL Button_GetTextWidth(Gadget.l)
  Protected sizept.SIZE
  SendMessage_(GadgetID(Gadget),#BCM_GETIDEALSIZE,0,sizept)
  ProcedureReturn sizept\cx
EndProcedure
ProcedureDLL Button_GetTextHeight(Gadget.l)
  Protected sizept.SIZE
  SendMessage_(GadgetID(Gadget),#BCM_GETIDEALSIZE,0,sizept)
  ProcedureReturn sizept\cy
EndProcedure

;- Couleurs
ProcedureDLL Button_SystemColor_SetFace(Color.l)
  syst = #COLOR_BTNFACE
  ProcedureReturn SetSysColors_(1, @syst, @Color) 
EndProcedure
ProcedureDLL Button_SystemColor_SetHighlight(Color.l)
  syst = #COLOR_BTNHIGHLIGHT
  ProcedureReturn SetSysColors_(1, @syst, @Color) 
EndProcedure
ProcedureDLL Button_SystemColor_SetShadow(Color.l)
  syst = #COLOR_BTNSHADOW
  ProcedureReturn SetSysColors_(1, @syst, @Color) 
EndProcedure
ProcedureDLL Button_SystemColor_SetText(Color.l)
  syst = #COLOR_BTNTEXT
  ProcedureReturn SetSysColors_(1, @syst, @Color) 
EndProcedure
ProcedureDLL Button_SystemColor_SetDisabledText(Color.l)
  syst = #COLOR_GRAYTEXT
  ProcedureReturn SetSysColors_(1, @syst, @Color) 
EndProcedure
ProcedureDLL Button_SystemColor_GetFace()
  syst = #COLOR_BTNFACE
  ProcedureReturn GetSysColor_(syst)
EndProcedure
ProcedureDLL Button_SystemColor_GetHighlight()
  syst = #COLOR_BTNHIGHLIGHT
  ProcedureReturn GetSysColor_(syst)
EndProcedure
ProcedureDLL Button_SystemColor_GetShadow()
  syst = #COLOR_BTNSHADOW
  ProcedureReturn GetSysColor_(syst)
EndProcedure
ProcedureDLL Button_SystemColor_GetText()
  syst = #COLOR_BTNTEXT
  ProcedureReturn GetSysColor_(syst)
EndProcedure
ProcedureDLL Button_SystemColor_GetDisabledText()
  syst = #COLOR_GRAYTEXT
  ProcedureReturn GetSysColor_(syst)
EndProcedure

;- Emulation
; BM_CLICK > An application sends a BM_CLICK message To simulate the user clicking a button. This message causes the button To receive the WM_LBUTTONDOWN And WM_LBUTTONUP messages, And the button's parent window to receive a BN_CLICKED notification message.
ProcedureDLL Button_EmulateClick(Gadget.l)
  SendMessage_(GadgetID(Gadget),#BM_CLICK,0,0)
  ProcedureReturn 
EndProcedure

;- State
; BM_GETSTATE > An application sends a BM_GETSTATE message To determine the state of a button Or check box. 
ProcedureDLL Button_IsChecked(Gadget.l)
  options=SendMessage_(GadgetID(Gadget),#BM_GETSTATE,0,0)
  If options & #BST_CHECKED
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Button_IsFocused(Gadget.l)
  options=SendMessage_(GadgetID(Gadget),#BM_GETSTATE,0,0)
  If options & #BST_FOCUS
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Button_IsInderterminate(Gadget.l)
  options=SendMessage_(GadgetID(Gadget),#BM_GETSTATE,0,0)
  If options & #BST_INDETERMINATE
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Button_IsPushed(Gadget.l)
  options=SendMessage_(GadgetID(Gadget),#BM_GETSTATE,0,0)
  If options & #BST_PUSHED
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Button_IsUnChecked(Gadget.l)
  options=SendMessage_(GadgetID(Gadget),#BM_GETSTATE,0,0)
  If options & #BST_UNCHECKED
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
; BM_SETSTATE > An application sends a BM_SETSTATE message To change the highlight state of a button. The highlight state indicates whether the button is highlighted As If the user had pushed it.
ProcedureDLL Button_SetState(Gadget.l, State.l)
  SendMessage_(GadgetID(Gadget),#BM_SETSTATE,State,0)
  ProcedureReturn 
EndProcedure

;- Mutation
;http://msdn.microsoft.com/library/en-us/shellcc/platform/commctls/buttons/buttonreference/buttonstyles.asp?frame=true
;{ OK
; #BS_3STATE 
  ; checkbox avec trois états
; #BS_AUTO3STATE 
  ; #BS_3STATE mais en auto
; #BS_AUTOCHECKBOX 
  ; checkbox avec deux états mais en auto
; #BS_AUTORADIOBUTTON 
  ; optiongadget mais avec changement auto
; #BS_CHECKBOX 
  ; checkbox avec deux états
; #BS_DEFPUSHBUTTON 
  ; bouton avec profondeur (entourage noir)
; #BS_GROUPBOX
  ; frame3D 
; #BS_OWNERDRAW 
  ; bouton en ownerdrawn => a WM_DRAWITEM message
; #BS_RADIOBUTTON 
  ; optiongadget 
; #BS_USERBUTTON 
  ;inutile
; #BS_BITMAP 
  ; le bouton affiche une image
;}
;{ NOK
; #BS_LEFTTEXT 
; #BS_PUSHBUTTON 
; #BS_BOTTOM 
; #BS_CENTER 
; #BS_ICON 
; #BS_FLAT 
; #BS_LEFT 
; #BS_MULTILINE 
; #BS_NOTIFY 
; #BS_PUSHLIKE 
; #BS_RIGHT 
; #BS_RIGHTBUTTON 
; #BS_TEXT 
; #BS_TOP 
; #BS_TYPEMASK 
; #BS_VCENTER 
;}
; BM_SETSTYLE > An application sends a BM_SETSTYLE message To change the style of a button.
ProcedureDLL Button_SetInCheckbox2(Gadget.l, ThreeState.l)
  If ThreeState=#True
    SendMessage_(GadgetID(Gadget),#BM_SETSTYLE,#BS_AUTO3STATE  ,#True)
  Else
    SendMessage_(GadgetID(Gadget),#BM_SETSTYLE,#BS_CHECKBOX ,#True)
  EndIf
  ProcedureReturn 
EndProcedure
ProcedureDLL Button_SetInCheckbox(Gadget.l)
  Button_SetInCheckbox2(Gadget.l,#False)
  ProcedureReturn 
EndProcedure
; BM_SETCHECK > An application sends a BM_SETCHECK message To set the check state of a radio button Or check box. 
ProcedureDLL Button_SetCheckbox3State(Gadget.l,State.l)
  Select State
    Case 0
      SendMessage_(GadgetID(Gadget),#BM_SETCHECK,#BST_CHECKED,0)
    Case 1
      SendMessage_(GadgetID(Gadget),#BM_SETCHECK,#BST_INDETERMINATE,0)
    Case 2
      SendMessage_(GadgetID(Gadget),#BM_SETCHECK,#BST_UNCHECKED,0)
    Default
      SendMessage_(GadgetID(Gadget),#BM_SETCHECK,#BST_CHECKED,0)
  EndSelect
  ProcedureReturn 
EndProcedure
; BM_GETCHECK > An application sends a BM_GETCHECK message To retrieve the check state of a radio button Or check box. 
ProcedureDLL Button_GetCheckbox3State(Gadget.l)
  Select SendMessage_(GadgetID(Gadget),#BM_GETCHECK,0,0)
    Case #BST_CHECKED
      State = 0
    Case #BST_INDETERMINATE
      State = 1
    Case #BST_UNCHECKED
      State = 2
    Default
      State = 0
  EndSelect
  ProcedureReturn State
EndProcedure
ProcedureDLL Button_SetInOption(Gadget.l)
  SendMessage_(GadgetID(Gadget),#BM_SETSTYLE,#BS_AUTORADIOBUTTON ,#True)
  ProcedureReturn 
EndProcedure
ProcedureDLL Button_SetInDepthButton(Gadget.l)
  SendMessage_(GadgetID(Gadget),#BM_SETSTYLE,#BS_DEFPUSHBUTTON,#True)
  ProcedureReturn 
EndProcedure
ProcedureDLL Button_SetInFrame3D(Gadget.l)
  SendMessage_(GadgetID(Gadget),#BM_SETSTYLE,#BS_GROUPBOX,#True)
  ProcedureReturn 
EndProcedure
ProcedureDLL Button_SetInOwnerDrawnButton(Gadget.l)
  SendMessage_(GadgetID(Gadget),#BM_SETSTYLE,#BS_OWNERDRAW,#True)
  ProcedureReturn 
EndProcedure

;- Margins
; BCM_SETTEXTMARGIN > The BCM_SETTEXTMARGIN message sets the margins For drawing text in a button control. 
ProcedureDLL Button_SetMargin(Gadget.l, Right.l, Left.l,Top.l,Bottom.l)
  Protected re.RECT
  re\left   = Left
  re\top    = Top
  re\right  = Right
  re\bottom = Bottom
  SendMessage_(GadgetID(Gadget),#BCM_SETTEXTMARGIN,0,re)
  ProcedureReturn 
EndProcedure
; BCM_GETTEXTMARGIN > The BCM_GETTEXTMARGIN message retrieves the margins used To draw text in a button control. 
ProcedureDLL Button_GetMarginLeft(Gadget.l)
  sizet.RECT
  SendMessage_(GadgetID(Gadget),#BCM_GETTEXTMARGIN,0,sizet)
  ProcedureReturn sizet\left
EndProcedure
ProcedureDLL Button_GetMarginRight(Gadget.l)
  sizet.RECT
  SendMessage_(GadgetID(Gadget),#BCM_GETTEXTMARGIN,0,sizet)
  ProcedureReturn sizet\right
EndProcedure
ProcedureDLL Button_GetMarginBottom(Gadget.l)
  sizet.RECT
  SendMessage_(GadgetID(Gadget),#BCM_GETTEXTMARGIN,0,sizet)
  ProcedureReturn sizet\bottom
EndProcedure
ProcedureDLL Button_GetMarginTop(Gadget.l)
  sizet.RECT
  SendMessage_(GadgetID(Gadget),#BCM_GETTEXTMARGIN,0,sizet)
  ProcedureReturn sizet\top
EndProcedure


