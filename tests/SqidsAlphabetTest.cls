 
/*------------------------------------------------------------------------
   File        : SqidsAlphabetTest
   Purpose     : 
   Syntax      : 
   Description : 
   Author(s)   : hutorovski
   Created     : Tue Oct 22 09:58:51 EEST 2024
   Notes       : 
 ----------------------------------------------------------------------*/


BLOCK-LEVEL ON ERROR UNDO, THROW.

USING OpenEdge.Core.Assert FROM PROPATH.
USING OpenEdge.Core.Assertion.AssertArray FROM PROPATH.
USING Sqids.Sqids FROM PROPATH.

CLASS SqidsAlphabetTest:
    
    @Test.
    METHOD PUBLIC VOID testSimple():
        DEFINE VARIABLE sqids   AS Sqids     NO-UNDO.
        DEFINE VARIABLE numbers AS INTEGER   EXTENT 3 NO-UNDO.
        DEFINE VARIABLE id      AS CHARACTER NO-UNDO.
       
        sqids = NEW Sqids('0123456789abcdef'). 
        
        ASSIGN 
            numbers[1] = 1
            numbers[2] = 2
            numbers[3] = 3
            
            id         = '489158'.
            
        Assert:Equals(id,sqids:Encode(numbers)).
        AssertArray:Equals(numbers, sqids:Decode(id)).
            
        RETURN.       
       
    END METHOD.

    @Test.
    METHOD PUBLIC VOID testShortAlphabet(  ):  
        DEFINE VARIABLE sqids   AS Sqids   NO-UNDO.
        DEFINE VARIABLE numbers AS INTEGER EXTENT 3 NO-UNDO.

        sqids = NEW Sqids('abc'). 
        
        ASSIGN 
            numbers[1] = 1
            numbers[2] = 2
            numbers[3] = 3.
            
        AssertArray:Equals(numbers,sqids:decode(sqids:encode(numbers))).
        
        RETURN.
 
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID testLongAlphabet(  ):  
        DEFINE VARIABLE sqids   AS Sqids   NO-UNDO.
        DEFINE VARIABLE numbers AS INTEGER EXTENT 3 NO-UNDO.
        
        sqids = NEW Sqids('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_+|~{~}[];:\~'"/?.>,<`~~'). 
        
        ASSIGN 
            numbers[1] = 1
            numbers[2] = 2
            numbers[3] = 3.
            
        AssertArray:Equals(numbers,sqids:decode(sqids:encode(numbers))).
        
        RETURN.
 
    END METHOD.

    @Test (expected="Sqids.Exceptions.InvalidArgumentException").
    METHOD PUBLIC VOID testRepeatingAlphabetCharacters(  ):  
        DEFINE VARIABLE sqids AS Sqids NO-UNDO.

        sqids = NEW Sqids('aabcdefg').

        RETURN.
 
    END METHOD.

    @Test (expected="Sqids.Exceptions.InvalidArgumentException").
    METHOD PUBLIC VOID testTooShortAlphabet(  ):  
        DEFINE VARIABLE sqids AS Sqids NO-UNDO.

        sqids = NEW Sqids('ab').

        RETURN.
 
    END METHOD.
      
END CLASS.