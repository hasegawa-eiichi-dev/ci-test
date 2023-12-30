## procs and templates
import std/monotimes, times, strformat, std/enumutils, math, strutils
import src/util/math_util

template getDuration*(code: typed): Duration =
  ## get duration of any process
  runnableExamples:
    import os, times
    let d1 = getDuration(sleep(0))
    let d2 = getDuration:
      sleep(1)
      sleep(2)
    doAssert d1 < d2
  var startMt, stopMt: MonoTime
  startMt = getMonoTime()
  code
  stopMt = getMonoTime()
  stopMt - startMt

func simpleFormat*(dur: Duration): string {.inline.} =
  ## convert `Duration` to `string` in simple format
  runnableExamples:
    import times
    doAssert initDuration(days=34, milliseconds=50).simpleFormat() ==  ">= 4 Weeks"
  let d = dur.toParts()
  for u in countdown(Weeks, Nanoseconds):
    if d[u] != 0:
      return &">= {d[u]} {u.symbolName()}"
  return "0 Nanoseconds"

func fullFormat*(dur: Duration): string {.inline.} =
  ## covert `Duration` to `string` in full format
  runnableExamples:
    import times
    doAssert initDuration(days=34, milliseconds=50).fullFormat() == "4w 6d 00:00:00.050000000"
  let d = dur.toParts()
  return &"{d[Weeks]}w {d[Days]}d {d[Hours]:02}:{d[Minutes]:02}:{d[Seconds]:02}.{d[Milliseconds]:03}{d[Microseconds]:03}{d[Nanoseconds]:03}"

func iso8601Format*(dur: Duration): string {.inline.} =
  ## covert `Duration` to `string` in ISO8601 format
  ##
  ## 下記のように概算
  ## - 1Y = 365.25D
  ## - 1M = 30.4375D
  ## - Dの表示は小数点以下切り捨て
  runnableExamples:
    import times
    doAssert initDuration(days=34, milliseconds=50).iso8601Format() == "+P1M3DT0.05S"
  let d = dur.toParts()
  let dSign = case dur.inNanoseconds().sgn()
                   of -1: "-"
                   of +1: "+"
                   else: ""
  let dSeconds = (&"{d[Seconds]}.{d[Milliseconds]:03}{d[Microseconds]:03}{d[Nanoseconds]:03}").strip(leading=false, chars={'0', '.'})
  var dLeftDaysAbs = abs(d[Weeks] * 7 + d[Days]).toFloat()
  var dDays: range[0 .. 30]
  var dMonths: range[0 .. 11]
  var dYears: range[0 .. int.high()]
  (dYears, dLeftDaysAbs) = divmod(dLeftDaysAbs, 365.25)
  (dMonths, dLeftDaysAbs) = divmod(dLeftDaysAbs, 30.4375)
  dDays = dLeftDaysAbs.floor().toInt()
  result = dSign & "P"
  if dYears != 0:
    result &= &"{dYears}Y"
  if dMonths != 0:
    result &= &"{dMonths}M"
  if dDays != 0:
    result &= &"{dDays}D"
  if d[Hours] != 0 or d[Minutes] != 0 or dSeconds != "":
    result &= "T"
    if d[Hours] != 0:
      result &= &"{d[Hours]}H"
    if d[Minutes] != 0:
      result &= &"{d[Minutes]}M"
    if dSeconds != "":
      result &= &"{dSeconds}S"
