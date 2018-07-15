module Latte.Validations.Var where

import Control.Monad.Except
import Data.Map
import qualified Data.Map as Map
import Latte.Commons
import Latte.Errors
import Latte.Parser.Abs


data VarState = VarState
    { level :: Int
    , vars :: Map Ident (Int, Int, (Type Position))
    , retType :: Maybe (Type Position)
    , context :: Maybe Ident
    , previous :: Maybe VarState
    } deriving (Show)

initialVarState :: VarState
initialVarState = VarState 
    { level = 0
    , vars = Map.empty
    , retType = Nothing
    , context = Nothing
    , previous = Nothing
    }

varProgram :: Program Position -> LatteRunner VarState ()
varProgram _ = throwError $ NotImplementedError "varProgram"

