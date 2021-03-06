module Drasil.GamePhysics.GenDefs (generalDefns, accelGravityGD, impulseGD,
 ) where

import Language.Drasil
import Utils.Drasil
import Theory.Drasil (GenDefn, gd)
import qualified Data.Drasil.Quantities.Physics as QP (acceleration,
 gravitationalAccel, gravitationalConst, restitutionCoef, impulseS, force,
 fOfGravity)
import Drasil.GamePhysics.Unitals (mLarger, dispNorm, dVect, massA, massB,
  momtInertA, momtInertB, normalLen, normalVect, perpLenA, perpLenB, initRelVel,
  mass_1, mass_2, sqrDist, distMass)
import Drasil.GamePhysics.DataDefs (collisionAssump, rightHandAssump,
  rigidTwoDAssump)
import Data.Drasil.Concepts.Math as CM (line, cartesian)
import qualified Data.Drasil.Quantities.PhysicalProperties as QPP (mass)
import Drasil.GamePhysics.TMods (newtonLUG)

----- General Models -----

generalDefns :: [GenDefn]
generalDefns = [accelGravityGD, impulseGD]


{-conservationOfMomentGDef :: RelationConcept
conservationOfMomentGDef = makeRC "conservOfMoment" (nounPhraseSP "Conservation of Momentum") 
  conservationOfMomentDesc conservationOfMomentRel

conservationOfMomentRel :: Relation
conservationOfMomentRel = UnaryOp $ Summation Nothing
  C massI

conservationOfMomentDesc :: Sentence
conservationOfMomentDesc = foldlSent [S "In an isolated system,",
  S "where the sum of external", phrase impulseS, S "acting on the system is zero,",
  S "the total momentum of the bodies is constant (conserved)"
  ]

--[mass, initialVelocity, finalVelocity]

conservationOfMomentDeriv :: Sentence
conservationOfMomentDeriv = foldlSent [S "When bodies collide, they exert",
  S "an equal (force) on each other in opposite directions" +:+.
  S "This is Newton's third law:",
  S "(expr1)",
  S "The objects collide with each other for the exact same amount of", 
  phrase time, getS time,
  S "The above equation is equal to the", phrase impulseS, 
  S "(GD1 ref)",
  S "(expr2)",
  S "The", phrase impulseS, S "is equal to the change in momentum:",
  S "(expr3)",
  S "Substituting 2*ref to 2* into 1*ref to 1* yields:",
  S "(expr4)",
  S "Expanding and rearranging the above formula gives",
  S "(expr5)",
  S "Generalizing for multiple (k) colliding objects:",
  S "(expr6)"
  ]
-}

--------------------------Acceleration due to gravity----------------------------
accelGravityGD :: GenDefn
accelGravityGD = gd accelGravityRC (getUnit QP.acceleration) (Just accelGravityDeriv)
   [accelGravitySrc] "accelGravity" [accelGravityDesc]

accelGravityRC :: RelationConcept
accelGravityRC = makeRC "accelGravityRC" (nounPhraseSP "Acceleration due to gravity") 
  accelGravityDesc accelGravityRel

accelGravityDesc :: Sentence
accelGravityDesc = foldlSent [S "If one of the", plural QPP.mass, S "is much larger than the other",
  S "it is convenient to define a gravitational field around the larger mass as shown above.",
  S "The negative sign in the equation indicates that the", phrase QP.force, S "is an attractive",
  phrase QP.force]

accelGravityRel :: Relation
accelGravityRel = sy QP.gravitationalAccel $= negate (sy QP.gravitationalConst * sy mLarger/
                  (sy dispNorm $^ 2) * sy dVect)

accelGravitySrc :: Reference
accelGravitySrc = makeURI "accelGravitySrc" "https://en.wikipedia.org/wiki/Gravitational_acceleration" $
  shortname' "Definition of Gravitational Acceleration"

accelGravityDeriv :: Derivation
accelGravityDeriv = mkDerivName (phrase QP.gravitationalAccel)
                      (weave [accelGravityDerivSentences, map E accelGravityDerivEqns])

accelGravityDerivSentences :: [Sentence]
accelGravityDerivSentences = map foldlSentCol [accelGravityDerivSentence1, 
 accelGravityDerivSentence2, accelGravityDerivSentence3, accelGravityDerivSentence4,
 accelGravityDerivSentence5] 

accelGravityDerivSentence1 :: [Sentence]
accelGravityDerivSentence1 = [S "From Newton's law of universal gravitation", sParen(makeRef2S newtonLUG), S "we have"]


accelGravityDerivSentence2 :: [Sentence]
accelGravityDerivSentence2 = [S "The above equation governs the gravitational attraction between two bodies.",
        S "Suppose that one of the bodies is significantly more massive than the other" `sC`
        S "so that we concern ourselves with the", phrase QP.force, 
        S "the massive body",
        S "exerts on the lighter body.", S "Further" `sC` S "suppose that the", phrase cartesian `sIs`
        S "chosen such that this", phrase QP.force, S "acts on a", phrase line, 
        S "which lies along one of the principal axes.", 
        S "Then our", getTandS dVect, S "for the x or y axes is"]

accelGravityDerivSentence3 :: [Sentence]
accelGravityDerivSentence3 =  [S "Given the above assumptions" `sC` S "let", ch mLarger `sAnd` ch QPP.mass, 
        S "be the", phrase QPP.mass `ofThe` S "massive and light body respectively.",
        S "Equating", ch QP.force, S "above with Newton's second law",
        S "for the", phrase QP.force, S "experienced by the light body" `sC` S "we get"]
                              
accelGravityDerivSentence4 :: [Sentence]
accelGravityDerivSentence4 =  [S "where", ch QP.gravitationalAccel `isThe` phrase QP.gravitationalAccel :+:
        S ".",
        S "Dividing the above equation by", ch QPP.mass `sC` S " we have"]

accelGravityDerivSentence5 :: [Sentence]
accelGravityDerivSentence5 =  [S "and thus the negative sign indicates that the", phrase QP.force `sIs`
                               S "an attractive", phrase QP.force]

accelGravityDerivEqn1 :: Expr
accelGravityDerivEqn1 = sy QP.force $= (sy QP.gravitationalConst * (sy mass_1 *  sy mass_2)/
                        sy sqrDist) * sy dVect

accelGravityDerivEqn2 :: Expr
accelGravityDerivEqn2 = sy dVect $= (sy distMass/ sy dispNorm)

accelGravityDerivEqn3 :: Expr
accelGravityDerivEqn3 = sy QP.fOfGravity $= sy QP.gravitationalConst *
                         (sy mLarger * sy QPP.mass / sy sqrDist) * sy dVect
                         $= sy QPP.mass * sy QP.gravitationalAccel

accelGravityDerivEqn4 :: Expr
accelGravityDerivEqn4 = sy QP.gravitationalConst *  (sy mLarger / sy sqrDist) * sy dVect $= sy QP.gravitationalAccel
                        
accelGravityDerivEqn5 :: Expr
accelGravityDerivEqn5 = sy QP.gravitationalAccel $= negate (sy QP.gravitationalConst *  (sy mLarger / sy sqrDist)) * sy dVect
                      
accelGravityDerivEqns :: [Expr]
accelGravityDerivEqns = [accelGravityDerivEqn1, accelGravityDerivEqn2, accelGravityDerivEqn3,
                         accelGravityDerivEqn4, accelGravityDerivEqn5]



----------------------------Impulse for Collision--------------------------------------------

impulseGD :: GenDefn
impulseGD = gd impulseRC (getUnit QP.impulseS) Nothing 
  [impulseSrc] "impulse" [rigidTwoDAssump, rightHandAssump, collisionAssump]

impulseRC :: RelationConcept
impulseRC = makeRC "impulseRC" (nounPhraseSP "Impulse for Collision") 
  impulseDesc impulseRel

impulseRel :: Relation
impulseRel = sy QP.impulseS $= (negate (1 + sy QP.restitutionCoef) * sy initRelVel $.
  sy normalVect) / (((1 / sy massA) + (1 / sy massB)) *
  (sy normalLen $^ 2) +
  ((sy perpLenA $^ 2) / sy momtInertA) +
  ((sy perpLenB $^ 2) / sy momtInertB))

impulseSrc :: Reference
impulseSrc = makeURI "impulseSrc" "http://www.chrishecker.com/images/e/e7/Gdmphys3.pdf" $
  shortname' "Impulse for Collision Ref"

impulseDesc :: Sentence
impulseDesc = foldlSent [S "Impulse for Collision"]
