module Language.Mk

import public Data.Maybe {- `public` is a workaround of idris-lang/Idris2#2439 -}

import public Deriving.Common {- `public` is a workaround of idris-lang/Idris2#2439 -}

import public Language.Reflection
import public Language.Reflection.TT {- `public` is a workaround of idris-lang/Idris2#2439 -}
import public Language.Reflection.TTImp {- `public` is a workaround of idris-lang/Idris2#2439 -}

%default total

isTyCon : NameInfo -> Bool
isTyCon $ MkNameInfo $ TyCon {} = True
isTyCon _                       = False

export %macro
Mk : (t : ty) -> Elab a
Mk t = do
  t <- quote t
  let fc = getFC t
  t <- isType t
  let [(conName, _)] = t.dataConstructors
    | []      => failAt fc "No constructors found for `\{show t.typeConstructor}`"
    | _::_::_ => failAt fc "Given type `\{show t.typeConstructor}` has more than one constructor"
  check $ IVar fc conName
