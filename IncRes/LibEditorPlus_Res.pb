;- Enumerations
;{
; Enumeration
;   #SH_Text
;   #SH_Constant
;   #SH_Number
;   #SH_String
;   #SH_Symbol
;   #SH_Operator
;   #SH_Bracket
;   #SH_Comment
;   #SH_xML_Comment
;   #SH_xML_Tag
;   #SH_xML_Option
;   #SH_xML_String
;   #SH_xML_Number
;   #SH_Keyword
; EndEnumeration
Enumeration
  #Editor_SH_Property_Text
  #Editor_SH_Property_Keyword
  #Editor_SH_Property_Integer
  #Editor_SH_Property_String
  #Editor_SH_Property_Comment
  #Editor_SH_Property_Constant
  #Editor_SH_Property_Symbols
  #Editor_SH_Property_Operators
  #Editor_SH_Property_Brackets
  #Editor_SH_Property_XML_CommentOpen
  #Editor_SH_Property_XML_CommentClose
  #Editor_SH_Property_XML_TagOpen
  #Editor_SH_Property_XML_TagClose
  #Editor_SH_Property_XML_Close
EndEnumeration
;}
;- Constantes
;{
#EM_ISIME				        = #WM_USER + 243
#EM_GETIMEPROPERTY		  = #WM_USER + 244
#EM_GETTEXTMODE			    = #WM_USER + 90
#EM_SETUNDOLIMIT			  = #WM_USER + 82


#CFM_LINK		            = $20
#CFM_SMALLCAPS          = $40
#CFM_ALLCAPS	          = $80
#CFM_HIDDEN		          = $100
#CFM_OUTLINE	          = $200
#CFM_SHADOW		          = $400
#CFM_EMBOSS	            = $800
#CFM_IMPRINT	          = $1000
#CFM_DISABLED	          = $2000
#CFM_REVISED	          = $4000
#CFM_BACKCOLOR		      = $4000000



#CFE_DISABLED           = $2000
#CFE_LINK		            = $20
#CFE_SMALLCAPS		      = #CFM_SMALLCAPS
#CFE_ALLCAPS			      = #CFM_ALLCAPS
#CFE_HIDDEN				      = #CFM_HIDDEN
#CFE_OUTLINE			      = #CFM_OUTLINE
#CFE_SHADOW			        = #CFM_SHADOW
#CFE_EMBOSS			        = #CFM_EMBOSS
#CFE_IMPRINT			      = #CFM_IMPRINT
#CFE_DISABLED			      = #CFM_DISABLED
#CFE_REVISED			      = #CFM_REVISED
#CFE_AUTOBACKCOLOR	    = #CFM_BACKCOLOR

; #EM_GETEDITSTYLE // #EM_SETEDITSTYLE
#SES_EMULATESYSEDIT     = 1
#SES_BEEPONMAXTEXT		  = 2
#SES_EXTENDBACKCOLOR		= 4
#SES_MAPCPS				      = 8
#SES_EMULATE10			    = 16
#SES_USECRLF				    = 32
#SES_USEAIMM				    = 64
#SES_NOIME				      = 128
#SES_ALLOWBEEPS			    = 256
#SES_UPPERCASE			    = 512
#SES_LOWERCASE			    = 1024
#SES_NOINPUTSEQUENCECHK	= 2048
#SES_BIDI				        = 4096
#SES_SCROLLONKILLFOCUS	= 8192
#SES_XLTCRCRLFTOCR		  = 16384
#SES_DRAFTMODE			    = 32768
#SES_USECTF				      = $10000
#SES_HIDEGRIDLINES		  = $20000
#SES_USEATFONT			    = $40000
#SES_CUSTOMLOOK			    = $80000
#SES_LBSCROLLNOTIFY		  = $100000
#SES_CTFALLOWEMBED		  = $200000
#SES_CTFALLOWSMARTTAG	  = $400000
#SES_CTFALLOWPROOFING	  = $800000


; #IMEGETCOMPMODE
#ICM_NOTOPEN            = $0
#ICM_LEVEL3             = $1
#ICM_LEVEL2             = $2
#ICM_LEVEL2_5           = $3
#ICM_LEVEL2_SUI			    = $4
#ICM_CTF	              = $5

; #IMEGETLANGOPTIONS
#IMF_AUTOKEYBOARD       = $1
#IMF_AUTOFONT           = $2
#IMF_IMECANCELCOMPLETE  = $4
#IMF_IMEALWAYSSENDNOTIFY= $8
#IMF_AUTOFONTSIZEADJUST = $10
#IMF_UIFONTS			      = $20
#IMF_DUALFONT		        = $80

; #EM_GETTEXTEX
#GT_DEFAULT             = 0
#GT_USECRLF             = 1
#GT_SELECTION           = 2
#GT_RAWTEXT             = 4
#GT_NOHIDDENTEXT        = 8

; #EM_GETTEXTLENGTHEX
#GTL_DEFAULT            = 0
#GTL_USECRLF            = 1
#GTL_PRECISE            = 2
#GTL_CLOSE              = 4
#GTL_NUMCHARS           = 8
#GTL_NUMBYTES           = 16

; #EM_SETTYPOGRAPHYOPTIONS
#TO_ADVANCEDTYPOGRAPHY	= 1
#TO_SIMPLELINEBREAK		  = 2

#PFM_SPACEBEFORE        = $40
#PFM_SPACEAFTER         = $80
#PFM_LINESPACING        = $100
#PFM_STYLE              = $400
#PFM_BORDER             = $800
#PFM_SHADING            = $1000
#PFM_NUMBERINGSTYLE     = $2000
#PFM_NUMBERINGTAB       = $4000
#PFM_NUMBERINGSTART     = $8000
#PFM_RTLPARA            = $10000
#PFM_KEEP               = $20000
#PFM_KEEPNEXT           = $40000
#PFM_PAGEBREAKBEFORE    = $80000
#PFM_NOLINENUMBER       = $100000
#PFM_NOWIDOWCONTROL     = $200000
#PFM_DONOTHYPHEN	      = $400000
#PFM_SIDEBYSIDE	        = $800000
#PFM_COLLAPSED          = $1000000
#PFM_OUTLINELEVEL       = $2000000
#PFM_BOX					      = $4000000
#PFM_RESERVED2	  		  = $8000000
#PFM_TABLE		          = $40000000
#PFM_TEXTWRAPPINGBREAK  = $20000000
#PFM_TABLEROWDELIMITER  = $10000000

#CFM_UNDERLINETYPE	          = $800000			 
#CFU_CF1UNDERLINE             = $FF
#CFU_INVERT			              = $FE
#CFU_UNDERLINETHICKLONGDASH	  =	18
#CFU_UNDERLINETHICKDOTTED		  = 17
#CFU_UNDERLINETHICKDASHDOTDOT	= 16
#CFU_UNDERLINETHICKDASHDOT		= 15
#CFU_UNDERLINETHICKDASH			  = 14
#CFU_UNDERLINELONGDASH			  = 13
#CFU_UNDERLINEHEAVYWAVE			  = 12
#CFU_UNDERLINEDOUBLEWAVE			= 11
#CFU_UNDERLINEHAIRLINE			  = 10
#CFU_UNDERLINETHICK				    = 9
#CFU_UNDERLINEWAVE				    = 8
#CFU_UNDERLINEDASHDOTDOT			= 7
#CFU_UNDERLINEDASHDOT			    = 6
#CFU_UNDERLINEDASH				    = 5
#CFU_UNDERLINEDOTTED				  = 4
#CFU_UNDERLINEDOUBLE				  = 3
#CFU_UNDERLINEWORD				    = 2
#CFU_UNDERLINE					      = 1
#CFU_UNDERLINENONE				    = 0

; Structure BIDIOPTIONS
#BOM_DEFPARADIR			    = 1	  ; Default paragraph direction (implies alignment) (obsolete) 
#BOM_PLAINTEXT			    = 2	  ; Use plain text layout (obsolete) 
#BOM_NEUTRALOVERRIDE		= 4	  ; Override neutral layout (obsolete) 
#BOM_CONTEXTREADING		  = 8	  ; Context reading order 
#BOM_CONTEXTALIGNMENT	  = 16	; Context alignment 

#BOE_RTLDIR				      = 1	  ; Default paragraph direction (implies alignment) (obsolete) 
#BOE_PLAINTEXT			    = 2	  ; Use plain text layout (obsolete) 
#BOE_NEUTRALOVERRIDE		= 4	  ; Override neutral layout (obsolete) 
#BOE_CONTEXTREADING		  = 8	  ; Context reading order 
#BOE_CONTEXTALIGNMENT	  = 16	; Context alignment 

; Flags for the SETEXTEX data structure 
#ST_DEFAULT             = 0
#ST_KEEPUNDO            = 1
#ST_SELECTION           = 2
#ST_NEWCHARS            = 4

; PARAFORMAT alignment options 
#PFA_LEFT			          = 1
#PFA_RIGHT			        = 2
#PFA_CENTER			        = 3
#PFA_JUSTIFY			      = 4
#PFA_FULL_INTERWORD	    = 4
#PFA_FULL_INTERLETTER   = 5
#PFA_FULL_SCALED		    = 6
#PFA_FULL_GLYPHS		    = 7
#PFA_SNAP_GRID		      = 8


; Notifications
#EN_LINK					      = $70b

; Notifications messages
#ENM_LINK               = $4000000

; East Asia specific flags 
#IMF_FORCENONE          = $1
#IMF_FORCEENABLE        = $2
#IMF_FORCEDISABLE       = $4
#IMF_CLOSESTATUSWINDOW  = $8
#IMF_VERTICAL           = $20
#IMF_FORCEACTIVE        = $40
#IMF_FORCEINACTIVE      = $80
#IMF_FORCEREMEMBER      = $100
#IMF_MULTIPLEEDIT       = $400




;}
;- Structures
;{
  Structure LN
    Editor_Ed.l
    Container.l
    Editor_Ln.l
  EndStructure
  Structure S_RLibPlus_Editor
    ErrorBuf.c ; Pour Eviter les erreurs de buffer
  	Gadget.l
  	Language.l
  	Text.s
  EndStructure
  Structure S_RLibPlus_Editor_Format
    FontName.s
    FontSize.l
    FontStyle.l
    BackColor.l
    FrontColor.l
  EndStructure
  Structure S_RLibPlus_EditorLng
  	Name.s
  	MarkupLng.b
  
    StringChr.s
    CommentChr.s
    ConstantChr.s
    SymbolChr.s
    OperatorChr.s
    BracketChr.s
    XML_CommentOpenChr.s  
    XML_CommentCloseChr.s  
    XML_TagOpenChr.s
    XML_TagCloseChr.s
    XML_CloseChr.s
    
    TextFormat.S_RLibPlus_Editor_Format
    IntegerFormat.S_RLibPlus_Editor_Format
    KeywordFormat.S_RLibPlus_Editor_Format
    StringFormat.S_RLibPlus_Editor_Format
    CommentFormat.S_RLibPlus_Editor_Format
    ConstantFormat.S_RLibPlus_Editor_Format
    SymbolFormat.S_RLibPlus_Editor_Format
    OperatorFormat.S_RLibPlus_Editor_Format
    BracketFormat.S_RLibPlus_Editor_Format
    XML_CommentOpenFormat.S_RLibPlus_Editor_Format  
    XML_CommentCloseFormat.S_RLibPlus_Editor_Format  
    XML_TagOpenFormat.S_RLibPlus_Editor_Format
    XML_TagCloseFormat.S_RLibPlus_Editor_Format
    XML_CloseFormat.S_RLibPlus_Editor_Format  
  
    TextActive.b
    KeywordActive.b
    IntegerActive.b
    StringActive.b
    CommentActive.b
    ConstantActive.b
    SymbolActive.b
    OperatorActive.b
    BracketActive.b
    XML_CommentOpenActive.b 
    XML_CommentCloseActive.b
    XML_TagOpenActive.b
    XML_TagCloseActive.b
    XML_CloseActive.b
    
    
    KeywordsList.s
  EndStructure

;}


;- Macros 
Macro Common_IsNumber(c)
  (((c >= '0') And (c <= '9')) Or (c='.') Or (c='-'))
EndMacro
Macro Common_IsInteger(c)
  ((c >= "0") And (c <= "9"))
EndMacro
Macro RLIBPLUS_EDLng_ID(object)
  Object_GetObject(RLibPlusEditorLngObjects, object)
EndMacro
Macro RLIBPLUS_EDLng_IS(object)
  Object_IsObject(RLibPlusEditorLngObjects, object) 
EndMacro
Macro RLIBPLUS_EDLng_NEW(object)
  Object_GetOrAllocateID(RLibPlusEditorLngObjects, object)
EndMacro
Macro RLIBPLUS_EDLng_FREEID(object)
  If object <> #PB_Any And RLIBPLUS_EDLng_IS(object) = #True
    Object_FreeID(RLibPlusEditorLngObjects, object)
  EndIf
EndMacro
Macro RLIBPLUS_EDLng_INITIALIZE(hCloseFunction)
  Object_Init(SizeOf(S_RLibPlus_EditorLng), 1, hCloseFunction)
EndMacro
Macro RLIBPLUS_ED_ID(object)
  Object_GetObject(RLibPlusEditorObjects, object)
EndMacro
Macro RLIBPLUS_ED_IS(object)
  Object_IsObject(RLibPlusEditorObjects, object) 
EndMacro
Macro RLIBPLUS_ED_NEW(object)
  Object_GetOrAllocateID(RLibPlusEditorObjects, object)
EndMacro
Macro RLIBPLUS_ED_FREEID(object)
  If object <> #PB_Any And RLIBPLUS_ED_IS(object) = #True
    Object_FreeID(RLibPlusEditorObjects, object)
  EndIf
EndMacro
Macro RLIBPLUS_ED_INITIALIZE(hCloseFunction)
  Object_Init(SizeOf(S_RLibPlus_Editor), 1, hCloseFunction)
EndMacro

Macro RLibPlus_Editor_SH_SetFormat(Item)
  format.CHARFORMAT2
  ;With 
    format\cbSize          = SizeOf(CHARFORMAT2)
    format\dwMask          = #CFM_COLOR|#CFM_BACKCOLOR|#CFM_FACE|#CFM_SIZE|#CFM_ITALIC|#CFM_BOLD|#CFM_STRIKEOUT|#CFM_UNDERLINE|#CFM_LINK
    format\dwEffects       | *RLng\Item\FontStyle
    format\yHeight         = *RLng\Item\FontSize * 20
    format\crTextColor     = *RLng\Item\FrontColor
    PokeS(@format\szFaceName, *RLng\Item\FontName)
    format\crBackColor     = *RLng\Item\BackColor
  ;EndWith
EndMacro
Macro RLibPlus_Editor_SH_ApplyFormat()
  ;{ On applique le formatage à la sélection
    SendMessage_(GadgetID(Gadget), #EM_SETCHARFORMAT, #SCF_SELECTION,@format)
  ;}
EndMacro
Macro RLibPlus_Editor_IsDigit(c)
  ((c >= '0') And (c <= '9'))
EndMacro 


; IDE Options = PureBasic 4.20 (Windows - x86)
; CursorPosition = 2
; Folding = AAAg
; EnableXP