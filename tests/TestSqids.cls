 
 /*------------------------------------------------------------------------
    File        : TestSqids
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : hutorovski
    Created     : Thu Mar 06 16:48:30 EET 2025
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING Sqids.Sqids.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS TestSqids INHERITS Sqids: 

    CONSTRUCTOR PUBLIC TestSqids ( cAlphabet AS CHARACTER, iMinLength AS INTEGER, cBlockList AS CHARACTER EXTENT):
        SUPER(cAlphabet,iMinLength,cBlockList).
    END CONSTRUCTOR.

    METHOD PUBLIC LOGICAL TestIsBlockedId( str AS CHARACTER  ):
        
        RETURN SUPER:IsBlockedId(str).

    END METHOD.

END CLASS.