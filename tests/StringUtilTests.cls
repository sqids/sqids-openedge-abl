 
/*------------------------------------------------------------------------
   File        : StringUtilTests
   Purpose     : 
   Syntax      : 
   Description : 
   Author(s)   : hutorovski
   Created     : Mon Oct 28 13:28:16 EET 2024
   Notes       : 
 ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OpenEdge.Core.Assert FROM PROPATH.
USING Sqids.Util.StringUtil FROM PROPATH.
USING OpenEdge.Core.Assertion.AssertArray FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS StringUtilTests:
      
    @Test.
    METHOD PUBLIC VOID TestReverse(  ):
        
        Assert:Equals('qwertyuiopasdfghjkl1234567890', StringUtil:Reverse('0987654321lkjhgfdsapoiuytrewq')).
        Assert:Equals('qwe', StringUtil:Reverse('ewq')). 
        Assert:Equals('q', StringUtil:Reverse('q')).  

        RETURN.
 
    END METHOD.

    @Test.
    METHOD PUBLIC VOID TestByChars(  ):
        DEFINE VARIABLE arr AS CHARACTER EXTENT 7 CASE-SENSITIVE NO-UNDO.
        DEFINE VARIABLE arr2 AS CHARACTER EXTENT 1 CASE-SENSITIVE NO-UNDO.
        
        DEFINE VARIABLE arr3 AS CHARACTER EXTENT CASE-SENSITIVE NO-UNDO.
        
        ASSIGN 
            arr[1] = 'q'
            arr[2] = 'w'
            arr[3] = 'e'
            arr[4] = 'r'
            arr[5] = 't'
            arr[6] = 'y'
            arr[7] = 'u'
            arr2[1] = 'q'.
          
        AssertArray:Equals(arr, StringUtil:ByChars('qwertyu')).
        AssertArray:Equals(arr2, StringUtil:ByChars('q')).
        arr3 = StringUtil:ByChars('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_+|~{~}[];:\~'"/?.>,<`~~').
        
        Assert:Equals('a', arr3[1]).
        Assert:Equals('t', arr3[20]).
        Assert:Equals('N', arr3[40]).
        Assert:Equals('2', arr3[55]).
        Assert:Equals('~~', arr3[93]).

        RETURN.
 
    END METHOD.

    @Test.
    METHOD PUBLIC VOID TestUnique(  ):  
        
        Assert:Equals('qwerty', StringUtil:Unique('qqwweerrttyy')).
        Assert:Equals('q', StringUtil:Unique('q')).
        Assert:Equals('q', StringUtil:Unique(FILL ('q',1000))).
        Assert:Equals('aA', StringUtil:Unique('aA')).
        
        RETURN.
 
    END METHOD.

END CLASS.