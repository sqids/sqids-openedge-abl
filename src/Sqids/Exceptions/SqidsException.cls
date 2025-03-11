 
 /*------------------------------------------------------------------------
    File        : SqidsException
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : hutorovski
    Created     : Tue Oct 22 10:48:00 EEST 2024
    Notes       : 
  ----------------------------------------------------------------------*/


BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Progress.Lang.AppError FROM PROPATH.

CLASS Sqids.Exceptions.SqidsException ABSTRACT SERIALIZABLE INHERITS AppError: 


    CONSTRUCTOR PUBLIC SqidsException ( INPUT errorMessage AS CHARACTER ):
        SUPER (INPUT errorMessage, 999).
        
    END CONSTRUCTOR.


END CLASS.