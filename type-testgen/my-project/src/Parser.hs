{-# OPTIONS_GHC -w #-}
module Parser where
import Data.Char (isSpace, isAlpha, isUpper)
import Control.Monad (liftM2)
import Data.Text (unpack)
import Turtle (strict, input)
import Data.List (isPrefixOf)
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
happyExpList = Happy_Data_Array.listArray (0,255) ([61440,2592,15360,648,0,0,0,0,0,0,0,8192,0,16384,1696,4096,424,1024,106,256,34,8,0,43024,1,34876,2,0,20480,22192,0,0,1024,106,33024,26,0,0,0,0,27140,0,1024,20480,5812,5120,1453,34560,491,33024,26,0,0,35844,5,34950,0,0,16384,1696,4096,424,128,0,256,34,41024,6,43024,3,27140,0,6785,16384,1696,0,0,256,355,49472,94,61520,22,0,0,0,0,0,16384,1696,1024,1420,256,355,16384,0,0,0,0,0,60293,1,16448,16384,1696,4096,544,1024,106,49216,88,0,0,44052,7,34948,0,8705,4096,5680,0,0,1024,136,8448,34,32832,8,0,0,0,0,0
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

action_0 (13) = happyShift action_6
action_0 (14) = happyShift action_7
action_0 (15) = happyShift action_8
action_0 (16) = happyShift action_9
action_0 (22) = happyShift action_10
action_0 (26) = happyShift action_11
action_0 (28) = happyShift action_12
action_0 (4) = happyGoto action_13
action_0 (5) = happyGoto action_2
action_0 (6) = happyGoto action_3
action_0 (7) = happyGoto action_4
action_0 (8) = happyGoto action_5
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (13) = happyShift action_6
action_1 (14) = happyShift action_7
action_1 (15) = happyShift action_8
action_1 (16) = happyShift action_9
action_1 (22) = happyShift action_10
action_1 (26) = happyShift action_11
action_1 (28) = happyShift action_12
action_1 (5) = happyGoto action_2
action_1 (6) = happyGoto action_3
action_1 (7) = happyGoto action_4
action_1 (8) = happyGoto action_5
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyReduce_1

action_3 _ = happyReduce_4

action_4 _ = happyReduce_18

action_5 (13) = happyShift action_6
action_5 (22) = happyShift action_10
action_5 (26) = happyShift action_11
action_5 (7) = happyGoto action_27
action_5 _ = happyReduce_3

action_6 (10) = happyShift action_26
action_6 _ = happyFail (happyExpListPerState 6)

action_7 (13) = happyShift action_16
action_7 (20) = happyShift action_17
action_7 (22) = happyShift action_18
action_7 (24) = happyShift action_19
action_7 (25) = happyShift action_20
action_7 (9) = happyGoto action_25
action_7 _ = happyFail (happyExpListPerState 7)

action_8 (13) = happyShift action_16
action_8 (20) = happyShift action_17
action_8 (22) = happyShift action_18
action_8 (24) = happyShift action_19
action_8 (25) = happyShift action_20
action_8 (9) = happyGoto action_24
action_8 _ = happyFail (happyExpListPerState 8)

action_9 (13) = happyShift action_16
action_9 (20) = happyShift action_17
action_9 (22) = happyShift action_18
action_9 (24) = happyShift action_19
action_9 (25) = happyShift action_20
action_9 (9) = happyGoto action_23
action_9 _ = happyFail (happyExpListPerState 9)

action_10 (13) = happyShift action_6
action_10 (22) = happyShift action_10
action_10 (26) = happyShift action_11
action_10 (7) = happyGoto action_22
action_10 _ = happyFail (happyExpListPerState 10)

action_11 (10) = happyShift action_21
action_11 _ = happyFail (happyExpListPerState 11)

action_12 (13) = happyShift action_16
action_12 (20) = happyShift action_17
action_12 (22) = happyShift action_18
action_12 (24) = happyShift action_19
action_12 (25) = happyShift action_20
action_12 (9) = happyGoto action_15
action_12 _ = happyFail (happyExpListPerState 12)

action_13 (13) = happyShift action_6
action_13 (14) = happyShift action_7
action_13 (15) = happyShift action_8
action_13 (16) = happyShift action_9
action_13 (22) = happyShift action_10
action_13 (26) = happyShift action_11
action_13 (28) = happyShift action_12
action_13 (30) = happyAccept
action_13 (5) = happyGoto action_14
action_13 (6) = happyGoto action_3
action_13 (7) = happyGoto action_4
action_13 (8) = happyGoto action_5
action_13 _ = happyFail (happyExpListPerState 13)

action_14 _ = happyReduce_2

action_15 (11) = happyShift action_31
action_15 (13) = happyShift action_16
action_15 (19) = happyShift action_35
action_15 (20) = happyShift action_17
action_15 (22) = happyShift action_18
action_15 (24) = happyShift action_19
action_15 (25) = happyShift action_20
action_15 (27) = happyShift action_37
action_15 (29) = happyShift action_44
action_15 (9) = happyGoto action_30
action_15 _ = happyFail (happyExpListPerState 15)

action_16 _ = happyReduce_21

action_17 (13) = happyShift action_16
action_17 (20) = happyShift action_17
action_17 (22) = happyShift action_18
action_17 (24) = happyShift action_19
action_17 (25) = happyShift action_20
action_17 (9) = happyGoto action_43
action_17 _ = happyFail (happyExpListPerState 17)

action_18 (13) = happyShift action_16
action_18 (20) = happyShift action_17
action_18 (22) = happyShift action_18
action_18 (24) = happyShift action_19
action_18 (25) = happyShift action_20
action_18 (9) = happyGoto action_42
action_18 _ = happyFail (happyExpListPerState 18)

action_19 _ = happyReduce_22

action_20 _ = happyReduce_20

action_21 (13) = happyShift action_16
action_21 (20) = happyShift action_17
action_21 (22) = happyShift action_18
action_21 (24) = happyShift action_19
action_21 (25) = happyShift action_20
action_21 (9) = happyGoto action_41
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (23) = happyShift action_40
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (11) = happyShift action_31
action_23 (13) = happyShift action_16
action_23 (17) = happyShift action_39
action_23 (19) = happyShift action_35
action_23 (20) = happyShift action_17
action_23 (22) = happyShift action_18
action_23 (24) = happyShift action_19
action_23 (25) = happyShift action_20
action_23 (27) = happyShift action_37
action_23 (9) = happyGoto action_30
action_23 _ = happyFail (happyExpListPerState 23)

action_24 (11) = happyShift action_31
action_24 (13) = happyShift action_16
action_24 (17) = happyShift action_38
action_24 (19) = happyShift action_35
action_24 (20) = happyShift action_17
action_24 (22) = happyShift action_18
action_24 (24) = happyShift action_19
action_24 (25) = happyShift action_20
action_24 (27) = happyShift action_37
action_24 (9) = happyGoto action_30
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (11) = happyShift action_31
action_25 (12) = happyShift action_32
action_25 (13) = happyShift action_33
action_25 (18) = happyShift action_34
action_25 (19) = happyShift action_35
action_25 (20) = happyShift action_17
action_25 (22) = happyShift action_36
action_25 (24) = happyShift action_19
action_25 (25) = happyShift action_20
action_25 (26) = happyShift action_11
action_25 (27) = happyShift action_37
action_25 (7) = happyGoto action_4
action_25 (8) = happyGoto action_29
action_25 (9) = happyGoto action_30
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (13) = happyShift action_16
action_26 (20) = happyShift action_17
action_26 (22) = happyShift action_18
action_26 (24) = happyShift action_19
action_26 (25) = happyShift action_20
action_26 (9) = happyGoto action_28
action_26 _ = happyFail (happyExpListPerState 26)

action_27 _ = happyReduce_19

action_28 (11) = happyShift action_31
action_28 (12) = happyShift action_57
action_28 (13) = happyShift action_16
action_28 (19) = happyShift action_35
action_28 (20) = happyShift action_17
action_28 (22) = happyShift action_18
action_28 (24) = happyShift action_19
action_28 (25) = happyShift action_20
action_28 (27) = happyShift action_37
action_28 (9) = happyGoto action_30
action_28 _ = happyReduce_16

action_29 (12) = happyShift action_55
action_29 (13) = happyShift action_6
action_29 (18) = happyShift action_56
action_29 (22) = happyShift action_10
action_29 (26) = happyShift action_11
action_29 (7) = happyGoto action_27
action_29 _ = happyFail (happyExpListPerState 29)

action_30 (13) = happyShift action_16
action_30 (20) = happyShift action_17
action_30 (22) = happyShift action_18
action_30 (24) = happyShift action_19
action_30 (25) = happyShift action_20
action_30 (9) = happyGoto action_30
action_30 _ = happyReduce_28

action_31 (13) = happyShift action_16
action_31 (20) = happyShift action_17
action_31 (22) = happyShift action_18
action_31 (24) = happyShift action_19
action_31 (25) = happyShift action_20
action_31 (9) = happyGoto action_54
action_31 _ = happyFail (happyExpListPerState 31)

action_32 (13) = happyShift action_16
action_32 (20) = happyShift action_17
action_32 (22) = happyShift action_18
action_32 (24) = happyShift action_19
action_32 (25) = happyShift action_20
action_32 (9) = happyGoto action_53
action_32 _ = happyFail (happyExpListPerState 32)

action_33 (10) = happyShift action_26
action_33 _ = happyReduce_21

action_34 (13) = happyShift action_6
action_34 (22) = happyShift action_10
action_34 (26) = happyShift action_11
action_34 (7) = happyGoto action_4
action_34 (8) = happyGoto action_52
action_34 _ = happyFail (happyExpListPerState 34)

action_35 (13) = happyShift action_16
action_35 (20) = happyShift action_17
action_35 (22) = happyShift action_18
action_35 (24) = happyShift action_19
action_35 (25) = happyShift action_20
action_35 (9) = happyGoto action_51
action_35 _ = happyFail (happyExpListPerState 35)

action_36 (13) = happyShift action_33
action_36 (20) = happyShift action_17
action_36 (22) = happyShift action_36
action_36 (24) = happyShift action_19
action_36 (25) = happyShift action_20
action_36 (26) = happyShift action_11
action_36 (7) = happyGoto action_22
action_36 (9) = happyGoto action_42
action_36 _ = happyFail (happyExpListPerState 36)

action_37 (13) = happyShift action_16
action_37 (20) = happyShift action_17
action_37 (22) = happyShift action_18
action_37 (24) = happyShift action_19
action_37 (25) = happyShift action_20
action_37 (9) = happyGoto action_50
action_37 _ = happyFail (happyExpListPerState 37)

action_38 (13) = happyShift action_16
action_38 (20) = happyShift action_17
action_38 (22) = happyShift action_18
action_38 (24) = happyShift action_19
action_38 (25) = happyShift action_20
action_38 (9) = happyGoto action_49
action_38 _ = happyFail (happyExpListPerState 38)

action_39 (13) = happyShift action_16
action_39 (20) = happyShift action_17
action_39 (22) = happyShift action_18
action_39 (24) = happyShift action_19
action_39 (25) = happyShift action_20
action_39 (9) = happyGoto action_48
action_39 _ = happyFail (happyExpListPerState 39)

action_40 _ = happyReduce_17

action_41 (11) = happyShift action_31
action_41 (12) = happyShift action_47
action_41 (13) = happyShift action_16
action_41 (19) = happyShift action_35
action_41 (20) = happyShift action_17
action_41 (22) = happyShift action_18
action_41 (24) = happyShift action_19
action_41 (25) = happyShift action_20
action_41 (27) = happyShift action_37
action_41 (9) = happyGoto action_30
action_41 _ = happyReduce_13

action_42 (11) = happyShift action_31
action_42 (13) = happyShift action_16
action_42 (19) = happyShift action_35
action_42 (20) = happyShift action_17
action_42 (22) = happyShift action_18
action_42 (23) = happyShift action_46
action_42 (24) = happyShift action_19
action_42 (25) = happyShift action_20
action_42 (27) = happyShift action_37
action_42 (9) = happyGoto action_30
action_42 _ = happyFail (happyExpListPerState 42)

action_43 (11) = happyShift action_31
action_43 (13) = happyShift action_16
action_43 (19) = happyShift action_35
action_43 (20) = happyShift action_17
action_43 (21) = happyShift action_45
action_43 (22) = happyShift action_18
action_43 (24) = happyShift action_19
action_43 (25) = happyShift action_20
action_43 (27) = happyShift action_37
action_43 (9) = happyGoto action_30
action_43 _ = happyFail (happyExpListPerState 43)

action_44 _ = happyReduce_7

action_45 _ = happyReduce_26

action_46 _ = happyReduce_27

action_47 (13) = happyShift action_16
action_47 (20) = happyShift action_17
action_47 (22) = happyShift action_18
action_47 (24) = happyShift action_19
action_47 (25) = happyShift action_20
action_47 (9) = happyGoto action_63
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (11) = happyShift action_31
action_48 (13) = happyShift action_16
action_48 (19) = happyShift action_35
action_48 (20) = happyShift action_17
action_48 (22) = happyShift action_18
action_48 (24) = happyShift action_19
action_48 (25) = happyShift action_20
action_48 (27) = happyShift action_37
action_48 (9) = happyGoto action_30
action_48 _ = happyReduce_5

action_49 (11) = happyShift action_31
action_49 (13) = happyShift action_16
action_49 (19) = happyShift action_35
action_49 (20) = happyShift action_17
action_49 (22) = happyShift action_18
action_49 (24) = happyShift action_19
action_49 (25) = happyShift action_20
action_49 (27) = happyShift action_37
action_49 (9) = happyGoto action_30
action_49 _ = happyReduce_6

action_50 (13) = happyShift action_16
action_50 (19) = happyShift action_35
action_50 (20) = happyShift action_17
action_50 (22) = happyShift action_18
action_50 (24) = happyShift action_19
action_50 (25) = happyShift action_20
action_50 (9) = happyGoto action_30
action_50 _ = happyReduce_24

action_51 (13) = happyShift action_16
action_51 (20) = happyShift action_17
action_51 (22) = happyShift action_18
action_51 (24) = happyShift action_19
action_51 (25) = happyShift action_20
action_51 (9) = happyGoto action_30
action_51 _ = happyReduce_23

action_52 (13) = happyShift action_6
action_52 (22) = happyShift action_10
action_52 (26) = happyShift action_11
action_52 (7) = happyGoto action_27
action_52 _ = happyReduce_8

action_53 (11) = happyShift action_31
action_53 (13) = happyShift action_33
action_53 (18) = happyShift action_62
action_53 (19) = happyShift action_35
action_53 (20) = happyShift action_17
action_53 (22) = happyShift action_36
action_53 (24) = happyShift action_19
action_53 (25) = happyShift action_20
action_53 (26) = happyShift action_11
action_53 (27) = happyShift action_37
action_53 (7) = happyGoto action_4
action_53 (8) = happyGoto action_61
action_53 (9) = happyGoto action_30
action_53 _ = happyFail (happyExpListPerState 53)

action_54 (13) = happyShift action_16
action_54 (19) = happyShift action_35
action_54 (20) = happyShift action_17
action_54 (22) = happyShift action_18
action_54 (24) = happyShift action_19
action_54 (25) = happyShift action_20
action_54 (27) = happyShift action_37
action_54 (9) = happyGoto action_30
action_54 _ = happyReduce_25

action_55 (13) = happyShift action_16
action_55 (20) = happyShift action_17
action_55 (22) = happyShift action_18
action_55 (24) = happyShift action_19
action_55 (25) = happyShift action_20
action_55 (9) = happyGoto action_60
action_55 _ = happyFail (happyExpListPerState 55)

action_56 (13) = happyShift action_6
action_56 (22) = happyShift action_10
action_56 (26) = happyShift action_11
action_56 (7) = happyGoto action_4
action_56 (8) = happyGoto action_59
action_56 _ = happyFail (happyExpListPerState 56)

action_57 (13) = happyShift action_16
action_57 (20) = happyShift action_17
action_57 (22) = happyShift action_18
action_57 (24) = happyShift action_19
action_57 (25) = happyShift action_20
action_57 (9) = happyGoto action_58
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (11) = happyShift action_31
action_58 (13) = happyShift action_16
action_58 (19) = happyShift action_35
action_58 (20) = happyShift action_17
action_58 (22) = happyShift action_18
action_58 (24) = happyShift action_19
action_58 (25) = happyShift action_20
action_58 (27) = happyShift action_37
action_58 (9) = happyGoto action_30
action_58 _ = happyReduce_15

action_59 (13) = happyShift action_6
action_59 (22) = happyShift action_10
action_59 (26) = happyShift action_11
action_59 (7) = happyGoto action_27
action_59 _ = happyReduce_12

action_60 (11) = happyShift action_31
action_60 (13) = happyShift action_33
action_60 (19) = happyShift action_35
action_60 (20) = happyShift action_17
action_60 (22) = happyShift action_36
action_60 (24) = happyShift action_19
action_60 (25) = happyShift action_20
action_60 (26) = happyShift action_11
action_60 (27) = happyShift action_37
action_60 (7) = happyGoto action_4
action_60 (8) = happyGoto action_66
action_60 (9) = happyGoto action_30
action_60 _ = happyFail (happyExpListPerState 60)

action_61 (13) = happyShift action_6
action_61 (18) = happyShift action_65
action_61 (22) = happyShift action_10
action_61 (26) = happyShift action_11
action_61 (7) = happyGoto action_27
action_61 _ = happyFail (happyExpListPerState 61)

action_62 (13) = happyShift action_6
action_62 (22) = happyShift action_10
action_62 (26) = happyShift action_11
action_62 (7) = happyGoto action_4
action_62 (8) = happyGoto action_64
action_62 _ = happyFail (happyExpListPerState 62)

action_63 (11) = happyShift action_31
action_63 (13) = happyShift action_16
action_63 (19) = happyShift action_35
action_63 (20) = happyShift action_17
action_63 (22) = happyShift action_18
action_63 (24) = happyShift action_19
action_63 (25) = happyShift action_20
action_63 (27) = happyShift action_37
action_63 (9) = happyGoto action_30
action_63 _ = happyReduce_14

action_64 (13) = happyShift action_6
action_64 (22) = happyShift action_10
action_64 (26) = happyShift action_11
action_64 (7) = happyGoto action_27
action_64 _ = happyReduce_9

action_65 (13) = happyShift action_6
action_65 (22) = happyShift action_10
action_65 (26) = happyShift action_11
action_65 (7) = happyGoto action_4
action_65 (8) = happyGoto action_68
action_65 _ = happyFail (happyExpListPerState 65)

action_66 (13) = happyShift action_6
action_66 (18) = happyShift action_67
action_66 (22) = happyShift action_10
action_66 (26) = happyShift action_11
action_66 (7) = happyGoto action_27
action_66 _ = happyFail (happyExpListPerState 66)

action_67 (13) = happyShift action_6
action_67 (22) = happyShift action_10
action_67 (26) = happyShift action_11
action_67 (7) = happyGoto action_4
action_67 (8) = happyGoto action_69
action_67 _ = happyFail (happyExpListPerState 67)

action_68 (13) = happyShift action_6
action_68 (22) = happyShift action_10
action_68 (26) = happyShift action_11
action_68 (7) = happyGoto action_27
action_68 _ = happyReduce_10

action_69 (13) = happyShift action_6
action_69 (22) = happyShift action_10
action_69 (26) = happyShift action_11
action_69 (7) = happyGoto action_27
action_69 _ = happyReduce_11

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
		 (FDecls happy_var_1
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

happyReduce_10 = happyReduce 7 6 happyReduction_10
happyReduction_10 ((HappyAbsSyn8  happy_var_7) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_5) `HappyStk`
	(HappyAbsSyn9  happy_var_4) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (Q2CDecl happy_var_2 happy_var_4 happy_var_5 happy_var_7
	) `HappyStk` happyRest

happyReduce_11 = happyReduce 8 6 happyReduction_11
happyReduction_11 ((HappyAbsSyn8  happy_var_8) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_6) `HappyStk`
	(HappyAbsSyn9  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	(HappyAbsSyn9  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (Q3CDecl happy_var_2 happy_var_3 happy_var_5 happy_var_6 happy_var_8
	) `HappyStk` happyRest

happyReduce_12 = happyReduce 5 6 happyReduction_12
happyReduction_12 ((HappyAbsSyn8  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn8  happy_var_3) `HappyStk`
	(HappyAbsSyn9  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn6
		 (U2CDecl happy_var_2 happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_13 = happySpecReduce_3  7 happyReduction_13
happyReduction_13 (HappyAbsSyn9  happy_var_3)
	_
	(HappyTerminal (TokenFName happy_var_1))
	 =  HappyAbsSyn7
		 (UFDecl happy_var_1 happy_var_3
	)
happyReduction_13 _ _ _  = notHappyAtAll 

happyReduce_14 = happyReduce 5 7 happyReduction_14
happyReduction_14 ((HappyAbsSyn9  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenFName happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (QFDecl happy_var_1 happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_15 = happyReduce 5 7 happyReduction_15
happyReduction_15 ((HappyAbsSyn9  happy_var_5) `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn9  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenType happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn7
		 (TQFDecl happy_var_1 happy_var_3 happy_var_5
	) `HappyStk` happyRest

happyReduce_16 = happySpecReduce_3  7 happyReduction_16
happyReduction_16 (HappyAbsSyn9  happy_var_3)
	_
	(HappyTerminal (TokenType happy_var_1))
	 =  HappyAbsSyn7
		 (TUFDecl happy_var_1 happy_var_3
	)
happyReduction_16 _ _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_3  7 happyReduction_17
happyReduction_17 _
	(HappyAbsSyn7  happy_var_2)
	_
	 =  HappyAbsSyn7
		 (FDBrack happy_var_2
	)
happyReduction_17 _ _ _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_1  8 happyReduction_18
happyReduction_18 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn8
		 ([happy_var_1]
	)
happyReduction_18 _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_2  8 happyReduction_19
happyReduction_19 (HappyAbsSyn7  happy_var_2)
	(HappyAbsSyn8  happy_var_1)
	 =  HappyAbsSyn8
		 (happy_var_2:happy_var_1
	)
happyReduction_19 _ _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_1  9 happyReduction_20
happyReduction_20 (HappyTerminal (TokenName happy_var_1))
	 =  HappyAbsSyn9
		 (Name happy_var_1
	)
happyReduction_20 _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_1  9 happyReduction_21
happyReduction_21 (HappyTerminal (TokenType happy_var_1))
	 =  HappyAbsSyn9
		 (Type happy_var_1
	)
happyReduction_21 _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_1  9 happyReduction_22
happyReduction_22 _
	 =  HappyAbsSyn9
		 (Any
	)

happyReduce_23 = happySpecReduce_3  9 happyReduction_23
happyReduction_23 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (Or happy_var_1 happy_var_3
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_3  9 happyReduction_24
happyReduction_24 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (Sep happy_var_1 happy_var_3
	)
happyReduction_24 _ _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_3  9 happyReduction_25
happyReduction_25 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (Function happy_var_1 happy_var_3
	)
happyReduction_25 _ _ _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_3  9 happyReduction_26
happyReduction_26 _
	(HappyAbsSyn9  happy_var_2)
	_
	 =  HappyAbsSyn9
		 (SBrack happy_var_2
	)
happyReduction_26 _ _ _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_3  9 happyReduction_27
happyReduction_27 _
	(HappyAbsSyn9  happy_var_2)
	_
	 =  HappyAbsSyn9
		 (Brack happy_var_2
	)
happyReduction_27 _ _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_2  9 happyReduction_28
happyReduction_28 (HappyAbsSyn9  happy_var_2)
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (App happy_var_1 happy_var_2
	)
happyReduction_28 _ _  = notHappyAtAll 

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
    | U2CDecl TypeExp FDecls FDecls
    | QCDecl TypeExp TypeExp FDecls
    | Q2CDecl TypeExp TypeExp FDecls FDecls
    | Q3CDecl TypeExp FDecls TypeExp FDecls FDecls
    deriving Show

data Decl
    = FDecls FDecls
    | CDecl CDecl
    | DDecl TypeExp TypeExp
    | TDecl TypeExp TypeExp
    | Directive TypeExp
    deriving Show

data FDecl
    = UFDecl String TypeExp
    | TUFDecl String TypeExp
    | QFDecl String TypeExp TypeExp
    | TQFDecl String TypeExp TypeExp
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
    | TEDir TypeExp TypeExp
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
lexer ('{':'-':'#':cs) = ignoreDirective cs
lexer ('#':cs) = lexer cs

isComma c = c == ','
isBracket c = c == '(' || c == ')' || c == '[' || c == ']'
fand = liftM2 (&&)
isValName = fand (fand (not . isSpace) (not . isComma)) (not . isBracket)

ignoreDirective cs =
    let (pre, post) = split "#-}" cs in
    lexer post

split splitter tosplit =
    if isPrefixOf splitter tosplit then
        ("", drop (length splitter) tosplit)
    else
       let c:cs = tosplit in
       let (pre, post) = split splitter cs in
       (c:pre, post)

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
      (c:cs,rest)   ->   if isUpper c then lookaheadAndLex TokenType (c:cs) rest else lookaheadAndLex TokenName (c:cs) rest

lexBrackets ('(':cs) =
    let (cts, next:rest) = Prelude.span isValName cs in
    if next == ')' then lookaheadAndLex TokenName cts rest else TokenOB : (lexer cs)
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
