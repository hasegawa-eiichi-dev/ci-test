# https://nim-lang.org/docs/nimscript.html
# https://nim-lang.org/docs/nims.html
# https://github.com/nim-lang/nimble?tab=readme-ov-file

# Package

version       = "0.0.0"
author        = "Eiichi Hasegawa"
description   = "ci test"
license       = "Proprietary"
srcDir        = "src"
binDir        = "bin"
bin           = @["ci_test"]


# Dependencies

requires "nim ^= 2.0.0"

# requires "jester ^= 0.6.0"
# requires "jester2swagger ^= 0.1.0"
# requires "coco"  # requires nim (>= 1.0.0 & < 2.0.0)


# Tasks

task help, "List all the available NimScript tasks along with their docstrings.":
  discard

task test, "Run the test suite.":
  try:
    exec("testament --megatest:off all")
  except Exception:
    exec("testament html")
    quit QuitFailure
  exec("testament html")

task bench, "Runs benchmarks belonging to the project.":
  exec("time nimble run")

task build, "hoge":
  discard
