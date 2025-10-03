<!-- idris
module README

import Data.Vect

import Language.Mk
-->

# Access the constructor, even unnamed

A macro for the Idris 2

## Why?

Not every interface or even a record has a name.
Moreover, usually they are just boring, like `Mk` + name of type.

This library adds a macro that searches for a name of the only constructor and allows to use it, even if there are no named constructors at all!

```idris
record Rec where
  field1 : Nat
  fiels2 : String

rec1 : Rec
rec1 = Mk Rec 42 "foo"
```

However, named applications are not supported in this case due to (temporary?) compiler restrictions:
```idris
failing
  rec2 : Rec
  rec2 = Mk Rec {field2 = "bar" } {field1 = 1}
```

## Specialisations

Currently getting constructors for specialisations are not supported, however, generally planned, i.e. this is okay

```idris
record Rec' n where
  pfield : Vect n Nat
  field2 : String

okay : Rec' 5
okay = Mk Rec' [1, 2, 3, 4, 5] "foo"
```

But this is not

```idris
failing
  bad : Rec' 5
  bad = Mk (Rec' 5) [1, 2, 3, 4, 5] "bar"
```
