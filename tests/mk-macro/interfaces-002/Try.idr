import Language.Mk

%default total

aqShowNat : Show Nat
aqShowNat = Mk (Show Nat) (\n => show n) (\d, n => showPrec d n)

aqShowNat' = Mk (Show Nat) (\n => show n) (\d, n => showPrec d n)

aq : (Nat -> String) -> (Prec -> Nat -> String) -> Show Nat
aq = Mk (Show Nat)

aq' = Mk (Show Nat) (show . S)
