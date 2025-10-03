module Language.Mk

--import public Data.SortedMap {- this import is a workaround of idris-lang/Idris2#2439 -}
--import public Data.SortedMap.Dependent {- this import is a workaround of idris-lang/Idris2#2439 -}
--import public Data.SortedSet {- `public` is a workaround of idris-lang/Idris2#2439 -}

import public Language.Reflection

%default total

--record TyCon where
--  constructor MkTyCon
--  typeConstructor : Name
--  appliedArgs : List $ Argument $ Maybe TTImp -- Nothing means "unapplied"
--  cons : List (Name, TTImp)
--
--tyConAndArgs : Elaboration m =>
--               (boundNames : SortedSet (FC, Name)) ->
--               (usedFreeNames : SortedSet Name) ->
--               TTImp ->
--               m $ List (Name, List $ Argument $ Maybe TTImp)
--tyConAndArgs boundNames usedFreeNames $ ILam fc _ _ Nothing argTy rest = failAt fc "Expected a type constructor, got an unnamed lambda"
--tyConAndArgs boundNames usedFreeNames $ ILam fc cnt pii (Just nm) argTy rest = tyConAndArgs (insert (fc, nm) boundNames) usedFreeNames rest
--tyConAndArgs boundNames usedFreeNames _ = ?tyConAndArgs_rest
--
--getTyCon : Elaboration m => TTImp -> m $ List TyCon
--getTyCon expr = ?foo

isTyCon : NameInfo -> Bool
isTyCon $ MkNameInfo $ TyCon {} = True
isTyCon _                       = False

export
getMk' : (t : ty) -> Elab (FC, Name)
getMk' t = do
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
  pure (fc, conName)

export
getMk : (t : ty) -> Elab Name
getMk = map snd . getMk'

export %macro %inline
Mk : (t : ty) -> Elab a
Mk t = do
  (fc, conName) <- getMk' t
  check $ IVar fc conName
