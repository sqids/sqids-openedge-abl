 
 /*------------------------------------------------------------------------
    File        : AllTests
    Syntax      : 
    Author(s)   : hutorovski
    Created     : Tue Oct 29 11:22:25 EET 2024
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
BLOCK-LEVEL ON ERROR UNDO, THROW.

@TestSuite (classes="SqidsTests.cls,StringUtilTests.cls").
CLASS AllTests: 

END CLASS.