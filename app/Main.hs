module Main where

import Latte.CLI (myTestInterface)
import System.Console.ArgParser

main :: IO ()
main = do
    interface <- myTestInterface
    runApp interface print