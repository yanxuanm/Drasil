module Drasil.GlassBR.Example where

import Drasil.GlassBR.Units

import Language.Drasil
import Data.Drasil.SI_Units
import Data.Drasil.Concepts.Documentation
import Control.Lens((^.))
import Prelude hiding (log, id)
import Data.Drasil.Utils (foldlSent)

--FIXME: There are three separate non-factored loads!
-- Two are (at least) linked, but the third is completely separate!

--FIXME: Clean up symbols (use symbol alphabet where possible)

--FIXME: Many of the current terms can be separated into terms and defns!

--FIXME: having id "" and term "" is completely bogus, and should not
--  be allowed.  This implicitly says that something here does not make sense.

{--}

glassBRSymbolsWithDefns :: [UnitalChunk]
glassBRSymbolsWithDefns = [mod_elas, sd]

mod_elas, sd :: UnitalChunk

mod_elas    = uc' "mod_elas" (nounPhraseSP "modulus of elasticity of glass")
  "The ratio of tensile stress to tensile strain of glass." cE kilopascal
sd          = makeUCWDS "sd" (nounPhraseSP "stand off distance")
  (foldlSent [S "The distance from the glazing surface to the",
  S "centroid of a hemispherical high explosive charge. It is represented by", 
  S "the coordinates (SDx, SDy, SDz)"])
  (Atomic "SD") metre

{--}

glassBRSymbols :: [UnitaryChunk]
glassBRSymbols = [plate_len, plate_width, dim_max, dim_min, act_thick,
  sflawParamK, sflawParamM, demand, sd_max, sd_min, nom_thick,
  load_dur, char_weight, cWeightMax, cWeightMin, eqTNTWeight]

plate_len, plate_width, dim_max, dim_min, act_thick, sflawParamK,
  sflawParamM, demand, sdx, sdy, sdz, sd_max, sd_min, nom_thick, load_dur,
  char_weight, cWeightMax, cWeightMin, eqTNTWeight :: UnitaryChunk

plate_len   = unitary' "plate_len" (nounPhraseSP "plate length (long dimension)")
  lA millimetre
plate_width = unitary' "plate_width" (nounPhraseSP "plate width (short dimension)")
  lB millimetre
dim_max     = unitary' "dim_max" 
  (nounPhraseSP "maximum value for one of the dimensions of the glass plate") 
  (sub lD (Atomic "max")) millimetre
dim_min     = unitary' "dim_min" 
  (nounPhraseSP "minimum value for one of the dimensions of the glass plate") 
  (sub lD (Atomic "min")) millimetre
act_thick   = unitary' "act_thick" (nounPhraseSP "actual thickness")
  lH millimetre
sflawParamK = unitary' "sflawParamK" (nounPhraseSP "surface flaw parameter") --parameterize?
  lK sFlawPU
sflawParamM = unitary' "sflawParamM" (nounPhraseSP "surface flaw parameter") --parameterize?
  lM sFlawPU
demand      = unitary' "demand" (nounPhraseSP "applied load (demand)")
  lQ kilopascal
sdx         = unitary' "sdx" (nounPhraseSP "stand off distance (x-component)")
  (sub (sd ^. symbol) lX) metre
sdy         = unitary' "sdy" (nounPhraseSP "stand off distance (y-component)")
  (sub (sd ^. symbol) lY) metre
sdz         = unitary' "sdz" (nounPhraseSP "stand off distance (z-component)")
  (sub (sd ^. symbol) lZ) metre
sd_max      = unitary' "sd_max" 
  (nounPhraseSP "maximum stand off distance permissible for input") 
  (sub (sd ^. symbol) (Atomic "max")) metre
sd_min      = unitary' "sd_min" 
  (nounPhraseSP "minimum stand off distance permissible for input") 
  (sub (sd ^. symbol) (Atomic "min")) metre
nom_thick   = unitary' "nom_thick" (nounPhraseSP $ 
  "nominal thickness t in {2.5, 2.7, 3.0, 4.0, " ++
  "5.0, 6.0, 8.0, 10.0, 12.0, 16.0, 19.0, 22.0}") 
  lT millimetre
load_dur    = unitary' "load_dur" (nounPhraseSP "duration of load")
  (sub lT lD) second
char_weight = unitary' "char_weight" (nounPhraseSP "charge weight")
  lW kilogram
cWeightMax  = unitary' "cWeightMax" 
  (nounPhraseSP "maximum permissible input charge weight")
  (sub (char_weight ^. symbol) 
  (Atomic "max")) kilogram
cWeightMin  = unitary' "cWeightMin" 
  (nounPhraseSP "minimum permissible input charge weight")
  (sub (char_weight ^. symbol) (Atomic "min")) kilogram
eqTNTWeight = unitary' "eqTNTWeight" 
  (nounPhraseSP "explosive mass in equivalent weight of TNT") --replace with short TNT?
  (sub (char_weight ^. symbol) (tNT ^. symbol)) kilogram

{-Quantities-}

glassBRUnitless :: [VarChunk]
glassBRUnitless = [ar_max, risk_fun, glass_type, is_safe1, is_safe2, sdf,
  sdf_tol, prob_br, pb_tol, dimlessLoad, tolLoad]

ar_max, risk_fun, glass_type, is_safe1, is_safe2, sdf, sdf_tol, prob_br,
  pb_tol, dimlessLoad, tolLoad, tNT, lRe, loadSF, ar_min, gTF :: VarChunk

ar_max      = makeVC "ar_max"   (nounPhraseSP "maximum aspect ratio")
  (sub (Atomic "AR") (Atomic "max"))
risk_fun    = makeVC "risk_fun" (nounPhraseSP "risk function") cB
glass_type  = makeVC "glass_type" (nounPhraseSP "glass type, g in {AN, HS, FT}")
  lG
is_safe1    = makeVC "is_safe1" 
  (nounPhraseSP $ "true when calculated probability is " ++
  "less than tolerable probability") (Concat [Atomic "is", Special UScore, 
  Atomic "safe1"])
is_safe2    = makeVC "is_safe2" 
  (nounPhraseSP $ "true when load resistance (capacity) " ++
  "is greater than load (demand)") (Concat [Atomic "is", Special UScore, 
  Atomic "safe2"])
sdf         = makeVC "sdf" 
  (nounPhraseSP "stress distribution factor (Function)") cJ
sdf_tol     = makeVC "sdf_tol" 
  (nounPhraseSP "stress distribution factor (Function) based on Pbtol")
  (sub (sdf ^. symbol) (Atomic "tol"))
prob_br     = makeVC "prob_br" (nounPhraseSP "probability of breakage")
  (sub cP lB)
pb_tol      = makeVC "pb_tol" 
  (nounPhraseSP "tolerable probability of breakage") (sub cP (Atomic "btol"))
dimlessLoad = makeVC "dimlessLoad" (nounPhraseSP "dimensionless load") (hat lQ)
tolLoad     = makeVC "tolLoad" (nounPhraseSP "tolerable load")
  (sub (dimlessLoad ^. symbol) (Atomic "tol"))
tNT         = makeVC "tNT" (nounPhraseSP "TNT equivalent factor") (Atomic "TNT")
lRe         = makeVC "lRe" (lResistance ^. term) (Atomic "LR")
loadSF      = makeVC "loadSF" (lShareFac ^. term) (Atomic "LSF")
ar_min      = makeVC "ar_min" (nounPhraseSP "minimum aspect ratio")
  (sub (Atomic "AR") (Atomic "min")) --find a way to call aspectR instead of using (Atomic "AR") again
gTF         = makeVC "gTF" (glassTypeFac ^. term) (Atomic "GTF")

{-Acronyms-}
-- FIXME: Use actual acronyms instead of CCs.

acronyms :: [CINP]
acronyms = [assumption, annealedGlass, aspectR, dataDefn, fullyTGlass,
  goalStmt, glassTypeFac, heatSGlass, iGlass, inModel, likelyChg, lDurFac,
  lGlass, lResistance, lShareFac, notApp, nonFactorL, physSyst, requirement,
  srs, thModel, eqTNT]

annealedGlass, aspectR, fullyTGlass, glassTypeFac, heatSGlass,
  iGlass, lDurFac, lGlass, lResistance, lShareFac, notApp, nonFactorL,
  eqTNT :: CINP
--FIXME: So many of these are duplicates of other named chunks/concepts
--FIXME: Add compound nounphrases
annealedGlass = commonINP "annealedGlass" (nounPhraseSP "annealed glass")          "AN"
aspectR       = commonINP' "aspectR"      (nounPhraseSP "aspect ratio")            (Atomic "AR")
fullyTGlass   = commonINP "fullyTGlass"   (nounPhraseSP "fully tempered glass")    "FT"
glassTypeFac  = commonINP "glassTypeFac"  (nounPhraseSP "glass type factor")       "GTF"
heatSGlass    = commonINP "heatSGlass"    (nounPhraseSP "heat strengthened glass") "HS"
iGlass        = commonINP "iGlass"        (nounPhraseSP "insulating glass")        "IG"
lDurFac       = commonINP "lDurFac"       (nounPhraseSP "load duration factor")    "LDF"
lGlass        = commonINP "lGlass"        (nounPhraseSP "laminated glass")         "LG"
lResistance   = commonINP "lResistance"   (nounPhraseSP "load resistance")         "LR"
lShareFac     = commonINP "lShareFac"     (nounPhraseSP "load share factor")       "LSF"
notApp        = commonINP "notApp"        (nounPhraseSP "not applicable")          "N/A"
nonFactorL    = commonINP "nonFactorL"    (nounPhraseSP "non-factored load")       "NFL"     --lowercase?
eqTNT         = commonINP "eqTNT"         (nounPhraseSP "TNT (Trinitrotoluene) Equivalent Factor") "TNT"

{-Terminology-}
-- TODO: See if we can make some of these terms less specific and/or parameterized.
 
blastRisk, glaSlab :: NPNC
blastRisk    = npnc "blastRisk" (nounPhraseSP "blast risk")
glaSlab      = npnc "glaSlab"   (nounPhraseSP "glass slab")

terms :: [ConceptChunk]
terms = [aR, gbr, lite, glassTy, an, ft, hs, gtf, lateral, load, specDeLoad, 
  lr, ldl, nfl, glassWL, sdl, lsf, pb, specA, blaReGLa, eqTNTChar, sD]

aR, gbr, lite, glassTy, an, ft, hs, gtf, lateral, load, specDeLoad, lr, 
  ldl, nfl, glassWL, sdl, lsf, pb, specA, blaReGLa, eqTNTChar, 
  sD, blast, blastTy, glassGeo, capacity, demandq, safeMessage,
  notSafe, bomb, explosion, gLassBR :: ConceptChunk

--FIXME: Why are there multiple copies of aspect ratio, glass type factor, etc.?
aR            = dcc "aR" (aspectR ^. term)
  ("The ratio of the long dimension of the glass to the short dimension of " ++
    "the glass. For glass supported on four sides, the aspect ratio is " ++
    "always equal to or greater than 1.0. For glass supported on three " ++
    "sides, the ratio of the length of one of the supported edges " ++
    "perpendicular to the free edge, to the length of the free edge, is " ++
    "equal to or greater than 0.5.")
gbr           = dcc "gbr" (nounPhraseSP "glass breakage")
  ("The fracture or breakage of any lite or ply in monolithic, laminated, " ++
    "or insulating glass.")
lite          = dcc "lite" (cn' "lite") --is used in the plural form
  ("Pieces of glass that are cut, prepared, and used to create the window " ++
    "or door.")
glassTy       = dcc "glassTy" (cn' "glass types") "type of glass"
an            = dcc "an" (annealedGlass ^. term)
  ("A flat, monolithic, glass lite which has uniform thickness where the " ++
    "residual surface stresses are almost zero, as defined in [5].")
ft            = dcc "ft" (fullyTGlass ^. term)
  ("A flat and monolithic, glass lite of uniform thickness that has been " ++
    "subjected to a special heat treatment process where the residual " ++
    "surface compression is not less than 69 MPa (10 000 psi) or the edge " ++
    "compression not less than 67 MPa (9700 psi), as defined in [6].")
hs            = dcc "hs" (heatSGlass ^. term)
  ("A flat, monolithic, glass lite of uniform thickness that has been " ++
    "subjected to a special heat treatment process where the residual " ++
    "surface compression is not less than 24 MPa (3500psi) or greater " ++
    "than 52 MPa (7500 psi), as defined in [6].")
gtf           = dccWDS "gtf" (glassTypeFac ^. term) 
  (foldlSent [S "A multiplying factor for adjusting the", (getAcc lResistance), 
  S "of different glass type, that is,", (getAcc annealedGlass) `sC` 
  (getAcc heatSGlass) `sC` S "or", (getAcc fullyTGlass), S "in monolithic glass" `sC`
  (getAcc lGlass), S "(Laminated Glass)" `sC` S "or", (getAcc iGlass), 
  S "(Insulating Glass) constructions"])
lateral       = dcc "lateral" (nounPhraseSP "lateral") "Perpendicular to the glass surface."
load          = dcc "load" (nounPhraseSP "load") "A uniformly distributed lateral pressure."
specDeLoad    = dcc "specDeLoad" (nounPhraseSP "specified design load")
  ("The magnitude in kPa (psf), type (for example, wind or snow) and " ++
    "duration of the load given by the specifying authority.")
lr            = dcc "lr" (lResistance ^. term)
  ("The uniform lateral load that a glass construction can sustain based " ++
    "upon a given probability of breakage and load duration as defined in " ++
    "[4 (pg. 1, 53)], following A2 and A1 respectively.")
ldl           = dcc "ldl" (nounPhraseSP "long duration load")
  ("Any load lasting approximately 30 days.")
nfl           = dccWDS "nfl" (nfl ^. term)
  (foldlSent [S "Three second duration uniform load associated with a probability of",
    S "breakage less than or equal to 8", (plural $ lite ^. term), S "per 1000 for monolithic",
    (getAcc annealedGlass), S "glass"])
glassWL       = dcc "glassWL" (nounPhraseSP "glass weight load")
  ("The dead load component of the glass weight.")
sdl           = dcc "sdl" (nounPhraseSP "short duration load")
  "Any load lasting 3s or less."
lsf           = dccWDS "lsf" (lShareFac ^. term)
  (foldlSent [S "A multiplying factor derived from the load sharing between the double",
  S "glazing, of equal or different thickness's and types (including the",
  S "layered behaviour of", (getAcc lGlass), S "under long duration",
  S "loads), in a sealed", (getAcc iGlass), S "unit"])
pb            = dcc "pb" (prob_br ^. term)
  ("The fraction of glass lites or plies that would break at the first " ++
    "occurrence of a specified load and duration, typically expressed " ++
    "in lites per 1000.")
specA         = dcc "specA" (nounPhraseSP "specifying authority")
  ("The design professional responsible for interpreting applicable " ++
    "regulations of authorities having jurisdiction and considering " ++
    "appropriate site specific factors to determine the appropriate " ++
    "values used to calculate the specified design load, and furnishing " ++
    "other information required to perform this practice.")
blaReGLa      = dcc "blaReGLa" (nounPhraseSP "blast resistant glazing")
  ("Glazing that provides protection against air blast pressure generated " ++
    "by explosions.")
eqTNTChar     = dcc "eqTNTChar" (nounPhraseSP "equivalent TNT charge mass")
  ("Mass of TNT placed on the ground in a hemisphere that represents the " ++
    "design explosive threat.")
sD            = dccWDS "sD" (sd ^. term) (sd ^. defn)
blast         = dcc "blast" (nounPhraseSP "blast") "any kind of man-made explosion"
blastTy       = dcc "blastTy" (nounPhraseSP "blast type")
  ("The blast type input includes parameters like weight of charge, TNT " ++
    "equivalent factor and stand off distance from the point of explosion.")
glassGeo      = dcc "glassGeo" (nounPhraseSP "glass geometry")
  ("The glass geometry based inputs include the dimensions of the glass " ++
    "plane, glass type and response type.")
capacity      = dcc "capacity" (nounPhraseSP "capacity") "the load resistance calculated"
demandq       = dcc "demandq" (nounPhraseSP "demand") "3 second duration equivalent pressure"
safeMessage   = dcc "safeMessage" (nounPhraseSP "safe")
  ("For the given input parameters, the glass is considered safe.")
notSafe       = dcc "notSafe" (nounPhraseSP "not safe")
  ("For the given input parameters, the glass is NOT considered safe.")
bomb          = dcc "bomb" (nounPhraseSP "bomb") ("a container filled with a destructive" ++
  "substance designed to exlode on impact or via detonation")
explosion     = dcc "explosion" (nounPhraseSP "explosion") "a destructive shattering of something"
gLassBR       = dcc "gLassBR" (pn "GlassBR") "GlassBR" --lowercase?
