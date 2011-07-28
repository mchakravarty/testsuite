{-# LANGUAGE TypeSynonymInstances       #-}
{-# LANGUAGE FlexibleInstances          #-}
{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE TypeOperators              #-}
{-# LANGUAGE DefaultSignatures          #-}

module GMap (
  -- * Generic show class
    GMap(..)
  ) where


import GHC.Generics

--------------------------------------------------------------------------------
-- Generic map
--------------------------------------------------------------------------------

class GMap' f where
  gmap' :: (a -> b) -> f a -> f b

instance GMap' U1 where
  gmap' _ U1 = U1

instance GMap' Par1 where
  gmap' f (Par1 a) = Par1 (f a)

instance GMap' (K1 i c) where
  gmap' _ (K1 a) = K1 a

instance (GMap f) => GMap' (Rec1 f) where
  gmap' f (Rec1 a) = Rec1 (gmap f a)

instance (GMap' f) => GMap' (M1 i c f) where
  gmap' f (M1 a) = M1 (gmap' f a)

instance (GMap' f, GMap' g) => GMap' (f :+: g) where
  gmap' f (L1 a) = L1 (gmap' f a)
  gmap' f (R1 a) = R1 (gmap' f a)

instance (GMap' f, GMap' g) => GMap' (f :*: g) where
  gmap' f (a :*: b) = gmap' f a :*: gmap' f b

instance (GMap f, GMap' g) => GMap' (f :.: g) where
  gmap' f (Comp1 x) = Comp1 (gmap (gmap' f) x)


class GMap f where
  gmap :: (a -> b) -> f a -> f b
  default gmap :: (Generic1 f, GMap' (Rep1 f))
               => (a -> b) -> f a -> f b
  gmap = gmapdefault

gmapdefault :: (Generic1 f, GMap' (Rep1 f))
            => (a -> b) -> f a -> f b
gmapdefault f = to1 . gmap' f . from1
