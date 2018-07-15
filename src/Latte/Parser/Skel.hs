module Latte.Parser.Skel where

-- Haskell module generated by the BNF converter

import Latte.Parser.Abs
import Latte.Parser.ErrM
type Result = Err String

failure :: Show a => a -> Result
failure x = Bad $ "Undefined case: " ++ show x

transIdent :: Ident -> Result
transIdent x = case x of
  Ident string -> failure x
transProgram :: Show a => Program a -> Result
transProgram x = case x of
  Program _ topdefs -> failure x
transTopDef :: Show a => TopDef a -> Result
transTopDef x = case x of
  FnDef _ fn -> failure x
  ClsDef _ clsheader clselems -> failure x
transFn :: Show a => Fn a -> Result
transFn x = case x of
  Fn _ type_ ident args block -> failure x
transClsHeader :: Show a => ClsHeader a -> Result
transClsHeader x = case x of
  BaseCls _ ident -> failure x
  SubCls _ ident1 ident2 -> failure x
transClsElem :: Show a => ClsElem a -> Result
transClsElem x = case x of
  Method _ fn -> failure x
  Field _ type_ ident -> failure x
transArg :: Show a => Arg a -> Result
transArg x = case x of
  NoValArg _ type_ ident -> failure x
transBlock :: Show a => Block a -> Result
transBlock x = case x of
  Block _ stmts -> failure x
transStmt :: Show a => Stmt a -> Result
transStmt x = case x of
  Empty _ -> failure x
  BStmt _ block -> failure x
  Decl _ type_ items -> failure x
  Ass _ expr1 expr2 -> failure x
  Incr _ ident -> failure x
  Decr _ ident -> failure x
  Ret _ expr -> failure x
  VRet _ -> failure x
  Cond _ expr stmt -> failure x
  CondElse _ expr stmt1 stmt2 -> failure x
  While _ expr stmt -> failure x
  ForEach _ type_ ident1 ident2 stmt -> failure x
  SExp _ expr -> failure x
transItem :: Show a => Item a -> Result
transItem x = case x of
  NoInit _ ident -> failure x
  Init _ ident expr -> failure x
transBasicType :: Show a => BasicType a -> Result
transBasicType x = case x of
  TInt _ -> failure x
  TStr _ -> failure x
  TBool _ -> failure x
transType :: Show a => Type a -> Result
transType x = case x of
  TVoid _ -> failure x
  TArr _ type_ -> failure x
  TBasic _ basictype -> failure x
  TObj _ ident -> failure x
  Fun _ type_ types -> failure x
transExpr :: Show a => Expr a -> Result
transExpr x = case x of
  EVar _ idents -> failure x
  EConstant _ constant -> failure x
  EFieldAcc _ fieldacc -> failure x
  EMth _ mthcall -> failure x
  ESpecName _ specname -> failure x
  ENewAlloc _ newalloc -> failure x
  EArr _ arracc -> failure x
  EString _ string -> failure x
  ENeg _ expr -> failure x
  ENot _ expr -> failure x
  ECast _ ident expr -> failure x
  EMul _ expr1 mulop expr2 -> failure x
  EAdd _ expr1 addop expr2 -> failure x
  ERel _ expr1 relop expr2 -> failure x
  EAnd _ expr1 expr2 -> failure x
  EOr _ expr1 expr2 -> failure x
transSpecName :: Show a => SpecName a -> Result
transSpecName x = case x of
  SSsuper _ -> failure x
  SSthis _ -> failure x
  SSnull _ -> failure x
transNewAlloc :: Show a => NewAlloc a -> Result
transNewAlloc x = case x of
  NewArr _ basictype expr -> failure x
  NewObj _ ident -> failure x
  NewObjConst _ ident args -> failure x
transArrAcc :: Show a => ArrAcc a -> Result
transArrAcc x = case x of
  Aarr _ idents expr -> failure x
  Aarr1 _ specexp expr -> failure x
transSpecExp :: Show a => SpecExp a -> Result
transSpecExp x = case x of
  Cep _ expr -> failure x
  Cnp _ specexpnp -> failure x
  Cthis _ specname -> failure x
transSpecExpNP :: Show a => SpecExpNP a -> Result
transSpecExpNP x = case x of
  CNLit _ constant -> failure x
  CNParr _ arracc -> failure x
  CNPmth _ mthcall -> failure x
  CNPfld _ fieldacc -> failure x
transMthCall :: Show a => MthCall a -> Result
transMthCall x = case x of
  Mmth _ idents args -> failure x
  Mmth1 _ specexpnp args -> failure x
  Mmthspec _ specname args -> failure x
transFieldAcc :: Show a => FieldAcc a -> Result
transFieldAcc x = case x of
  Ffvar _ specexp ident -> failure x
  Ffvar1 _ newalloc ident -> failure x
transArgs :: Show a => Args a -> Result
transArgs x = case x of
  Args _ exprs -> failure x
transConstant :: Show a => Constant a -> Result
transConstant x = case x of
  Cint _ integer -> failure x
  Cfalse _ -> failure x
  Ctrue _ -> failure x
transAddOp :: Show a => AddOp a -> Result
transAddOp x = case x of
  Plus _ -> failure x
  Minus _ -> failure x
transMulOp :: Show a => MulOp a -> Result
transMulOp x = case x of
  Times _ -> failure x
  Div _ -> failure x
  Mod _ -> failure x
transRelOp :: Show a => RelOp a -> Result
transRelOp x = case x of
  LTH _ -> failure x
  LE _ -> failure x
  GTH _ -> failure x
  GE _ -> failure x
  EQU _ -> failure x
  NE _ -> failure x

