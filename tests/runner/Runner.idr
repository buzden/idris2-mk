module Runner

import BaseDir

import Test.Golden.RunnerHelper

main : IO ()
main = goldenRunner
  [ "Compilability tests of `Mk`" `atDir` "mk-compiles"
  ]
