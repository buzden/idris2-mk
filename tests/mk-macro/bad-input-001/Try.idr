import Language.Mk

%default total

failing "Expected a type constructor, got: String"

  y = Mk String

failing "Expected a type constructor, got: \\ x => Prelude.Basics.List x"

  y = Mk (\x => List x)

failing "No constructors found for `Builtin.Void`"

  y = Mk Void

failing "Given type `Prelude.Basics.List` has more than one constructor"

  y = Mk List
