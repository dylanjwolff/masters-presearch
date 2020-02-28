{-# OPTIONS_GHC -w #-}
module Main where
import Data.Char (isSpace, isAlpha, isUpper)
import Control.Monad (liftM2)
import Data.Text (unpack)
import Turtle (strict, input)
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.12

data HappyAbsSyn t4 t5 t6 t7 t8 t9
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 t5
	| HappyAbsSyn6 t6
	| HappyAbsSyn7 t7
	| HappyAbsSyn8 t8
	| HappyAbsSyn9 t9

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,176) ([57344,2592,14336,648,0,0,0,0,0,0,0,0,6785,16384,1696,4096,424,0,136,32,0,41024,6,8416,10,0,16384,23233,1,0,4096,424,1024,106,0,0,0,0,43024,1,4096,16384,23249,20480,5812,7168,1454,0,0,0,0,41024,6,43024,1,34816,0,6785,16384,1696,4096,424,1024,106,0,0,12400,22,60436,5,28421,1,0,0,0,0,0,1024,106,49472,88,12368,22,1024,0,0,0,0,20480,5816,0,1028,0,136,49472,88,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parser","Decls","Decl","CDecl","FDecl","FDecls","TypeExp","'::'","'->'","'=>'","type","class_decl","type_decl","data_decl","'='","where","'|'","'['","']'","'('","')'","'*'","name","fname","','","'{-#'","'#-}'","%eof"]
        bit_start = st * 30
        bit_end = (st + 1) * 30
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..29]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (14) = happyShift action_6
action_0 (15) = happyShift action_7
action_0 (16) = happyShift action_8
action_0 (22) = happyShift action_9
action_0 (26) = happyShift action_10
action_0 (28) = happyShift action_11
action_0 (4) = happyGoto action_12
action_0 (5) = happyGoto action_2
action_0 (6) = happyGoto action_3
action_0 (7) = happyGoto action_4
action_0 (8) = happyGoto action_5
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (14) = happyShift action_6
action_1 (15) = happyShift action_7
action_1 (16) = happyShift action_8
action_1 (22) = happyShift action_9
action_1 (26) = happyShift action_10
action_1 (28) = happyShift action_11
action_1 (5) = happyGoto action_2
action_1 (6) = happyGoto action_3
action_1 (7) = happyGoto action_4
action_1 (8) = happyGoto action_5
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyReduce_1

action_3 _ = happyReduce_4

action_4 _ = happyReduce_13

action_5 (22) = happyShift action_9
action_5 (26) = happyShift action_10
action_5 (7) = happyGoto action_25
action_5 _ = happyReduce_3

action_6 (13) = happyShift action_15
action_6 (20) = happyShift action_16
action_6 (22) = happyShift action_17
action_6 (24) = happyShift action_18
action_6 (25) = happyShift action_19
action_6 (9) = happyGoto action_24
action_6 _ = happyFail (happyExpListPerState 6)

action_7 (13) = happyShift action_15
action_7 (20) = happyShift action_16
action_7 (22) = happyShift action_17
action_7 (24) = happyShift action_18
action_7 (25) = happyShift action_19
action_7 (9) = happyGoto action_23
action_7 _ = happyFail (happyExpListPerState 7)

action_8 (13) = happyShift action_15
action_8 (20) = happyShift action_16
action_8 (22) = happyShift action_17
action_8 (24) = happyShift action_18
action_8 (25) = happyShift action_19
action_8 (9) = happyGoto action_22
action_8 _ = happyFail (happyExpListPerState 8)

action_9 (22) = happyShift action_9
action_9 (26) = happyShift action_10
action_9 (7) = happyGoto action_21
action_9 _ = happyFail (happyExpListPerState 9)

action_10 (10) = happyShift action_20
action_10 _ = happyFail (happyExpListPerState 10)

action_11 (13) = happyShift action_15
action_11 (20) = happyShift action_16
action_11 (22) = happyShift action_17
action_11 (24) = happyShift action_18
action_11 (25) = happyShift action_19
action_11 (9) = happyGoto action_14
action_11 _ = happyFail (happyExpListPerState 11)

action_12 (14) = happyShift action_6
action_12 (15) = happyShift action_7
action_12 (16) = happyShift action_8
action_12 (22) = happyShift action_9
action_12 (26) = happyShift action_10
action_12 (28) = happyShift action_11
action_12 (30) = happyAccept
action_12 (5) = happyGoto action_13
action_12 (6) = happyGoto action_3
action_12 (7) = happyGoto action_4
action_12 (8) = happyGoto action_5
action_12 _ = happyFail (happyExpListPerState 12)

action_13 _ = happyReduce_2

action_14 (11) = happyShift action_27
action_14 (13) = happyShift action_15
action_14 (19) = happyShift action_30
action_14 (20) = happyShift action_16
action_14 (22) = happyShift action_17
action_14 (24) = happyShift action_18
action_14 (25) = happyShift action_19
action_14 (27) = happyShift action_31
action_14 (29) = happyShift action_38
action_14 (9) = happyGoto action_26
action_14 _ = happyFail (happyExpListPerState 14)

action_15 _ = happyReduce_16

action_16 (13) = happyShift action_15
action_16 (20) = happyShift action_16
action_16 (22) = happyShift action_17
action_16 (24) = happyShift action_18
action_16 (25) = happyShift action_19
action_16 (9) = happyGoto action_37
action_16 _ = happyFail (happyExpListPerState 16)

action_17 (13) = happyShift action_15
action_17 (20) = happyShift action_16
action_17 (22) = happyShift action_17
action_17 (24) = happyShift action_18
action_17 (25) = happyShift action_19
action_17 (9) = happyGoto action_36
action_17 _ = happyFail (happyExpListPerState 17)

action_18 _ = happyReduce_17

action_19 _ = happyReduce_15

action_20 (13) = happyShift action_15
action_20 (20) = happyShift action_16
action_20 (22) = happyShift action_17
action_20 (24) = happyShift action_18
action_20 (25) = happyShift action_19
action_20 (9) = happyGoto action_35
action_20 _ = happyFail (happyExpListPerState 20)

action_21 (23) = happyShift action_34
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (11) = happyShift action_27
action_22 (13) = happyShift action_15
action_22 (17) = happyShift action_33
action_22 (19) = happyShift action_30
action_22 (20) = happyShift action_16
action_22 (22) = happyShift action_17
action_22 (24) = happyShift action_18
action_22 (25) = happyShift action_19
action_22 (27) = happyShift action_31
action_22 (9) = happyGoto action_26
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (11) = happyShift action_27
action_23 (13) = happyShift action_15
action_23 (17) = happyShift action_32
action_23 (19) = happyShift action_30
action_23 (20) = happyShift action_16
action_23 (22) = happyShift action_17
action_23 (24) = happyShift action_18
action_23 (25) = happyShift action_19
action_23 (27) = happyShift action_31
action_23 (9) = happyGoto action_26
action_23 _ = happyFail (happyExpListPerState 23)

action_24 (11) = happyShift action_27
action_24 (12) = happyShift action_28
action_24 (13) = happyShift action_15
action_24 (18) = happyShift action_29
action_24 (19) = happyShift action_30
action_24 (20) = happyShift action_16
action_24 (22) = happyShift action_17
action_24 (24) = happyShift action_18
action_24 (25) = happyShift action_19
action_24 (27) = happyShift action_31
action_24 (9) = happyGoto action_26
action_24 _ = happyFail (happyExpListPerState 24)

action_25 _ = happyReduce_14

action_26 (13) = happyShift action_15
action_26 (20) = happyShift action_16
action_26 (22) = happyShift action_17
action_26 (24) = happyShift action_18
action_26 (25) = happyShift action_19
action_26 (9) = happyGoto action_26
action_26 _ = happyReduce_23

action_27 (13) = happyShift action_15
action_27 (20) = happyShift action_16
action_27 (22) = happyShift action_17
action_27 (24) = happyShift action_18
action_27 (25) = happyShift action_19
action_27 (9) = happyGoto action_48
action_27 _ = happyFail (happyExpListPerState 27)

action_28 (13) = happyShift action_15
action_28 (20) = happyShift action_16
action_28 (22) = happyShift action_17
action_28 (24) = happyShift action_18
action_28 (25) = happyShift action_19
action_28 (9) = happyGoto action_47
action_28 _ = happyFail (happyExpListPerState 28)

action_29 (22) = happyShift action_9
action_29 (26) = happyShift action_10
action_29 (7) = happyGoto action_4
action_29 (8) = happyGoto action_46
action_29 _ = happyFail (happyExpListPerState 29)

action_30 (13) = happyShift action_15
action_30 (20) = happyShift action_16
action_30 (22) = happyShift action_17
action_30 (24) = happyShift action_18
action_30 (25) = happyShift action_19
action_30 (9) = happyGoto action_45
action_30 _ = happyFail (happyExpListPerState 30)

action_31 (13) = happyShift action_15
action_31 (20) = happyShift action_16
action_31 (22) = happyShift action_17
action_31 (24) = happyShift action_18
action_31 (25) = happyShift action_19
action_31 (9) = happyGoto action_44
action_31 _ = happyFail (happyExpListPerState 31)

action_32 (13) = happyShift action_15
action_32 (20) = happyShift action_16
action_32 (22) = happyShift action_17
action_32 (24) = happyShift action_18
action_32 (25) = happyShift action_19
action_32 (9) = happyGoto action_43
action_32 _ = happyFail (happyExpListPerState 32)

action_33 (13) = happyShift action_15
action_33 (20) = happyShift action_16
action_33 (22) = happyShift action_17
action_33 (24) = happyShift action_18
action_33 (25) = happyShift action_19
action_33 (9) = happyGoto action_42
action_33 _ = happyFail (happyExpListPerState 33)

action_34 _ = happyReduce_12

action_35 (11) = happyShift action_27
action_35 (12) = happyShift action_41
action_35 (13) = happyShift action_15
action_35 (19) = happyShift action_30
action_35 (20) = happyShift action_16
action_35 (22) = happyShift action_17
action_35 (24) = happyShift action_18
action_35 (25) = happyShift action_19
action_35 (27) = happyShift action_31
action_35 (9) = happyGoto action_26
action_35 _ = happyReduce_10

action_36 (11) = happyShift action_27
action_36 (13) = happyShift action_15
action_36 (19) = happyShift action_30
action_36 (20) = happyShift action_16
action_36 (22) = happyShift action_17
action_36 (23) = happyShift action_40
action_36 (24) = happyShift action_18
action_36 (25) = happyShift action_19
action_36 (27) = happyShift action_31
action_36 (9) = happyGoto action_26
action_36 _ = happyFail (happyExpListPerState 36)

action_37 (11) = happyShift action_27
action_37 (13) = happyShift action_15
action_37 (19) = happyShift action_30
action_37 (20) = happyShift action_16
action_37 (21) = happyShift action_39
action_37 (22) = happyShift action_17
action_37 (24) = happyShift action_18
action_37 (25) = happyShift action_19
action_37 (27) = happyShift action_31
action_37 (9) = happyGoto action_26
action_37 _ = happyFail (happyExpListPerState 37)

action_38 _ = happyReduce_7

action_39 _ = happyReduce_21

action_40 _ = happyReduce_22

action_41 (13) = happyShift action_15
action_41 (20) = happyShift action_16
action_41 (22) = happyShift action_17
action_41 (24) = happyShift action_18
action_41 (25) = happyShift action_19
action_41 (9) = happyGoto action_50
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (11) = happyShift action_27
action_42 (13) = happyShift action_15
action_42 (19) = happyShift action_30
action_42 (20) = happyShift action_16
action_42 (22) = happyShift action_17
action_42 (24) = happyShift action_18
action_42 (25) = happyShift action_19
action_42 (27) = happyShift action_31
action_42 (9) = happyGoto action_26
action_42 _ = happyReduce_5

action_43 (11) = happyShift action_27
action_43 (13) = happyShift action_15
action_43 (19) = happyShift action_30
action_43 (20) = happyShift action_16
action_43 (22) = happyShift action_17
action_43 (24) = happyShift action_18
action_43 (25) = happyShift action_19
action_43 (27) = happyShift action_31
action_43 (9) = happyGoto action_26
action_43 _ = happyReduce_6

action_44 (13) = happyShift action_15
action_44 (19) = happyShift action_30
action_44 (20) = happyShift action_16
action_44 (22) = happyShift action_17
action_44 (24) = happyShift action_18
action_44 (25) = happyShift action_19
action_44 (9) = happyGoto action_26
action_44 _ = happyReduce_19

action_45 (13) = happyShift action_15
action_45 (20) = happyShift action_16
action_45 (22) = happyShift action_17
action_45 (24) = happyShift action_18
action_45 (25) = happyShift action_19
action_45 (9) = happyGoto action_26
action_45 _ = happyReduce_18

action_46 (22) = happyShift action_9
action_46 (26) = happyShift action_10
action_46 (7) = happyGoto action_25
action_46 _ = happyReduce_8

action_47 (11) = happyShift action_27
action_47 (13) = happyShift action_15
action_47 (18) = happyShift action_49
action_47 (19) = happyShift action_30
action_47 (20) = happyShift action_16
action_47 (22) = happyShift action_17
action_47 (24) = happyShift action_18
action_47 (25) = happyShift action_19
action_47 (27) = happyShift action_31
action_47 (9) = happyGoto action_26
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (13) = happyShift action_15
action_48 (19) = happyShift action_30
action_48 (20) = happyShift action_16
action_48 (22) = happyShift action_17
action_48 (24) = happyShift action_18
action_48 (25) = happyShift action_19
action_48 (27) = happyShift action_31
action_48 (9) = happyGoto action_26
action_48 _ = happyReduce_20

action_49 (22) = happyShift action_9
action_49 (26) = happyShift action_10
action_49 (7) = happyGoto action_4
action_49 (8) = happyGoto action_51
action_49 _ = happyFail (happyExpListPerState 49)

action_50 (11) = happyShift action_27
action_50 (13) = happyShift action_15
action_50 (19) = happyShift action_30
action_50 (20) = happyShift action_16
action_50 (22) = happyShift action_17
action_50 (24) = happyShift action_18
action_50 (25) = happyShift action_19
action_50 (27) = happyShift action_31
action_50 (9) = happyGoto action_26
action_50 _ = happyReduce_11

action_51 (22) = happyShift action_9
action_51 (26) = happyShift action_10
action_51 (7) = happyGoto action_25
action_51 _ = happyReduce_9

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 ([happy_var_1]
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_2  4 happyReduction_2
happyReduction_2 (HappyAbsSyn5  happy_var_2)
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_2:happy_var_1
	)
happyReduction_2 _ _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_1  5 happyReduction_3
happyReduction_3 (HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn5
		 (FDecl happy_var_1
	)
happyReduction_3 _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_1  5 happyReduction_4
happyReduction_4 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn5
		 (CDecl happy_var_1
	)
happyReduction_4 _  = notHappyAtAll 

happyReduce_5 = happyReduce 4 5 happyReduction_5
happyReduction_5 ((HappyAbsSyn9  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (DDecl happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_6 = happyReduce 4 5 happyReduction_6
happyReduction_6 ((HappyAbsSyn9  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn5
		 (TDecl happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_7 = happySpecReduce_3  5 happyReduction_7
happyReduction_7 _
	(HappyAbsSyn9  happy_var_2)
	_
	 =  HappyAbsSyn5
		 (Directive happy_var_2
	)
happyReduction_7 _ _ _  = notHappyAtAll 

happyReduce_8 = happyReduce 4 6 happyReduction_8
happyReduction_8 ((HappyAbsSyn8  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (UCDecl happy_var_2 happy_var_4
	) `HappyStk` happyRest

happyReduce_9 = happyReduce 6 6 happyReduction_9
happyReduction_9 ((HappyAbsSyn8  happy_var_6) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (QCDecl happy_var_2 happy_var_4 happy_var_6
	) `HappyStk` happyRest

happyReduce_10 = happySpecReduce_3  7 happyReduction_10
happyReduction_10 (HappyAbsSyn9  happy_var_3)
	_
	(HappyTerminal (TokenFName happy_var_1))
	 =  HappyAbsSyn7
		 (UFDecl happy_var_1 happy_var_3
	)
happyReduction_10 _ _ _  = notHappyAtAll 

happyReduce_11 = happyReduce 5 7 happyReduction_11
happyReduction_11 ((HappyAbsSyn9  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenFName happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (QFDecl happy_var_1 happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_12 = happySpecReduce_3  7 happyReduction_12
happyReduction_12 _
	(HappyAbsSyn7  happy_var_2)
	_
	 =  HappyAbsSyn7
		 (FDBrack happy_var_2
	)
happyReduction_12 _ _ _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_1  8 happyReduction_13
happyReduction_13 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn8
		 ([happy_var_1]
	)
happyReduction_13 _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_2  8 happyReduction_14
happyReduction_14 (HappyAbsSyn7  happy_var_2)
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn8
		 (happy_var_2:happy_var_1
	)
happyReduction_14 _ _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_1  9 happyReduction_15
happyReduction_15 (HappyTerminal (TokenName happy_var_1))
	 =  HappyAbsSyn9
		 (Name happy_var_1
	)
happyReduction_15 _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_1  9 happyReduction_16
happyReduction_16 (HappyTerminal (TokenType happy_var_1))
	 =  HappyAbsSyn9
		 (Type happy_var_1
	)
happyReduction_16 _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_1  9 happyReduction_17
happyReduction_17 _
	 =  HappyAbsSyn9
		 (Any
	)

happyReduce_18 = happySpecReduce_3  9 happyReduction_18
happyReduction_18 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (Or happy_var_1 happy_var_3
	)
happyReduction_18 _ _ _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_3  9 happyReduction_19
happyReduction_19 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (Sep happy_var_1 happy_var_3
	)
happyReduction_19 _ _ _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_3  9 happyReduction_20
happyReduction_20 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (Function happy_var_1 happy_var_3
	)
happyReduction_20 _ _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_3  9 happyReduction_21
happyReduction_21 _
	(HappyAbsSyn9  happy_var_2)
	_
	 =  HappyAbsSyn9
		 (SBrack happy_var_2
	)
happyReduction_21 _ _ _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_3  9 happyReduction_22
happyReduction_22 _
	(HappyAbsSyn9  happy_var_2)
	_
	 =  HappyAbsSyn9
		 (Brack happy_var_2
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_2  9 happyReduction_23
happyReduction_23 (HappyAbsSyn9  happy_var_2)
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (App happy_var_1 happy_var_2
	)
happyReduction_23 _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 30 30 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenColons -> cont 10;
	TokenArrow -> cont 11;
	TokenBigArrow -> cont 12;
	TokenType happy_dollar_dollar -> cont 13;
	TokenClassMeta -> cont 14;
	TokenTypeMeta -> cont 15;
	TokenDataMeta -> cont 16;
	TokenEquals -> cont 17;
	TokenWhere -> cont 18;
	TokenOr -> cont 19;
	TokenOSB -> cont 20;
	TokenCSB -> cont 21;
	TokenOB -> cont 22;
	TokenCB -> cont 23;
	TokenAny -> cont 24;
	TokenName happy_dollar_dollar -> cont 25;
	TokenFName happy_dollar_dollar -> cont 26;
	TokenComma -> cont 27;
	TokenODir -> cont 28;
	TokenCDir -> cont 29;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 30 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure  = HappyIdentity
    (<*>) = ap
instance Monad HappyIdentity where
    return = pure
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (return)
happyThen1 m k tks = (>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (return) a
happyError' :: () => ([(Token)], [String]) -> HappyIdentity a
happyError' = HappyIdentity . (\(tokens, _) -> parseError tokens)
parser tks = happyRunIdentity happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


parseError :: [Token] -> a
parseError _ = error "Parse error"


type Decls = [Decl]
type FDecls = [FDecl]

data CDecl
    = UCDecl TypeExp FDecls
    | QCDecl TypeExp TypeExp FDecls
    deriving Show

data Decl
    = FDecl FDecls
    | CDecl CDecl
    | DDecl TypeExp TypeExp
    | TDecl TypeExp TypeExp
    | Directive TypeExp
    deriving Show

data FDecl
    = UFDecl String TypeExp
    | QFDecl String TypeExp TypeExp
    | FDBrack FDecl
    deriving Show

data TypeExp
    = Name String
    | Type String
    | Function TypeExp TypeExp
    | Sep TypeExp TypeExp
    | Or TypeExp TypeExp
    | SBrack TypeExp
    | Brack TypeExp
    | App TypeExp TypeExp
    | Any
    deriving Show

data Token
      = TokenColons
      | TokenArrow
      | TokenBigArrow
      | TokenTimes
      | TokenEquals
      | TokenWhere
      | TokenClassMeta
      | TokenTypeMeta
      | TokenType String
      | TokenDataMeta
      | TokenOr
      | TokenOSB
      | TokenCSB
      | TokenOB
      | TokenCB
      | TokenODir
      | TokenCDir
      | TokenAny
      | TokenName String
      | TokenFName String
      | TokenComma
      | TokenHash
      deriving Show


lexer :: String -> [Token]
lexer [] = []
lexer (c:cs)
      | isSpace c = lexer cs
      | isAlpha c = lexVar (c:cs)
lexer ('=':'>':cs) = TokenBigArrow : lexer cs
lexer ('=':cs) = TokenEquals : lexer cs
lexer ('*':cs) = TokenAny : lexer cs
lexer ('|':cs) = TokenOr : lexer cs
lexer ('[':cs) = TokenOSB : lexer cs
lexer (']':cs) = TokenCSB : lexer cs
lexer ('(':cs) = lexBrackets ('(':cs)
lexer (')':cs) = TokenCB : lexer cs
lexer (':':':':cs) = TokenColons : lexer cs
lexer (',':cs) = TokenComma : lexer cs
lexer ('-':'>':cs) = TokenArrow : lexer cs
lexer ('{':'-':'#':cs) = TokenODir : lexer cs
lexer ('#':'-':'}':cs) = TokenCDir : lexer cs
lexer ('#':cs) = lexer cs

isComma c = c == ','
isBracket c = c == '(' || c == ')' || c == '[' || c == ']'
fand = liftM2 (&&)
isValName = fand (fand (not . isSpace) (not . isComma)) (not . isBracket)

lookaheadAndLex proposed current rest =
    case rest of
        a:b:c:cs -> case a:b:[c] of
                    " ::" -> TokenFName current : TokenColons : lexer cs
                    otherwise -> (proposed current) : lexer rest
        otherwise -> (proposed current) : lexer rest

lexVar cs =
   case Prelude.span isValName cs of
      ("class",rest) -> TokenClassMeta : lexer rest
      ("data",rest)  -> TokenDataMeta : lexer rest
      ("type",rest)  -> TokenTypeMeta : lexer rest
      ("newtype",rest)  -> TokenTypeMeta : lexer rest
      ("where",rest)  -> TokenWhere   : lexer rest
      (c:cs,rest)   ->   if isUpper c then (TokenType (c:cs)) : (lexer rest) else lookaheadAndLex TokenName (c:cs) rest

lexBrackets ('(':cs) =
    let (cts, next:rest) = Prelude.span isValName cs in
    if next == ')' then lookaheadAndLex TokenName cts rest else TokenOB : (lexer cs)

main = getContents >>= print . parser . lexer
{-# LINE 1 "templates/GenericTemplate.hs" #-}
-- $Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp $










































data Happy_IntList = HappyCons Int Happy_IntList








































infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is ERROR_TOK, it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action









































indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x < y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `div` 16)) (bit `mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction









happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery (ERROR_TOK is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  ERROR_TOK tk old_st CONS(HAPPYSTATE(action),sts) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        DO_ACTION(action,ERROR_TOK,tk,sts,(saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ((HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.









{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
