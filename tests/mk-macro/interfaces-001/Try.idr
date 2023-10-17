import Language.Mk

%default total

aqShowNat : Show Nat
aqShowNat = Mk Show (\n => show n) (\d, n => showPrec d n)

aqShowNat' = Mk Show (\n : Nat => show n) (\d, n => showPrec d n)

aq : (a -> String) -> (Prec -> a -> String) -> Show a
aq = Mk Show

aq' = Mk Show (show . S)
