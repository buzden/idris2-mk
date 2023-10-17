module Runner

import BaseDir

import Test.Golden.RunnerHelper

main : IO ()
main = goldenRunner
  [ "Usage of the `Mk` macro" `atDir` "mk-macro"
  ]
