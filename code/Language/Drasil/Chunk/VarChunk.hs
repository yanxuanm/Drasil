{-# Language GADTs, Rank2Types #-}
module Language.Drasil.Chunk.VarChunk where

import Language.Drasil.Chunk
import Language.Drasil.Chunk.NamedIdea
import Language.Drasil.Chunk.SymbolForm
import Control.Lens ((^.), set, Simple, Lens)
import Language.Drasil.Chunk.Wrapper (NWrapper, nw)

import Language.Drasil.Symbol
import Language.Drasil.Space

import Language.Drasil.NounPhrase (NP)

import Prelude hiding (id)
  
-- | VarChunks are Quantities that have symbols, but not units.
data VarChunk = VC { _ni :: NWrapper
                   , _vsymb :: Symbol
                   , _vtyp  :: Space }

instance Eq VarChunk where
  c1 == c2 = (c1 ^. id) == (c2 ^. id)

instance Chunk VarChunk where
  id = nl id

instance NamedIdea VarChunk where
  term = nl term
  getA (VC n _ _) = getA n

instance SymbolForm VarChunk where
  symbol f (VC n s t) = fmap (\x -> VC n x t) (f s)
  
nl :: (forall c. (NamedIdea c) => Simple Lens c a) -> Simple Lens VarChunk a
nl l f (VC n s t) = fmap (\x -> VC (set l x n) s t) (f (n ^. l))
  
-- the code generation system needs VC to have a type (for now)
-- Setting all varchunks to have Rational type so it compiles
-- | Creates a VarChunk from an id, term, and symbol. Assumes Rational 'Space'
-- Needs to be removed
makeVC :: String -> NP -> Symbol -> VarChunk
makeVC i des sym = VC (nw $ nc i des) sym Real

-- | Creates a VarChunk from an id, term, symbol, and space
vc :: String -> NP -> Symbol -> Space -> VarChunk
vc i des sym space = VC (nw $ nc i des) sym space

-- | Creates a VarChunk from a 'NamedIdea', symbol, and space
vc' :: NamedIdea c => c -> Symbol -> Space -> VarChunk
vc' n s t = VC (nw n) s t

-- | Creates a VarChunk from a 'NamedIdea''s id and term and symbol
vc'' :: NamedIdea c => c -> Symbol -> VarChunk
vc'' n sy  = makeVC (n ^. id) (n ^. term) sy

-- | Creates a VarChunk from an id, term, symbol, and 
makeVCObj :: String -> NP -> Symbol -> String -> VarChunk
makeVCObj i des sym s = VC (nw $ nc i des) sym (Obj s)