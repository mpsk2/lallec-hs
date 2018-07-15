module Latte.Errors where

import Latte.Parser.Abs

data LatteError
    = NotImplementedError String
    | ParseError String
    | OtherError String

instance Show LatteError where
    show (NotImplementedError s) = s ++ " is not implemented"
    show (ParseError s) = "Failed to parse program: " ++ s
    show (OtherError s) = s