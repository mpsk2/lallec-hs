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

addVar :: Ident -> Position -> Type Position -> VarRunner ()
addVar _ _ _ = throwError $ NotImplementedError "add var"

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
    addType :: a -> VarRunner (Type Position)

    notImplemented :: a -> VarRunner ()
    notImplemented a = throwError $ NotImplementedError $ "variable check " ++ (show a)

    var a = notImplemented a
    typeVar a = notImplemented a >> return Nothing
    addType a = notImplemented a >> (return $ TVoid Nothing)

instance Var (Program Position) where
    var p@(Program _ topDefs) = do
        levelUp
        _ <- addType p
        levelUp
        forM_ topDefs var
        levelDown
        levelDown

    addType p@(Program _ topDefs) = forM_ topDefs addType >> (return $ TVoid Nothing)

instance Var (TopDef Position) where
    addType (FnDef _ fn) = addType fn
    addType a = notImplemented a >> (return $ TVoid Nothing)

instance Var (Fn Position) where
    addType (Fn pos t ident args _) = do
        t_ <- addType t
        argsT <- mapM addType args
        let funT = Fun Nothing t_ argsT
        addVar ident pos $ funT
        return funT

instance Var (Type Position) where

instance Var (Arg Position) where

