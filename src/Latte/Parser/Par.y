-- This Happy file was machine-generated by the BNF converter
{
{-# OPTIONS_GHC -fno-warn-incomplete-patterns -fno-warn-overlapping-patterns #-}
module Latte.Parser.Par where
import Latte.Parser.Abs
import Latte.Parser.Lex
import Latte.Parser.ErrM

}

-- no lexer declaration
%monad { Err } { thenM } { returnM }
%tokentype {Token}
%name pProgram_internal Program
%token
  '!' { PT _ (TS _ 1) }
  '!=' { PT _ (TS _ 2) }
  '%' { PT _ (TS _ 3) }
  '&&' { PT _ (TS _ 4) }
  '(' { PT _ (TS _ 5) }
  ')' { PT _ (TS _ 6) }
  '*' { PT _ (TS _ 7) }
  '+' { PT _ (TS _ 8) }
  '++' { PT _ (TS _ 9) }
  ',' { PT _ (TS _ 10) }
  '-' { PT _ (TS _ 11) }
  '--' { PT _ (TS _ 12) }
  '.' { PT _ (TS _ 13) }
  '/' { PT _ (TS _ 14) }
  ':' { PT _ (TS _ 15) }
  ';' { PT _ (TS _ 16) }
  '<' { PT _ (TS _ 17) }
  '<=' { PT _ (TS _ 18) }
  '=' { PT _ (TS _ 19) }
  '==' { PT _ (TS _ 20) }
  '>' { PT _ (TS _ 21) }
  '>=' { PT _ (TS _ 22) }
  '[' { PT _ (TS _ 23) }
  ']' { PT _ (TS _ 24) }
  'boolean' { PT _ (TS _ 25) }
  'class' { PT _ (TS _ 26) }
  'else' { PT _ (TS _ 27) }
  'extends' { PT _ (TS _ 28) }
  'false' { PT _ (TS _ 29) }
  'for' { PT _ (TS _ 30) }
  'if' { PT _ (TS _ 31) }
  'int' { PT _ (TS _ 32) }
  'new' { PT _ (TS _ 33) }
  'null' { PT _ (TS _ 34) }
  'return' { PT _ (TS _ 35) }
  'string' { PT _ (TS _ 36) }
  'super' { PT _ (TS _ 37) }
  'this' { PT _ (TS _ 38) }
  'true' { PT _ (TS _ 39) }
  'void' { PT _ (TS _ 40) }
  'while' { PT _ (TS _ 41) }
  '{' { PT _ (TS _ 42) }
  '||' { PT _ (TS _ 43) }
  '}' { PT _ (TS _ 44) }

  L_ident {PT _ (TV _)}
  L_quoted {PT _ (TL _)}
  L_integ {PT _ (TI _)}

%%

Ident :: {
  (Maybe (Int, Int), Ident)
}
: L_ident {
  (Just (tokenLineCol $1), Ident (prToken $1)) 
}

String :: {
  (Maybe (Int, Int), String)
}
: L_quoted {
  (Just (tokenLineCol $1), prToken $1)
}

Integer :: {
  (Maybe (Int, Int), Integer)
}
: L_integ {
  (Just (tokenLineCol $1), read (prToken $1)) 
}

Program :: {
  (Maybe (Int, Int), Program (Maybe (Int, Int)))
}
: ListTopDef {
  (fst $1, Latte.Parser.Abs.Program (fst $1)(snd $1)) 
}

TopDef :: {
  (Maybe (Int, Int), TopDef (Maybe (Int, Int)))
}
: Fn {
  (fst $1, Latte.Parser.Abs.FnDef (fst $1)(snd $1)) 
}
| ClsHeader '{' ListClsElem '}' {
  (fst $1, Latte.Parser.Abs.ClsDef (fst $1)(snd $1)(reverse (snd $3)))
}

ListTopDef :: {
  (Maybe (Int, Int), [TopDef (Maybe (Int, Int))]) 
}
: TopDef {
  (fst $1, (:[]) (snd $1)) 
}
| TopDef ListTopDef {
  (fst $1, (:) (snd $1)(snd $2)) 
}

Fn :: {
  (Maybe (Int, Int), Fn (Maybe (Int, Int)))
}
: Type Ident '(' ListArg ')' Block {
  (fst $1, Latte.Parser.Abs.Fn (fst $1)(snd $1)(snd $2)(snd $4)(snd $6)) 
}

ClsHeader :: {
  (Maybe (Int, Int), ClsHeader (Maybe (Int, Int)))
}
: 'class' Ident {
  (Just (tokenLineCol $1), Latte.Parser.Abs.BaseCls (Just (tokenLineCol $1)) (snd $2)) 
}
| 'class' Ident 'extends' Ident {
  (Just (tokenLineCol $1), Latte.Parser.Abs.SubCls (Just (tokenLineCol $1)) (snd $2)(snd $4)) 
}

ClsElem :: {
  (Maybe (Int, Int), ClsElem (Maybe (Int, Int)))
}
: Fn {
  (fst $1, Latte.Parser.Abs.Method (fst $1)(snd $1)) 
}
| Type Ident ';' {
  (fst $1, Latte.Parser.Abs.Field (fst $1)(snd $1)(snd $2)) 
}

ListClsElem :: {
  (Maybe (Int, Int), [ClsElem (Maybe (Int, Int))]) 
}
: {
  (Nothing, [])
}
| ListClsElem ClsElem {
  (fst $1, flip (:) (snd $1)(snd $2)) 
}

Arg :: {
  (Maybe (Int, Int), Arg (Maybe (Int, Int)))
}
: Type Ident {
  (fst $1, Latte.Parser.Abs.NoValArg (fst $1)(snd $1)(snd $2)) 
}

ListArg :: {
  (Maybe (Int, Int), [Arg (Maybe (Int, Int))]) 
}
: {
  (Nothing, [])
}
| Arg {
  (fst $1, (:[]) (snd $1)) 
}
| Arg ',' ListArg {
  (fst $1, (:) (snd $1)(snd $3)) 
}

Block :: {
  (Maybe (Int, Int), Block (Maybe (Int, Int)))
}
: '{' ListStmt '}' {
  (Just (tokenLineCol $1), Latte.Parser.Abs.Block (Just (tokenLineCol $1)) (reverse (snd $2)))
}

ListStmt :: {
  (Maybe (Int, Int), [Stmt (Maybe (Int, Int))]) 
}
: {
  (Nothing, [])
}
| ListStmt Stmt {
  (fst $1, flip (:) (snd $1)(snd $2)) 
}

Stmt :: {
  (Maybe (Int, Int), Stmt (Maybe (Int, Int)))
}
: ';' {
  (Just (tokenLineCol $1), Latte.Parser.Abs.Empty (Just (tokenLineCol $1)))
}
| Block {
  (fst $1, Latte.Parser.Abs.BStmt (fst $1)(snd $1)) 
}
| Type ListItem ';' {
  (fst $1, Latte.Parser.Abs.Decl (fst $1)(snd $1)(snd $2)) 
}
| Expr '=' Expr ';' {
  (fst $1, Latte.Parser.Abs.Ass (fst $1)(snd $1)(snd $3)) 
}
| Ident '++' ';' {
  (fst $1, Latte.Parser.Abs.Incr (fst $1)(snd $1)) 
}
| Ident '--' ';' {
  (fst $1, Latte.Parser.Abs.Decr (fst $1)(snd $1)) 
}
| 'return' Expr ';' {
  (Just (tokenLineCol $1), Latte.Parser.Abs.Ret (Just (tokenLineCol $1)) (snd $2)) 
}
| 'return' ';' {
  (Just (tokenLineCol $1), Latte.Parser.Abs.VRet (Just (tokenLineCol $1)))
}
| 'if' '(' Expr ')' Stmt {
  (Just (tokenLineCol $1), Latte.Parser.Abs.Cond (Just (tokenLineCol $1)) (snd $3)(snd $5)) 
}
| 'if' '(' Expr ')' Stmt 'else' Stmt {
  (Just (tokenLineCol $1), Latte.Parser.Abs.CondElse (Just (tokenLineCol $1)) (snd $3)(snd $5)(snd $7)) 
}
| 'while' '(' Expr ')' Stmt {
  (Just (tokenLineCol $1), Latte.Parser.Abs.While (Just (tokenLineCol $1)) (snd $3)(snd $5)) 
}
| 'for' '(' Type Ident ':' Ident ')' Stmt {
  (Just (tokenLineCol $1), Latte.Parser.Abs.ForEach (Just (tokenLineCol $1)) (snd $3)(snd $4)(snd $6)(snd $8)) 
}
| Expr ';' {
  (fst $1, Latte.Parser.Abs.SExp (fst $1)(snd $1)) 
}

Item :: {
  (Maybe (Int, Int), Item (Maybe (Int, Int)))
}
: Ident {
  (fst $1, Latte.Parser.Abs.NoInit (fst $1)(snd $1)) 
}
| Ident '=' Expr {
  (fst $1, Latte.Parser.Abs.Init (fst $1)(snd $1)(snd $3)) 
}

ListItem :: {
  (Maybe (Int, Int), [Item (Maybe (Int, Int))]) 
}
: Item {
  (fst $1, (:[]) (snd $1)) 
}
| Item ',' ListItem {
  (fst $1, (:) (snd $1)(snd $3)) 
}

BasicType :: {
  (Maybe (Int, Int), BasicType (Maybe (Int, Int)))
}
: 'int' {
  (Just (tokenLineCol $1), Latte.Parser.Abs.TInt (Just (tokenLineCol $1)))
}
| 'string' {
  (Just (tokenLineCol $1), Latte.Parser.Abs.TStr (Just (tokenLineCol $1)))
}
| 'boolean' {
  (Just (tokenLineCol $1), Latte.Parser.Abs.TBool (Just (tokenLineCol $1)))
}

Type :: {
  (Maybe (Int, Int), Type (Maybe (Int, Int)))
}
: 'void' {
  (Just (tokenLineCol $1), Latte.Parser.Abs.TVoid (Just (tokenLineCol $1)))
}
| Type '[' ']' {
  (fst $1, Latte.Parser.Abs.TArr (fst $1)(snd $1)) 
}
| BasicType {
  (fst $1, Latte.Parser.Abs.TBasic (fst $1)(snd $1)) 
}
| Ident {
  (fst $1, Latte.Parser.Abs.TObj (fst $1)(snd $1)) 
}

ListType :: {
  (Maybe (Int, Int), [Type (Maybe (Int, Int))]) 
}
: {
  (Nothing, [])
}
| Type {
  (fst $1, (:[]) (snd $1)) 
}
| Type ',' ListType {
  (fst $1, (:) (snd $1)(snd $3)) 
}

Expr6 :: {
  (Maybe (Int, Int), Expr (Maybe (Int, Int)))
}
: ListIdent {
  (fst $1, Latte.Parser.Abs.EVar (fst $1)(snd $1)) 
}
| Constant {
  (fst $1, Latte.Parser.Abs.EConstant (fst $1)(snd $1)) 
}
| FieldAcc {
  (fst $1, Latte.Parser.Abs.EFieldAcc (fst $1)(snd $1)) 
}
| MthCall {
  (fst $1, Latte.Parser.Abs.EMth (fst $1)(snd $1)) 
}
| SpecName {
  (fst $1, Latte.Parser.Abs.ESpecName (fst $1)(snd $1)) 
}
| NewAlloc {
  (fst $1, Latte.Parser.Abs.ENewAlloc (fst $1)(snd $1)) 
}
| ArrAcc {
  (fst $1, Latte.Parser.Abs.EArr (fst $1)(snd $1)) 
}
| String {
  (fst $1, Latte.Parser.Abs.EString (fst $1)(snd $1)) 
}
| '(' Expr ')' {
  (Just (tokenLineCol $1), snd $2)
}

Expr5 :: {
  (Maybe (Int, Int), Expr (Maybe (Int, Int)))
}
: '-' Expr6 {
  (Just (tokenLineCol $1), Latte.Parser.Abs.ENeg (Just (tokenLineCol $1)) (snd $2)) 
}
| '!' Expr6 {
  (Just (tokenLineCol $1), Latte.Parser.Abs.ENot (Just (tokenLineCol $1)) (snd $2)) 
}
| '(' Ident ')' Expr6 {
  (Just (tokenLineCol $1), Latte.Parser.Abs.ECast (Just (tokenLineCol $1)) (snd $2)(snd $4)) 
}
| Expr6 {
  (fst $1, snd $1)
}

Expr4 :: {
  (Maybe (Int, Int), Expr (Maybe (Int, Int)))
}
: Expr4 MulOp Expr5 {
  (fst $1, Latte.Parser.Abs.EMul (fst $1)(snd $1)(snd $2)(snd $3)) 
}
| Expr5 {
  (fst $1, snd $1)
}

Expr3 :: {
  (Maybe (Int, Int), Expr (Maybe (Int, Int)))
}
: Expr3 AddOp Expr4 {
  (fst $1, Latte.Parser.Abs.EAdd (fst $1)(snd $1)(snd $2)(snd $3)) 
}
| Expr4 {
  (fst $1, snd $1)
}

Expr2 :: {
  (Maybe (Int, Int), Expr (Maybe (Int, Int)))
}
: Expr2 RelOp Expr3 {
  (fst $1, Latte.Parser.Abs.ERel (fst $1)(snd $1)(snd $2)(snd $3)) 
}
| Expr3 {
  (fst $1, snd $1)
}

Expr1 :: {
  (Maybe (Int, Int), Expr (Maybe (Int, Int)))
}
: Expr2 '&&' Expr1 {
  (fst $1, Latte.Parser.Abs.EAnd (fst $1)(snd $1)(snd $3)) 
}
| Expr2 {
  (fst $1, snd $1)
}

Expr :: {
  (Maybe (Int, Int), Expr (Maybe (Int, Int)))
}
: Expr1 '||' Expr {
  (fst $1, Latte.Parser.Abs.EOr (fst $1)(snd $1)(snd $3)) 
}
| Expr1 {
  (fst $1, snd $1)
}

ListExpr :: {
  (Maybe (Int, Int), [Expr (Maybe (Int, Int))]) 
}
: {
  (Nothing, [])
}
| Expr {
  (fst $1, (:[]) (snd $1)) 
}
| Expr ',' ListExpr {
  (fst $1, (:) (snd $1)(snd $3)) 
}

SpecName :: {
  (Maybe (Int, Int), SpecName (Maybe (Int, Int)))
}
: 'super' {
  (Just (tokenLineCol $1), Latte.Parser.Abs.SSsuper (Just (tokenLineCol $1)))
}
| 'this' {
  (Just (tokenLineCol $1), Latte.Parser.Abs.SSthis (Just (tokenLineCol $1)))
}
| 'null' {
  (Just (tokenLineCol $1), Latte.Parser.Abs.SSnull (Just (tokenLineCol $1)))
}

NewAlloc :: {
  (Maybe (Int, Int), NewAlloc (Maybe (Int, Int)))
}
: 'new' BasicType '[' Expr ']' {
  (Just (tokenLineCol $1), Latte.Parser.Abs.NewArr (Just (tokenLineCol $1)) (snd $2)(snd $4)) 
}
| 'new' Ident {
  (Just (tokenLineCol $1), Latte.Parser.Abs.NewObj (Just (tokenLineCol $1)) (snd $2)) 
}
| 'new' Ident Args {
  (Just (tokenLineCol $1), Latte.Parser.Abs.NewObjConst (Just (tokenLineCol $1)) (snd $2)(snd $3)) 
}

ArrAcc :: {
  (Maybe (Int, Int), ArrAcc (Maybe (Int, Int)))
}
: ListIdent '[' Expr ']' {
  (fst $1, Latte.Parser.Abs.Aarr (fst $1)(snd $1)(snd $3)) 
}
| SpecExp '[' Expr ']' {
  (fst $1, Latte.Parser.Abs.Aarr1 (fst $1)(snd $1)(snd $3)) 
}

SpecExp :: {
  (Maybe (Int, Int), SpecExp (Maybe (Int, Int)))
}
: '(' Expr ')' {
  (Just (tokenLineCol $1), Latte.Parser.Abs.Cep (Just (tokenLineCol $1)) (snd $2)) 
}
| SpecExpNP {
  (fst $1, Latte.Parser.Abs.Cnp (fst $1)(snd $1)) 
}
| SpecName {
  (fst $1, Latte.Parser.Abs.Cthis (fst $1)(snd $1)) 
}

SpecExpNP :: {
  (Maybe (Int, Int), SpecExpNP (Maybe (Int, Int)))
}
: Constant {
  (fst $1, Latte.Parser.Abs.CNLit (fst $1)(snd $1)) 
}
| ArrAcc {
  (fst $1, Latte.Parser.Abs.CNParr (fst $1)(snd $1)) 
}
| MthCall {
  (fst $1, Latte.Parser.Abs.CNPmth (fst $1)(snd $1)) 
}
| FieldAcc {
  (fst $1, Latte.Parser.Abs.CNPfld (fst $1)(snd $1)) 
}

MthCall :: {
  (Maybe (Int, Int), MthCall (Maybe (Int, Int)))
}
: ListIdent Args {
  (fst $1, Latte.Parser.Abs.Mmth (fst $1)(snd $1)(snd $2)) 
}
| SpecExpNP Args {
  (fst $1, Latte.Parser.Abs.Mmth1 (fst $1)(snd $1)(snd $2)) 
}
| SpecName Args {
  (fst $1, Latte.Parser.Abs.Mmthspec (fst $1)(snd $1)(snd $2)) 
}

FieldAcc :: {
  (Maybe (Int, Int), FieldAcc (Maybe (Int, Int)))
}
: SpecExp '.' Ident {
  (fst $1, Latte.Parser.Abs.Ffvar (fst $1)(snd $1)(snd $3)) 
}
| NewAlloc '.' Ident {
  (fst $1, Latte.Parser.Abs.Ffvar1 (fst $1)(snd $1)(snd $3)) 
}

Args :: {
  (Maybe (Int, Int), Args (Maybe (Int, Int)))
}
: '(' ListExpr ')' {
  (Just (tokenLineCol $1), Latte.Parser.Abs.Args (Just (tokenLineCol $1)) (snd $2)) 
}

Constant :: {
  (Maybe (Int, Int), Constant (Maybe (Int, Int)))
}
: Integer {
  (fst $1, Latte.Parser.Abs.Cint (fst $1)(snd $1)) 
}
| 'false' {
  (Just (tokenLineCol $1), Latte.Parser.Abs.Cfalse (Just (tokenLineCol $1)))
}
| 'true' {
  (Just (tokenLineCol $1), Latte.Parser.Abs.Ctrue (Just (tokenLineCol $1)))
}

AddOp :: {
  (Maybe (Int, Int), AddOp (Maybe (Int, Int)))
}
: '+' {
  (Just (tokenLineCol $1), Latte.Parser.Abs.Plus (Just (tokenLineCol $1)))
}
| '-' {
  (Just (tokenLineCol $1), Latte.Parser.Abs.Minus (Just (tokenLineCol $1)))
}

MulOp :: {
  (Maybe (Int, Int), MulOp (Maybe (Int, Int)))
}
: '*' {
  (Just (tokenLineCol $1), Latte.Parser.Abs.Times (Just (tokenLineCol $1)))
}
| '/' {
  (Just (tokenLineCol $1), Latte.Parser.Abs.Div (Just (tokenLineCol $1)))
}
| '%' {
  (Just (tokenLineCol $1), Latte.Parser.Abs.Mod (Just (tokenLineCol $1)))
}

RelOp :: {
  (Maybe (Int, Int), RelOp (Maybe (Int, Int)))
}
: '<' {
  (Just (tokenLineCol $1), Latte.Parser.Abs.LTH (Just (tokenLineCol $1)))
}
| '<=' {
  (Just (tokenLineCol $1), Latte.Parser.Abs.LE (Just (tokenLineCol $1)))
}
| '>' {
  (Just (tokenLineCol $1), Latte.Parser.Abs.GTH (Just (tokenLineCol $1)))
}
| '>=' {
  (Just (tokenLineCol $1), Latte.Parser.Abs.GE (Just (tokenLineCol $1)))
}
| '==' {
  (Just (tokenLineCol $1), Latte.Parser.Abs.EQU (Just (tokenLineCol $1)))
}
| '!=' {
  (Just (tokenLineCol $1), Latte.Parser.Abs.NE (Just (tokenLineCol $1)))
}

ListIdent :: {
  (Maybe (Int, Int), [Ident]) 
}
: Ident {
  (fst $1, (:[]) (snd $1)) 
}
| Ident '.' ListIdent {
  (fst $1, (:) (snd $1)(snd $3)) 
}

{

returnM :: a -> Err a
returnM = return

thenM :: Err a -> (a -> Err b) -> Err b
thenM = (>>=)

happyError :: [Token] -> Err a
happyError ts =
  Bad $ "syntax error at " ++ tokenPos ts ++ 
  case ts of
    [] -> []
    [Err _] -> " due to lexer error"
    t:_ -> " before `" ++ id(prToken t) ++ "'"

myLexer = tokens

pProgram = (>>= return . snd) . pProgram_internal
}

