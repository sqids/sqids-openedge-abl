 
/*------------------------------------------------------------------------
   File        : SqidsEncodingTest
   Purpose     : 
   Syntax      : 
   Description : 
   Author(s)   : hutorovski
   Created     : Wed Oct 23 00:31:24 EEST 2024
   Notes       : 
 ----------------------------------------------------------------------*/


BLOCK-LEVEL ON ERROR UNDO, THROW.

USING OpenEdge.Core.Assert FROM PROPATH.
USING OpenEdge.Core.Assertion.AssertArray FROM PROPATH.
USING Sqids.Sqids FROM PROPATH.

CLASS SqidsEncodingTest:
      
    @Test.
    METHOD PUBLIC VOID testSimple(  ):  
        DEFINE VARIABLE sqids   AS Sqids     NO-UNDO.
        DEFINE VARIABLE numbers AS INTEGER   EXTENT 3 NO-UNDO.
        DEFINE VARIABLE id      AS CHARACTER NO-UNDO.
        
        sqids = NEW Sqids(). 
        
        ASSIGN 
            numbers[1] = 1
            numbers[2] = 2
            numbers[3] = 3
            
            id         = '86Rf07'.
        
        AssertCS:Equals(id, sqids:Encode(numbers)).
        AssertArray:Equals(numbers, sqids:Decode(id)).
        
        RETURN.
 
    END METHOD.

    @Test.
    METHOD PUBLIC VOID testDifferentInputs(  ):  
        DEFINE VARIABLE sqids   AS Sqids   NO-UNDO.
        DEFINE VARIABLE numbers AS INTEGER EXTENT 11 NO-UNDO.
        
        sqids = NEW Sqids(). 
        
        ASSIGN 
            numbers[1]  = 0
            numbers[2]  = 0
            numbers[3]  = 0
            numbers[4]  = 1
            numbers[5]  = 2
            numbers[6]  = 3
            numbers[7]  = 100
            numbers[8]  = 1000
            numbers[9]  = 100000
            numbers[10] = 1000000
            numbers[11] = 2147483647.
        
        AssertArray:Equals(numbers, sqids:Decode(sqids:Encode(numbers))).
        
        RETURN.
 
    END METHOD.

    @Test.
    METHOD PUBLIC VOID testIncrementalNumbers(  ):  
        DEFINE VARIABLE sqids   AS Sqids     NO-UNDO.
        DEFINE VARIABLE numbers AS INTEGER   EXTENT 1 NO-UNDO.
        DEFINE VARIABLE id      AS CHARACTER NO-UNDO.
        DEFINE VARIABLE ids     AS CHARACTER NO-UNDO.
        DEFINE VARIABLE itr     AS INTEGER   NO-UNDO.
        
        sqids = NEW Sqids(). 
        
        ASSIGN 
            ids = 'bM,Uk,gb,Ef,Vq,uw,OI,AX,p6,nJ'.
        
        DO itr = 0 TO 9:
            ASSIGN 
                numbers[1] = itr
                id         = ENTRY (itr + 1, ids).
            
            AssertCS:Equals(id, sqids:Encode(numbers)).
            AssertArray:Equals(numbers, sqids:Decode(id)).
        
        END.
        
        RETURN.
 
    END METHOD.

    @Test.
    METHOD PUBLIC VOID testIncrementalNumbersSameIndex0(  ):  
        DEFINE VARIABLE sqids   AS Sqids     NO-UNDO.
        DEFINE VARIABLE numbers AS INTEGER   EXTENT 2 NO-UNDO.
        DEFINE VARIABLE id      AS CHARACTER NO-UNDO.
        DEFINE VARIABLE ids     AS CHARACTER NO-UNDO.
        DEFINE VARIABLE itr     AS INTEGER   NO-UNDO.
        
        sqids = NEW Sqids(). 
        
        ASSIGN 
            ids = 'SvIz,n3qa,tryF,eg6q,rSCF,sR8x,uY2M,74dI,30WX,moxr'.
        
        DO itr = 0 TO 9:
            ASSIGN 
                numbers[1] = 0
                numbers[2] = itr
                id         = ENTRY (itr + 1, ids).
            
            AssertCS:Equals(id, sqids:Encode(numbers)).
            AssertArray:Equals(numbers, sqids:Decode(id)).
        
        END.
        
        RETURN.
 
    END METHOD.

    @Test.
    METHOD PUBLIC VOID testIncrementalNumbersSameIndex1(  ):  
        DEFINE VARIABLE sqids   AS Sqids     NO-UNDO.
        DEFINE VARIABLE numbers AS INTEGER   EXTENT 2 NO-UNDO.
        DEFINE VARIABLE id      AS CHARACTER NO-UNDO.
        DEFINE VARIABLE ids     AS CHARACTER NO-UNDO.
        DEFINE VARIABLE itr     AS INTEGER   NO-UNDO.
        
        sqids = NEW Sqids(). 
        
        ASSIGN 
            ids = 'SvIz,nWqP,tSyw,eX68,rxCY,sV8a,uf2K,7Cdk,3aWP,m2xn'.
        
        DO itr = 0 TO 9:
            ASSIGN 
                numbers[1] = itr
                numbers[2] = 0
                id         = ENTRY (itr + 1, ids).
            
            AssertCS:Equals(id, sqids:Encode(numbers)).
            AssertArray:Equals(numbers, sqids:Decode(id)).
        
        END.
        
        RETURN.
 
    END METHOD.

    @Test.
    METHOD PUBLIC VOID testMultiInput(  ):  
        DEFINE VARIABLE sqids      AS Sqids   NO-UNDO.
        DEFINE VARIABLE numbers    AS INTEGER EXTENT 100 NO-UNDO.
        DEFINE VARIABLE numbersOut AS INTEGER EXTENT 100 NO-UNDO.
        DEFINE VARIABLE itr        AS INTEGER NO-UNDO.
        
        sqids = NEW Sqids(). 
        
        DO itr = 1 TO 100:
            numbers[itr] = itr - 1.
        END.
       
        numbersOut = sqids:Decode(sqids:Encode(numbers)).
        
        AssertArray:Equals(numbers, numbersOut).
        
        RETURN.
 
    END METHOD.

    @Test.
    METHOD PUBLIC VOID testEncodingNoNumbers(  ):  
        DEFINE VARIABLE sqids   AS Sqids   NO-UNDO.
        DEFINE VARIABLE numbers AS INTEGER EXTENT NO-UNDO.
        
        sqids = NEW Sqids(). 
        
        Assert:Equals('', sqids:Encode(numbers)).
        
        RETURN.
 
    END METHOD.

    @Test.
    METHOD PUBLIC VOID testDecodingEmptyString(  ):  
        DEFINE VARIABLE sqids AS Sqids NO-UNDO.
        
        sqids = NEW Sqids(). 
                
        AssertArray:IsIndeterminateArray(sqids:Decode('')).
        
        RETURN.
 
    END METHOD.

    @Test.
    METHOD PUBLIC VOID testDecodingAnIdWithAnInvalidCharacter(  ):  
        DEFINE VARIABLE sqids AS Sqids NO-UNDO.
        
        sqids = NEW Sqids(). 
                
        AssertArray:IsIndeterminateArray(sqids:Decode('*')).
        
        RETURN.
 
    END METHOD.

    @Test (expected="Sqids.Exceptions.InvalidArgumentException").
    METHOD PUBLIC VOID testEncodeOutOfRangeNumbersLower(  ):  
        DEFINE VARIABLE sqids   AS Sqids     NO-UNDO.
        DEFINE VARIABLE numbers AS INTEGER   EXTENT 1 NO-UNDO.
        DEFINE VARIABLE id      AS CHARACTER NO-UNDO.
        
        sqids = NEW Sqids(). 
        
        ASSIGN 
            numbers[1] = -1.
        
        id = sqids:Encode(numbers).
        
        RETURN.
 
    END METHOD.

END CLASS.