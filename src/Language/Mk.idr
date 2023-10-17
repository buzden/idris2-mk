module Language.Mk

import Language.Reflection

%default total

isTyCon : NameInfo -> Bool
isTyCon $ MkNameInfo $ TyCon {} = True
isTyCon _                       = False

export %macro
Mk : (t : ty) -> Elab a
Mk t = do
  expr <- quote t
  let fc = getFC expr
  let IVar _ name = expr
    | IPrimVal {} => failAt fc "Expression must not be a primitive value or type"
    | expr        => failAt fc "Expression must be just a name"
  [(name, _)] <- getInfo name <&> filter (isTyCon . snd)
    | []      => failAt fc "Expression must be an unambiguous type"
    | _::_::_ => failAt fc "Given name `\{show name}` is ambiguous type"
  [conName] <- getCons name
    | []      => failAt fc "No constructors found for `\{show name}`"
    | _::_::_ => failAt fc "Given type `\{show name}` has more than one constructor"
  check $ IVar fc conName

failing "Expression must not be a primitive value or type"

  y = Mk String

failing "Expression must be just a name"

  y = Mk (\x => List x)

failing "No constructors found for `Builtin.Void`"

  y = Mk Void

failing "Given type `Prelude.Basics.List` has more than one constructor"

  y = Mk List

aqShowNat : Show Nat
aqShowNat = Mk Show (\n => show n) (\d, n => showPrec d n)

aqShowNat' = Mk Show (\n : Nat => show n) (\d, n => showPrec d n)

aq : (a -> String) -> (Prec -> a -> String) -> Show a
aq = Mk Show

aq' = Mk Show (show . S)
