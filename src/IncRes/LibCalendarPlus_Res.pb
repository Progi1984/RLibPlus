;-Macros
Macro HiByte(Word)
  ((Word >> 8) & $FF)
EndMacro
Macro LoByte(Word)
  (Word & $FF)
EndMacro
Macro TransformDateStr(systemtime)
  yy = systemtime\wYear
  mm = systemtime\wMonth
  dd = systemtime\wDay
  hh = systemtime\wHour
  mi = systemtime\wMinute
  ss = systemtime\wSecond
  currentdate.s = Str(yy) + " " + Str(mm) + " "+ Str(dd) + " "+ Str(hh) + " "+ Str(mi) + " "+ Str(ss) + " "
EndMacro

;-Structures
Structure MCHITTESTINFO
  cbSize.l
  pt.POINT
  uHit.l
  st.SYSTEMTIME
EndStructure

;-Constantes
#MCM_SETTODAY                 = #MCM_FIRST + 12
#MCM_GETTODAY                 = #MCM_FIRST + 13
#MCM_HITTEST                  = #MCM_FIRST + 14
#MCM_GETRANGE                 = #MCM_FIRST + 17
#MCM_SETRANGE                 = #MCM_FIRST + 18
#MCM_GETMONTHDELTA            = #MCM_FIRST + 19
#MCM_SETMONTHDELTA            = #MCM_FIRST + 20
#MCM_GETMAXTODAYWIDTH         = #MCM_FIRST + 21
#MCM_SETUNICODEFORMAT         = #CCM_SETUNICODEFORMAT
#MCM_GETUNICODEFORMAT         = #CCM_GETUNICODEFORMAT

#GMR_VISIBLE                  = 0
#GMR_DAYSTATE                 = 1
#GDTR_MIN                     = $1
#GDTR_MAX                     = $2

#MCHT_TITLE                   = $10000
#MCHT_CALENDAR                = $20000
#MCHT_TODAYLINK               = $30000

#MCHT_NEXT                    = $1000000   ; these indicate that hitting
#MCHT_PREV                    = $2000000   ; here will go To the Next/prev month

#MCHT_NOWHERE                 = $0

#MCHT_TITLEBK                 = #MCHT_TITLE
#MCHT_TITLEMONTH              = #MCHT_TITLE        | $1
#MCHT_TITLEYEAR               = #MCHT_TITLE        | $2
#MCHT_TITLEBTNNEXT            = #MCHT_TITLE        | #MCHT_NEXT | $3
#MCHT_TITLEBTNPREV            = #MCHT_TITLE        | #MCHT_PREV | $3

#MCHT_CALENDARBK              = #MCHT_CALENDAR
#MCHT_CALENDARDATE            = #MCHT_CALENDAR     | $1
#MCHT_CALENDARDATENEXT        = #MCHT_CALENDARDATE | #MCHT_NEXT
#MCHT_CALENDARDATEPREV        = #MCHT_CALENDARDATE | #MCHT_PREV
#MCHT_CALENDARDAY             = #MCHT_CALENDAR     | $2
#MCHT_CALENDARWEEKNUM         = #MCHT_CALENDAR     | $3

#MCS_DAYSTATE                 = $1
#MCS_MULTISELECT              = $2
#MCS_WEEKNUMBERS              = $4
#MCS_NOTODAYCIRCLE            = $8
#MCS_NOTODAY                  = $10
