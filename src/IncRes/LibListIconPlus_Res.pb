;{
  #LVM_GETHEADER                = #LVM_FIRST + 31
  #LVM_SETICONSPACING           = #LVM_FIRST + 53
  #LVM_SETEXTENDEDLISTVIEWSTYLE = #LVM_FIRST + 54
  #LVM_GETEXTENDEDLISTVIEWSTYLE = #LVM_FIRST + 55
  #LVM_GETSUBITEMRECT           = #LVM_FIRST + 56
  #LVM_SUBITEMHITTEST           = #LVM_FIRST + 57
  #LVM_SETCOLUMNORDERARRAY      = #LVM_FIRST + 58
  #LVM_GETCOLUMNORDERARRAY      = #LVM_FIRST + 59
  #LVM_GETHOTITEM               = #LVM_FIRST + 61
  #LVM_SETHOTCURSOR             = #LVM_FIRST + 62
  #LVM_GETHOTCURSOR             = #LVM_FIRST + 63
  #LVM_APPROXIMATEVIEWRECT      = #LVM_FIRST + 64
  #LVM_SETWORKAREAS             = #LVM_FIRST + 65
  #LVM_GETSELECTIONMARK         = #LVM_FIRST + 66
  #LVM_SETSELECTIONMARK         = #LVM_FIRST + 67
  #LVM_GETWORKAREAS             = #LVM_FIRST + 70
  #LVM_SETHOVERTIME             = #LVM_FIRST + 71
  #LVM_GETHOVERTIME             = #LVM_FIRST + 72
  #LVM_GETNUMBEROFWORKAREAS     = #LVM_FIRST + 73
  #LVM_SETTOOLTIPS              = #LVM_FIRST + 74
  #LVM_GETTOOLTIPS              = #LVM_FIRST + 78
  #LVM_SETSELECTEDCOLUMN        = #LVM_FIRST + 140
  #LVM_SETVIEW                  = #LVM_FIRST + 142
  #LVM_GETVIEW                  = #LVM_FIRST + 143
  #LVM_INSERTGROUP              = #LVM_FIRST + 145
  #LVM_GETGROUPINFO             = #LVM_FIRST + 149
  #LVM_MOVEITEMTOGROUP          = #LVM_FIRST + 154
  #LVM_SETGROUPMETRICS          = #LVM_FIRST + 155
  #LVM_GETGROUPMETRICS          = #LVM_FIRST + 156
  #LVM_ENABLEGROUPVIEW          = #LVM_FIRST + 157
  #LVM_REMOVEALLGROUPS          = #LVM_FIRST + 160
  #LVM_HASGROUP                 = #LVM_FIRST + 161
  #LVM_GETTILEVIEWINFO          = #LVM_FIRST + 163
  #LVM_SETTILEINFO              = #LVM_FIRST + 164
  #LVM_GETTILEINFO              = #LVM_FIRST + 165
  #LVM_SETINSERTMARK            = #LVM_FIRST + 166
  #LVM_GETINSERTMARK            = #LVM_FIRST + 167
  #LVM_INSERTMARKHITTEST        = #LVM_FIRST + 168
  #LVM_GETINSERTMARKRECT        = #LVM_FIRST + 169
  #LVM_SETINSERTMARKCOLOR       = #LVM_FIRST + 170
  #LVM_GETINSERTMARKCOLOR       = #LVM_FIRST + 171
  #LVM_SETINFOTIP               = #LVM_FIRST + 173
  #LVM_GETSELECTEDCOLUMN        = #LVM_FIRST + 174
  #LVM_ISGROUPVIEWENABLED       = #LVM_FIRST + 175
  #LVM_GETOUTLINECOLOR          = #LVM_FIRST + 176
  #LVM_SETOUTLINECOLOR          = #LVM_FIRST + 177
  #LVM_CANCELEDITLABEL          = #LVM_FIRST + 179
  
  #LVM_GETUNICODEFORMAT         = #CCM_GETUNICODEFORMAT
  #LVM_SETUNICODEFORMAT         = #CCM_SETUNICODEFORMAT
  
  #LVIF_INDENT                  = $10
  #LVIF_GROUPID                 = $100
  #LVIF_COLUMNS                 = $200
  #LVIF_NORECOMPUTE             = $800
  
  #LV_VIEW_ICON                 = $0
  #LV_VIEW_DETAILS              = $1
  #LV_VIEW_SMALLICON            = $2
  #LV_VIEW_LIST                 = $3
  #LV_VIEW_TILE                 = $4
  #LV_VIEW_MAX                  = $4
  
  #LVBKIF_SOURCE_URL            = $2
  #LVBKIF_SOURCE_MASK           = $3
  #LVBKIF_STYLE_NORMAL          = $0
  #LVBKIF_STYLE_TILE            = $10
  #LVBKIF_STYLE_MASK            = $10
  #LVBKIF_FLAG_TILEOFFSET       = $100
  #LVBKIF_TYPE_WATERMARK        = $10000000
  
  #LVCF_FMT                     = $1
  #LVCF_WIDTH                   = $2
  #LVCF_TEXT                    = $4
  #LVCF_SUBITEM                 = $8
  #LVCF_IMAGE                   = $10
  #LVCF_ORDER                   = $20
  #LVCFMT_LEFT                  = $0
  #LVCFMT_RIGHT                 = $1
  #LVCFMT_CENTER                = $2
  #LVCFMT_JUSTIFYMASK           = $3
  #LVCFMT_IMAGE                 = $800
  #LVCFMT_BITMAP_ON_RIGHT       = $1000
  #LVCFMT_COL_HAS_IMAGES        = $8000
  
  #LVGA_HEADER_LEFT             = $1
  #LVGA_HEADER_CENTER           = $2
  #LVGA_HEADER_RIGHT            = $4
  #LVGA_FOOTER_LEFT             = $8
  #LVGA_FOOTER_CENTER           = $10
  #LVGA_FOOTER_RIGHT            = $20
  
  #LVGF_NONE                    = $0
  #LVGF_HEADER                  = $1
  #LVGF_FOOTER                  = $2
  #LVGF_STATE                   = $4
  #LVGF_ALIGN                   = $8
  #LVGF_GROUPID                 = $10
  
  #LVGMF_NONE                   = $0
  #LVGMF_BORDERSIZE             = $1
  #LVGMF_BORDERCOLOR            = $2
  #LVGMF_TEXTCOLOR              = $4
  
  #LVGS_NORMAL                  = $0
  #LVGS_COLLAPSED               = $1
  #LVGS_HIDDEN                  = $2
  
  #LVIM_AFTER                   = $1
  
  #LVS_EX_GRIDLINES             = $1
  #LVS_EX_SUBITEMIMAGES         = $2
  #LVS_EX_CHECKBOXES            = $4
  #LVS_EX_TRACKSELECT           = $8
  #LVS_EX_HEADERDRAGDROP        = $10
  #LVS_EX_FULLROWSELECT         = $20
  #LVS_EX_ONECLICKACTIVATE      = $40
  #LVS_EX_TWOCLICKACTIVATE      = $80
  #LVS_EX_FLATSB                = $100
  #LVS_EX_REGIONAL              = $200
  #LVS_EX_INFOTIP               = $400
  #LVS_EX_UNDERLINEHOT          = $800
  #LVS_EX_UNDERLINECOLD         = $1000
  #LVS_EX_MULTIWORKAREAS        = $2000
  #LVS_EX_LABELTIP              = $4000
  #LVS_EX_BORDERSELECT          = $8000
  #LVS_EX_DOUBLEBUFFER          = $10000
  #LVS_EX_HIDELABELS            = $20000
  #LVS_EX_SINGLEROW             = $40000
  #LVS_EX_SNAPTOGRID            = $80000
  #LVS_EX_SIMPLESELECT          = $100000
;}

Structure LV_BKIMAGE
  ulFlags.l
  hbm.l
  pszImage.l
  cchImageMax.l
  xOffsetPercent.l
  yOffsetPercent.l
EndStructure
Structure LV_GROUP
  cbSize.l
  mask.l
  pszHeader.l
  cchHeader.l
  pszFooter.l
  cchFooter.l
  iGroupId.l
  stateMask.l
  state.l
  uAlign.l
EndStructure
Structure LV_GROUPMETRICS
  cbSize.l
  mask.l
  Left.l
  Top.l
  Right.l
  Bottom.l
  crLeft.l
  crTop.l
  crRight.l
  crBottom.l
  crHeader.l
  crFooter.l
EndStructure
Structure LV_INSERTMARK
  cbSize.l
  dwFlags.l
  iItem.l
  dwReserved.l
EndStructure
Structure LV_TILEINFO
  cbSize.l
  iItem.l
  cColumns.l
  puColumns.l
EndStructure
Structure LV_TILEVIEWINFO
  cbSize.l
  dwMask.l
  dwFlags.l
  sizeTile.SIZE
  cLines.l
  rcLabelMargin.RECT
EndStructure
Structure LV_SETINFOTIP
  cbSize.l
  dwFlags.l
  pszText.l
  iItem.l
  iSubItem.l
EndStructure
