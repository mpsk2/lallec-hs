module Latte.Validations.VarSpec (main, spec) where

import Control.Monad
import Data.List (isInfixOf)
import Data.String.Utils (endswith)
import Data.Tree
import Latte.Commons
import Latte.Errors
import Latte.Parser.Abs (Program)
import Latte.Parser.ErrM
import Latte.Parser.Par (pProgram)
import Latte.Parser.Test (run)
import Latte.Validations.Var
import System.Directory
import System.Directory.Tree
import Test.Hspec
import Test.QuickCheck


main :: IO ()
main = hspec spec

filterFn (File fileName _) = endswith ".lat" fileName
filterFn _ = False

isOk :: String -> Err (Program Position) -> Bool
isOk path (Ok _) = not $ isInfixOf "syntax" path
isOk path (Bad _) = isInfixOf "syntax" path

passes :: Either LatteError ((), VarState) -> Bool
passes res = do
   case res of
        (Left _) -> False
        _ -> True	

parseTest :: DirTree (FilePath, String) -> SpecWith (Arg Expectation)
parseTest f@(File _ (path, code)) = do
    it path $ do
        let parsed = run 0 pProgram code
        parsed `shouldSatisfy` (isOk path)
        let (Ok prog) = parsed
        let runner = var prog
        res <- runLatteRunner initialVarState runner
        res `shouldSatisfy` passes

spec :: Spec
spec = do
  describe "parser test" $ do
    goodFilesDir <- runIO (readDirectory "test/fixtures/input/good")
    let goodFiles = filter filterFn $ flattenDir $ zipPaths goodFilesDir

    forM_ goodFiles parseTest
