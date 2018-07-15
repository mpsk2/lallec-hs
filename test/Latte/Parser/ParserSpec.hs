module Latte.Parser.ParserSpec (main, spec) where

import Control.Monad
import Data.List (isInfixOf)
import Data.String.Utils (endswith)
import Data.Tree
import Latte.Parser.Abs (Program)
import Latte.Parser.ErrM
import Latte.Parser.Par (pProgram)
import Latte.Parser.Test (run)
import System.Directory
import System.Directory.Tree
import Test.Hspec
import Test.QuickCheck


main :: IO ()
main = hspec spec

filterFn (File fileName _) = endswith ".lat" fileName
filterFn _ = False

isOk :: String ->Err (Program (Maybe (Int, Int))) -> Bool
isOk path (Ok _) = not $ isInfixOf "syntax" path
isOk path (Bad _) = isInfixOf "syntax" path

parseTest :: DirTree (FilePath, String) -> SpecWith (Arg Expectation)
parseTest f@(File _ (path, code)) = do
    it path $ do
        let parsed = run 0 pProgram code
        parsed `shouldSatisfy` (isOk path)

spec :: Spec
spec = do
  describe "parser test" $ do
    goodFilesDir <- runIO (readDirectory "test/fixtures/input")
    let goodFiles = filter filterFn $ flattenDir $ zipPaths goodFilesDir

    forM_ goodFiles parseTest
