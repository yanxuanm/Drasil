module Data.Drasil.Concepts.Computation where

import Language.Drasil
import Data.Drasil.Concepts.Documentation
import qualified Language.Drasil.NounPhrase as NP
import Data.Drasil.Concepts.Math (parameter)


algorithm :: ConceptChunk
algorithm    = dcc "algorithm"    (cn' "algorithm")               "A series of steps to be followed in calculations and problem-solving operations"

mod_calc_desc :: Sentence -> ConceptChunk
mod_calc_desc defnFromEx = dccWDS "mod_calc_desc" (cn' "calculation")   defnFromEx


computer, os, structure, type_ :: NamedChunk

computer        = npnc "computer"       (cn' "computer")
os              = npnc' "os"            (cn' "operating system") "OS"
structure       = npnc "structure"      (cn' "structure")
type_           = npnc "type"           (cn' "type")


dataStruct, dataStruct', dataType, dataType', 
  inDatum, outDatum, inParam, inVar, inValue, inQty,
  computerLiteracy :: NamedChunk

dataStruct       = compoundNC'' NP.plural NP.phrase datum structure
dataStruct'      = compoundNC'' NP.plural NP.plural datum structure
dataType         = compoundNC'' NP.plural NP.phrase datum type_
dataType'        = compoundNC'' NP.plural NP.plural datum type_
inDatum          = compoundNC input_ datum
outDatum         = compoundNC output_ datum
inParam          = compoundNC input_ parameter
inVar            = compoundNC input_ variable
inValue          = compoundNC input_ value
inQty            = compoundNC input_ quantity
computerLiteracy = compoundNC computer literacy