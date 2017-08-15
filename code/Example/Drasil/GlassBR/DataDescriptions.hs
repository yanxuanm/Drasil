module Drasil.GlassBR.DataDescriptions where

import Language.Drasil

import Drasil.GlassBR.Unitals (plate_len, plate_width, nom_thick,
  glass_type, char_weight, tNT, sdx, sdy, sdz, pb_tol)
import Drasil.GlassBR.Interpolation (v_z_array, v_x_array, v_y_array)

--from TSD.txt:

read_table :: Func
read_table = funcData "read_table" $
  [ singleLine (repeated [junk, listEntry [WithPattern] v_z_array]) ',',
    multiLine (repeated [listEntry [WithLine, WithPattern] v_x_array, 
                         listEntry [WithLine, WithPattern] v_y_array]) ','
  ]
  
readTableMod :: Mod
readTableMod = Mod "ReadTable" [read_table]

-----

--from defaultInput.txt:

inputMod :: Mod
inputMod = Mod "InputFormat" [glassInputData]

glassInputData :: Func
glassInputData = funcData "get_input" $
  [ junkLine,
    singleton plate_len, singleton plate_width, singleton nom_thick,
    junkLine,
    singleton glass_type, 
    junkLine,
    singleton char_weight, 
    junkLine, 
    singleton tNT, 
    junkLine,
    singleton sdx, singleton sdy, singleton sdz,
    junkLine,
    singleton pb_tol
  ]
