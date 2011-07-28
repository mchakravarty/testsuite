{-# LANGUAGE DeriveGeneric #-}

module Main where

import GHC.Generics hiding (C, D)
import GMap

-- We should be able to generate a generic representation for these types
data D a = D0 | D1 { d11 :: a, d12 :: (D a) } deriving (Show, Generic1)

-- Example values
d0 :: D Int
d0 = D1 0 D0

d1 :: D (Int,Float)
d1 = D1 (3,0.14) D0

-- Generic instances
instance GMap D

-- Tests
main = print (gmap (+1) d0, gmap (\(a,b) -> (b,a)) d1)
