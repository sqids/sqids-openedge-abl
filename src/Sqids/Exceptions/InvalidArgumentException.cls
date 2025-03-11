 
 /*------------------------------------------------------------------------
    File        : InvalidArgumentException
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : hutorovski
    Created     : Tue Oct 22 11:08:32 EEST 2024
    Notes       : 
  ----------------------------------------------------------------------*/


BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Sqids.Exceptions.SqidsException FROM PROPATH.

CLASS Sqids.Exceptions.InvalidArgumentException INHERITS SqidsException: 

    CONSTRUCTOR PUBLIC InvalidArgumentException ( INPUT errorMessage AS CHARACTER):
        SUPER (INPUT errorMessage).
        
    END CONSTRUCTOR.

END CLASS.