module Latte.Commons where

import Control.Monad.State
import Control.Monad.Except
import Latte.Errors

type Position = Maybe (Int, Int)

type LatteRunner state retType = StateT state (ExceptT LatteError IO) retType

runLatteRunner :: state -> LatteRunner state retType -> IO (Either LatteError (retType, state))
runLatteRunner state runner = runExceptT $ runStateT runner state
