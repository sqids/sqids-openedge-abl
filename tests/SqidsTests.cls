 
/*------------------------------------------------------------------------
   File        : SqidsTests
   Purpose     : 
   Syntax      : 
   Description : 
   Author(s)   : hutorovski
   Created     : Thu Oct 24 14:20:08 EEST 2024
   Notes       : 
 ----------------------------------------------------------------------*/

USING Progress.Lang.*.

BLOCK-LEVEL ON ERROR UNDO, THROW.
@TestSuite (classes="SqidsAlphabetTest.cls,SqidsBlocklistTest.cls,SqidsEncodingTest.cls,SqidsMinLengthTest.cls").
CLASS SqidsTests:
      
END CLASS.