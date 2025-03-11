 
 /*------------------------------------------------------------------------
    File        : AssertCS
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : hutorovski
    Created     : Fri Mar 07 10:04:46 EET 2025
    Notes       : 
  ----------------------------------------------------------------------*/

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING OpenEdge.Core.AssertionFailedError.

CLASS AssertCS: 

    METHOD PUBLIC STATIC VOID Equals(INPUT a AS CHARACTER, INPUT b AS CHARACTER):
        DEFINE VARIABLE aCS AS CHARACTER CASE-SENSITIVE NO-UNDO.
        DEFINE VARIABLE bCS AS CHARACTER CASE-SENSITIVE NO-UNDO.
        
        ASSIGN
            aCS = a
            bCS = b.
        
        IF NOT aCS = bCS THEN
            RETURN ERROR NEW AssertionFailedError(SUBSTITUTE("Expected: &1 but was: &2", a, b), 0).

    END METHOD.

    METHOD PUBLIC STATIC VOID NotEqual(INPUT a AS CHARACTER, INPUT b AS CHARACTER):
        DEFINE VARIABLE aCS AS CHARACTER CASE-SENSITIVE NO-UNDO.
        DEFINE VARIABLE bCS AS CHARACTER CASE-SENSITIVE NO-UNDO.
        
        ASSIGN
            aCS = a
            bCS = b.
            
        IF aCS = bCS THEN 
            RETURN ERROR NEW AssertionFailedError(SUBSTITUTE('&1 and &2 are equal', a, b), 0).
    
    END METHOD.


END CLASS.