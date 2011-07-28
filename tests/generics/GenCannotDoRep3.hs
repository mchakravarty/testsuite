{-# LANGUAGE DeriveGeneric       #-}

module CannotDoRep3 where

import GHC.Generics

-- Only types that can derive Functor can derive Generic1
data Simple = Simple deriving Generic1
