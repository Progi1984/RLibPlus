XIncludeFile "../RLibPlus.pb"
;- Couleurs
; MCM_GETCOLOR  > Retrieves the color For a given portion of a month calendar control. You can send this message explicitly Or by using the MonthCal_GetColor Macro. 
; MCM_SETCOLOR  > Sets the color For a given portion of a month calendar control. You can send this message explicitly Or by using the MonthCal_SetColor Macro. 
  ; MCSC_BACKGROUND   > Retrieve the background color displayed between months.
  ProcedureDLL Calendar_Color_GetBackGadget(Gadget.l)
    ProcedureReturn SendMessage_(GadgetID(Gadget),#MCM_GETCOLOR,#MCSC_BACKGROUND,0)
  EndProcedure
  ProcedureDLL Calendar_Color_SetBackGadget(Gadget.l, Color.l)
    ProcedureReturn SendMessage_(GadgetID(Gadget),#MCM_SETCOLOR,#MCSC_BACKGROUND,Color)
  EndProcedure
  ; MCSC_TITLEBK      > Retrieve the background color displayed in the calendar's title.
  ProcedureDLL Calendar_Color_GetBackTitle(Gadget.l)
    ProcedureReturn SendMessage_(GadgetID(Gadget),#MCM_GETCOLOR,#MCSC_TITLEBK,0)
  EndProcedure
  ProcedureDLL Calendar_Color_SetBackTitle(Gadget.l, Color.l)
    ProcedureReturn SendMessage_(GadgetID(Gadget),#MCM_SETCOLOR,#MCSC_TITLEBK,Color)
  EndProcedure
  ; MCSC_TITLETEXT    > Retrieve the color used To display text within the calendar's title.
  ProcedureDLL Calendar_Color_GetTextTitle(Gadget.l)
    ProcedureReturn SendMessage_(GadgetID(Gadget),#MCM_GETCOLOR,#MCSC_TITLETEXT,0)
  EndProcedure
  ProcedureDLL Calendar_Color_SetTextTitle(Gadget.l, Color.l)
    ProcedureReturn SendMessage_(GadgetID(Gadget),#MCM_SETCOLOR,#MCSC_TITLETEXT,Color)
  EndProcedure
  ; MCSC_MONTHBK      > Retrieve the background color displayed within the month.
  ProcedureDLL Calendar_Color_GetBackMonth(Gadget.l)
    ProcedureReturn SendMessage_(GadgetID(Gadget),#MCM_GETCOLOR,#MCSC_MONTHBK,0)
  EndProcedure
  ProcedureDLL Calendar_Color_SetBackMonth(Gadget.l, Color.l)
    ProcedureReturn SendMessage_(GadgetID(Gadget),#MCM_SETCOLOR,#MCSC_MONTHBK,Color)
  EndProcedure
  ; MCSC_TEXT         > Retrieve the color used To display text within a month.
  ProcedureDLL Calendar_Color_GetTextMonthCurrent(Gadget.l)
    ProcedureReturn SendMessage_(GadgetID(Gadget),#MCM_GETCOLOR,#MCSC_TEXT,0)
  EndProcedure
  ProcedureDLL Calendar_Color_SetTextMonthCurrent(Gadget.l, Color.l)
    ProcedureReturn SendMessage_(GadgetID(Gadget),#MCM_SETCOLOR,#MCSC_TEXT,Color)
  EndProcedure
  ; MCSC_TRAILINGTEXT > Retrieve the color used To display header day And trailing day text. Header And trailing days are the days from the previous And following months that appear on the current month calendar.
  ProcedureDLL Calendar_Color_GetTextMonthOther(Gadget.l)
    ProcedureReturn SendMessage_(GadgetID(Gadget),#MCM_GETCOLOR,#MCSC_TRAILINGTEXT,0)
  EndProcedure
  ProcedureDLL Calendar_Color_SetTextMonthOther(Gadget.l, Color.l)
    ProcedureReturn SendMessage_(GadgetID(Gadget),#MCM_SETCOLOR,#MCSC_TRAILINGTEXT,Color)
  EndProcedure

;- Date
; MCM_GETCURSEL > Retrieves the currently selected date. You can send this message explicitly Or by using the MonthCal_GetCurSel Macro. 
ProcedureDLL Calendar_GetCurrentDate(Gadget.l)
  getcursel.SYSTEMTIME
  SendMessage_(GadgetID(Gadget),#MCM_GETCURSEL,0,@getcursel)
  TransformDateStr(getcursel)
  ProcedureReturn ParseDate("%yyyy %mm %dd %hh %ii %ss", currentdate)
EndProcedure
; MCM_SETTODAY  > Sets the "today" selection For a month calendar control. You can send this message explicitly Or by using the MonthCal_SetToday Macro. 
ProcedureDLL Calendar_SetCurrentDate(Gadget.l, Date.l)
  Protected today.SYSTEMTIME
  today\wYear         = Year(Date)
  today\wMonth        = Month(Date)
  today\wDayOfWeek    = DayOfWeek(Date)
  today\wDay          = Day(Date)
  today\wHour         = Hour(Date)
  today\wMinute       = Minute(Date)
  today\wSecond       = Second(Date)
  today\wMilliseconds = 1
  Debug SendMessage_(GadgetID(Gadget),#MCM_SETTODAY,0,@today)
  ProcedureReturn 
EndProcedure

;- Date Configuration
; MCM_GETFIRSTDAYOFWEEK > Retrieves the first day of the week For a month calendar control. You can send this message explicitly Or by using the MonthCal_GetFirstDayOfWeek Macro. 
ProcedureDLL Calendar_IsSystemFirstDay(Gadget.l)
; The high word is a BOOL value that is nonzero if the first day of the week is set to something other than LOCALE_IFIRSTDAYOFWEEK, or zero otherwise.
  getfirst=SendMessage_(GadgetID(Gadget),#MCM_GETFIRSTDAYOFWEEK,0,0)
  ProcedureReturn HiByte(getfirst)
EndProcedure
ProcedureDLL Calendar_GetFirstDayOfWeek(Gadget.l)
; The low word is an INT value that represents the first day of the week.
  getfirst=SendMessage_(GadgetID(Gadget),#MCM_GETFIRSTDAYOFWEEK,0,0)
  ProcedureReturn LoByte(getfirst)
EndProcedure
; MCM_SETFIRSTDAYOFWEEK > Sets the first day of the week For a month calendar control. You can send this message explicitly Or by using the MonthCal_SetFirstDayOfWeek Macro. 
ProcedureDLL Calendar_SetFirstDayOfWeek(Gadget.l, Day.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#MCM_SETFIRSTDAYOFWEEK,0, Day)
EndProcedure

; MCM_GETMAXSELCOUNT  > Retrieves the maximum date range that can be selected in a month calendar control. You can send this message explicitly Or by using the MonthCal_GetMaxSelCount Macro. 
ProcedureDLL Calendar_GetSelMaxItems(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#MCM_GETMAXSELCOUNT,0,0)
EndProcedure

; MCM_GETMAXTODAYWIDTH  > Retrieves the maximum width of the "today" string in a month calendar control. This includes the label text And the date text. You can send this message explicitly Or by using the MonthCal_GetMaxTodayWidth Macro. 
ProcedureDLL Calendar_GetWidthOfToday(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#MCM_GETMAXTODAYWIDTH,0,0)
EndProcedure

; MCM_GETMINREQRECT > Retrieves the minimum size required To display a full month in a month calendar control. You can send this message explicitly Or by using the MonthCal_GetMinReqRect Macro. 
ProcedureDLL Calendar_GetMinPerfectWidth(Gadget.l)
  rc.RECT
  SendMessage_(GadgetID(Gadget),#MCM_GETMINREQRECT,0,@rc)
  ProcedureReturn rc\right - rc\left
EndProcedure
ProcedureDLL Calendar_GetMinPerfectHeight(Gadget.l)
  rc.RECT
  SendMessage_(GadgetID(Gadget),#MCM_GETMINREQRECT,0,@rc)
  ProcedureReturn rc\bottom - rc\top
EndProcedure

; MCM_GETMONTHDELTA > Retrieves the scroll rate For a month calendar control. The scroll rate is the number of months that the control moves its display when the user clicks a scroll button. You can send this message explicitly Or by using the MonthCal_GetMonthDelta Macro. 
ProcedureDLL Calendar_GetInterval(Gadget.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#MCM_GETMONTHDELTA,0,0)
EndProcedure
; MCM_SETMONTHDELTA > Sets the scroll rate For a month calendar control. The scroll rate is the number of months that the control moves its display when the user clicks a scroll button. You can send this message explicitly Or by using the MonthCal_SetMonthDelta Macro. 
ProcedureDLL Calendar_SetInterval(Gadget.l, Interval.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget), #MCM_SETMONTHDELTA, Interval, 0)
EndProcedure

; MCM_GETMONTHRANGE > Retrieves date information (using SYSTEMTIME structures) that represents the high And low limits of a month calendar control's display. You can send this message explicitly or by using the MonthCal_GetMonthRange macro. 
ProcedureDLL Calendar_GetPreviousMonth(Gadget.l)
  Protected Dim array.SYSTEMTIME(2)
    SendMessage_(GadgetID(Gadget),#MCM_GETMONTHRANGE,#GMR_DAYSTATE,@array())
  ProcedureReturn array(0)\wMonth
EndProcedure
ProcedureDLL Calendar_GetNextMonth(Gadget.l)
  Protected Dim array.SYSTEMTIME(2)
    SendMessage_(GadgetID(Gadget),#MCM_GETMONTHRANGE,#GMR_DAYSTATE,@array())
  ProcedureReturn array(1)\wMonth
EndProcedure
ProcedureDLL Calendar_GetMinMonthVisible(Gadget.l)
  Protected Dim array.SYSTEMTIME(2)
    SendMessage_(GadgetID(Gadget),#MCM_GETMONTHRANGE,#GMR_VISIBLE,@array())
  ProcedureReturn array(0)\wMonth
EndProcedure
ProcedureDLL Calendar_GetMaxMonthVisible(Gadget.l)
  Protected Dim array.SYSTEMTIME(2)
    SendMessage_(GadgetID(Gadget),#MCM_GETMONTHRANGE,#GMR_VISIBLE,@array())
  ProcedureReturn array(1)\wMonth
EndProcedure

; MCM_GETRANGE  > Retrieves the minimum And maximum allowable dates set For a month calendar control. You can send this message explicitly Or by using the MonthCal_GetRange Macro. 
ProcedureDLL Calendar_GetMinDate(Gadget.l)
  Protected Dim lprgSysTimeArray.SYSTEMTIME(2)
    If SendMessage_(GadgetID(Gadget),#MCM_GETRANGE,0,@lprgSysTimeArray()) & #GDTR_MIN
      TransformDateStr(lprgSysTimeArray(0))
      ProcedureReturn ParseDate("%yyyy %mm %dd %hh %ii %ss", currentdate)
    Else
      ProcedureReturn -1
    EndIf
EndProcedure
ProcedureDLL Calendar_GetMaxDate(Gadget.l)
  Protected Dim lprgSysTimeArray.SYSTEMTIME(2)
    If SendMessage_(GadgetID(Gadget),#MCM_GETRANGE,0,@lprgSysTimeArray()) & #GDTR_MAX
      TransformDateStr(lprgSysTimeArray(1))
      ProcedureReturn ParseDate("%yyyy %mm %dd %hh %ii %ss", currentdate)
    Else
      ProcedureReturn -1
    EndIf
EndProcedure

; MCM_GETTODAY  > Retrieves the date information For the date specified As "today" For a month calendar control. You can send this message explicitly Or by using the MonthCal_GetToday Macro. 
ProcedureDLL Calendar_GetGadgetState(Gadget.l)
  gettoday.SYSTEMTIME
  SendMessage_(GadgetID(Gadget),#MCM_GETTODAY,0,@gettoday)
  TransformDateStr(gettoday)
  ProcedureReturn ParseDate("%yyyy %mm %dd %hh %ii %ss", currentdate)
EndProcedure
; MCM_SETCURSEL > Sets the currently selected date For a month calendar control. If the specified date is Not in view, the control updates the display To bring it into view. You can send this message explicitly Or by using the MonthCal_SetCurSel Macro. 
ProcedureDLL Calendar_SetGadgetState(Gadget.l, Date.l)
  Protected SETCURSEL.SYSTEMTIME
  SETCURSEL\wYear         = Year(Date)
  SETCURSEL\wMonth        = Month(Date)
  SETCURSEL\wDayOfWeek    = DayOfWeek(Date)
  SETCURSEL\wDay          = Day(Date)
  SETCURSEL\wHour         = Hour(Date)
  SETCURSEL\wMinute       = Minute(Date)
  SETCURSEL\wSecond       = Second(Date)
  SETCURSEL\wMilliseconds = 1
  ProcedureReturn SendMessage_(GadgetID(Gadget),#MCM_SETCURSEL,0,@SETCURSEL)
EndProcedure

; MCM_SETDAYSTATE > Sets the day states For all months that are currently visible within a month calendar control. You can send this message explicitly Or by using the MonthCal_SetDayState Macro. 
ProcedureDLL Calendar_SetBoldDays(Gadget.l, Days.s)
  Protected Inc_a.l
  Dim daystate.l(2)
  daystate(0)=255
  daystate(1)=0
  For Inc_a=1 To CountString(Days, ";")
    word.s = StringField(Days, Inc_a, ";")
    daystate(1) + Pow(2,Val(word)-1)
  Next
  ProcedureReturn SendMessage_(GadgetID(Gadget),#MCM_SETDAYSTATE,2,@daystate())
EndProcedure

; MCM_GETUNICODEFORMAT  > Retrieves the Unicode character format flag For the control. You can send this message explicitly Or use the MonthCal_GetUnicodeFormat Macro. 
ProcedureDLL Calendar_GetUnicodeFormat(Gadget.l)
  If SendMessage_(GadgetID(Gadget),#MCM_GETUNICODEFORMAT,0,0)
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
; MCM_SETUNICODEFORMAT  > Sets the Unicode character format flag For the control. This message allows you To change the character set used by the control at run time rather than having To re-create the control. You can send this message explicitly Or use the MonthCal_SetUnicodeFormat Macro.
ProcedureDLL Calendar_SetUnicodeFormat(Gadget.l, State.l)
  ProcedureReturn SendMessage_(GadgetID(Gadget),#MCM_SETUNICODEFORMAT,State,0)
EndProcedure

; MCM_HITTEST > Determines which portion of a month calendar control is at a given point on the screen. You can send this message explicitly Or by using the MonthCal_HitTest Macro. 
ProcedureDLL Calendar_Click_GetX(Gadget.l)
  mchi.MCHITTESTINFO 
  mchi\cbsize=SizeOf(MCHITTESTINFO)
  GetCursorPos_(@mchi\pt)
  ScreenToClient_(GadgetID(Gadget),@mchi\pt)
  ProcedureReturn mchi\pt\x
EndProcedure
ProcedureDLL Calendar_Click_GetY(Gadget.l)
  mchi.MCHITTESTINFO 
  mchi\cbsize=SizeOf(MCHITTESTINFO)
  GetCursorPos_(@mchi\pt)
  ScreenToClient_(GadgetID(Gadget),@mchi\pt)
  ProcedureReturn mchi\pt\y
EndProcedure
; #MCHT_CALENDARBK ;The given point was in the calendar's background.
ProcedureDLL Calendar_Click_IsOnBackground(Gadget.l)
  mchi.MCHITTESTINFO 
  mchi\cbsize=SizeOf(MCHITTESTINFO)
  GetCursorPos_(@mchi\pt)
  ScreenToClient_(GadgetID(Gadget),@mchi\pt)
  If SendMessage_(GadgetID(Gadget),#MCM_HITTEST,0,mchi) = #MCHT_CALENDARBK
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
; #MCHT_CALENDARDATE ;The given point was on a particular date within the calendar. The SYSTEMTIME Structure at lpMCHitTest>st is set To the date at the given point.
ProcedureDLL Calendar_Click_IsOnCalendar(Gadget.l)
  mchi.MCHITTESTINFO 
  mchi\cbsize=SizeOf(MCHITTESTINFO)
  GetCursorPos_(@mchi\pt)
  ScreenToClient_(GadgetID(Gadget),@mchi\pt)
  If SendMessage_(GadgetID(Gadget),#MCM_HITTEST,0,mchi) = #MCHT_CALENDARDATE
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
; #MCHT_CALENDARDATENEXT ;The given point was over a date from the Next Month (partially displayed at the End of the currently displayed month). If the user clicks here, the month calendar will scroll its display To the Next month Or set of months.
ProcedureDLL Calendar_Click_IsOnCalendarNext(Gadget.l)
  mchi.MCHITTESTINFO 
  mchi\cbsize=SizeOf(MCHITTESTINFO)
  GetCursorPos_(@mchi\pt)
  ScreenToClient_(GadgetID(Gadget),@mchi\pt)
  If SendMessage_(GadgetID(Gadget),#MCM_HITTEST,0,mchi) = #MCHT_CALENDARDATENEXT
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
; #MCHT_CALENDARDATEPREV ;The given point was over a date from the previous Month (partially displayed at the End of the currently displayed month). If the user clicks here, the month calendar will scroll its display To the previous month Or set of months.
ProcedureDLL Calendar_Click_IsOnCalendarPrevious(Gadget.l)
  mchi.MCHITTESTINFO 
  mchi\cbsize=SizeOf(MCHITTESTINFO)
  GetCursorPos_(@mchi\pt)
  ScreenToClient_(GadgetID(Gadget),@mchi\pt)
  If SendMessage_(GadgetID(Gadget),#MCM_HITTEST,0,mchi) = #MCHT_CALENDARDATEPREV
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
; #MCHT_CALENDARDAY ;The given point was over a day abbreviation ("Fri", For example). The SYSTEMTIME Structure at lpMCHitTest>st is set To the corresponding date in the top row.
ProcedureDLL Calendar_Click_IsOnCalendarDay(Gadget.l)
  mchi.MCHITTESTINFO 
  mchi\cbsize=SizeOf(MCHITTESTINFO)
  GetCursorPos_(@mchi\pt)
  ScreenToClient_(GadgetID(Gadget),@mchi\pt)
  If SendMessage_(GadgetID(Gadget),#MCM_HITTEST,0,mchi) = #MCHT_CALENDARDAY
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
; #MCHT_CALENDARWEEKNUM ;The given point was over a week number (MCS_WEEKNUMBERS style only). The SYSTEMTIME Structure at lpMCHitTest>st is set To the corresponding date in the leftmost column.
ProcedureDLL Calendar_Click_IsOnCalendarWeekNumber(Gadget.l)
  mchi.MCHITTESTINFO 
  mchi\cbsize=SizeOf(MCHITTESTINFO)
  GetCursorPos_(@mchi\pt)
  ScreenToClient_(GadgetID(Gadget),@mchi\pt)
  If SendMessage_(GadgetID(Gadget),#MCM_HITTEST,0,mchi) = #MCHT_CALENDARWEEKNUM
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
; #MCHT_NOWHERE ;The given point was Not on the month calendar control, Or it was in an inactive portion of the control.
ProcedureDLL Calendar_Click_IsNoWhere(Gadget.l)
  mchi.MCHITTESTINFO 
  mchi\cbsize=SizeOf(MCHITTESTINFO)
  GetCursorPos_(@mchi\pt)
  ScreenToClient_(GadgetID(Gadget),@mchi\pt)
  If SendMessage_(GadgetID(Gadget),#MCM_HITTEST,0,mchi) = #MCHT_NOWHERE
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
; #MCHT_TITLEBK ;The given point was over the background of a month's title.
ProcedureDLL Calendar_Click_IsOnTitleBack(Gadget.l)
  mchi.MCHITTESTINFO 
  mchi\cbsize=SizeOf(MCHITTESTINFO)
  GetCursorPos_(@mchi\pt)
  ScreenToClient_(GadgetID(Gadget),@mchi\pt)
  If SendMessage_(GadgetID(Gadget),#MCM_HITTEST,0,mchi) = #MCHT_TITLEBK
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
; #MCHT_TITLEBTNNEXT ;The given point was over the button at the top right corner of the control. If the user clicks here, the month calendar will scroll its display To the Next month Or set of months.
ProcedureDLL Calendar_Click_IsOnTitleNext(Gadget.l)
  mchi.MCHITTESTINFO 
  mchi\cbsize=SizeOf(MCHITTESTINFO)
  GetCursorPos_(@mchi\pt)
  ScreenToClient_(GadgetID(Gadget),@mchi\pt)
  If SendMessage_(GadgetID(Gadget),#MCM_HITTEST,0,mchi) = #MCHT_TITLEBTNNEXT
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
; #MCHT_TITLEBTNPREV ;The given point was over the button at the top left corner of the control. If the user clicks here, the month calendar will scroll its display To the previous month Or set of months.
ProcedureDLL Calendar_Click_IsOnTitlePrevious(Gadget.l)
  mchi.MCHITTESTINFO 
  mchi\cbsize=SizeOf(MCHITTESTINFO)
  GetCursorPos_(@mchi\pt)
  ScreenToClient_(GadgetID(Gadget),@mchi\pt)
  If SendMessage_(GadgetID(Gadget),#MCM_HITTEST,0,mchi) = #MCHT_TITLEBTNPREV
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
; #MCHT_TITLEMONTH ;The given point was in a month's title bar, over a month name.
ProcedureDLL Calendar_Click_IsOnTitleMonth(Gadget.l)
  mchi.MCHITTESTINFO 
  mchi\cbsize=SizeOf(MCHITTESTINFO)
  GetCursorPos_(@mchi\pt)
  ScreenToClient_(GadgetID(Gadget),@mchi\pt)
  If SendMessage_(GadgetID(Gadget),#MCM_HITTEST,0,mchi) = #MCHT_TITLEMONTH
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
; #MCHT_TITLEYEAR ;The given point was in a month's title bar, over the year value.
ProcedureDLL Calendar_Click_IsOnTitleYear(Gadget.l)
  mchi.MCHITTESTINFO 
  mchi\cbsize=SizeOf(MCHITTESTINFO)
  GetCursorPos_(@mchi\pt)
  ScreenToClient_(GadgetID(Gadget),@mchi\pt)
  If SendMessage_(GadgetID(Gadget),#MCM_HITTEST,0,mchi) = #MCHT_TITLEYEAR
    ProcedureReturn #True
  Else
    ProcedureReturn #False
  EndIf
EndProcedure
