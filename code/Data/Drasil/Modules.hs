module Data.Drasil.Modules
  ( mod_hw
  , mod_behav
  , mod_sw
  , mod_seq_fun
  , mod_linked_fun
  , mod_assoc_fun
  , mod_vector_fun
  , mod_ctrl_fun
  , mod_io_fun
  , mod_plot_fun
  , mod_rng_fun
  , mod_outputf_desc_fun
  ) where

import Language.Drasil
import Data.Drasil.Utils (foldlSent)
import Data.Drasil.Concepts.Documentation
import Data.Drasil.Concepts.Software

{-- Concept Chunks for Modules  --}

mod_seq_serv :: ConceptChunk
mod_seq_serv = dccWDS "mod_seq_serv" (cn' "sequence data structure")
    (S "Provides array manipulation operations, such as building an array" `sC`
    S "accessing a specific entry, slicing an array, etc.")

mod_linked_serv :: ConceptChunk
mod_linked_serv = dccWDS "mod_linked_serv" (cn' "linked data structure")
    (S "Provides tree manipulation operations, such as building a tree" `sC`
    S "accessing a specific entry, etc.")

mod_assoc_serv :: ConceptChunk
mod_assoc_serv = dccWDS "mod_assoc_serv" (cn' "associative data structure")
    (S "Provides operations on hash tables, such as building a hash table" `sC`
    S "accessing a specific entry, etc.")

mod_vector_serv :: ConceptChunk
mod_vector_serv = dccWDS "mod_vector_serv" (cn' "vector")
    (S "Provides vector operations such as addition, scalar and vector" +:+
    S "multiplication, dot and cross products, rotations, etc.")
    
mod_plot_desc :: ConceptChunk
mod_plot_desc = dcc "mod_plot_desc" (cn' "plotting") "Provides a plot function."

mod_outputf_desc_fun :: Sentence -> ConceptChunk
mod_outputf_desc_fun desc = dccWDS "mod_outputf_desc" (cn' "output format")
    (S "Outputs the results of the calculations, including the" +:+ desc)

{-- Module Chunks --}

mod_hw :: ModuleChunk
mod_hw = makeImpModule hwHiding
  (foldlSent [S "The", (plural $ dataStruct), 
  S "and algorithm used to implement the virtual",
  S "hardware"])
  os
  []
  []
  []
  Nothing

-- Behaviour Hiding Module
mod_behav :: ModuleChunk
mod_behav = makeUnimpModule modBehavHiding
  (S "The contents of the required behaviors.")
  Nothing

-- sfwr desc module
mod_sw :: ModuleChunk
mod_sw = makeUnimpModule modSfwrDecision
  (S "The design decision based on mathematical theorems, physical facts" `sC`
  S "or programming considerations. The secrets of this module are" +:+
  S "not described in the SRS.")
  Nothing

-- Control module
mod_ctrl_fun :: NamedIdea a => a -> [ModuleChunk] -> ModuleChunk
mod_ctrl_fun impl depnd = makeImpModule modControl
  (S "The algorithm for coordinating the running of the program.")
  impl
  []
  []
  depnd
  (Just mod_behav)

-- parameterize inputf and inputp into one mod_input?
mod_io_fun :: NamedIdea a => a -> [ModuleChunk] -> Sentence -> ConceptChunk -> ModuleChunk
mod_io_fun impl depnd desc cChunk= makeImpModule cChunk
  (foldlSent [S "The format and", (phrase structure), S "of the", desc])
  impl
  []
  []
  depnd
  (Just mod_behav)

mod_seq_fun :: NamedIdea a => a -> [ModuleChunk] -> ModuleChunk
mod_seq_fun impl depnd = makeImpModule mod_seq_serv 
  (foldlSent [S "The", (plural $ dataStruct), S "for a sequence", 
  (plural dataType)]) 
  impl
  []
  []
  depnd
  (Just mod_sw)

mod_linked_fun :: NamedIdea a => a -> [ModuleChunk] -> ModuleChunk
mod_linked_fun impl depnd = makeImpModule mod_linked_serv
  (foldlSent [S "The", (plural $ dataStruct), S "for a linked", 
  (plural dataType)])
  impl
  []
  []
  depnd
  (Just mod_sw)

mod_assoc_fun :: NamedIdea a => a -> [ModuleChunk] -> ModuleChunk
mod_assoc_fun impl depnd = makeImpModule mod_assoc_serv
  (foldlSent [S "The", (plural $ dataStruct), S "for an associative", 
  (plural dataType)])
  impl
  []
  []
  depnd
  (Just mod_sw)

mod_vector_fun :: NamedIdea a => a -> [ModuleChunk] -> ModuleChunk
mod_vector_fun impl depnd = makeImpModule mod_vector_serv
  (foldlSent [S "The", (plural $ dataStruct), S "representing vectors"])
  impl
  []
  []
  depnd
  (Just mod_sw)


mod_plot_fun :: NamedIdea a => a -> [ModuleChunk] -> ModuleChunk
mod_plot_fun impl depnd = makeImpModule mod_plot_desc
  (foldlSent [S "The", (plural $ dataStruct'), 
  S "and algorithms for plotting data graphically"])
  impl
  []
  []
  depnd
  (Just mod_sw)
   
mod_rng_fun :: NamedIdea a => a -> [ModuleChunk] -> Sentence -> ModuleChunk
mod_rng_fun impl depnd desc = makeImpModule (dccWDS "mod_rng_desc" (cn' "random number generator") desc)
  (S "Pseudo-random number generation algorithm.")
  impl
  []
  []
  depnd
  (Just mod_sw)

{--
      -> [VarChunk]        -- module fields, aka state variables
      -> [MethodChunk]     -- the methods offered by module
      -> [ModuleChunk]     -- what modules this one depends on [extract!]
      -> Maybe ModuleChunk -- Parent module, for documents [extract!]
--}