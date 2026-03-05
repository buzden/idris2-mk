import Language.Mk

%default total

record Rec where
  field1 : Nat
  field2 : String

rec1 : Rec
rec1 = Mk Rec 42 "foo"
