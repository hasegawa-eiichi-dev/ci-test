##[
  This is test program
  - markdown
  - foo
  - bar
]##
import ./greet, ./util/time_util, os

when isMainModule:
  greet()
  echo getDuration(sleep(1000)).simpleFormat()
