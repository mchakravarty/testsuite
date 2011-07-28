{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE TypeOperators #-}

module CanDoRep0 where

import GHC.Generics (Generic, Generic1)


-- We should be able to generate a generic representation for these types
data A  
  deriving Generic

data B a
  deriving (Generic, Generic1)

data B' a
  deriving Generic1

data C = C0 | C1
  deriving Generic

data D a = D0 | D1 { d11 :: a, d12 :: (D a) }
  deriving (Generic, Generic1)

data (:*:) a b = a :*: b
  deriving Generic

data Bush a = BushNil | BushCons a (Bush (Bush a))
  deriving (Generic, Generic1)

data Nested a = Leaf | Nested { value :: a, rec :: Nested [a] }
  deriving (Generic, Generic1)

data Rose a = Rose [a] [Rose a]
  deriving (Generic, Generic1)
