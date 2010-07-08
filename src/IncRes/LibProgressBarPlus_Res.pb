#PBM_SETRANGE       = #WM_USER + 1
#PBM_SETPOS         = #WM_USER + 2
#PBM_DELTAPOS       = #WM_USER + 3
#PBM_SETSTEP        = #WM_USER + 4
#PBM_STEPIT         = #WM_USER + 5
#PBM_SETRANGE32     = #WM_USER + 6
#PBM_GETRANGE       = #WM_USER + 7
#PBM_GETPOS         = #WM_USER + 8
#PBM_SETBARCOLOR    = #WM_USER + 9
#PBM_SETMARQUEE     = #WM_USER + 10
#PBM_SETBKCOLOR     = #CCM_SETBKCOLOR
#PBS_SMOOTH         = $1
#PBS_VERTICAL       = $4
#PBS_MARQUEE        = $8

Structure PB_RANGE
  iLow.l
  iHigh.l
EndStructure