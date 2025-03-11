 
/*------------------------------------------------------------------------
   File        : StringUtil
   Purpose     : 
   Syntax      : 
   Description : 
   Author(s)   : hutorovski
   Created     : Mon Oct 28 10:18:32 EET 2024
   Notes       : 
 ----------------------------------------------------------------------*/


BLOCK-LEVEL ON ERROR UNDO, THROW.


CLASS Sqids.Util.StringUtil FINAL: 

    METHOD PUBLIC STATIC CHARACTER Reverse( str AS CHARACTER ):
        DEFINE VARIABLE mData   AS MEMPTR  NO-UNDO.
        DEFINE VARIABLE itr     AS INTEGER NO-UNDO.
        DEFINE VARIABLE iLength AS INTEGER NO-UNDO.
        DEFINE VARIABLE f_byte  AS INTEGER NO-UNDO.
        DEFINE VARIABLE l_pos   AS INTEGER NO-UNDO.
    
        ASSIGN 
            iLength             = LENGTH(str)
            SET-SIZE(mData)     = 0
            SET-SIZE(mData)     = iLength + 1
            PUT-STRING(mData,1) = str.
    
        DO itr = 1 TO INTEGER(TRUNCATE(iLength / 2,0)):
            ASSIGN
                l_pos                  = iLength - itr + 1
                f_byte                 = GET-BYTE(mData,itr)
                    
                PUT-BYTE (mData,itr)   = GET-BYTE(mData,l_pos)
                PUT-BYTE (mData,l_pos) = f_byte.
        END.
    
        RETURN GET-STRING(mData,1).
    END METHOD.

    METHOD PUBLIC STATIC CHARACTER EXTENT ByChars( str AS CHARACTER ):
        DEFINE VARIABLE res     AS CHARACTER NO-UNDO EXTENT CASE-SENSITIVE.
        DEFINE VARIABLE itr     AS INTEGER   NO-UNDO.
        DEFINE VARIABLE iLength AS INTEGER   NO-UNDO.
        DEFINE VARIABLE mData   AS MEMPTR    NO-UNDO.

        iLength = LENGTH(str).
    
        IF iLength > 28000 THEN
        DO:
            UNDO, THROW NEW Progress.Lang.AppError ("Sqids.Util.StringUtil:ByChars parameter may not be greater than 28000", 999).
        END.
        
        ASSIGN 
            SET-SIZE(mData)     = 0
            SET-SIZE(mData)     = iLength + 1
            PUT-STRING(mData,1) = str
            EXTENT(res)         = iLength.
        
        DO itr = 1 TO iLength:
            ASSIGN 
                res[itr] = CHR(GET-BYTE(mData,itr)).
        END.

        SET-SIZE (mData) = 0.

        RETURN res.
    END METHOD.

    METHOD PUBLIC STATIC CHARACTER Unique( str AS CHARACTER ):
        DEFINE VARIABLE res     AS CHARACTER NO-UNDO INITIAL "" CASE-SENSITIVE.
        DEFINE VARIABLE itr     AS INTEGER   NO-UNDO.
        DEFINE VARIABLE strChar AS CHARACTER NO-UNDO CASE-SENSITIVE.
        DEFINE VARIABLE baseStr AS CHARACTER NO-UNDO CASE-SENSITIVE.

        baseStr = str.

        DO itr = 1 TO LENGTH(baseStr):
            strChar = SUBSTRING(baseStr,itr,1).
            
            IF INDEX(baseStr,strChar) = itr THEN 
            DO:
                res = res + strChar.
            END. 
        END.

        RETURN res.

    END METHOD.

END CLASS.