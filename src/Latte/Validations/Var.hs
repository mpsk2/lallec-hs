{-# OPTIONS_GHC -XFlexibleInstances #-}
module Latte.Validations.Var where

import Control.Monad.Except
import Control.Monad.State
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
    , errors :: [String]
    , previous :: Maybe VarState
    } deriving (Show)

initialVarState :: VarState
initialVarState = VarState 
    { level = 0
    , vars = Map.empty
    , retType = Nothing
    , context = Nothing
    , errors = []
    , previous = Nothing
    }

type VarRunner a = LatteRunner VarState a

levelUp :: VarRunner ()
levelUp = do
    st <- get
    put $ st { previous = Just st }
    return ()

levelDown :: VarRunner ()
levelDown = do
    st <- get
    let (Just old) = previous st
    put $ old { errors = errors st }
    return ()

class (Show a) => Var a where
    var :: a -> VarRunner ()
    typeVar :: a -> VarRunner (Maybe (Type Position))
    addType :: a -> VarRunner ()

    notImplemented :: a -> VarRunner ()
    notImplemented a = throwError $ NotImplementedError $ "variable check " ++ (show a)

    var a = notImplemented a
    typeVar a = notImplemented a >> return Nothing
    addType a = notImplemented a

instance Var (Program Position) where
    var p@(Program _ topDefs) = do
        levelUp
        addType p
        forM_ topDefs var
        levelDown

instance Var (TopDef Position) where

