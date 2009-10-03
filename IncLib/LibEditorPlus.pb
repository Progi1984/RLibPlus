;-Thanks
; Sparkie : code initial > Numérotation des Lignes
; Nico & LSI : Editor_RTF_GetRTFCode (PB V3.93, le 19/05/05)
; Who???? : Macro IsAscii / IsNumeric / IsDigit

XIncludeFile "../RLibPlus.pb"
; Global NewList LNumber.LN()
; 
; ; Coloration Syntaxique
; Structure SH_Gadget
;   Gadget.l
;   Language.l
;   State.l
;   Text.s
; EndStructure
; Structure SH_Language
;   Name.s
;   Balise.l
;   Constant.s
;   Comment0.s                ; xML => CommentOpen
;   Comment1.s                ; xML => CommentClose
;   Comment2.s                ; xML => TagOpen
;   String.s                  ; xML => String
;   Symbols.s                 ; xML => Close
;   Operators.s               ; xML => TagClose
;   Brackets.s
;   NbKeywords.l
; EndStructure
; Structure SH_Format
;   IdLangage.l
;   IdProperty.l
;   Font.s
;   FontSize.l
;   FontFlags.l
;   FontColor.l
;   BgColor.l
;   State.l
; EndStructure
; Structure SH_Keyword
;   IdLangage.l
;   IdKeyword.l
;   Keywords.s
; EndStructure
; Structure SH_xML_Keyword Extends SH_Keyword
;   Keywords_Options.s
; EndStructure
; Global NewList SH.SH_Language()
; Global NewList SHFormat.SH_Format()
; Global NewList SHKeyword.SH_Keyword()
; Global NewList SHxMLKeyword.SH_xML_Keyword()
; Global NewList SHGadget.SH_Gadget()


Procedure RLibPlusEditorLngFree(Id.l)
  Global RLibPlusEditorLngObjects
  RLIBPLUS_EDLng_FREEID(Id)
  ProcedureReturn #True
EndProcedure
Procedure RLibPlusEditorFree(Id.l)
  Global RLibPlusEditorObjects 
  RLIBPLUS_ED_FREEID(Id)
  ProcedureReturn #True
EndProcedure
ProcedureDLL RLibPlus_Editor_Init()
  Global RLibPlusEditorObjects 
  RLibPlusEditorObjects = RLIBPLUS_ED_INITIALIZE(@RLibPlusEditorFree()) 
  
  Global RLibPlusEditorLngObjects 
  RLibPlusEditorLngObjects = RLIBPLUS_EDLng_INITIALIZE(@RLibPlusEditorLngFree()) 
  
  Global NewList LNumber.LN()
EndProcedure
ProcedureDLL.s RLibPlus_Editor_Version()
  ProcedureReturn "0.4 Beta"
EndProcedure

;- OK Fonctions Communes
;{
Procedure Common_ExistFile(name.s,directory.s)
  Protected dir
  dir=ExamineDirectory(#PB_Any,directory,"*.*")
  If dir
    While NextDirectoryEntry(dir)
      If DirectoryEntryType(dir) = #PB_DirectoryEntry_File
        If DirectoryEntryName(0)=name
          ProcedureReturn 1
        EndIf
      EndIf
    Wend
    FinishDirectory(dir)
  EndIf
  ProcedureReturn 0
EndProcedure
Procedure.l Common_IsNumeric(String.s)
  Protected Numeric.l, *String.Character
  If String
    String = Trim(String)
    Numeric = #True
    *String = @String
    While Numeric And *String\c
      Numeric = Common_IsNumber(*String\c)
      *String + SizeOf(Character)
    Wend
    If Len(String) = 1
      If String = "-" Or String = "."
        ProcedureReturn #False
      EndIf
    EndIf
  EndIf
  ProcedureReturn Numeric
EndProcedure
Procedure.l Stream_FileOutCallback(dwCookie, pbBuff, cb, pcb)
  Protected result, length
  result=0
  WriteData(dwCookie, pbBuff, cb)
  PokeL(pcb, cb)
  If cb = 0
    result = 1
  EndIf
  ProcedureReturn result
EndProcedure
Procedure.l Stream_FileInCallback(dwCookie, pbBuff, cb, pcb)
;The following is called repeatedly by Windows to stream data into an editor gadget from an external file.
  Protected result, length
  result=0
  length=ReadData(dwCookie, pbBuff, cb)
  PokeL(pcb, length)
  If length = 0
    result = 1
  EndIf
  ProcedureReturn result
EndProcedure
;}
;- OK Barre de Scrolling
;{
ProcedureDLL Editor_Up(Gadget.l)
    SendMessage_(GadgetID(Gadget),#EM_LINESCROLL,0,-1) 
EndProcedure
ProcedureDLL Editor_Down(Gadget.l)
    SendMessage_(GadgetID(Gadget),#EM_LINESCROLL,0,1) 
EndProcedure
ProcedureDLL Editor_GetScrollBarX(Gadget.l)
  SendMessage_(GadgetID(Gadget), #EM_GETSCROLLPOS, 0, @scrollP.POINT)
  ProcedureReturn scrollP\x
EndProcedure
ProcedureDLL Editor_GetScrollBarY(Gadget.l)
  SendMessage_(GadgetID(Gadget), #EM_GETSCROLLPOS, 0, @scrollP.POINT)
  ProcedureReturn scrollP\y
EndProcedure
ProcedureDLL Editor_SetScrollBar(Gadget.l, ScrollbarX.l, ScrollbarY.l)
  scrollP.point
  scrollP\x = ScrollbarX
  scrollP\y = ScrollbarY
  SendMessage_(GadgetID(Gadget), #EM_SETSCROLLPOS, 0, @scrollP)
  ProcedureReturn 
EndProcedure
ProcedureDLL Editor_SetHScrollBarVisible(Gadget.l, Activate.l)
  SendMessage_(GadgetID(Gadget),#EM_SHOWSCROLLBAR,#SB_HORZ,Activate)
  ProcedureReturn 
EndProcedure
ProcedureDLL Editor_SetVScrollBarVisible(Gadget.l, Activate.l)
  SendMessage_(GadgetID(Gadget),#EM_SHOWSCROLLBAR,#SB_VERT,Activate)
  ProcedureReturn 
EndProcedure
;}
;- OK Edition
;{
ProcedureDLL Editor_Copy(Gadget.l)
  SendMessage_(GadgetID(gadget), #WM_COPY,0,0)
EndProcedure
ProcedureDLL Editor_CanPaste(Gadget.l, Format.l)
; ms-help://MS.PSDK.1033/shellcc/platform/commctls/richedit/richeditcontrols/richeditcontrolreference/richeditmessages/em_canpaste.htm
; CF_BITMAP A handle To a bitmap (HBITMAP). 
; CF_DIB A memory object containing a BITMAPINFO Structure followed by the bitmap bits. 
; CF_DIBV5 Windows 2000/XP: A memory object containing a BITMAPV5HEADER Structure followed by the bitmap color space information And the bitmap bits. 
; CF_DIF Software Arts' Data Interchange Format. 
; CF_DSPBITMAP Bitmap display format associated With a private format. The hMem parameter must be a handle To Data that can be displayed IN bitmap format IN lieu of the privately formatted Data. 
; CF_DSPENHMETAFILE Enhanced metafile display format associated With a private format. The hMem parameter must be a handle To Data that can be displayed IN enhanced metafile format IN lieu of the privately formatted Data. 
; CF_DSPMETAFILEPICT Metafile-picture display format associated With a private format. The hMem parameter must be a handle To Data that can be displayed IN metafile-picture format IN lieu of the privately formatted Data. 
; CF_DSPTEXT Text display format associated With a private format. The hMem parameter must be a handle To Data that can be displayed IN text format IN lieu of the privately formatted Data. 
; CF_ENHMETAFILE A handle To an enhanced metafile (HENHMETAFILE). 
; CF_GDIOBJFIRST through CF_GDIOBJLAST Range of integer values For application-defined Microsoft® Windows® Graphics Device Interface (GDI) object clipboard formats. Handles associated With clipboard formats IN this range are Not automatically deleted using the GlobalFree function when the clipboard is emptied. Also, when using values IN this range, the hMem parameter is Not a handle To a GDI object, but is a handle allocated by the GlobalAlloc function With the GMEM_MOVEABLE flag. 
; CF_HDROP A handle To type HDROP that identifies a list of files. An application can retrieve information about the files by passing the handle To the DragQueryFile functions. 
; CF_LOCALE The Data is a handle To the locale identifier associated With text IN the clipboard. When you close the clipboard, If it contains CF_TEXT Data but no CF_LOCALE Data, the system automatically SETS the CF_LOCALE format To the current input language. You can use the CF_LOCALE format To associate a different locale With the clipboard text. 
; CF_METAFILEPICT Handle To a metafile picture format As defined by the METAFILEPICT Structure. When passing a CF_METAFILEPICT handle by means of Dynamic Data Exchange (DDE), the application responsible For deleting hMem should also free the metafile referred To by the CF_METAFILEPICT handle. 
; CF_OEMTEXT Text format containing characters IN the OEM character set. Each line ends With a carriage Return/linefeed (CR-LF) combination. A null character signals the End of the Data. 
; CF_OWNERDISPLAY Owner-display format. The clipboard owner must display And update the clipboard viewer window, And receive the WM_ASKCBFORMATNAME, WM_HSCROLLCLIPBOARD, WM_PAINTCLIPBOARD, WM_SIZECLIPBOARD, And WM_VSCROLLCLIPBOARD messages. The hMem parameter must be NULL. 
; CF_PALETTE Handle To a color palette. Whenever an application places Data IN the clipboard that depends on Or assumes a color palette, it should place the palette on the clipboard As well. 
; CF_PENDATA Data For the pen extensions To the Microsoft® Windows® For Pen Computing. 
; CF_PRIVATEFIRST through CF_PRIVATELAST Range of integer values For private clipboard formats. Handles associated With private clipboard formats are Not freed automatically; the clipboard owner must free such handles, typically in response to the WM_DESTROYCLIPBOARD message. 
; CF_RIFF Represents audio Data more complex than can be represented IN a CF_WAVE standard wave format. 
; CF_SYLK Microsoft Symbolic Link (SYLK) format. 
; CF_TEXT Text format. Each line ends With a carriage Return/linefeed (CR-LF) combination. A null character signals the End of the Data. Use this format For ANSI text. 
; CF_WAVE Represents audio Data IN one of the standard wave formats, such As 11 kHz Or 22 kHz Pulse Code Modulation (PCM). 
; CF_TIFF Tagged-image file format. 
; CF_UNICODETEXT Windows NT/2000/XP: Unicode text format. Each line ends With a carriage Return/linefeed (CR-LF) combination. A null character signals the End of the Data. 
  ProcedureReturn SendMessage_(GadgetID(Gadget),#EM_CANPASTE, Format,0)
EndProcedure
ProcedureDLL Editor_Paste(Gadget.l) 
  SendMessage_(GadgetID(gadget), #WM_PASTE,0,0)
EndProcedure 
ProcedureDLL Editor_Cut(Gadget.l)
  SendMessage_(GadgetID(gadget), #WM_CUT,0,0)  
EndProcedure
ProcedureDLL Editor_Insert(Gadget.l,Text.s)
  ProcedureReturn SendMessage_(GadgetID(gadget),#EM_REPLACESEL,0,Text)
EndProcedure
ProcedureDLL Editor_Delete(Gadget.l)
  SendMessage_(GadgetID(Gadget), #EM_REPLACESEL, #True, 0)
EndProcedure
ProcedureDLL Editor_Undo(Gadget.l)

  SendMessage_(GadgetID(Gadget), #EM_UNDO, 0, 0)
EndProcedure
ProcedureDLL Editor_Redo(Gadget.l)
  SendMessage_(GadgetID(Gadget), #EM_REDO, 0, 0)
EndProcedure
;{ Editor_CanUndo
; Retourne :
; 1 : oui
; 0 : non
;}
ProcedureDLL Editor_CanUndo(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget), #EM_CANUNDO, 0, 0)
EndProcedure
;{ Editor_CanRedo
; Retourne :
; 1 : oui
; 0 : non
;}
ProcedureDLL Editor_CanRedo(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget), #EM_CANREDO, 0, 0)
EndProcedure
;{  Editor_GetType*
; UID_UNKNOWN   = 0
; UID_TYPING    = 1
; UID_DELETE    = 2
; UID_DRAGDROP  = 3
; UID_CUT       = 4
; UID_PASTE     = 5
;}
ProcedureDLL Editor_GetTypeUndo(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget), #EM_GETUNDONAME, 0, 0)
EndProcedure
ProcedureDLL Editor_GetTypeRedo(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget), #EM_GETREDONAME, 0, 0)
EndProcedure
ProcedureDLL Editor_Print(Gadget.l,NameDocument.s,InchMode.l,MarginRight.f,MarginLeft.f,MarginTop.f,MarginBottom.f) 
  Protected DC 
  If InchMode=#False
    MarginRight   = MarginRight   / 25.4
    MarginLeft    = MarginLeft    / 25.4
    MarginTop     = MarginTop     / 25.4
    MarginBottom  = MarginBottom  / 25.4
  EndIf          
  lppd.PRINTDLG
  lppd\lStructsize=SizeOf(PRINTDLG) 
  lppd\Flags=#PD_ALLPAGES| #PD_HIDEPRINTTOFILE | #PD_NOSELECTION | #PD_RETURNDC 
  PrintDlg_(lppd) 
    
  DC=lppd\hDC 
  cRect.RECT 
  FormatRange.FORMATRANGE 

  Docinfo.Docinfo 
  DocInfo\cbSize = SizeOf(Docinfo) 
  DocInfo\lpszDocName = @NameDocument 
  DocInfo\lpszOutput = #Null 
    
    StartDoc_(DC,Docinfo) 
    LastChar = 0 
    MaxLen = Len(GetGadgetText(Gadget)) 
    MaxLen - SendMessage_(GadgetID(Gadget),#EM_GETLINECOUNT,0,0) 
    OldMapMode = GetMapMode_(DC) 
    SetMapMode_(DC,#MM_TWIPS) 
    OffsetX = GetDeviceCaps_(DC,#PHYSICALOFFSETX) 
    OffsetY = -GetDeviceCaps_(DC,#PHYSICALOFFSETY) 
    HorzRes = GetDeviceCaps_(DC,#HORZRES) 
    VertRes = -GetDeviceCaps_(DC,#VERTRES) 
    SetRect_(cRect,OffsetX,OffsetY,HorzRes,VertRes) 
    DPtoLP_(DC,cRect,2) 
    SetMapMode_(DC,OldMapMode) 
    
    iWidthTwips = Int((GetDeviceCaps_(DC, #HORZRES)/GetDeviceCaps_(DC, #LOGPIXELSX))*1440) 
    iHeightTwips = Int((GetDeviceCaps_(DC, #VERTRES )/GetDeviceCaps_(DC, #LOGPIXELSY))*1440) 

    FormatRange\hdc = DC 
    FormatRange\hdcTarget = DC 
    FormatRange\rc\left       = MarginLeft *1440;cRect\left
    FormatRange\rc\top        = MarginTop *1440;
    FormatRange\rc\right      = iWidthTwips - MarginRight*1440 ;cRect\Right
    ;iWidthTwips - MarginRight*144 ;
    FormatRange\rc\bottom     = iHeightTwips - MarginBottom*1440;cRect\Bottom
    FormatRange\rcPage\left   = MarginLeft *1440;cRect\left
    FormatRange\rcPage\top    = MarginTop *1440;cRect\Top
    FormatRange\rcPage\right  = iWidthTwips - MarginRight*1440 ;cRect\Right
    FormatRange\rcPage\bottom = iHeightTwips - MarginBottom*1440;cRect\Bottom
    a = 1 
    Repeat 
        StartPage_(DC) 
        FormatRange\chrg\cpMax = -1 
        LastChar = SendMessage_(GadgetID(Gadget),#EM_FORMATRANGE,#True,@FormatRange) 
        FormatRange\chrg\cpMin = LastChar 
        SendMessage_(GadgetID(Gadget),#EM_DISPLAYBAND,0,cRect) 
        a + 1 
        EndPage_(DC) 
    Until LastChar >= MaxLen Or LastChar = -1 
    EndDoc_(DC) 
    SendMessage_(GadgetID(Gadget),#EM_FORMATRANGE,0,0) 
EndProcedure
;{ Editor_SetZoom
;  1/64 < Numerator/Denominator < 64
;}
ProcedureDLL Editor_SetZoom(Gadget.l,Numerator.l ,Denominator.l)
  lRet=SendMessage_(GadgetID(Gadget),#EM_SETZOOM,Numerator ,Denominator) 
  ProcedureReturn lRet
EndProcedure
ProcedureDLL Editor_GetZoomDenominator(Gadget.l)
  lRet=SendMessage_(GadgetID(Gadget),#EM_GETZOOM,@Numerator ,@Denominator )
  ProcedureReturn Denominator 
EndProcedure
ProcedureDLL Editor_GetZoomNumerator(Gadget.l)
  lRet=SendMessage_(GadgetID(Gadget),#EM_GETZOOM,@Numerator ,@Denominator )
  ProcedureReturn Numerator 
EndProcedure
ProcedureDLL.f Editor_GetZoomCurrent(Gadget.l)
  lRet=SendMessage_(GadgetID(Gadget),#EM_GETZOOM,@Numerator ,@Denominator )
  zoom.f=Numerator/Denominator
  ProcedureReturn zoom 
EndProcedure
ProcedureDLL Editor_Find(Gadget.l,Position.l,Text.s,HighLight.l,Flags.l)
; FLAGS :
;   FR_DOWN : si activé de la sélection au bas du document
;             si non activé de la sélection au haut du document
;   FR_MATCHCASE : si activé, sensitif à la casse
;   FR_WHOLEWORD : si activé, mots entiers seulement
  finder.FINDTEXTEX
  finder\chrg\cpMin = Position
  finder\chrg\cpMax = -1
  finder\lpstrText = @Text     
  position=SendMessage_(GadgetID(Gadget),#EM_FINDTEXTEX,Flags,finder)
  If HighLight=#True
    SendMessage_(GadgetID(Gadget),#EM_EXSETSEL, 0, finder\chrgText)
  EndIf
  If position=-1
    ProcedureReturn -1
  Else
    ProcedureReturn finder\chrgText\cpMax
  EndIf
EndProcedure
;}
;- OK Curseur
;{
ProcedureDLL Editor_GetCursorX(Gadget.l) 
      s.CHARRANGE
      SendMessage_(GadgetID(gadget),#EM_EXGETSEL,0,@s)
      p = s\cpMin
      ; the 'character index' of the first character of this line is at
      l = SendMessage_(GadgetID(gadget),#EM_LINEINDEX,-1,0)
      ; retrieve char index from caret so the x coordinate should be
      x = p-l
      ProcedureReturn x
EndProcedure 
ProcedureDLL Editor_GetCursorY(Gadget.l) 
    ;Première version du code
    ;GetCaretPos_(@p.POINT)   ;Get current cursor position in the client area
    ;chrIdx=SendMessage_(GadgetID(Gadget), #EM_CHARFROMPOS, 0, @p)  ;Get character index on cursor position
    ;ProcedureReturn SendMessage_(GadgetID(Gadget), #EM_LINEFROMCHAR, chrIdx, 0)
    ProcedureReturn SendMessage_(GadgetID(Gadget), #EM_EXLINEFROMCHAR, 0, -1)
EndProcedure 
ProcedureDLL Editor_GetCursorPos(Gadget.l) 
      s.CHARRANGE
      SendMessage_(GadgetID(Gadget),#EM_EXGETSEL,0,@s)
      p = s\cpMin
  ProcedureReturn p
EndProcedure 
ProcedureDLL Editor_SetCursorPos(Gadget.l,Position.l)
  newpos.CHARRANGE
  newpos\cpMin=Position
  newpos\cpMax=Position
  SendMessage_(GadgetID(Gadget),#EM_EXSETSEL,0,@newpos)
EndProcedure
;}
;- OK Fichiers
;{
ProcedureDLL.l Editor_LoadText(Gadget.l,Filename.s) 
    file_editor=ReadFile(#PB_Any, filename.s) 
    If file_editor
      While Eof(file_editor)=0 
        OFText$ = OFText$+ReadString(file_editor)+Chr(13)+ Chr(10) 
      Wend 
      CloseFile(file_editor) 
      SetGadgetText(Gadget, OFText$)
      ProcedureReturn 0
    Else 
      ProcedureReturn 1
    EndIf 
EndProcedure 
ProcedureDLL.l Editor_SaveText(Gadget.l,Filename.s)
  Protected file_editor
  Protected SFText.s
    
  If Common_ExistFile(GetFilePart(Filename),GetPathPart(Filename))=1
    If DeleteFile(filename$)=0   
      ProcedureReturn 1
    EndIf
  EndIf
  file_editor=CreateFile(#PB_Any,Filename)
  If file_editor
    SFText=GetGadgetText(gadget)
    WriteStringN(file_editor,SFText)
    CloseFile(file_editor)
    ProcedureReturn 0
  EndIf
EndProcedure
ProcedureDLL.l Editor_LoadRTF(Gadget.l, Filename.s, Replaceall.l=0)
  Protected edstr.EDITSTREAM
  edstr\dwCookie = ReadFile(#PB_Any, filename)
  If edstr\dwCookie
    edstr\dwError = 0
    edstr\pfnCallback = @Stream_FileInCallback()
    SendMessage_(GadgetID(gadget), #EM_STREAMIN, #SF_RTF|replaceall, edstr)
    CloseFile(edstr\dwCookie)
    ProcedureReturn edstr\dwError
  Else
    ProcedureReturn 1
  EndIf
EndProcedure
;{ Editor_SaveRTF(
; The following procedure saves the rtf content of an editor gadget to an external file.
; Returns zero if no error encountered.
;}
ProcedureDLL.l Editor_SaveRTF(Gadget.l, Filename.s)
  Protected edstr.EDITSTREAM
  edstr\dwCookie = CreateFile(#PB_Any, filename)
  If edstr\dwCookie
    edstr\dwError = 0
    edstr\pfnCallback = @Stream_FileOutCallback()
    SendMessage_(GadgetID(gadget), #EM_STREAMOUT, #SF_RTF, edstr)
    CloseFile(edstr\dwCookie)
    ProcedureReturn edstr\dwError
  Else
    ProcedureReturn 1
  EndIf
EndProcedure
;}
;- OK Sélection
;{
ProcedureDLL Editor_Locate(Gadget.l, Line.l ,Char.l)
  ; Set cursor position 
  REG = GadgetID(Gadget) 
  CharIdx = SendMessage_(REG,#EM_LINEINDEX,Char,0) 
  LLength = SendMessage_(REG,#EM_LINELENGTH,CharIdx,0) 
  If LLength >= Line-1 
    CharIdx + Line-1 
  EndIf 
  Range.CHARRANGE 
  Range\cpMin = CharIdx 
  Range\cpMax = CharIdx 
  SendMessage_(REG,#EM_EXSETSEL,0,Range) 
EndProcedure 

ProcedureDLL Editor_Select(Gadget.l, LineStart.l, CharStart.l, LineEnd.l, CharEnd.l)
  ;{ Editor_Select
  ; Line numbers range from 0 To CountGadgetItems(#Gadget)-1
  ; Char numbers range from 1 to the length of a line
  ; Set Line numbers to -1 to indicate the last line, and Char
  ; numbers to -1 to indicate the end of a line
  ; selecting from 0,1 to -1, -1 selects all.
  ;}
  sel.CHARRANGE
  sel\cpMin = SendMessage_(GadgetID(Gadget), #EM_LINEINDEX, LineStart, 0) + CharStart - 1
 
  If LineEnd = -1
    LineEnd = SendMessage_(GadgetID(Gadget), #EM_GETLINECOUNT, 0, 0)-1
  EndIf
  sel\cpMax = SendMessage_(GadgetID(Gadget), #EM_LINEINDEX, LineEnd, 0)
 
  If CharEnd = -1
    sel\cpMax + SendMessage_(GadgetID(Gadget), #EM_LINELENGTH, sel\cpMax, 0)
  Else
    sel\cpMax + CharEnd - 1
  EndIf
  SendMessage_(GadgetID(Gadget), #EM_EXSETSEL, 0, @sel)
EndProcedure 
ProcedureDLL Editor_SelectAll(Gadget.l)
  editSel.CHARRANGE
  editSel\cpMin = 0
  editSel\cpMax = -1
  SendMessage_(GadgetID(Gadget), #EM_EXSETSEL, 0, @editSel)
EndProcedure
ProcedureDLL Editor_SelSetSel(Gadget.l, SelStart.l, SelEnd.l)
  Protected sel.CHARRANGE
  sel\cpmin=SelStart
  sel\cpMax=SelEnd
  SendMessage_(GadgetID(Gadget),#EM_EXSETSEL,0,@sel)
  ProcedureReturn
EndProcedure

ProcedureDLL Editor_SelGetPosStart(Gadget.l)
  ; aprés test => EM_EXGETSEL
  SendMessage_(GadgetID(Gadget),#EM_GETSEL,@StartS, @EndS) 
  ProcedureReturn StartS
EndProcedure
ProcedureDLL Editor_SelGetPosEnd(Gadget.l)
  SendMessage_(GadgetID(Gadget),#EM_GETSEL,@StartS, @EndS) 
  ProcedureReturn EndS
EndProcedure
ProcedureDLL.s Editor_SelGetText(Gadget.l)
  SendMessage_(GadgetID(Gadget),#EM_GETSEL,@StartSel,@EndSel)
  TextBuf.s = Space(EndSel-StartSel)
  SendMessage_(GadgetID(Gadget),#EM_GETSELTEXT,0,@TextBuf)
  ProcedureReturn TextBuf
EndProcedure
ProcedureDLL Editor_SelGetLength(Gadget.l)
  SendMessage_(GadgetID(Gadget),#EM_GETSEL,@StartS, @EndS) 
  ProcedureReturn EndS-StartS
EndProcedure

ProcedureDLL Editor_SelGetWordStart(Gadget.l, Position.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#EM_FINDWORDBREAK,#WB_MOVEWORDLEFT,Position)
EndProcedure
ProcedureDLL Editor_SelGetWordEnd(Gadget.l, Position.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#EM_FINDWORDBREAK,#WB_RIGHTBREAK,Position)
EndProcedure

ProcedureDLL Editor_SelGetNextWordStart(Gadget.l, Position.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#EM_FINDWORDBREAK,#WB_RIGHT,Position)
EndProcedure
ProcedureDLL Editor_SelGetPrevWordStart(Gadget.l, Position.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#EM_FINDWORDBREAK,#WB_LEFT,Position)
EndProcedure

ProcedureDLL Editor_SelIsEmpty(Gadget.l)
  mes=SendMessage_(GadgetID(Gadget),#EM_SELECTIONTYPE,0,0)
  If mes & #SEL_EMPTY
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_SelIsText(Gadget.l)
  mes=SendMessage_(GadgetID(Gadget),#EM_SELECTIONTYPE,0,0)
  If mes & #SEL_TEXT
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_SelIsObject(Gadget.l)
  mes=SendMessage_(GadgetID(Gadget),#EM_SELECTIONTYPE,0,0)
  If mes & #SEL_OBJECT
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_SelIsMultiChar(Gadget.l)
  mes=SendMessage_(GadgetID(Gadget),#EM_SELECTIONTYPE,0,0)
  If mes & #SEL_MULTICHAR
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_SelIsMultiObject(Gadget.l)
  mes=SendMessage_(GadgetID(Gadget),#EM_SELECTIONTYPE,0,0)
  If mes & #SEL_MULTIOBJECT
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
;}
;- OK EditorGadget
;{
ProcedureDLL Editor_Activate(Gadget.l)
  SetFocus_(GadgetID(Gadget))
EndProcedure

ProcedureDLL Editor_SetEditorFlags(Gadget.l, Flags.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#EM_SETEDITSTYLE,Flags,Flags|SendMessage_(GadgetID(Gadget),#EM_GETEDITSTYLE,0,0))
EndProcedure
ProcedureDLL Editor_GetEditorFlags(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#EM_GETEDITSTYLE,0,0)
EndProcedure

ProcedureDLL Editor_SetEventCallBack(Gadget.l,Flags.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#EM_SETEVENTMASK,0,Flags)
EndProcedure
ProcedureDLL Editor_GetEventCallBack(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#EM_GETEVENTMASK,0,0)
EndProcedure

ProcedureDLL Editor_SetAutoVScroll(Gadget.l,Activate.l)
  If Activate=#True
    SendMessage_(GadgetID(Gadget),#EM_SETOPTIONS,#ECOOP_OR,#ECO_AUTOVSCROLL)
  Else
    If SendMessage_(GadgetID(Gadget),#EM_GETOPTIONS,0,0) & #ECO_AUTOVSCROLL
      SendMessage_(GadgetID(Gadget),#EM_SETOPTIONS,#ECOOP_XOR,#ECO_AUTOVSCROLL)
    EndIf
  EndIf
  ProcedureReturn 
EndProcedure
ProcedureDLL Editor_GetAutoVScroll(Gadget.l)
  options= SendMessage_(GadgetID(Gadget),#EM_GETOPTIONS,0,0)
  If options  & #ECO_AUTOVSCROLL
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure

ProcedureDLL Editor_SetAutoHScroll(Gadget.l,Activate.l)
  If Activate=#True
    SendMessage_(GadgetID(Gadget),#EM_SETOPTIONS,#ECOOP_OR,#ECO_AUTOHSCROLL)
  Else
    If SendMessage_(GadgetID(Gadget),#EM_GETOPTIONS,0,0) & #ECO_AUTOHSCROLL
      SendMessage_(GadgetID(Gadget),#EM_SETOPTIONS,#ECOOP_XOR,#ECO_AUTOHSCROLL)
    EndIf
  EndIf
  ProcedureReturn 
EndProcedure
ProcedureDLL Editor_GetAutoHScroll(Gadget.l)
  options= SendMessage_(GadgetID(Gadget),#EM_GETOPTIONS,0,0)
  If options  & #ECO_AUTOHSCROLL
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure

ProcedureDLL Editor_SetReadOnly(Gadget.l,Activate.l)
  If Activate=#True
    SendMessage_(GadgetID(Gadget),#EM_SETOPTIONS,#ECOOP_OR,#ECO_READONLY)
  Else
    If SendMessage_(GadgetID(Gadget),#EM_GETOPTIONS,0,0) & #ECO_READONLY
      SendMessage_(GadgetID(Gadget),#EM_SETOPTIONS,#ECOOP_XOR,#ECO_READONLY)
    EndIf
  EndIf
  ProcedureReturn 
EndProcedure
ProcedureDLL Editor_GetReadOnly(Gadget.l)
  options= SendMessage_(GadgetID(Gadget),#EM_GETOPTIONS,0,0)
  If options  & #ECO_READONLY
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure

ProcedureDLL Editor_SetSelectionBar(Gadget.l,Activate.l)
  If Activate=#True
    SendMessage_(GadgetID(Gadget),#EM_SETOPTIONS,#ECOOP_OR,#ECO_SELECTIONBAR)
  Else
    If SendMessage_(GadgetID(Gadget),#EM_GETOPTIONS,0,0)&#ECO_SELECTIONBAR
      SendMessage_(GadgetID(Gadget),#EM_SETOPTIONS,#ECOOP_XOR,#ECO_SELECTIONBAR)
    EndIf
  EndIf
  ProcedureReturn 
EndProcedure
ProcedureDLL Editor_GetSelectionBar(Gadget.l)
  options= SendMessage_(GadgetID(Gadget),#EM_GETOPTIONS,0,0)
  If options  & #ECO_SELECTIONBAR
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure

ProcedureDLL Editor_SetLineBreakSimple(Gadget.l,Activate.l)
  If Activate=#True
    ProcedureReturn SendMessage_(GadgetID(Gadget),#EM_SETTYPOGRAPHYOPTIONS ,#TO_SIMPLELINEBREAK,#TO_SIMPLELINEBREAK|SendMessage_(GadgetID(Gadget),#EM_GETTYPOGRAPHYOPTIONS,0,0))
  Else
    ProcedureReturn SendMessage_(GadgetID(Gadget),#EM_SETTYPOGRAPHYOPTIONS ,#TO_ADVANCEDTYPOGRAPHY,#TO_ADVANCEDTYPOGRAPHY|SendMessage_(GadgetID(Gadget),#EM_GETTYPOGRAPHYOPTIONS,0,0))
  EndIf
EndProcedure
ProcedureDLL Editor_GetLineBreakSimple(Gadget.l)
  If SendMessage_(GadgetID(Gadget),#EM_GETTYPOGRAPHYOPTIONS,0,0)  = #TO_SIMPLELINEBREAK
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_GetLineBreakAdvanced(Gadget.l)
  If SendMessage_(GadgetID(Gadget),#EM_GETTYPOGRAPHYOPTIONS,0,0)  = #TO_ADVANCEDTYPOGRAPHY
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure

ProcedureDLL Editor_SetFlatBorder(Gadget.l,Activate.l)
  If Activate=#True
    style = GetWindowLong_(GadgetID(Gadget), #GWL_EXSTYLE)
    newstyle = style &(~#WS_EX_CLIENTEDGE)
    SetWindowLong_(GadgetID(Gadget), #GWL_EXSTYLE, newstyle)
    SetWindowPos_(GadgetID(Gadget), 0, 0, 0, 0, 0, #SWP_SHOWWINDOW | #SWP_NOSIZE | #SWP_NOMOVE | #SWP_FRAMECHANGED) 
  Else
    newstyle = #WS_EX_CLIENTEDGE
    SetWindowLong_(GadgetID(Gadget), #GWL_EXSTYLE, newstyle)
    SetWindowPos_(GadgetID(Gadget), 0, 0, 0, 0, 0, #SWP_SHOWWINDOW | #SWP_NOSIZE | #SWP_NOMOVE | #SWP_FRAMECHANGED) 
  EndIf
  ProcedureReturn 
EndProcedure
ProcedureDLL Editor_GetFlatBorder(Gadget.l)
  style = GetWindowLong_(GadgetID(Gadget), #GWL_EXSTYLE)
  If style & 512
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure

ProcedureDLL Editor_IsPlainText(Gadget.l)
  text= SendMessage_(GadgetID(Gadget),#EM_GETTEXTMODE ,0,0)
  If text&1
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_IsRichText(Gadget.l)
  text= SendMessage_(GadgetID(Gadget),#EM_GETTEXTMODE ,0,0)
  If text&2
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_IsSingleLevelUndo(Gadget.l)
  text= SendMessage_(GadgetID(Gadget),#EM_GETTEXTMODE ,0,0)
  If text&4
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_IsMultiLevelUndo(Gadget.l)
  text= SendMessage_(GadgetID(Gadget),#EM_GETTEXTMODE ,0,0)
  If text&8
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_IsSingleCodePage(Gadget.l)
  text= SendMessage_(GadgetID(Gadget),#EM_GETTEXTMODE ,0,0)
  If text&16
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_IsMultiCodePage(Gadget.l)
  text= SendMessage_(GadgetID(Gadget),#EM_GETTEXTMODE ,0,0)
  If text&32
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure

ProcedureDLL Editor_SetTextMode(Gadget.l, ActivateRichEdit.l)
  Text.s=GetGadgetText(Gadget)
  SetGadgetText(Gadget,"")
  If ActivateRichEdit=#True
    SendMessage_(GadgetID(Gadget),#EM_SETTEXTMODE,#TM_RICHTEXT,0)
  Else
    SendMessage_(GadgetID(Gadget),#EM_SETTEXTMODE,#TM_PLAINTEXT,0)
  EndIf
  SetGadgetText(Gadget,Text.s)
EndProcedure

ProcedureDLL Editor_SetLevelUndo(Gadget.l, Activate.l)
  Text.s=GetGadgetText(Gadget)
  SetGadgetText(Gadget,"")
  If Activate=#True
    SendMessage_(GadgetID(Gadget),#EM_SETTEXTMODE,#TM_MULTILEVELUNDO,0)
  Else
    SendMessage_(GadgetID(Gadget),#EM_SETTEXTMODE,#TM_SINGLELEVELUNDO,0)
  EndIf
  SetGadgetText(Gadget,Text.s)
EndProcedure
ProcedureDLL Editor_SetMaxLevelUndo(Gadget.l, MaxLevel.l)
  ; MaxLevel =  0 => désactivation de l'undo
  SendMessage_(GadgetID(Gadget),#EM_SETUNDOLIMIT,MaxLevel,0)
EndProcedure

ProcedureDLL Editor_SetCodePage(Gadget.l, Activate.l)
  Text.s=GetGadgetText(Gadget)
  SetGadgetText(Gadget,"")
  If Activate=#True
    SendMessage_(GadgetID(Gadget),#EM_SETTEXTMODE,#TM_SINGLECODEPAGE,0)
  Else
    SendMessage_(GadgetID(Gadget),#EM_SETTEXTMODE,#TM_MULTICODEPAGE,0)
  EndIf
  SetGadgetText(Gadget,Text.s)
EndProcedure

ProcedureDLL Editor_SetActiveSel(Gadget.l, Activate.l)
  SendMessage_(GadgetID(Gadget),#EM_HIDESELECTION,Activate,0)
EndProcedure

ProcedureDLL Editor_SetMargin(Gadget.l, MarginLeft.l, MarginRight.l)
  If MarginLeft <0
    MarginLeft =0
  EndIf
  If MarginRight <0
    MarginRight =0
  EndIf
  SendMessage_(GadgetID(Gadget),#EM_SETMARGINS,1|2, MarginLeft|(MarginRight<<16))
EndProcedure

ProcedureDLL Editor_SetTabulationSize(Gadget.l, Size.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#EM_SETTABSTOPS,1,@Size)
EndProcedure

ProcedureDLL Editor_GetNumberChar(Gadget.l)
  text.GETTEXTLENGTHEX
  text\flags=#GTL_DEFAULT
  count= SendMessage_(GadgetID(Gadget),#EM_GETTEXTLENGTHEX ,text,0)
  ProcedureReturn count
EndProcedure
ProcedureDLL Editor_SetAutomaticLine(Gadget.l, Activate.l, LineWidth.l)
  If Activate=#True
    SendMessage_(GadgetID(Gadget), #EM_SETTARGETDEVICE, #Null, LineWidth)
    ProcedureReturn
  ElseIf Activate=#False
    SendMessage_(GadgetID(Gadget), #EM_SETTARGETDEVICE, #Null, $FFFFFF)
    ProcedureReturn
  Else
    SendMessage_(GadgetID(Gadget), #EM_SETTARGETDEVICE, #Null, $FFFFFF)
    ProcedureReturn
  EndIf
EndProcedure
ProcedureDLL Editor_SetAlinea(Gadget.l,Taille.l)
  SendMessage_(GadgetID(Gadget),#EM_SETTABSTOPS,1,@Taille)
EndProcedure
ProcedureDLL Editor_SetLimitText(Gadget.l,Limit.l)
  ; Max > 64K caractères : a définir exactemetn
  ; Défaut:32,767 
  SendMessage_(GadgetID(Gadget),#EM_EXLIMITTEXT,0,Limit)
EndProcedure

ProcedureDLL.s Editor_GetGadgetText(Gadget.l)
  Protected text.s, gt.GETTEXTEX, gtl.GETTEXTLENGTHEX
  If IsWindowUnicode_(GadgetID(Gadget))
    gtl\codepage = 1200
  Else
    gtl\codepage = #CP_ACP
  EndIf
  gtl\flags = #GTL_DEFAULT|#GTL_NUMCHARS
  gt\cb = SendMessage_(GadgetID(Gadget), #EM_GETTEXTLENGTHEX, @gtl, #Null)
  gt\flags = #GT_DEFAULT
  gt\codepage = gtl\codepage
  text = Space(gt\cb)
  SendMessage_(GadgetID(Gadget), #EM_GETTEXTEX, @gt, @text)
  ProcedureReturn text
EndProcedure

ProcedureDLL Editor_SetAutoDetectURL(Gadget.l, AutoDetect.l)
  Text.s=GetGadgetText(Gadget)
  SetGadgetText(Gadget,"")
  SendMessage_(GadgetID(gadget.l), #EM_AUTOURLDETECT,AutoDetect,0)
  SetGadgetText(Gadget,Text)
  ProcedureReturn 
EndProcedure
ProcedureDLL Editor_GetAutoDetectURL(Gadget.l)
  ; 1 actif
  ; 0 inactif
  ProcedureReturn SendMessage_(GadgetID(gadget.l), #EM_GETAUTOURLDETECT,0,0)
EndProcedure

;}
;- OK IME
;{
ProcedureDLL Editor_IME_IsIME(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#EM_ISIME,0,0)
EndProcedure
ProcedureDLL Editor_IME_Reconversion(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#EM_RECONVERSION ,0,0)
EndProcedure
ProcedureDLL Editor_IME_GetMode(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#EM_GETIMECOMPMODE,0,0)
EndProcedure

ProcedureDLL Editor_IME_GetOptions(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#EM_GETIMEOPTIONS,0,0)
EndProcedure
ProcedureDLL Editor_IME_IsCloseStatusWindow(Options.l)
  If Options & #IMF_CLOSESTATUSWINDOW
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_IME_IsForceActive(Options.l)
  If Options & #IMF_FORCEACTIVE
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_IME_IsForceDisable(Options.l)
  If Options & #IMF_FORCEDISABLE
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_IME_IsForceEnable(Options.l)
  If Options & #IMF_FORCEENABLE
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_IME_IsForceInactive(Options.l)
  If Options & #IMF_FORCEINACTIVE
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_IME_IsForceNone(Options.l)
  If Options & #IMF_FORCENONE
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_IME_IsForceRemember(Options.l)
  If Options & #IMF_FORCEREMEMBER
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_IME_IsMultipleEdit(Options.l)
  If Options & #IMF_MULTIPLEEDIT
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure

ProcedureDLL Editor_IME_GetLangOptions(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#EM_GETLANGOPTIONS,0,0)
EndProcedure
ProcedureDLL Editor_IME_IsAutoFont(LangOptions.l)
  If LangOptions & #IMF_AUTOFONT
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_IME_IsAutoFontSizeAdjust(LangOptions.l)
  If LangOptions & #IMF_AUTOFONTSIZEADJUST
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_IME_IsAutoKeyboard(LangOptions.l)
  If LangOptions & #IMF_AUTOKEYBOARD
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_IME_IsDualFont(LangOptions.l)
  If LangOptions & #IMF_DUALFONT
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_IME_IsAlwaysSendNotify(LangOptions.l)
  If LangOptions & #IMF_IMEALWAYSSENDNOTIFY
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_IME_IsCancelComplete(LangOptions.l)
  If LangOptions & #IMF_IMECANCELCOMPLETE
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_IME_IsUIFonts(LangOptions.l)
  If LangOptions & #IMF_UIFONTS
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
;}
;- OK RTF
;{
ProcedureDLL Editor_RTF_SetList(Gadget.l,TypeList.w,NumStart.w,Style.w,Tab.w)
  ;TYPE :
  ; ; 2 = 1..2..3 
    ; 3 = a..b..c 
    ; 4 = A..B..C 
    ; 5 = i...ii...iii 
    ; 6 = I...II...III
  ; STYLE
    ; 0 = NUM) 
    ; $100 = (NUM) 
    ; $200 =NUM. 
    ; $300 = NUM
  egPara.PARAFORMAT2
  egPara\cbSize = SizeOf(PARAFORMAT2)
  egPara\dwMask = #PFM_NUMBERING      ; wNumbering
  egPara\dwMask = egPara\dwMask|#PFM_NUMBERINGSTART ; wNumberingStart
  egPara\dwMask = egPara\dwMask|#PFM_NUMBERINGSTYLE ; wNumberingStyle
  egPara\dwMask = egPara\dwMask|#PFM_NUMBERINGTAB   ; wNumberingTab
  egPara\wNumbering =TypeList       
  egPara\wNumberingStart = NumStart
  egPara\wNumberingStyle = Style 
  egPara\wNumberingTab = Tab    ; twips
          
  SendMessage_(GadgetID(Gadget), #EM_SETPARAFORMAT, #SCF_DEFAULT, @egPara)
  ; récupère le texte de la sélection
  SendMessage_(GadgetID(Gadget),#EM_GETSEL,@StartSel,@EndSel)
  Buffer$ = Space(EndSel-StartSel)
  SendMessage_(GadgetID(Gadget),#EM_GETSELTEXT,0,@Buffer$)
  ; récupère la position des barres de scroll
  SendMessage_(GadgetID(Gadget), #EM_GETSCROLLPOS, 0, @scrollP.POINT)
  SendMessage_(GadgetID(Gadget),#EM_REPLACESEL,#True,@Buffer$)
  ; définit la position des barres de scroll
  SendMessage_(GadgetID(Gadget), #EM_SETSCROLLPOS, 0, scrollP.POINT)
  ProcedureReturn 
EndProcedure
ProcedureDLL Editor_RTF_GetListType(Gadget.l)
  ;TYPE :
  ; ; 2 = 1..2..3 
    ; 3 = a..b..c 
    ; 4 = A..B..C 
    ; 5 = i...ii...iii 
    ; 6 = I...II...III
  egPara.PARAFORMAT2
  egPara\cbSize = SizeOf(PARAFORMAT2)
  SendMessage_(GadgetID(Gadget), #EM_GETPARAFORMAT, 0, @egPara)
  ProcedureReturn egPara\wNumbering
EndProcedure
ProcedureDLL Editor_RTF_GetListNumStart(Gadget.l)
  egPara.PARAFORMAT2
  egPara\cbSize = SizeOf(PARAFORMAT2)
  SendMessage_(GadgetID(Gadget), #EM_GETPARAFORMAT, 0, @egPara)
  ProcedureReturn egPara\wNumberingStart
EndProcedure
ProcedureDLL Editor_RTF_GetListStyle(Gadget.l)
  ; STYLE
    ; 0 = NUM) 
    ; $100 = (NUM) 
    ; $200 =NUM. 
    ; $300 = NUM
  egPara.PARAFORMAT2
  egPara\cbSize = SizeOf(PARAFORMAT2)
  SendMessage_(GadgetID(Gadget), #EM_GETPARAFORMAT, 0, @egPara)
  ProcedureReturn egPara\wNumberingStyle
EndProcedure
ProcedureDLL Editor_RTF_GetListTab(Gadget.l)
  egPara.PARAFORMAT2
  egPara\cbSize = SizeOf(PARAFORMAT2)
  SendMessage_(GadgetID(Gadget), #EM_GETPARAFORMAT, 0, @egPara)
  ProcedureReturn egPara\wNumberingTab
EndProcedure

ProcedureDLL Editor_RTF_SetAlignment(Gadget.l,Alignment.l)
  ; Alignment
    ; #PFA_LEFT
    ; #PFA_RIGHT
    ; #PFA_CENTER
    ; #PFA_JUSTIFY
    ; #PFA_FULL_INTERWORD
    ; #PFA_FULL_INTERLETTER
    ; #PFA_FULL_SCALED
    ; #PFA_FULL_GLYPHS
    ; #PFA_SNAP_GRID
  ;{ Récuperation de l'ancienne sélection
    oldsel.CHARRANGE
    SendMessage_(GadgetID(Gadget), #EM_GETSEL, @oldsel\cpMin, @oldsel\cpMax)
  ;}
  ;{ Get EdOptions
  EdOptions = SendMessage_(GadgetID(Gadget), #EM_GETOPTIONS, 0,0)
  ;}
  ;{ Désactivation du Scolling Horizontal
  SendMessage_(GadgetID(Gadget), #EM_SETOPTIONS, #ECOOP_XOR, #ECO_AUTOHSCROLL)
  ;}
  ;{ Désactivation du Scolling Vertical
  SendMessage_(GadgetID(Gadget), #EM_SETOPTIONS, #ECOOP_XOR, #ECO_AUTOVSCROLL)
  ;}
  ;{ Désactivation de la sélection
  SendMessage_(GadgetID(Gadget), #EM_HIDESELECTION, #True, #Null)
  ;}

  egPara.PARAFORMAT2
  egPara\cbSize = SizeOf(PARAFORMAT2)
  egPara\dwMask = #PFM_ALIGNMENT
  egpara\wAlignment = Alignment
  SendMessage_(GadgetID(Gadget), #EM_SETPARAFORMAT, #SCF_DEFAULT, @egPara)
  ; récupère le texte de la sélection
  SendMessage_(GadgetID(Gadget),#EM_GETSEL,@StartSel,@EndSel)
  Buffer$ = Space(EndSel-StartSel)
  SendMessage_(GadgetID(Gadget),#EM_GETSELTEXT,0,@Buffer$)
  ; récupère la position des barres de scroll
  SendMessage_(GadgetID(Gadget), #EM_GETSCROLLPOS, 0, @scrollP.POINT)
  SendMessage_(GadgetID(Gadget),#EM_REPLACESEL,#True,@Buffer$)
  ; définit la position des barres de scroll
  SendMessage_(GadgetID(Gadget), #EM_SETSCROLLPOS, 0, scrollP.POINT)
  ;{ Remplacement de l'ancienne sélection
    SendMessage_(GadgetID(Gadget), #EM_SETSEL, oldsel\cpMin, oldsel\cpMax)
  ;}
  ;{ Activation du Scolling Horizontal
    SendMessage_(GadgetID(Gadget), #EM_SETOPTIONS, #ECOOP_SET, EdOptions)
  ;}
  ;{ Activation de la sélection
  SendMessage_(GadgetID(Gadget), #EM_HIDESELECTION, #False, #Null)
  ;}

  ProcedureReturn 
EndProcedure
ProcedureDLL Editor_RTF_GetAlignment(Gadget.l)
  ; Alignment
    ; #PFA_LEFT
    ; #PFA_RIGHT
    ; #PFA_CENTER
    ; #PFA_JUSTIFY
    ; #PFA_FULL_INTERWORD
    ; #PFA_FULL_INTERLETTER
    ; #PFA_FULL_SCALED
    ; #PFA_FULL_GLYPHS
    ; #PFA_SNAP_GRID
  egPara.PARAFORMAT2
  egPara\cbSize = SizeOf(PARAFORMAT2)
  SendMessage_(GadgetID(Gadget), #EM_GETPARAFORMAT, 0, @egPara)
  ProcedureReturn egPara\wAlignment
EndProcedure
ProcedureDLL Editor_RTF_IsRight(Alignment.l)
  If Alignment = #PFA_RIGHT
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_RTF_IsLeft(Alignment.l)
  If Alignment = #PFA_LEFT
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_RTF_IsCenter(Alignment.l)
  If Alignment = #PFA_CENTER
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_RTF_IsJustify(Alignment.l)
  If Alignment = #PFA_JUSTIFY
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure

ProcedureDLL Editor_RTF_SetSpaceAfter(Gadget.l,SpaceAfter.l)
  ;{ Récuperation de l'ancienne sélection
    oldsel.CHARRANGE
    SendMessage_(GadgetID(Gadget), #EM_GETSEL, @oldsel\cpMin, @oldsel\cpMax)
  ;}
  ;{ Get EdOptions
  EdOptions = SendMessage_(GadgetID(Gadget), #EM_GETOPTIONS, 0,0)
  ;}
  ;{ Désactivation du Scolling Horizontal
  SendMessage_(GadgetID(Gadget), #EM_SETOPTIONS, #ECOOP_XOR, #ECO_AUTOHSCROLL)
  ;}
  ;{ Désactivation du Scolling Vertical
  SendMessage_(GadgetID(Gadget), #EM_SETOPTIONS, #ECOOP_XOR, #ECO_AUTOVSCROLL)
  ;}
  ;{ Désactivation de la sélection
  SendMessage_(GadgetID(Gadget), #EM_HIDESELECTION, #True, #Null)
  ;}
  egPara.PARAFORMAT2
  egPara\cbSize = SizeOf(PARAFORMAT2)
  egPara\dwMask = #PFM_SPACEAFTER 
  egpara\dySpaceAfter = SpaceAfter
  SendMessage_(GadgetID(Gadget), #EM_SETPARAFORMAT, 0, @egPara)
  ; récupère le texte de la sélection
  SendMessage_(GadgetID(Gadget),#EM_GETSEL,@StartSel,@EndSel)
  Buffer$ = Space(EndSel-StartSel)
  SendMessage_(GadgetID(Gadget),#EM_GETSELTEXT,0,@Buffer$)
  ; récupère la position des barres de scroll
  SendMessage_(GadgetID(Gadget), #EM_GETSCROLLPOS, 0, @scrollP.POINT)
  SendMessage_(GadgetID(Gadget), #EM_REPLACESEL,#True,@Buffer$)
  ; définit la position des barres de scroll
  SendMessage_(GadgetID(Gadget), #EM_SETSCROLLPOS, 0, scrollP.POINT)
  ;{ Remplacement de l'ancienne sélection
    SendMessage_(GadgetID(Gadget), #EM_SETSEL, oldsel\cpMin, oldsel\cpMax)
  ;}
  ;{ Activation du Scolling Horizontal
    SendMessage_(GadgetID(Gadget), #EM_SETOPTIONS, #ECOOP_SET, EdOptions)
  ;}
  ;{ Activation de la sélection
  SendMessage_(GadgetID(Gadget), #EM_HIDESELECTION, #False, #Null)
  ;}

  ProcedureReturn 
EndProcedure
ProcedureDLL Editor_RTF_GetSpaceAfter(Gadget.l)
  egPara.PARAFORMAT2
  egPara\cbSize = SizeOf(PARAFORMAT2)
  SendMessage_(GadgetID(Gadget), #EM_GETPARAFORMAT, 0, @egPara)
  ProcedureReturn egPara\dySpaceAfter
EndProcedure

ProcedureDLL Editor_RTF_SetSpaceBefore(Gadget.l,SpaceBefore.l)
  ;{ Récuperation de l'ancienne sélection
    oldsel.CHARRANGE
    SendMessage_(GadgetID(Gadget), #EM_GETSEL, @oldsel\cpMin, @oldsel\cpMax)
  ;}
  ;{ Get EdOptions
  EdOptions = SendMessage_(GadgetID(Gadget), #EM_GETOPTIONS, 0,0)
  ;}
  ;{ Désactivation du Scolling Horizontal
  SendMessage_(GadgetID(Gadget), #EM_SETOPTIONS, #ECOOP_XOR, #ECO_AUTOHSCROLL)
  ;}
  ;{ Désactivation du Scolling Vertical
  SendMessage_(GadgetID(Gadget), #EM_SETOPTIONS, #ECOOP_XOR, #ECO_AUTOVSCROLL)
  ;}
  ;{ Désactivation de la sélection
  SendMessage_(GadgetID(Gadget), #EM_HIDESELECTION, #True, #Null)
  ;}
  egPara.PARAFORMAT2
  egPara\cbSize = SizeOf(PARAFORMAT2)
  egPara\dwMask = #PFM_SPACEBEFORE
  egpara\dySpaceBefore = SpaceBefore
  SendMessage_(GadgetID(Gadget), #EM_SETPARAFORMAT, 0, @egPara)
  ; récupère le texte de la sélection
  SendMessage_(GadgetID(Gadget),#EM_GETSEL,@StartSel,@EndSel)
  Buffer$ = Space(EndSel-StartSel)
  SendMessage_(GadgetID(Gadget),#EM_GETSELTEXT,0,@Buffer$)
  ; récupère la position des barres de scroll
  SendMessage_(GadgetID(Gadget), #EM_GETSCROLLPOS, 0, @scrollP.POINT)
  SendMessage_(GadgetID(Gadget),#EM_REPLACESEL,#True,@Buffer$)
  ; définit la position des barres de scroll
  SendMessage_(GadgetID(Gadget), #EM_SETSCROLLPOS, 0, scrollP.POINT)
  ;{ Remplacement de l'ancienne sélection
    SendMessage_(GadgetID(Gadget), #EM_SETSEL, oldsel\cpMin, oldsel\cpMax)
  ;}
  ;{ Activation du Scolling Horizontal
    SendMessage_(GadgetID(Gadget), #EM_SETOPTIONS, #ECOOP_SET, EdOptions)
  ;}
  ;{ Activation de la sélection
  SendMessage_(GadgetID(Gadget), #EM_HIDESELECTION, #False, #Null)
  ;}
  ProcedureReturn 
EndProcedure
ProcedureDLL Editor_RTF_GetSpaceBefore(Gadget.l)
  egPara.PARAFORMAT2
  egPara\cbSize = SizeOf(PARAFORMAT2)
  SendMessage_(GadgetID(Gadget), #EM_GETPARAFORMAT, 0, @egPara)
  ProcedureReturn egPara\dySpaceBefore
EndProcedure

ProcedureDLL Editor_RTF_SetInterline(Gadget.l,Interline.l)
  egPara.PARAFORMAT2
  egPara\cbSize = SizeOf(PARAFORMAT2)
  egPara\dwMask = #PFM_LINESPACING
  egpara\bLineSpacingRule = Interline
  SendMessage_(GadgetID(Gadget), #EM_SETPARAFORMAT, 0, @egPara)
  ; récupère le texte de la sélection
  SendMessage_(GadgetID(Gadget),#EM_GETSEL,@StartSel,@EndSel)
  Buffer$ = Space(EndSel-StartSel)
  SendMessage_(GadgetID(Gadget),#EM_GETSELTEXT,0,@Buffer$)
  ; récupère la position des barres de scroll
  SendMessage_(GadgetID(Gadget), #EM_GETSCROLLPOS, 0, @scrollP.POINT)
  SendMessage_(GadgetID(Gadget),#EM_REPLACESEL,#True,@Buffer$)
  ; définit la position des barres de scroll
  SendMessage_(GadgetID(Gadget), #EM_SETSCROLLPOS, 0, scrollP.POINT)
  ProcedureReturn 
EndProcedure
ProcedureDLL Editor_RTF_GetInterline(Gadget.l)
  egPara.PARAFORMAT2
  egPara\cbSize = SizeOf(PARAFORMAT2)
  SendMessage_(GadgetID(Gadget), #EM_GETPARAFORMAT, 0, @egPara)
  ProcedureReturn egPara\bLineSpacingRule
EndProcedure

ProcedureDLL Editor_RTF_SetSpecialUnderline(Gadget.l,UnderlineType.l)
  format.CHARFORMAT2
  format\cbSize = SizeOf(CHARFORMAT2)
  format\dwMask = #CFM_UNDERLINETYPE 
  format\bUnderlineType=UnderlineType.l
  SendMessage_(GadgetID(Gadget), #EM_SETCHARFORMAT, #SCF_SELECTION, @format)
EndProcedure
ProcedureDLL Editor_RTF_GetSpecialUnderline(Gadget.l)
  format.CHARFORMAT2
  format\cbSize = SizeOf(CHARFORMAT2)
  format\dwMask = #CFM_UNDERLINETYPE 
  SendMessage_(GadgetID(Gadget), #EM_GETCHARFORMAT, #SCF_SELECTION, @format)
  ProcedureReturn format\bUnderlineType
EndProcedure
ProcedureDLL Editor_RTF_IsCf1Underline(SpecialUnderline.l)
; Map charformat's bit underline to CF2
  If SpecialUnderline=#CFU_CF1UNDERLINE
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_RTF_IsInvert(SpecialUnderline.l)
; For IME composition fake a selection
  If SpecialUnderline=#CFU_INVERT
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_RTF_IsUnderlineThickLongDash(SpecialUnderline.l)
; (*) display As dash
  If SpecialUnderline=#CFU_UNDERLINETHICKLONGDASH
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_RTF_IsUnderlineThickDotted(SpecialUnderline.l)
; (*) display As dot
  If SpecialUnderline=#CFU_UNDERLINETHICKDOTTED
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_RTF_IsUnderlineThickDashDotDot(SpecialUnderline.l)
; (*) display As dash dot dot
  If SpecialUnderline=#CFU_UNDERLINETHICKDASHDOTDOT
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_RTF_IsUnderlineThickDashDot(SpecialUnderline.l)
; (*) display As dash dot
  If SpecialUnderline=#CFU_UNDERLINETHICKDASHDOT
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_RTF_IsUnderlineThickDash(SpecialUnderline.l)
; (*) display As dash
  If SpecialUnderline= #CFU_UNDERLINETHICKDASH
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_RTF_IsUnderlineLongDash(SpecialUnderline.l)
; (*) display As dash
  If SpecialUnderline= #CFU_UNDERLINELONGDASH
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_RTF_IsUnderlineHeavyWave(SpecialUnderline.l)
; (*) display As wave
  If SpecialUnderline= #CFU_UNDERLINEHEAVYWAVE
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_RTF_IsUnderlineDoubleWave(SpecialUnderline.l)
; (*) display As wave
  If SpecialUnderline= #CFU_UNDERLINEDOUBLEWAVE
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_RTF_IsUnderlineHairLine(SpecialUnderline.l)
; (*) display As single	
  If SpecialUnderline= #CFU_UNDERLINEHAIRLINE
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_RTF_IsUnderlineThick(SpecialUnderline.l)
  If SpecialUnderline= #CFU_UNDERLINETHICK
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_RTF_IsUnderlineWave(SpecialUnderline.l)
  If SpecialUnderline= #CFU_UNDERLINEWAVE
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_RTF_IsUnderlineDashDotDot(SpecialUnderline.l)
  If SpecialUnderline= #CFU_UNDERLINEDASHDOTDOT
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_RTF_IsUnderlineDashDot(SpecialUnderline.l)
  If SpecialUnderline= #CFU_UNDERLINEDASHDOT
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_RTF_IsUnderlineDash(SpecialUnderline.l)
  If SpecialUnderline= #CFU_UNDERLINEDASH
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_RTF_IsUnderlineDotted(SpecialUnderline.l)
  If SpecialUnderline= #CFU_UNDERLINEDOTTED
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_RTF_IsUnderlineDouble(SpecialUnderline.l)
; (*) display As single
  If SpecialUnderline= #CFU_UNDERLINEDOUBLE
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_RTF_IsUnderlineWord(SpecialUnderline.l)
; (*) display As single	
  If SpecialUnderline= #CFU_UNDERLINEWORD
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_RTF_IsUnderlineLine(SpecialUnderline.l)
  If SpecialUnderline= #CFU_UNDERLINE
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_RTF_IsUnderlineNone(SpecialUnderline.l)
  If SpecialUnderline= #CFU_UNDERLINENONE
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure

ProcedureDLL Editor_RTF_SetFont(Gadget.l, NameFont.s) 
 ; Set Font for the Selection 
; You must specify a font name, the font doesn't need 
; to be loaded  
  format.CHARFORMAT 
  format\cbSize = SizeOf(CHARFORMAT) 
  SendMessage_(GadgetID(Gadget), #EM_GETCHARFORMAT, #SCF_SELECTION, @format)
  format\cbSize = SizeOf(CHARFORMAT)
  format\dwMask = format\dwMask |#CFM_FACE
  PokeS(@format\szFaceName, NameFont) 
  SendMessage_(GadgetID(Gadget), #EM_SETCHARFORMAT, #SCF_SELECTION, @format)
EndProcedure 
ProcedureDLL.s Editor_RTF_GetFont(Gadget.l)
  Protected format.CHARFORMAT
  format\cbSize = SizeOf(CHARFORMAT) 
  resultat = SendMessage_(GadgetID(Gadget), #EM_GETCHARFORMAT, #SCF_SELECTION, @format)
  Font.s=PeekS(@format\szFaceName)
  ProcedureReturn Font.s
EndProcedure

ProcedureDLL Editor_RTF_SetFontSize(Gadget.l, FontSize.l) 
  ; Set Font Size for the Selection 
; in pt 
  format.CHARFORMAT 
  format\cbSize = SizeOf(CHARFORMAT) 
  format\dwMask = #CFM_SIZE 
  format\yHeight = FontSize*20 
  SendMessage_(GadgetID(Gadget), #EM_SETCHARFORMAT, #SCF_SELECTION, @format) 
EndProcedure 
ProcedureDLL Editor_RTF_SetFontSizeStep(Gadget.l,StepSize.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget), #EM_SETFONTSIZE, StepSize, 0)
EndProcedure
ProcedureDLL Editor_RTF_GetFontSize(Gadget.l)
  Protected format.CHARFORMAT
  format\cbSize = SizeOf(CHARFORMAT) 
  SendMessage_(GadgetID(Gadget), #EM_GETCHARFORMAT, #SCF_SELECTION, @format) 
  size.l=format\yHeight/20
  ProcedureReturn size
EndProcedure

ProcedureDLL Editor_RTF_SetFormat(Gadget.l, Flags.l) 
; Set Format of the Selection. 
; This can be a combination of the following values :
; - #CFE_BOLD 
; - #CFE_ITALIC 
; - #CFE_UNDERLINE 
; - #CFE_STRIKEOUT  
;Tester
; - #CFE_AUTOCOLOR
; - #CFE_DISABLED
; - #CFE_PROTECTED
  format.CHARFORMAT2
  format\cbSize = SizeOf(CHARFORMAT2)
  SendMessage_(GadgetID(Gadget), #EM_GETCHARFORMAT, #SCF_SELECTION, @format)
  format\cbSize = SizeOf(CHARFORMAT2)
  format\dwMask | #CFM_ITALIC|#CFM_BOLD|#CFM_STRIKEOUT|#CFM_UNDERLINE|#CFM_LINK
  format\dwEffects | Flags
  SendMessage_(GadgetID(Gadget), #EM_SETCHARFORMAT, #SCF_SELECTION, @format)
EndProcedure
ProcedureDLL Editor_RTF_AddFormat(Gadget.l,Flags.l)
  ; Set Format of the Selection. 
  ; This can be a combination of the following values :
  ; - #CFE_BOLD           Gras
  ; - #CFE_ITALIC         Italique
  ; - #CFE_UNDERLINE      Souligné
  ; - #CFE_STRIKEOUT      Barré
  ; - #CFE_AUTOCOLOR      Couleur par défaut du système
  ; - #CFE_ALLCAPS        Tout en majuscules
  ; - #CFE_AUTOBACKCOLOR  Couleur du fond du texte = couleur de l'EditorGadget
  ; - #CFE_DISABLED       Ombre de 3/4 pixels
  ; - #CFE_HIDDEN         Cache le texte
  ;{ Récuperation de l'ancienne sélection
    oldsel.CHARRANGE
    SendMessage_(GadgetID(Gadget), #EM_GETSEL, @oldsel\cpMin, @oldsel\cpMax)
  ;}
  ;{ Get EdOptions
  EdOptions = SendMessage_(GadgetID(Gadget), #EM_GETOPTIONS, 0,0)
  ;}
  ;{ Désactivation du Scolling Horizontal
  SendMessage_(GadgetID(Gadget), #EM_SETOPTIONS, #ECOOP_XOR, #ECO_AUTOHSCROLL)
  ;}
  ;{ Désactivation du Scolling Vertical
  SendMessage_(GadgetID(Gadget), #EM_SETOPTIONS, #ECOOP_XOR, #ECO_AUTOVSCROLL)
  ;}
  ;{ Désactivation de la sélection
  SendMessage_(GadgetID(Gadget), #EM_HIDESELECTION, #True, #Null)
  ;}
  For Inc_a=0 To (oldsel\cpMax-oldsel\cpMin)-1
    SendMessage_(GadgetID(Gadget), #EM_SETSEL, oldsel\cpMin+Inc_a, oldsel\cpMin+Inc_a+1)
    format.CHARFORMAT2
    format\cbSize = SizeOf(CHARFORMAT2)
    SendMessage_(GadgetID(Gadget), #EM_GETCHARFORMAT, #SCF_SELECTION, @format)
    format\cbSize = SizeOf(CHARFORMAT2)
    format\dwMask|#CFM_ITALIC|#CFM_BOLD|#CFM_STRIKEOUT|#CFM_UNDERLINE|#CFM_LINK|#CFM_ALLCAPS|#CFM_DISABLED|#CFM_HIDDEN
    format\dwEffects | Flags
    SendMessage_(GadgetID(Gadget), #EM_SETCHARFORMAT, #SCF_SELECTION, @format)  
  Next
  ;{ Remplacement de l'ancienne sélection
    SendMessage_(GadgetID(Gadget), #EM_SETSEL, oldsel\cpMin, oldsel\cpMax)
  ;}
  ;{ Activation du Scolling Horizontal
    SendMessage_(GadgetID(Gadget), #EM_SETOPTIONS, #ECOOP_SET, EdOptions)
  ;}
  ;{ Activation de la sélection
  SendMessage_(GadgetID(Gadget), #EM_HIDESELECTION, #False, #Null)
  ;}
EndProcedure
ProcedureDLL Editor_RTF_RemoveFormat(Gadget.l,Flags.l)
  ; Set Format of the Selection. 
  ; This can be a combination of the following values :
  ; - #CFE_BOLD 
  ; - #CFE_ITALIC 
  ; - #CFE_UNDERLINE 
  ; - #CFE_STRIKEOUT  
  ;Tester
  ; - #CFE_AUTOCOLOR
  ; - #CFE_DISABLED
  ; - #CFE_PROTECTED

  ;{ Récuperation de l'ancienne sélection
    oldsel.CHARRANGE
    SendMessage_(GadgetID(Gadget), #EM_GETSEL, @oldsel\cpMin, @oldsel\cpMax)
  ;}
  ;{ Get EdOptions
  EdOptions = SendMessage_(GadgetID(Gadget), #EM_GETOPTIONS, 0,0)
  ;}
  ;{ Désactivation du Scolling Horizontal
  SendMessage_(GadgetID(Gadget), #EM_SETOPTIONS, #ECOOP_XOR, #ECO_AUTOHSCROLL)
  ;}
  ;{ Désactivation du Scolling Vertical
  SendMessage_(GadgetID(Gadget), #EM_SETOPTIONS, #ECOOP_XOR, #ECO_AUTOVSCROLL)
  ;}
  ;{ Désactivation de la sélection
  SendMessage_(GadgetID(Gadget), #EM_HIDESELECTION, #True, #Null)
  ;}
  For Inc_a=0 To (oldsel\cpMax-oldsel\cpMin)-1
    SendMessage_(GadgetID(Gadget), #EM_SETSEL, oldsel\cpMin+Inc_a, oldsel\cpMin+Inc_a+1)
    format.CHARFORMAT2
    format\cbSize = SizeOf(CHARFORMAT2)
    SendMessage_(GadgetID(Gadget), #EM_GETCHARFORMAT, #SCF_SELECTION, @format)
    If format\dwEffects& Flags
      format\cbSize = SizeOf(CHARFORMAT2)
      format\dwMask | #CFM_ITALIC|#CFM_BOLD|#CFM_STRIKEOUT|#CFM_UNDERLINE|#CFM_LINK
      format\dwEffects - Flags
    EndIf
    SendMessage_(GadgetID(Gadget), #EM_SETCHARFORMAT, #SCF_SELECTION, @format)  
  Next
  ;{ Remplacement de l'ancienne sélection
    SendMessage_(GadgetID(Gadget), #EM_SETSEL, oldsel\cpMin, oldsel\cpMax)
  ;}
  ;{ Activation du Scolling Horizontal
    SendMessage_(GadgetID(Gadget), #EM_SETOPTIONS, #ECOOP_SET, EdOptions)
  ;}
  ;{ Activation de la sélection
  SendMessage_(GadgetID(Gadget), #EM_HIDESELECTION, #False, #Null)
  ;}
EndProcedure
ProcedureDLL Editor_RTF_GetFormat(Gadget.l)
  Protected format.CHARFORMAT2
  format\cbSize = SizeOf(CHARFORMAT2)
  SendMessage_(GadgetID(Gadget), #EM_GETCHARFORMAT, #SCF_SELECTION, @format)
  ProcedureReturn format\dwEffects
EndProcedure

ProcedureDLL Editor_RTF_SetScript(Gadget.l, ScriptSize.l)
  format.CHARFORMAT2
  format\cbSize = SizeOf(CHARFORMAT2)
  SendMessage_(GadgetID(Gadget), #EM_GETCHARFORMAT, #SCF_SELECTION, @format)
  
  format\dwMask | #CFM_OFFSET
  format\yOffset = ScriptSize
  SendMessage_(GadgetID(Gadget), #EM_SETCHARFORMAT, #SCF_SELECTION, @format)
  ProcedureReturn 
EndProcedure
ProcedureDLL Editor_RTF_IsSubScript(Gadget.l)
  ; Indice
  Protected format.CHARFORMAT2
  format\cbSize = SizeOf(CHARFORMAT2) 
  SendMessage_(GadgetID(Gadget), #EM_GETCHARFORMAT, #SCF_SELECTION, @format) 
  size=format\yOffset
  If size<0
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_RTF_IsSuperScript(Gadget.l)
  ; Exposant
  Protected format.CHARFORMAT2
  format\cbSize = SizeOf(CHARFORMAT2) 
  SendMessage_(GadgetID(Gadget), #EM_GETCHARFORMAT, #SCF_SELECTION, @format) 
  size=format\yOffset
  If size>0  
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure

ProcedureDLL Editor_RTF_SetColorText(Gadget.l, Color.l)
  format.CHARFORMAT
  format\cbSize = SizeOf(CHARFORMAT)
  SendMessage_(GadgetID(Gadget), #EM_GETCHARFORMAT, #SCF_SELECTION, @format)
  If format\dwEffects & #CFE_AUTOCOLOR
    format\dwEffects - #CFE_AUTOCOLOR
  EndIf
  format\dwMask |#CFM_COLOR
  format\crTextColor = Color
  SendMessage_(GadgetID(Gadget), #EM_SETCHARFORMAT, #SCF_SELECTION, @format)
  ProcedureReturn
EndProcedure
ProcedureDLL Editor_RTF_GetColorText(Gadget.l)
  Protected format.CHARFORMAT2
  format\cbSize = SizeOf(CHARFORMAT2) 
  SendMessage_(GadgetID(Gadget), #EM_GETCHARFORMAT, #SCF_SELECTION, @format) 
  ProcedureReturn format\crTextColor
EndProcedure

ProcedureDLL Editor_RTF_SetColorBack(Gadget.l, Color.l)
  format.CHARFORMAT2
  format\cbSize = SizeOf(CHARFORMAT2)
  SendMessage_(GadgetID(Gadget), #EM_GETCHARFORMAT, #SCF_SELECTION, @format)
  If format\dwEffects & #CFM_BACKCOLOR
    format\dwEffects - #CFM_BACKCOLOR
  EndIf
  format\dwMask |#CFM_BACKCOLOR
  format\crBackColor  = Color
  SendMessage_(GadgetID(Gadget), #EM_SETCHARFORMAT, #SCF_SELECTION, @format)
  ProcedureReturn
EndProcedure
ProcedureDLL Editor_RTF_GetColorBack(Gadget.l)
  Protected format.CHARFORMAT2
  format\cbSize = SizeOf(CHARFORMAT2)
  SendMessage_(GadgetID(Gadget), #EM_GETCHARFORMAT, #SCF_SELECTION, @format)
  ProcedureReturn format\crBackColor
EndProcedure

ProcedureDLL Editor_RTF_IsBold(Format.l)
  If format & #CFE_BOLD
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_RTF_IsItalic(Format.l)
  If format & #CFE_ITALIC
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_RTF_IsUnderline(Format.l)
  If format & #CFE_UNDERLINE
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_RTF_IsStrikeout(Format.l)
  If format & #CFE_STRIKEOUT
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_RTF_IsAutoTextColor(Format.l)
  If format & #CFE_AUTOCOLOR
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_RTF_IsDisabled(Format.l)
  If format & #CFE_DISABLED
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_RTF_IsAutoBackColor(Format.l)
  If format & #CFE_AUTOBACKCOLOR
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_RTF_IsAllCaps(Format.l)
  If format & #CFE_ALLCAPS
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure

ProcedureDLL Editor_RTF_IsLink(Format.l)
  If format & #CFE_LINK
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf

EndProcedure
ProcedureDLL Editor_RTF_SetLink(Gadget.l, Activate.l)
  cf.CHARFORMAT2
  SendMessage_(GadgetID(Gadget), #EM_SETEVENTMASK, 0, #ENM_LINK|SendMessage_(GadgetID(Gadget), #EM_GETEVENTMASK, 0, 0))
  cf\cbSize = SizeOf(CHARFORMAT2)
  SendMessage_(GadgetID(Gadget), #EM_GETCHARFORMAT, #SCF_SELECTION, cf)
  cf\cbSize = SizeOf(CHARFORMAT2)

  If Activate=#True
    cf\dwMask|#CFM_LINK
    cf\dwEffects|#CFE_LINK
  Else
    cf\dwEffects - #CFE_LINK
  EndIf

  SendMessage_(GadgetID(Gadget), #EM_SETCHARFORMAT, #SCF_SELECTION, cf)
  ProcedureReturn 
EndProcedure

ProcedureDLL Editor_RTF_SetColorBackground(Gadget.l,Color.l)
  If Color = -1 ; couleur system
    SendMessage_(GadgetID(Gadget),#EM_SETBKGNDCOLOR,1,0)
  Else
    SendMessage_(GadgetID(Gadget),#EM_SETBKGNDCOLOR,#Null,Color)
  EndIf
EndProcedure

ProcedureDLL.s Editor_RTF_GetRTFCode(Gadget.l)
  ; on récupére la sélection d'avant
  s.CHARRANGE
  SendMessage_(GadgetID(gadget),#EM_EXGETSEL,0,@s)
  ; on copie tout dans le clipboard
  SendMessage_(GadgetID(Gadget),#EM_SETSEL, 0, -1)
  SendMessage_(GadgetID(Gadget),#WM_COPY,0,0)
  ; on obtient le code rtf
  If OpenClipboard_(0)
    ;Nombre de format contenu dans le presse papier
    NbFormat = CountClipboardFormats_()
    format = 0
    For n = 1 To NbFormat
      format = EnumClipboardFormats_(format)
      Nom.s = Space(255)
      GetClipboardFormatName_(format, @Nom.s, 255)
      Hmem = GetClipboardData_(format)
      *lpmem=GlobalLock_(Hmem)
      If *lpmem
        If Nom="Rich Text Format"
          Texte.s= PeekS(*lpmem)
          GlobalUnlock_(Hmem)
          Break
        EndIf
        GlobalUnlock_(Hmem)
      EndIf
    Next
    CloseClipboard_()
  EndIf
  ; on remet l'ancienne sélection
  SendMessage_(GadgetID(gadget),#EM_EXSETSEL,0,@s)
  ProcedureReturn Texte
EndProcedure
ProcedureDLL Editor_RTF_InsertRTFCode(Gadget.l, CodeRTF.s)
; CodeRTF >
;   commence {\rtf
;   finit     }
  If Left(CodeRTF,5)<>"{\rtf"
    CodeRTF = "{\urtf" + CodeRTF
  EndIf
  If Right(CodeRTF,1)<>"}"
    CodeRTF + "}"
  EndIf
  Protected settex.SETTEXTEX
  settex\flags=#ST_SELECTION
  settex\codepage=#CP_ACP 
  CompilerIf #PB_Compiler_Unicode = #True
    Protected buffer.l = AllocateMemory(Len(CodeRTF)+1)
    PokeS(buffer, CodeRTF, -1, #PB_Ascii)
    ProcedureReturn SendMessage_(GadgetID(Gadget), #EM_SETTEXTEX, settex, buffer)
  CompilerElse
    ProcedureReturn SendMessage_(GadgetID(Gadget), #EM_SETTEXTEX, settex, @CodeRTF)
  CompilerEndIf
EndProcedure

;}
;- OK Tableau
;{
ProcedureDLL Editor_Table_Create()
  Protected sTableRTF.s="{\rtf1\deff0"
  Protected *Table = AllocateMemory(Len(sTableRTF) + 1)
  PokeS(*Table, sTableRTF)
  ProcedureReturn *Table
EndProcedure
ProcedureDLL Editor_Table_Close(Table.l)
  Protected sTableRTF.s
  Protected *Table
  If Table 
    sTableRTF = PeekS(Table)
    sTableRTF + "}"
    
    FreeMemory(Table)
    
    *Table = AllocateMemory(Len(sTableRTF) + 1)
    
    PokeS(*Table, sTableRTF)
    ProcedureReturn *Table
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_Table_LineOpen(Table.l, MarginLeft.l)
  Protected sTableRTF.s
  Protected *Table
  If Table 
    sTableRTF = PeekS(Table)
    sTableRTF + "\trowd\trgaph"+Str(MarginLeft)
    
    FreeMemory(Table)
    
    *Table = AllocateMemory(Len(sTableRTF) + 1)
    
    PokeS(*Table, sTableRTF)
    ProcedureReturn *Table
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_Table_LineClose(Table.l)
  Protected sTableRTF.s
  Protected *Table
  If Table 
    sTableRTF = PeekS(Table)
    sTableRTF + "{\row }"
    
    FreeMemory(Table)
    
    *Table = AllocateMemory(Len(sTableRTF) + 1)
    
    PokeS(*Table, sTableRTF)
    ProcedureReturn *Table
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_Table_CellOpen(Table.l, CellSize.l)
  Protected sTableRTF.s
  Protected *Table
  If Table 
    sTableRTF = PeekS(Table)
    sTableRTF + "\cellx"+Str(CellSize)
    
    FreeMemory(Table)
    
    *Table = AllocateMemory(Len(sTableRTF) + 1)
    
    PokeS(*Table, sTableRTF)
    ProcedureReturn *Table
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_Table_CellContent(Table.l, sContent.s)
  Protected sTableRTF.s
  Protected *Table
  If Table 
    sTableRTF = PeekS(Table)
    sTableRTF + "\pard\intbl " + sContent
    
    FreeMemory(Table)
    
    *Table = AllocateMemory(Len(sTableRTF) + 1)
    
    PokeS(*Table, sTableRTF)
    ProcedureReturn *Table
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_Table_CellClose(Table.l)
  Protected sTableRTF.s
  Protected *Table
  If Table 
    sTableRTF = PeekS(Table)
    sTableRTF + "\cell"
    
    FreeMemory(Table)
    
    *Table = AllocateMemory(Len(sTableRTF) + 1)
    
    PokeS(*Table, sTableRTF)
    ProcedureReturn *Table
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_Table_Insert(Gadget.l, Line.l, Table.l)
  Protected sTableRTF.s
  If Table 
    sTableRTF = PeekS(Table)

    AddGadgetItem(Gadget, Line, sTableRTF)
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_Table_Clear(Table.l)
  If Table 
    FreeMemory(Table)
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure

;}
;- OK Bidirectional Options
;{
ProcedureDLL Editor_BIDI_GetOptions(Gadget.l)
  bidiget.BIDIOPTIONS
  bidiget\cbSize.l=SizeOf(BIDIOPTIONS)
  SendMessage_(GadgetID(Gadget), #EM_GETBIDIOPTIONS,0,bidiget)
  ProcedureReturn bidiget\wMask
EndProcedure
ProcedureDLL Editor_BIDI_IsDefault(Options.l)
  If Options & #BOM_DEFPARADIR
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_BIDI_IsPlainText(Options.l)
  If Options & #BOM_PLAINTEXT
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_BIDI_IsNeutralLayout(Options.l)
  If Options & #BOM_NEUTRALOVERRIDE
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_BIDI_IsContextReading(Options.l)
  If Options & #BOM_CONTEXTREADING
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
ProcedureDLL Editor_BIDI_IsContextAlignment(Options.l)
  If Options & #BOM_CONTEXTALIGNMENT
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
;}
;- Coloration Syntaxique
;{
;   Un langage a de nombreuses propriétés à qui est attribué un style et un état particuliers.


ProcedureDLL.l Editor_SH_CreateLanguage(Id.l, Name.s, MarkupLangage.b)
  Protected *RObject.S_RLibPlus_EditorLng = RLIBPLUS_EDLng_NEW(Id)
  If *RObject
    *RObject\Name       = Name
    *RObject\MarkupLng  = MarkupLangage
    ProcedureReturn *RObject
  EndIf
EndProcedure
ProcedureDLL.l Editor_SH_DeleteLanguage(Id.l, Name.s)
  Protected *RObject.S_RLibPlus_EditorLng = RLIBPLUS_EDLng_ID(Id)
  If *RObject
    ProcedureReturn RLibPlusEditorLngFree(Id.l)
  EndIf
EndProcedure

ProcedureDLL.l Editor_SH_SetLanguageName(Id.l, Name.s)
  Protected *RObject.S_RLibPlus_EditorLng = RLIBPLUS_EDLng_ID(Id)
  If *RObject
    *RObject\Name = Name
    ProcedureReturn #True
  EndIf
EndProcedure
ProcedureDLL.s Editor_SH_GetLanguageName(Id.l)
  Protected *RObject.S_RLibPlus_EditorLng = RLIBPLUS_EDLng_ID(Id)
  If *RObject
    ProcedureReturn *RObject\Name
  EndIf
EndProcedure
ProcedureDLL.b Editor_SH_SetLanguageMarkup(Id.l, MarkupLangage.b)
  Protected *RObject.S_RLibPlus_EditorLng = RLIBPLUS_EDLng_ID(Id)
  If *RObject
    *RObject\MarkupLng = MarkupLangage
    ProcedureReturn #True
  EndIf
EndProcedure
ProcedureDLL.b Editor_SH_GetLanguageMarkup(Id.l)
  Protected *RObject.S_RLibPlus_EditorLng = RLIBPLUS_EDLng_ID(Id)
  If *RObject
    ProcedureReturn *RObject\MarkupLng
  EndIf
EndProcedure

ProcedureDLL.l Editor_SH_SetProperty(Id.l, Property.l, Content.s)
  Protected *RObject.S_RLibPlus_EditorLng = RLIBPLUS_EDLng_ID(Id)
  If *RObject
    Select Property
      Case #Editor_SH_Property_String           : *RObject\StringChr  = Content
      Case #Editor_SH_Property_Comment          : *RObject\CommentChr = Content
      Case #Editor_SH_Property_Constant         : *RObject\ConstantChr = Content
      Case #Editor_SH_Property_Symbols          : *RObject\SymbolChr = Content
      Case #Editor_SH_Property_Operators        : *RObject\OperatorChr = Content
      Case #Editor_SH_Property_Brackets         : *RObject\BracketChr = Content
      Case #Editor_SH_Property_XML_CommentOpen  : *RObject\XML_CommentOpenChr = Content
      Case #Editor_SH_Property_XML_CommentClose : *RObject\XML_CommentCloseChr = Content
      Case #Editor_SH_Property_XML_TagOpen      : *RObject\XML_TagOpenChr = Content
      Case #Editor_SH_Property_XML_TagClose     : *RObject\XML_TagCloseChr = Content
      Case #Editor_SH_Property_XML_Close        : *RObject\XML_CloseChr = Content

      Default : ProcedureReturn #False
    EndSelect
    ProcedureReturn #True
  EndIf
EndProcedure
ProcedureDLL.s Editor_SH_GetProperty(Id.l, Property.l)
  Protected *RObject.S_RLibPlus_EditorLng = RLIBPLUS_EDLng_ID(Id)
  If *RObject
    Select Property
      Case #Editor_SH_Property_String           : ProcedureReturn *RObject\StringChr  
      Case #Editor_SH_Property_Comment          : ProcedureReturn *RObject\CommentChr 
      Case #Editor_SH_Property_Constant         : ProcedureReturn *RObject\ConstantChr
      Case #Editor_SH_Property_Symbols          : ProcedureReturn *RObject\SymbolChr
      Case #Editor_SH_Property_Operators        : ProcedureReturn *RObject\OperatorChr
      Case #Editor_SH_Property_Brackets         : ProcedureReturn *RObject\BracketChr 
      Case #Editor_SH_Property_XML_CommentOpen  : ProcedureReturn *RObject\XML_CommentOpenChr
      Case #Editor_SH_Property_XML_CommentClose : ProcedureReturn *RObject\XML_CommentCloseChr
      Case #Editor_SH_Property_XML_TagOpen      : ProcedureReturn *RObject\XML_TagOpenChr
      Case #Editor_SH_Property_XML_TagClose     : ProcedureReturn *RObject\XML_TagCloseChr
      Case #Editor_SH_Property_XML_Close        : ProcedureReturn *RObject\XML_CloseChr
      Default                                   : ProcedureReturn ""
    EndSelect
  EndIf
EndProcedure

ProcedureDLL.l Editor_SH_SetKeywords(Id.l, List Keywords.s())
  Protected *RObject.S_RLibPlus_EditorLng = RLIBPLUS_EDLng_ID(Id)
  If *RObject
    *RObject\KeywordsList = ""
    ForEach Keywords()
      If *RObject\KeywordsList = ""
        *RObject\KeywordsList = Keywords()
      Else
        *RObject\KeywordsList + ";" + Keywords()
      EndIf
    Next
    ProcedureReturn #True
  EndIf
EndProcedure
ProcedureDLL.s Editor_SH_GetKeywords(Id.l)
  Protected *RObject.S_RLibPlus_EditorLng = RLIBPLUS_EDLng_ID(Id)
  If *RObject
    ProcedureReturn *RObject\KeywordsList
  EndIf
EndProcedure

ProcedureDLL.l Editor_SH_SetPropertyFormat(Id.l, Property.l, FontName.s, FontSize.l, FontStyle.l, BackColor.l, FrontColor.l)
  Protected *RObject.S_RLibPlus_EditorLng = RLIBPLUS_EDLng_ID(Id)
  If *RObject
    Select Property
      Case #Editor_SH_Property_Text
        With *RObject\TextFormat
          \FontName = FontName
          \FontSize = FontSize
          \FontStyle= FontStyle
          \BackColor= BackColor
          \FrontColor=FrontColor
        EndWith
      Case #Editor_SH_Property_Keyword
        With *RObject\KeywordFormat
          \FontName = FontName
          \FontSize = FontSize
          \FontStyle= FontStyle
          \BackColor= BackColor
          \FrontColor=FrontColor
        EndWith
      Case #Editor_SH_Property_Integer
        With *RObject\IntegerFormat
          \FontName = FontName
          \FontSize = FontSize
          \FontStyle= FontStyle
          \BackColor= BackColor
          \FrontColor=FrontColor
        EndWith
      Case #Editor_SH_Property_String
        With *RObject\StringFormat
          \FontName = FontName
          \FontSize = FontSize
          \FontStyle= FontStyle
          \BackColor= BackColor
          \FrontColor=FrontColor
        EndWith
      Case #Editor_SH_Property_Comment
        With *RObject\CommentFormat
          \FontName = FontName
          \FontSize = FontSize
          \FontStyle= FontStyle
          \BackColor= BackColor
          \FrontColor=FrontColor
        EndWith
      Case #Editor_SH_Property_Constant
        With *RObject\ConstantFormat
          \FontName = FontName
          \FontSize = FontSize
          \FontStyle= FontStyle
          \BackColor= BackColor
          \FrontColor=FrontColor
        EndWith
      Case #Editor_SH_Property_Symbols
        With *RObject\SymbolFormat
          \FontName = FontName
          \FontSize = FontSize
          \FontStyle= FontStyle
          \BackColor= BackColor
          \FrontColor=FrontColor
        EndWith
      Case #Editor_SH_Property_Operators
        With *RObject\OperatorFormat
          \FontName = FontName
          \FontSize = FontSize
          \FontStyle= FontStyle
          \BackColor= BackColor
          \FrontColor=FrontColor
        EndWith
      Case #Editor_SH_Property_Brackets
        With *RObject\BracketFormat
          \FontName = FontName
          \FontSize = FontSize
          \FontStyle= FontStyle
          \BackColor= BackColor
          \FrontColor=FrontColor
        EndWith
      Default : ProcedureReturn #False
    EndSelect
    ProcedureReturn #True
  EndIf
EndProcedure
ProcedureDLL.s Editor_SH_GetPropertyFormatFontName(Id.l, Property.l)
  Protected *RObject.S_RLibPlus_EditorLng = RLIBPLUS_EDLng_ID(Id)
  If *RObject
    Select Property
      Case #Editor_SH_Property_Text
        With *RObject\TextFormat
          ProcedureReturn \FontName
        EndWith
      Case #Editor_SH_Property_Keyword
        With *RObject\KeywordFormat
          ProcedureReturn \FontName
        EndWith
      Case #Editor_SH_Property_Integer
        With *RObject\IntegerFormat
          ProcedureReturn \FontName
        EndWith
      Case #Editor_SH_Property_String
        With *RObject\StringFormat
          ProcedureReturn \FontName
        EndWith
      Case #Editor_SH_Property_Comment
        With *RObject\CommentFormat
          ProcedureReturn \FontName
        EndWith
      Case #Editor_SH_Property_Constant
        With *RObject\ConstantFormat
          ProcedureReturn \FontName
        EndWith
      Case #Editor_SH_Property_Symbols
        With *RObject\SymbolFormat
          ProcedureReturn \FontName
        EndWith
      Case #Editor_SH_Property_Operators
        With *RObject\OperatorFormat
          ProcedureReturn \FontName
        EndWith
      Case #Editor_SH_Property_Brackets
        With *RObject\BracketFormat
          ProcedureReturn \FontName
        EndWith
      Default : ProcedureReturn ""
    EndSelect
  EndIf
EndProcedure
ProcedureDLL.l Editor_SH_GetPropertyFormatFontSize(Id.l, Property.l)
  Protected *RObject.S_RLibPlus_EditorLng = RLIBPLUS_EDLng_ID(Id)
  If *RObject
    Select Property
      Case #Editor_SH_Property_Text
        With *RObject\TextFormat
          ProcedureReturn \FontSize
        EndWith
      Case #Editor_SH_Property_Keyword
        With *RObject\KeywordFormat
          ProcedureReturn \FontSize
        EndWith
      Case #Editor_SH_Property_Integer
        With *RObject\IntegerFormat
          ProcedureReturn \FontSize
        EndWith
      Case #Editor_SH_Property_String
        With *RObject\StringFormat
          ProcedureReturn \FontSize
        EndWith
      Case #Editor_SH_Property_Comment
        With *RObject\CommentFormat
          ProcedureReturn \FontSize
        EndWith
      Case #Editor_SH_Property_Constant
        With *RObject\ConstantFormat
          ProcedureReturn \FontSize
        EndWith
      Case #Editor_SH_Property_Symbols
        With *RObject\SymbolFormat
          ProcedureReturn \FontSize
        EndWith
      Case #Editor_SH_Property_Operators
        With *RObject\OperatorFormat
          ProcedureReturn \FontSize
        EndWith
      Case #Editor_SH_Property_Brackets
        With *RObject\BracketFormat
          ProcedureReturn \FontSize
        EndWith
      Default : ProcedureReturn #False
    EndSelect
  EndIf
EndProcedure
ProcedureDLL.l Editor_SH_GetPropertyFormatFontStyle(Id.l, Property.l)
  Protected *RObject.S_RLibPlus_EditorLng = RLIBPLUS_EDLng_ID(Id)
  If *RObject
    Select Property
      Case #Editor_SH_Property_Text
        With *RObject\TextFormat
          ProcedureReturn \FontStyle
        EndWith
      Case #Editor_SH_Property_Keyword
        With *RObject\KeywordFormat
          ProcedureReturn \FontStyle
        EndWith
      Case #Editor_SH_Property_Integer
        With *RObject\IntegerFormat
          ProcedureReturn \FontStyle
        EndWith
      Case #Editor_SH_Property_String
        With *RObject\StringFormat
          ProcedureReturn \FontStyle
        EndWith
      Case #Editor_SH_Property_Comment
        With *RObject\CommentFormat
          ProcedureReturn \FontStyle
        EndWith
      Case #Editor_SH_Property_Constant
        With *RObject\ConstantFormat
          ProcedureReturn \FontStyle
        EndWith
      Case #Editor_SH_Property_Symbols
        With *RObject\SymbolFormat
          ProcedureReturn \FontStyle
        EndWith
      Case #Editor_SH_Property_Operators
        With *RObject\OperatorFormat
          ProcedureReturn \FontStyle
        EndWith
      Case #Editor_SH_Property_Brackets
        With *RObject\BracketFormat
          ProcedureReturn \FontStyle
        EndWith
      Default : ProcedureReturn #False
    EndSelect
  EndIf
EndProcedure
ProcedureDLL.l Editor_SH_GetPropertyFormatBackColor(Id.l, Property.l)
  Protected *RObject.S_RLibPlus_EditorLng = RLIBPLUS_EDLng_ID(Id)
  If *RObject
    Select Property
      Case #Editor_SH_Property_Text
        With *RObject\TextFormat
          ProcedureReturn \BackColor
        EndWith
      Case #Editor_SH_Property_Keyword
        With *RObject\KeywordFormat
          ProcedureReturn \BackColor
        EndWith
      Case #Editor_SH_Property_Integer
        With *RObject\IntegerFormat
          ProcedureReturn \BackColor
        EndWith
      Case #Editor_SH_Property_String
        With *RObject\StringFormat
          ProcedureReturn \BackColor
        EndWith
      Case #Editor_SH_Property_Comment
        With *RObject\CommentFormat
          ProcedureReturn \BackColor
        EndWith
      Case #Editor_SH_Property_Constant
        With *RObject\ConstantFormat
          ProcedureReturn \BackColor
        EndWith
      Case #Editor_SH_Property_Symbols
        With *RObject\SymbolFormat
          ProcedureReturn \BackColor
        EndWith
      Case #Editor_SH_Property_Operators
        With *RObject\OperatorFormat
          ProcedureReturn \BackColor
        EndWith
      Case #Editor_SH_Property_Brackets
        With *RObject\BracketFormat
          ProcedureReturn \BackColor
        EndWith
      Default : ProcedureReturn #False
    EndSelect
  EndIf
EndProcedure
ProcedureDLL.l Editor_SH_GetPropertyFormatFrontColor(Id.l, Property.l)
  Protected *RObject.S_RLibPlus_EditorLng = RLIBPLUS_EDLng_ID(Id)
  If *RObject
    Select Property
      Case #Editor_SH_Property_Text
        With *RObject\TextFormat
          ProcedureReturn \FrontColor
        EndWith
      Case #Editor_SH_Property_Keyword
        With *RObject\KeywordFormat
          ProcedureReturn \FrontColor
        EndWith
      Case #Editor_SH_Property_Integer
        With *RObject\IntegerFormat
          ProcedureReturn \FrontColor
        EndWith
      Case #Editor_SH_Property_String
        With *RObject\StringFormat
          ProcedureReturn \FrontColor
        EndWith
      Case #Editor_SH_Property_Comment
        With *RObject\CommentFormat
          ProcedureReturn \FrontColor
        EndWith
      Case #Editor_SH_Property_Constant
        With *RObject\ConstantFormat
          ProcedureReturn \FrontColor
        EndWith
      Case #Editor_SH_Property_Symbols
        With *RObject\SymbolFormat
          ProcedureReturn \FrontColor
        EndWith
      Case #Editor_SH_Property_Operators
        With *RObject\OperatorFormat
          ProcedureReturn \FrontColor
        EndWith
      Case #Editor_SH_Property_Brackets
        With *RObject\BracketFormat
          ProcedureReturn \FrontColor
        EndWith
      Default : ProcedureReturn #False
    EndSelect
  EndIf
EndProcedure

ProcedureDLL.l Editor_SH_SetPropertyState(Id.l, Property.l, State.b)
  Protected *RObject.S_RLibPlus_EditorLng = RLIBPLUS_EDLng_ID(Id)
  If *RObject
    Select Property
      Case #Editor_SH_Property_String           : *RObject\StringActive = State
      Case #Editor_SH_Property_Text             : *RObject\TextActive = State
      Case #Editor_SH_Property_Keyword          : *RObject\KeywordActive = State
      Case #Editor_SH_Property_Integer          : *RObject\IntegerActive = State
      Case #Editor_SH_Property_Comment          : *RObject\CommentActive = State
      Case #Editor_SH_Property_Constant         : *RObject\ConstantActive = State
      Case #Editor_SH_Property_Symbols          : *RObject\SymbolActive = State
      Case #Editor_SH_Property_Operators        : *RObject\OperatorActive = State
      Case #Editor_SH_Property_Brackets         : *RObject\BracketActive = State
      Case #Editor_SH_Property_XML_CommentOpen  : *RObject\XML_CommentOpenActive = State
      Case #Editor_SH_Property_XML_CommentClose : *RObject\XML_CommentCloseActive = State
      Case #Editor_SH_Property_XML_TagOpen      : *RObject\XML_TagOpenActive = State
      Case #Editor_SH_Property_XML_TagClose     : *RObject\XML_TagCloseActive = State
      Case #Editor_SH_Property_XML_Close        : *RObject\XML_CloseActive = State
      Default : ProcedureReturn #False
    EndSelect
  EndIf
EndProcedure
ProcedureDLL.b Editor_SH_GetPropertyState(Id.l, Property.l)
  Protected *RObject.S_RLibPlus_EditorLng = RLIBPLUS_EDLng_ID(Id)
  If *RObject
    Select Property
      Case #Editor_SH_Property_String           : ProcedureReturn *RObject\StringActive
      Case #Editor_SH_Property_Text             : ProcedureReturn *RObject\TextActive
      Case #Editor_SH_Property_Keyword          : ProcedureReturn *RObject\KeywordActive
      Case #Editor_SH_Property_Integer          : ProcedureReturn *RObject\IntegerActive
      Case #Editor_SH_Property_Comment          : ProcedureReturn *RObject\CommentActive
      Case #Editor_SH_Property_Constant         : ProcedureReturn *RObject\ConstantActive
      Case #Editor_SH_Property_Symbols          : ProcedureReturn *RObject\SymbolActive
      Case #Editor_SH_Property_Operators        : ProcedureReturn *RObject\OperatorActive
      Case #Editor_SH_Property_Brackets         : ProcedureReturn *RObject\BracketActive
      Case #Editor_SH_Property_XML_CommentOpen  : ProcedureReturn *RObject\XML_CommentOpenActive
      Case #Editor_SH_Property_XML_CommentClose : ProcedureReturn *RObject\XML_CommentCloseActive
      Case #Editor_SH_Property_XML_TagOpen      : ProcedureReturn *RObject\XML_TagOpenActive
      Case #Editor_SH_Property_XML_TagClose     : ProcedureReturn *RObject\XML_TagCloseActive
      Case #Editor_SH_Property_XML_Close        : ProcedureReturn *RObject\XML_CloseActive
      Default                                   : ProcedureReturn #False
    EndSelect
  EndIf
EndProcedure

ProcedureDLL.l Editor_SH_EnableSHGadget(Gadget.l, Language.l)
  Protected *RObject.S_RLibPlus_Editor = RLIBPLUS_ED_NEW(Gadget)
  If *RObject
    *RObject\ErrorBuf = 1
    *RObject\Gadget   = Gadget
    *RObject\Language = Language
    ;Debug Language
  EndIf
EndProcedure
ProcedureDLL.l Editor_SH_DisableSHGadget(Gadget.l)
  Protected *RObject.S_RLibPlus_Editor = RLIBPLUS_ED_ID(Gadget)
  If *RObject
    ProcedureReturn RLibPlusEditorFree(Gadget.l)
  EndIf
EndProcedure
ProcedureDLL.l Editor_SH_GetSHGadget(Gadget.l)
  Protected *RObject.S_RLibPlus_Editor = RLIBPLUS_ED_ID(Gadget)
  If *RObject
    ProcedureReturn *RObject\Language
  EndIf
EndProcedure

Procedure Editor_SH_Update_Proc(Gadget.l)
  Protected *RObject.S_RLibPlus_Editor = RLIBPLUS_ED_ID(Gadget)
  Protected *RLng.S_RLibPlus_EditorLng = RLIBPLUS_EDLng_ID(*RObject\Language)

  Protected Inc_a.l, Inc_b.l, NbString.l
  Protected Char.s, SearchChar.s
  Protected NewSel.CHARRANGE
  
  ;Debug "------"
  Pos_y = Editor_GetCursorY(Gadget)
  Text_CurrentLine.s = LCase(GetGadgetItemText(Gadget,Pos_y,0))
  If *RObject\Text<>Text_CurrentLine
    Pos           = Editor_GetCursorPos(Gadget)
    Pos_x         = Editor_GetCursorX(Gadget)
    *RObject\Text = Text_CurrentLine
    ; Y a t il du texte ?
    If Len(Text_CurrentLine)>0
      ;{ Récuperation de l'ancienne sélection
        oldsel.CHARRANGE
        SendMessage_(GadgetID(Gadget), #EM_GETSEL, @oldsel\cpMin, @oldsel\cpMax)
      ;}
      ;{ Désactivation du Scolling Horizontal
      EdOptions = SendMessage_(GadgetID(Gadget), #EM_GETOPTIONS, 0,0)
      SendMessage_(GadgetID(Gadget), #EM_SETOPTIONS, #ECOOP_XOR, #ECO_AUTOHSCROLL)
      ;}
      ;{ Désactivation de la sélection
      SendMessage_(GadgetID(Gadget), #EM_HIDESELECTION, #True, #Null)
      ;}
      ;{  Coloration Syntaxique
        ;{ --- Valeurs SH ---
          ; début de la ligne
          lignedeb=SendMessage_(GadgetID(Gadget), #EM_LINEINDEX, Pos_y, 0)-1
        ;}
        ;{ Texte - Text
          If *RLng\TextActive = #True
            ; On définit le format
            RLibPlus_Editor_SH_SetFormat(TextFormat)
            ;{ On sélectionne la ligne
              ; position du début de la ligne
              NewSel\cpMin = lignedeb + 1 
              ; position de la fin de la ligne = position du début de la ligne + nb caractères de la ligne
              NewSel\cpMax = lignedeb + 1 + Len(Text_CurrentLine)
              SendMessage_(GadgetID(Gadget), #EM_EXSETSEL, 0, @NewSel)
            ;}
            RLibPlus_Editor_SH_ApplyFormat()
          EndIf
        ;}
        ;{ Symboles - Symbols
          If *RLng\SymbolActive = #True
            RLibPlus_Editor_SH_SetFormat(SymbolFormat)
            ;{ On sélectionne seulement les Symboles
            ;Debug "SH - Symboles"
            For Inc_a = 1 To Len(Text_CurrentLine)
              Char = Mid(Text_CurrentLine, Inc_a, 1)
              For Inc_b = 1 To Len(*RLng\SymbolChr)
                SearchChar = Mid(*RLng\SymbolChr, Inc_b, 1)
                ;Debug symbol
                If Char = SearchChar
                  ; position du début de la constante
                  NewSel\cpMin = lignedeb + Inc_a
                  ; position de la fin de la constante = position du début de la constante + nb caractères de la constante
                  NewSel\cpMax = lignedeb + Inc_a + 1
                  SendMessage_(GadgetID(Gadget), #EM_EXSETSEL, 0, @NewSel)
                  RLibPlus_Editor_SH_ApplyFormat()
                  Break 1
                EndIf
              Next Inc_b
            Next Inc_a
            ;}            
          EndIf
        ;}
        ;{ Opérateurs - Operators
          If *RLng\OperatorActive = #True
            RLibPlus_Editor_SH_SetFormat(OperatorFormat)
            ;{ On sélectionne seulement les opérateurs
            ;Debug "SH - Opérateurs"
            For Inc_a = 1 To Len(Text_CurrentLine)
              Char = Mid(Text_CurrentLine, Inc_a, 1)
              For Inc_b = 1 To Len(*RLng\OperatorChr)
                SearchChar = Mid(*RLng\OperatorChr, Inc_b, 1)
                ;Debug operator
                If Char = SearchChar
                  ; position du début de la constante
                  NewSel\cpMin = lignedeb + Inc_a
                  ; position de la fin de la constante = position du début de la constante + nb caractères de la constante
                  NewSel\cpMax = lignedeb + Inc_a + 1
                  SendMessage_(GadgetID(Gadget), #EM_EXSETSEL, 0, @NewSel)
                  RLibPlus_Editor_SH_ApplyFormat()
                  Break 1
                EndIf
              Next Inc_b
            Next Inc_a
            ;}            
          EndIf
        ;}
        ;{ Entiers - Integers
          If *RLng\IntegerActive = #True
            RLibPlus_Editor_SH_SetFormat(IntegerFormat)
            ;{ On sélectionne seulement les nombres
            ;Debug "SH - Nombres"
            NbString = CountString(Text_CurrentLine,Chr(32))
            For Inc_a=1 To NbString + 1
              Protected Result.l  = 0
              Protected DebSol.l  = 0
              SearchChar = StringField(Text_CurrentLine,Inc_a,Chr(32))
              If Common_IsNumeric(SearchChar)
                For Inc_b = 0 To (Inc_a-2)
                  Result = FindString(Text_CurrentLine,Chr(32), Result)
                  Result + 1
                Next       
                DebSol = FindString(Text_CurrentLine, SearchChar, Result)
                If DebSol=0
                  DebSol=1
                EndIf
                ; position du début du mot
                NewSel\cpMin = lignedeb + DebSol
                ; position de la fin du mot = position du début du mot + nb caractères du mot
                NewSel\cpMax = lignedeb + DebSol + Len(SearchChar)
                SendMessage_(GadgetID(Gadget), #EM_EXSETSEL, 0, @NewSel)
                RLibPlus_Editor_SH_ApplyFormat()
              EndIf
              ;Debug "---------------------------"
            Next
            ;}
          EndIf
        ;}
        ;{ Constantes - Constants
          If *RLng\ConstantActive = #True
            RLibPlus_Editor_SH_SetFormat(ConstantFormat)
            ;{ On sélectionne seulement les constantes
            ;Debug "SH - Constantes"
            NbString = CountString(Text_CurrentLine,*RLng\ConstantChr)
            For Inc_a = 1 To NbString
              Protected Pos_Diese.l = 0
              Protected Pos_Space.l = 0
              For Inc_b =1 To Inc_a
                Pos_Diese + 1
                Pos_Diese = FindString(Text_CurrentLine, *RLng\ConstantChr, Pos_Diese)
                Pos_Space = FindString(Text_CurrentLine, Chr(32), Pos_Diese)
              Next
              ; Est ce que le dièse est en début de ligne ?
              ; Est ce qu'il y a un espace avant le dièse ?
              If Pos_Diese = 1 Or Mid(Text_CurrentLine,Pos_Diese-1,1) = Chr(32)
                ; Est-ce la fin de la ligne ?
                If Pos_Space = 0 : Pos_Space = Len(Text_CurrentLine) + 1 : EndIf
                ; position du début de la constante
                NewSel\cpMin = lignedeb + Pos_Diese
                ; position de la fin de la constante = position du début de la constante + nb caractères de la constante
                NewSel\cpMax = lignedeb + Pos_Space 
                SendMessage_(GadgetID(Gadget), #EM_EXSETSEL, 0, @NewSel)
                RLibPlus_Editor_SH_ApplyFormat()
              EndIf
            Next
            ;}
          EndIf
        ;}
        ;{ Mots Clefs - Keywords
          If *RLng\KeywordActive = #True
            Protected Pos_Keyword.l = 0
            NumKeyword=CountString(*RLng\KeywordsList, ";") + 1
            If Len(*RLng\KeywordsList) = 0 : NumKeyword = 0 : EndIf
            If NumKeyword > 0
              RLibPlus_Editor_SH_SetFormat(KeywordFormat)
              For Inc_a= 1 To NumKeyword
                ;Debug "SH - Keyword"
                SearchChar = StringField(*RLng\KeywordsList, Inc_a,";")
                NbString = CountString(LCase(Text_CurrentLine), SearchChar)
                If NbString > 0
                  Pos_Keyword = 1
                  For Inc_b=1 To NbString
                    Pos_Keyword = FindString(LCase(Text_CurrentLine),LCase(SearchChar), Pos_Keyword)
                    ; position du début 
                    NewSel\cpMin = lignedeb + Pos_Keyword
                    ; position de la fin du keyword = position du début du keyword + nb caractères du keyword
                    NewSel\cpMax = lignedeb + Pos_Keyword + Len(SearchChar)
                    SendMessage_(GadgetID(Gadget), #EM_EXSETSEL, 0, @NewSel)
                    RLibPlus_Editor_SH_ApplyFormat()
                    Pos_Keyword + 1
                  Next
                EndIf
              Next
            EndIf
          EndIf
        ;}
        ;{ Parenthèses - Brackets
          If *RLng\BracketActive = #True
            RLibPlus_Editor_SH_SetFormat(BracketFormat)
            ;{ On sélectionne seulement les parenthèses
            ;Debug "SH - Opérateurs"
            For Inc_a = 1 To Len(Text_CurrentLine)
              Char = Mid(Text_CurrentLine, Inc_a, 1)
              For Inc_b = 1 To Len(*RLng\BracketChr)
                SearchChar = Mid(*RLng\BracketChr,Inc_b, 1)
                ;Debug operator
                If Char = SearchChar
                  ; position du début de la constante
                  NewSel\cpMin = lignedeb + Inc_a
                  ; position de la fin de la constante = position du début de la constante + nb caractères de la constante
                  NewSel\cpMax = lignedeb + Inc_a + 1
                  SendMessage_(GadgetID(Gadget), #EM_EXSETSEL, 0, @NewSel)
                  RLibPlus_Editor_SH_ApplyFormat()
                  Break 1
                EndIf
              Next Inc_b
            Next Inc_a
            ;}            
          EndIf
        ;}
        ;{ Chaines - Strings
          If *RLng\StringActive = #True
            Protected Str_Deb.l, Str_Fin.l
            Protected CountQuote.l
            RLibPlus_Editor_SH_SetFormat(StringFormat)
            ;{ On cherche les chaines
            Str_Deb=0
            If CountString(Text_CurrentLine,*RLng\StringChr) = 0
              CountQuote = 0
            ElseIf CountString(Text_CurrentLine,*RLng\StringChr) = 1
              CountQuote = 1
            Else 
              CountQuote = CountString(Text_CurrentLine,*RLng\StringChr) / 2
            EndIf
            For Inc_a=1 To CountQuote
              Str_Deb=FindString(Text_CurrentLine,*RLng\StringChr,Str_Deb+1)
              Str_Fin=FindString(Text_CurrentLine,*RLng\StringChr,Str_Deb+1)
              If Str_Fin = 0 : Str_Fin = Len(Text_CurrentLine) : EndIf
              If Str_Fin > Str_Deb
                ; position du début de la chaine
                NewSel\cpMin = lignedeb + Str_Deb
                ; position de la fin de la chaine = position du début de la chaine + nb caractères de la chaine
                NewSel\cpMax = lignedeb + Str_Fin + 1
                SendMessage_(GadgetID(Gadget), #EM_EXSETSEL, 0, @NewSel)
                RLibPlus_Editor_SH_ApplyFormat()
              EndIf
              Str_Deb = Str_Fin
            Next
            ;}
          EndIf
        ;}
        ;{ Commentaires - Comments
          ;{ Simples
            If *RLng\CommentActive = #True
              RLibPlus_Editor_SH_SetFormat(CommentFormat)
              ;{ On cherche les commentaires simples
              Inc_a=FindString(Text_CurrentLine, *RLng\CommentChr, 1)
              If Inc_a <> 0
                ; position du début du commentaire
                NewSel\cpMin = lignedeb + Inc_a
                ; position de la fin de la ligne = position du début de la ligne + nb caractères de la ligne
                NewSel\cpMax = lignedeb + Len(Text_CurrentLine) + 1
                SendMessage_(GadgetID(Gadget), #EM_EXSETSEL, 0, @NewSel)
                RLibPlus_Editor_SH_ApplyFormat()
              EndIf
              ;}
            EndIf
          ;}
        ;}
      ;}
      ;{ Activation du Scolling Horizontal
      SendMessage_(GadgetID(Gadget), #EM_SETOPTIONS, #ECOOP_SET, EdOptions)
      ;}
      ;{ Activation de la sélection
      SendMessage_(GadgetID(Gadget), #EM_HIDESELECTION, #False, #Null)
      ;}
      ;{ Remplacement de l'ancienne sélection
        SendMessage_(GadgetID(Gadget), #EM_SETSEL, oldsel\cpMin, oldsel\cpMax)
      ;}
    EndIf
  EndIf
EndProcedure

ProcedureDLL Editor_SH_Update(Gadget.l)
  Protected *RObject.S_RLibPlus_Editor = RLIBPLUS_ED_ID(Gadget)
  ;Debug *RObject\Gadget
  ;Debug *RObject\Language
  If *RObject
    Protected *RLng.S_RLibPlus_EditorLng = RLIBPLUS_EDLng_ID(*RObject\Language)
    If *RLng\MarkupLng = #False
      ProcedureReturn Editor_SH_Update_Proc(Gadget)
    Else
      ;ProcedureReturn Editor_SH_Update_Mark(Gadget)
    EndIf
  Else
    ProcedureReturn -1
  EndIf
EndProcedure
;}
