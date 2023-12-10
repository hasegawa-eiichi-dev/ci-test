# Package

version       = "0.0.0"
author        = "hasegawa-eiichi-dev"
description   = "ci test"
license       = "Proprietary"
srcDir        = "src"
binDir        = "bin"
bin           = @["ci_test"]


# Dependencies

requires "nim >= 2.0.0"
requires "db >= 1.1.0"


# Tasks

task test, "Run the test suite":
  exec "testament --megatest:on --print all"

after test:
  exec "testament html"
  mvFile "testresults.html", "testresults/testresults.html"
