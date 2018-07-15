module Latte.Parser.ParserSpec (main, spec) where

import Control.Monad
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

isOk :: Err (Program (Maybe (Int, Int))) -> Bool
isOk (Ok _) = True
isOk _ = False

parseTest :: DirTree (FilePath, String) -> SpecWith (Arg Expectation)
parseTest f@(File _ (path, code)) = do
    it path $ do
        let parsed = run 0 pProgram code
        parsed `shouldSatisfy` isOk

spec :: Spec
spec = do
  describe "parser test" $ do
    goodFilesDir <- runIO (readDirectory "test/fixtures/input")
    let goodFiles = filter filterFn $ flattenDir $ zipPaths goodFilesDir

    forM_ goodFiles parseTest
