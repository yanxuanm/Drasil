{-# OPTIONS -Wall #-} 
module ASTInternal where

import qualified Data.Map.Strict as Map
import Data.List (nub)
--import Unicode
import Format

--Field should be configurable, but currently not in config to avoid
  -- cyclic import.
data Field = Symbol | Equation | Description | SIU | Name | VarName | Dependencies
  deriving (Ord, Eq)

type Chunk = Map.Map FName FDesc
type Chunks = [Chunk]
type FName = Field
type FDesc = Spec
type Dependency = Chunks

--Supported output formats for documentation.
data OutLang   = CLang

data Expr = V Variable
          | Dbl Double
          | Int Integer
          | Expr :^ Expr
          | Expr :* Expr
          | Expr :/ Expr
          | Expr :+ Expr
          | Expr :- Expr
          | C Chunk
  deriving (Eq, Ord)

type Variable = String

--For writing chunks in a specification language that can be converted to TeX
data Spec = E Expr        -- Expressions
          | S String      -- Strings, used for Descriptions/Symbols in Chunks
          | Spec :-: Spec -- Subscripting (Spec :- Spec -> Spec_{Spec} in TeX)
          | Spec :^: Spec -- Superscript (Spec :^ Spec -> Spec^{Spec} in TeX)
          | Spec :+: Spec -- Concatenation of two Specs (e.g. delta :+: T -> deltaT)
          | Empty         -- Blank
          | U Unicode     -- Unicode for special characters
          | M Unit        -- Measured in *
          | F FormatC Spec -- Special formatting for certain symbols & special chars
                                --(e.g. hat, dot, etc.)
          | CS Chunk
          | D Dependency  -- Should only be used for "Dependencies" field. Need a way to ensure it.
  deriving (Eq, Ord)

data Unit = Fundamental String --Fundamental unit type (e.g. "m" for length)
          | Derived String Expr --Derived unit type (e.g. "J" for power, from
                                --the expression kg m^2 / s^2
  deriving (Eq, Ord)

data Unicode = Tau_L
             | Tau_U
             | Alpha_L
             | Alpha_U
             | Circle
             | Delta_U
             | Delta_L
             | Rho_U
             | Rho_L
             | Phi_U
             | Phi_L
  deriving (Eq,Ord)

data FormatC = Hat
            | Vector
            | Grave
            | Acute
  deriving (Eq, Ord)
  
data LayoutObj = Table Chunks [Field]
               | Section Title [LayoutObj]
               | Paragraph Contents
               | EqnBlock Contents
               | Definition DType Chunk

data DType = Data
           | Literate
               
data Document = Document Title Author [LayoutObj] --[LayoutObj] -> DocContent

type Title    = Spec
type Contents = Spec
type Author   = Spec
               
--data Context = Pg | Eqn | Cd -- paragraph, equation, or code
-- ----------------------------------------------------------------
-- data CodeType = Calc
-- data Precision = Single | Double

data DocType = SRS
             | LPM
             | Code

data DocParams = DocClass String String --SqBracks vs. Braces
               | UsePackages [String] -- Package name list
               | ExDoc String String --SqBracks vs. Braces
             
--Get dependency from equation  
get_dep :: Expr -> Dependency
get_dep (a :/ b) = nub (get_dep a ++ get_dep b)
get_dep (a :* b) = nub (get_dep a ++ get_dep b)
get_dep (a :+ b) = nub (get_dep a ++ get_dep b)
get_dep (a :^ b) = nub (get_dep a ++ get_dep b)
get_dep (a :- b) = nub (get_dep a ++ get_dep b)
get_dep (C c) = [c]
get_dep (Int _) = []
get_dep (Dbl _) = []
get_dep (V _) = []
