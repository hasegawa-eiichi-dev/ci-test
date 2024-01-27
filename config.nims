switch("cc", "clang")
switch("path", ".")
switch("parallelBuild", "0")
switch("styleCheck", "error")
switch("errorMax", "0")
switch("threads", "on")
switch("define", "checkAbi")


when defined(dev):
  switch("checks", "on")
  switch("assertions", "on")
  switch("showAllMismatches", "on")
  switch("debuginfo", "on")
  switch("usenimcache")
  switch("lineTrace", "on")
  switch("incremental", "on") # experimental
  switch("define", "logGC")
when defined(stg) or defined(prd):
  switch("define", "release")

switch("project")
switch("index", "on")
switch("git.url", "https://github.com/hasegawa-eiichi-dev/ci-test")


# begin Nimble config (version 2)
when withDir(thisDir(), system.fileExists("nimble.paths")):
  include "nimble.paths"
# end Nimble config
