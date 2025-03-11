 
/*------------------------------------------------------------------------
   File        : SqidsBlocklistTest
   Purpose     : 
   Syntax      : 
   Description : 
   Author(s)   : hutorovski
   Created     : Tue Oct 22 11:29:35 EEST 2024
   Notes       : 
 ----------------------------------------------------------------------*/


BLOCK-LEVEL ON ERROR UNDO, THROW.

USING OpenEdge.Core.Assert FROM PROPATH.
USING OpenEdge.Core.Assertion.AssertArray FROM PROPATH.
USING Sqids.Sqids FROM PROPATH.

CLASS SqidsBlocklistTest:
    
    @Test.
    METHOD PUBLIC VOID testIsBlockedIdMethod(  ):
        DEFINE VARIABLE t_sqids    AS TestSqids NO-UNDO.
        DEFINE VARIABLE cBlackList AS CHARACTER EXTENT 5 NO-UNDO INITIAL 
        ['ab','goo','dick','dildo','d1ld0'].
        
        t_sqids = NEW TestSqids('',0,cBlackList). //'',0,cBlackList 
            
        Assert:isTrue(t_sqids:TestIsBlockedId('ab')).
        Assert:isFalse(t_sqids:TestIsBlockedId('abc')).

        Assert:isFalse(t_sqids:TestIsBlockedId('go')).
        Assert:isFalse(t_sqids:TestIsBlockedId('dic')).

        Assert:isTrue(t_sqids:TestIsBlockedId('421dildo123')).
        Assert:isFalse(t_sqids:TestIsBlockedId('421d11do123')).

        Assert:isTrue(t_sqids:TestIsBlockedId('421d11do')).
        Assert:isTrue(t_sqids:TestIsBlockedId('d11do123')).
        Assert:isTrue(t_sqids:TestIsBlockedId('di1do123')).
        Assert:isTrue(t_sqids:TestIsBlockedId('d1ldo123')).
        
        RETURN.
    END METHOD.
    
    @Test.
    METHOD PUBLIC VOID testIfNoCustomBlocklistParamUseDefaultBlocklist(  ):
        DEFINE VARIABLE sqids   AS Sqids   NO-UNDO.
        DEFINE VARIABLE numbers AS INTEGER EXTENT 1 NO-UNDO.

        sqids = NEW Sqids().

        ASSIGN
            numbers[1] = 4572721.

        AssertArray:Equals(numbers,sqids:decode('aho1e')).
        AssertCS:Equals('JExTR',sqids:Encode(numbers)).

        RETURN.

    END METHOD.

    @Test.
    METHOD PUBLIC VOID testIfEmptyBlocklistParamPassedDontUseAnyBlocklist(  ):
        DEFINE VARIABLE sqids      AS Sqids     NO-UNDO.
        DEFINE VARIABLE numbers    AS INTEGER   EXTENT 1 NO-UNDO.
        DEFINE VARIABLE cBlackList AS CHARACTER EXTENT NO-UNDO.

        sqids = NEW Sqids('',0,cBlackList).

        ASSIGN
            numbers[1] = 4572721.

        AssertArray:Equals(numbers,sqids:decode('aho1e')).
        AssertCS:Equals('aho1e',sqids:Encode(numbers)).

        RETURN.

    END METHOD.

    @Test.
    METHOD PUBLIC VOID testIfNonEmptyBlocklistParamPassedUseOnlyThat(  ):
        DEFINE VARIABLE sqids      AS Sqids     NO-UNDO.
        DEFINE VARIABLE numbers1   AS INTEGER   EXTENT 1 NO-UNDO.
        DEFINE VARIABLE numbers2   AS INTEGER   EXTENT 1 NO-UNDO.
        DEFINE VARIABLE cBlackList AS CHARACTER EXTENT 1 NO-UNDO INITIAL ['ArUO'].

        sqids = NEW Sqids('',0,cBlackList).

        ASSIGN
            numbers1[1] = 4572721
            numbers2[1] = 100000.

        AssertArray:Equals(numbers1,sqids:decode('aho1e')).
        AssertCS:Equals('aho1e',sqids:Encode(numbers1)).

        AssertArray:Equals(numbers2,sqids:decode('ArUO')).
        AssertCS:Equals('QyG4',sqids:Encode(numbers2)).
        AssertArray:Equals(numbers2,sqids:decode('QyG4')).

        RETURN.

    END METHOD.

    @Test.
    METHOD PUBLIC VOID testBlocklist(  ):
        DEFINE VARIABLE sqids      AS Sqids     NO-UNDO.
        DEFINE VARIABLE numbers    AS INTEGER   EXTENT 2 NO-UNDO.
        DEFINE VARIABLE cBlackList AS CHARACTER EXTENT 5 NO-UNDO INITIAL ['JSwXFaosAN','OCjV9JK64o','rBHf','79SM','7tE6'].

        sqids = NEW Sqids('',0,cBlackList).

        ASSIGN
            numbers[1] = 1000000
            numbers[2] = 2000000.

        AssertCS:Equals('1aYeB7bRUt',sqids:Encode(numbers)).
        AssertArray:Equals(numbers,sqids:decode('1aYeB7bRUt')).

        RETURN.

    END METHOD.

    @Test.
    METHOD PUBLIC VOID testDecodingBlocklistWordsShouldStillWork(  ):
        DEFINE VARIABLE sqids      AS Sqids     NO-UNDO.
        DEFINE VARIABLE numbers    AS INTEGER   EXTENT 3 NO-UNDO.
        DEFINE VARIABLE cBlackList AS CHARACTER EXTENT 5 NO-UNDO INITIAL ['86Rf07','se8ojk','ARsz1p','Q8AI49','5sQRZO'].

        sqids = NEW Sqids('',0,cBlackList).

        ASSIGN
            numbers[1] = 1
            numbers[2] = 2
            numbers[3] = 3.

        AssertArray:Equals(numbers,sqids:decode('86Rf07')).
        AssertArray:Equals(numbers,sqids:decode('se8ojk')).
        AssertArray:Equals(numbers,sqids:decode('ARsz1p')).
        AssertArray:Equals(numbers,sqids:decode('Q8AI49')).
        AssertArray:Equals(numbers,sqids:decode('5sQRZO')).

        RETURN.

    END METHOD.

    @Test.
    METHOD PUBLIC VOID testMatchAgainstAShortBlocklistWord(  ):
        DEFINE VARIABLE sqids      AS Sqids     NO-UNDO.
        DEFINE VARIABLE numbers    AS INTEGER   EXTENT 1 NO-UNDO.
        DEFINE VARIABLE cBlackList AS CHARACTER EXTENT 1 NO-UNDO INITIAL ['pnd'].

        sqids = NEW Sqids('',0,cBlackList).

        ASSIGN
            numbers[1] = 1000.

        AssertArray:Equals(numbers,sqids:decode(sqids:Encode(numbers))).

        RETURN.

    END METHOD.

    @Test.
    METHOD PUBLIC VOID testBlocklistFilteringInConstructor(  ):
        DEFINE VARIABLE sqids         AS Sqids     NO-UNDO.
        DEFINE VARIABLE numbers       AS INTEGER   EXTENT 3 NO-UNDO.
        DEFINE VARIABLE numbersResult AS INTEGER   EXTENT 3 NO-UNDO.
        DEFINE VARIABLE id            AS CHARACTER NO-UNDO.
        DEFINE VARIABLE cBlackList    AS CHARACTER EXTENT 1 NO-UNDO INITIAL ['sxnzkl'].

        sqids = NEW Sqids('ABCDEFGHIJKLMNOPQRSTUVWXYZ',0,cBlackList).

        ASSIGN
            numbers[1]    = 1
            numbers[2]    = 2
            numbers[3]    = 3

            id            = sqids:Encode(numbers)

            numbersResult = sqids:Decode(id).

        AssertCS:Equals(id, 'IBSHOZ').
        AssertArray:Equals(numbersResult, Numbers).

        RETURN.

    END METHOD.

    @Test (expected="Sqids.Exceptions.InvalidArgumentException").
    METHOD PUBLIC VOID testMaxEncodingAttempts(  ):
        DEFINE VARIABLE sqids      AS Sqids     NO-UNDO.
        DEFINE VARIABLE alphabet   AS CHARACTER NO-UNDO.
        DEFINE VARIABLE minLength  AS INTEGER   NO-UNDO.
        DEFINE VARIABLE numbers    AS INTEGER   EXTENT 1 NO-UNDO.
        DEFINE VARIABLE id         AS CHARACTER NO-UNDO.
        DEFINE VARIABLE cBlackList AS CHARACTER EXTENT 3 NO-UNDO.

        ASSIGN
            alphabet      = 'abc'
            minLength     = 3
            cBlackList[1] = 'cab'
            cBlackList[2] = 'abc'
            cBlackList[3] = 'bca'
            numbers[1]    = 0.

        sqids = NEW Sqids(alphabet,minLength,cBlackList).

        Assert:Equals(minLength, LENGTH(alphabet)).
        Assert:Equals(EXTENT(cBlackList), LENGTH(alphabet) ).

        id = sqids:Encode(numbers).

        RETURN.

    END METHOD.

END CLASS.