
/*------------------------------------------------------------------------
    File        : SqidsInterface
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : hutorovski
    Created     : Tue Oct 22 09:23:22 EEST 2024
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.

INTERFACE Sqids.SqidsInterface:  
    METHOD PUBLIC INTEGER EXTENT Decode( str AS CHARACTER ).
    METHOD PUBLIC CHARACTER Encode( numbers AS INTEGER EXTENT ).
END INTERFACE.