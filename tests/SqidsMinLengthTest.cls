 
/*------------------------------------------------------------------------
   File        : SqidsMinLengthTest
   Purpose     : 
   Syntax      : 
   Description : 
   Author(s)   : hutorovski
   Created     : Wed Oct 23 10:35:42 EEST 2024
   Notes       : 
 ----------------------------------------------------------------------*/


BLOCK-LEVEL ON ERROR UNDO, THROW.

USING OpenEdge.Core.Assert FROM PROPATH.
USING OpenEdge.Core.Assertion.AssertArray FROM PROPATH.
USING Sqids.Sqids FROM PROPATH.

CLASS SqidsMinLengthTest:
    
    DEFINE PRIVATE TEMP-TABLE ttIds NO-UNDO 
        FIELD ll AS INTEGER 
        FIELD id AS CHARACTER. 
        
    METHOD PROTECTED VOID setIds( INPUT iIdx AS INTEGER, INPUT cId AS CHARACTER  ):
        
        FIND ttIds WHERE ttIds.ll = iIdx NO-ERROR.
        
        IF NOT AVAILABLE ttIds THEN 
        DO:
            CREATE ttIds.
            ttIds.ll = iIdx.
        END.
        
        ttIds.id = cId.
        
        RETURN.

    END METHOD.
    
    METHOD PROTECTED INTEGER EXTENT getArray(INPUT numberDimentions AS INTEGER EXTENT, INPUT id AS INTEGER ):
        DEFINE VARIABLE iArr AS INTEGER EXTENT NO-UNDO.
       
        EXTENT (iArr) = numberDimentions[id].

        CASE id:
            WHEN 1 THEN
                DO: 
                    iArr[1] = 0.
                END.
            WHEN 2 THEN 
                DO:
                    iArr[1] = 0.
                    iArr[2] = 0.
                    iArr[3] = 0.
                    iArr[4] = 0.
                    iArr[5] = 0.
                END.
            WHEN 3 THEN 
                DO: 
                    iArr[1]  = 1.
                    iArr[2]  = 2.
                    iArr[3]  = 3.               
                    iArr[4]  = 4.
                    iArr[5]  = 5.
                    iArr[6]  = 6.
                    iArr[7]  = 7.
                    iArr[8]  = 8.
                    iArr[9]  = 9.
                    iArr[10] = 10.
                END.
            WHEN 4 THEN 
                DO:
                    iArr[1] = 100.
                    iArr[2] = 200.
                    iArr[3] = 300.
                END.
            WHEN 5 THEN 
                DO: 
                    iArr[1] = 1000.
                    iArr[2] = 2000.
                    iArr[3] = 3000.
                END.
            WHEN 6 THEN 
                DO:
                    iArr[1] = 1000000.
                END.
            WHEN 7 THEN 
                DO:
                    iArr[1] = 2147483647.
                END.
        END CASE.
        
        RETURN iArr.
    END METHOD.
      
    @Test.
    METHOD PUBLIC VOID testSimple(  ):  
        DEFINE VARIABLE oSqids  AS Sqids     NO-UNDO.
        DEFINE VARIABLE numbers AS INTEGER   EXTENT 3 NO-UNDO.
        DEFINE VARIABLE id      AS CHARACTER NO-UNDO.
                
        oSqids = NEW Sqids('',LENGTH(Sqids:DEFAULT_ALPHABET)).
        
        ASSIGN 
            numbers[1] = 1
            numbers[2] = 2
            numbers[3] = 3
            
            id         = '86Rf07xd4zBmiJXQG6otHEbew02c3PWsUOLZxADhCpKj7aVFv9I8RquYrNlSTM'.
        
        AssertCS:Equals(id, oSqids:Encode(numbers)).
        AssertArray:Equals(numbers, oSqids:Decode(id)).
        
        RETURN.
 
    END METHOD.

    @Test.
    METHOD PUBLIC VOID testIncremental(  ):  
        DEFINE VARIABLE oSqids         AS Sqids   NO-UNDO.
        DEFINE VARIABLE alphabetLength AS INTEGER NO-UNDO.
        DEFINE VARIABLE numbers        AS INTEGER EXTENT 3 NO-UNDO.
        
        EMPTY TEMP-TABLE ttIds.
        
        
        ASSIGN 
            alphabetLength = LENGTH (Sqids:DEFAULT_ALPHABET)
            
            numbers[1]     = 1
            numbers[2]     = 2
            numbers[3]     = 3.
            
        
        setIds(6, '86Rf07').
        setIds(7, '86Rf07x').
        setIds(8, '86Rf07xd').
        setIds(9, '86Rf07xd4').
        setIds(10, '86Rf07xd4z').
        setIds(11, '86Rf07xd4zB').
        setIds(12, '86Rf07xd4zBm').
        setIds(13, '86Rf07xd4zBmi').
        
        setIds(alphabetLength + 0, '86Rf07xd4zBmiJXQG6otHEbew02c3PWsUOLZxADhCpKj7aVFv9I8RquYrNlSTM').
        setIds(alphabetLength + 1, '86Rf07xd4zBmiJXQG6otHEbew02c3PWsUOLZxADhCpKj7aVFv9I8RquYrNlSTMy').
        setIds(alphabetLength + 2, '86Rf07xd4zBmiJXQG6otHEbew02c3PWsUOLZxADhCpKj7aVFv9I8RquYrNlSTMyf').
        setIds(alphabetLength + 3, '86Rf07xd4zBmiJXQG6otHEbew02c3PWsUOLZxADhCpKj7aVFv9I8RquYrNlSTMyf1').
        
        FOR EACH ttIds:
            oSqids = NEW Sqids('', ttIds.ll).
            
            AssertCS:Equals(ttIds.id, oSqids:Encode(numbers)).
            Assert:Equals(ttIds.ll, LENGTH(oSqids:Encode(numbers))).
            AssertArray:Equals(numbers, oSqids:Decode(ttIds.id)).
        END.    
        
        RETURN.
 
    END METHOD.

    @Test.
    METHOD PUBLIC VOID testIncrementalNumbers(  ):  
        DEFINE VARIABLE oSqids  AS Sqids     NO-UNDO.
        DEFINE VARIABLE numbers AS INTEGER   EXTENT 2 NO-UNDO.
        DEFINE VARIABLE ids     AS CHARACTER EXTENT 10 NO-UNDO.
        DEFINE VARIABLE itr     AS INTEGER   NO-UNDO.
        DEFINE VARIABLE id      AS CHARACTER NO-UNDO.
        
        oSqids = NEW Sqids('',LENGTH(Sqids:DEFAULT_ALPHABET)).
        
        ASSIGN 
            ids[1]  = 'SvIzsqYMyQwI3GWgJAe17URxX8V924Co0DaTZLtFjHriEn5bPhcSkfmvOslpBu'
            ids[2]  = 'n3qafPOLKdfHpuNw3M61r95svbeJGk7aAEgYn4WlSjXURmF8IDqZBy0CT2VxQc'
            ids[3]  = 'tryFJbWcFMiYPg8sASm51uIV93GXTnvRzyfLleh06CpodJD42B7OraKtkQNxUZ'
            ids[4]  = 'eg6ql0A3XmvPoCzMlB6DraNGcWSIy5VR8iYup2Qk4tjZFKe1hbwfgHdUTsnLqE'
            ids[5]  = 'rSCFlp0rB2inEljaRdxKt7FkIbODSf8wYgTsZM1HL9JzN35cyoqueUvVWCm4hX'
            ids[6]  = 'sR8xjC8WQkOwo74PnglH1YFdTI0eaf56RGVSitzbjuZ3shNUXBrqLxEJyAmKv2'
            ids[7]  = 'uY2MYFqCLpgx5XQcjdtZK286AwWV7IBGEfuS9yTmbJvkzoUPeYRHr4iDs3naN0'
            ids[8]  = '74dID7X28VLQhBlnGmjZrec5wTA1fqpWtK4YkaoEIM9SRNiC3gUJH0OFvsPDdy'
            ids[9]  = '30WXpesPhgKiEI5RHTY7xbB1GnytJvXOl2p0AcUjdF6waZDo9Qk8VLzMuWrqCS'
            ids[10] = 'moxr3HqLAK0GsTND6jowfZz3SUx7cQ8aC54Pl1RbIvFXmEJuBMYVeW9yrdOtin'.
        
        DO itr = 0 TO 9:
            ASSIGN 
                id         = ids[itr + 1]
            
                numbers[1] = 0
                numbers[2] = itr.
                
            AssertCS:Equals(id, oSqids:Encode(numbers)).
            AssertArray:Equals(numbers, oSqids:Decode(id)).
        END.
        
        RETURN.
 
    END METHOD.

    @Test.
    METHOD PUBLIC VOID testMinLengths(  ):
        DEFINE VARIABLE oSqids           AS Sqids     NO-UNDO.
        DEFINE VARIABLE minLengths       AS INTEGER   EXTENT 5 NO-UNDO.
        DEFINE VARIABLE itr              AS INTEGER   NO-UNDO.
        DEFINE VARIABLE i                AS INTEGER   NO-UNDO.
        DEFINE VARIABLE numbers          AS INTEGER   EXTENT NO-UNDO.
        DEFINE VARIABLE numberDimentions AS INTEGER   EXTENT 7 NO-UNDO INITIAL [1,5,10,3,3,1,1].
        DEFINE VARIABLE id               AS CHARACTER NO-UNDO.

        ASSIGN
            minLengths[1] = 0
            minLengths[2] = 1
            minLengths[3] = 5
            minLengths[4] = 10
            minLengths[5] = LENGTH(Sqids:DEFAULT_ALPHABET).


        DO itr = 1 TO EXTENT (minLengths):
            DO i = 1 TO 7:
                EXTENT (numbers) = ?.
                oSqids = NEW Sqids(Sqids:DEFAULT_ALPHABET, minLengths[itr]).
                ASSIGN
                    numbers = getArray(numberDimentions, i)
                    id      = oSqids:Encode(numbers).

                AssertArray:Equals(numbers, oSqids:Decode(id)).
            END.
        END.

        RETURN.

    END METHOD.

    @Test (expected="Sqids.Exceptions.InvalidArgumentException").
    METHOD PUBLIC VOID testOutOfRangeInvalidMinLengthLower(  ):  
        DEFINE VARIABLE oSqids AS Sqids NO-UNDO.
        
        oSqids = NEW Sqids('',-1).
        
        RETURN.
 
    END METHOD.

    @Test (expected="Sqids.Exceptions.InvalidArgumentException").
    METHOD PUBLIC VOID testOutOfRangeInvalidMinLengthUpper(  ):  
        DEFINE VARIABLE oSqids AS Sqids NO-UNDO.
        
        oSqids = NEW Sqids('',256).
        
        RETURN.
 
    END METHOD.

END CLASS.