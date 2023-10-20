import Language.Mk

%default total

failing "Expression must not be a primitive value or type"

  y = Mk String

failing "Expression must be just a name"

  y = Mk (\x => List x)

failing "No constructors found for `Builtin.Void`"

  y = Mk Void

failing "Given type `Prelude.Basics.List` has more than one constructor"

  y = Mk List
