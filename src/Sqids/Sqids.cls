 
/*------------------------------------------------------------------------
   File        : Sqids
   Purpose     : 
   Syntax      : 
   Description : 
   Author(s)   : hutorovski
   Created     : Mon Oct 02 12:24:34 EEST 2023
   Notes       : 
 ----------------------------------------------------------------------*/


BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Sqids.Exceptions.InvalidArgumentException FROM PROPATH.
USING Sqids.SqidsInterface FROM PROPATH.
USING Sqids.Util.StringUtil FROM PROPATH.

CLASS Sqids.Sqids IMPLEMENTS SqidsInterface: 

&SCOPED-DEFINE MIN_LENGTH_LIMIT 255
&SCOPED-DEFINE DEFAULT_MIN_LENGTH 0

    DEFINE STATIC PUBLIC PROPERTY DEFAULT_BLOCKLIST AS CHARACTER EXTENT 560 INITIAL [
        "0rgasm","1d10t","1d1ot","1di0t","1diot","1eccacu10","1eccacu1o","1eccacul0","1eccaculo","1mbec11e",
        "1mbec1le","1mbeci1e","1mbecile","a11upat0","a11upato","a1lupat0","a1lupato","aand","ah01e","ah0le",
        "aho1e","ahole","al1upat0","al1upato","allupat0","allupato","ana1","ana1e","anal","anale","anus",
        "arrapat0","arrapato","arsch","arse","ass","b00b","b00be","b01ata","b0ceta","b0iata","b0ob","b0obe",
        "b0sta","b1tch","b1te","b1tte","ba1atkar","balatkar","bastard0","bastardo","batt0na","battona",
        "bitch","bite","bitte","bo0b","bo0be","bo1ata","boceta","boiata","boob","boobe","bosta","bran1age",
        "bran1er","bran1ette","bran1eur","bran1euse","branlage","branler","branlette","branleur","branleuse",
        "c0ck","c0g110ne","c0g11one","c0g1i0ne","c0g1ione","c0gl10ne","c0gl1one","c0gli0ne","c0glione","c0na",
        "c0nnard","c0nnasse","c0nne","c0u111es","c0u11les","c0u1l1es","c0u1lles","c0ui11es","c0ui1les",
        "c0uil1es","c0uilles","c11t","c11t0","c11to","c1it","c1it0","c1ito","cabr0n","cabra0","cabrao",
        "cabron","caca","cacca","cacete","cagante","cagar","cagare","cagna","cara1h0","cara1ho","caracu10",
        "caracu1o","caracul0","caraculo","caralh0","caralho","cazz0","cazz1mma","cazzata","cazzimma","cazzo",
        "ch00t1a","ch00t1ya","ch00tia","ch00tiya","ch0d","ch0ot1a","ch0ot1ya","ch0otia","ch0otiya","ch1asse",
        "ch1avata","ch1er","ch1ng0","ch1ngadaz0s","ch1ngadazos","ch1ngader1ta","ch1ngaderita","ch1ngar",
        "ch1ngo","ch1ngues","ch1nk","chatte","chiasse","chiavata","chier","ching0","chingadaz0s","chingadazos",
        "chingader1ta","chingaderita","chingar","chingo","chingues","chink","cho0t1a","cho0t1ya","cho0tia",
        "cho0tiya","chod","choot1a","choot1ya","chootia","chootiya","cl1t","cl1t0","cl1to","clit","clit0",
        "clito","cock","cog110ne","cog11one","cog1i0ne","cog1ione","cogl10ne","cogl1one","cogli0ne","coglione",
        "cona","connard","connasse","conne","cou111es","cou11les","cou1l1es","cou1lles","coui11es","coui1les",
        "couil1es","couilles","cracker","crap","cu10","cu1att0ne","cu1attone","cu1er0","cu1ero","cu1o","cul0",
        "culatt0ne","culattone","culer0","culero","culo","cum","cunt","d11d0","d11do","d1ck","d1ld0","d1ldo",
        "damn","de1ch","deich","depp","di1d0","di1do","dick","dild0","dildo","dyke","encu1e","encule","enema",
        "enf01re","enf0ire","enfo1re","enfoire","estup1d0","estup1do","estupid0","estupido","etr0n","etron",
        "f0da","f0der","f0ttere","f0tters1","f0ttersi","f0tze","f0utre","f1ca","f1cker","f1ga","fag","fica",
        "ficker","figa","foda","foder","fottere","fotters1","fottersi","fotze","foutre","fr0c10","fr0c1o",
        "fr0ci0","fr0cio","fr0sc10","fr0sc1o","fr0sci0","fr0scio","froc10","froc1o","froci0","frocio",
        "frosc10","frosc1o","frosci0","froscio","fuck","g00","g0o","g0u1ne","g0uine","gandu","go0","goo",
        "gou1ne","gouine","gr0gnasse","grognasse","haram1","harami","haramzade","hund1n","hundin","id10t",
        "id1ot","idi0t","idiot","imbec11e","imbec1le","imbeci1e","imbecile","j1zz","jerk","jizz","k1ke",
        "kam1ne","kamine","kike","leccacu10","leccacu1o","leccacul0","leccaculo","m1erda","m1gn0tta",
        "m1gnotta","m1nch1a","m1nchia","m1st","mam0n","mamahuev0","mamahuevo","mamon","masturbat10n",
        "masturbat1on","masturbate","masturbati0n","masturbation","merd0s0","merd0so","merda","merde","merdos0",
        "merdoso","mierda","mign0tta","mignotta","minch1a","minchia","mist","musch1","muschi","n1gger","neger",
        "negr0","negre","negro","nerch1a","nerchia","nigger","orgasm","p00p","p011a","p01la","p0l1a","p0lla",
        "p0mp1n0","p0mp1no","p0mpin0","p0mpino","p0op","p0rca","p0rn","p0rra","p0uff1asse","p0uffiasse","p1p1",
        "p1pi","p1r1a","p1rla","p1sc10","p1sc1o","p1sci0","p1scio","p1sser","pa11e","pa1le","pal1e","palle",
        "pane1e1r0","pane1e1ro","pane1eir0","pane1eiro","panele1r0","panele1ro","paneleir0","paneleiro","patakha",
        "pec0r1na","pec0rina","pecor1na","pecorina","pen1s","pendej0","pendejo","penis","pip1","pipi","pir1a",
        "pirla","pisc10","pisc1o","pisci0","piscio","pisser","po0p","po11a","po1la","pol1a","polla","pomp1n0",
        "pomp1no","pompin0","pompino","poop","porca","porn","porra","pouff1asse","pouffiasse","pr1ck","prick",
        "pussy","put1za","puta","puta1n","putain","pute","putiza","puttana","queca","r0mp1ba11e","r0mp1ba1le",
        "r0mp1bal1e","r0mp1balle","r0mpiba11e","r0mpiba1le","r0mpibal1e","r0mpiballe","rand1","randi","rape",
        "recch10ne","recch1one","recchi0ne","recchione","retard","romp1ba11e","romp1ba1le","romp1bal1e","romp1balle",
        "rompiba11e","rompiba1le","rompibal1e","rompiballe","ruff1an0","ruff1ano","ruffian0","ruffiano","s1ut",
        "sa10pe","sa1aud","sa1ope","sacanagem","sal0pe","salaud","salope","saugnapf","sb0rr0ne","sb0rra",
        "sb0rrone","sbattere","sbatters1","sbattersi","sborr0ne","sborra","sborrone","sc0pare","sc0pata",
        "sch1ampe","sche1se","sche1sse","scheise","scheisse","schlampe","schwachs1nn1g","schwachs1nnig",
        "schwachsinn1g","schwachsinnig","schwanz","scopare","scopata","sexy","sh1t","shit","slut","sp0mp1nare",
        "sp0mpinare","spomp1nare","spompinare","str0nz0","str0nza","str0nzo","stronz0","stronza","stronzo",
        "stup1d","stupid","succh1am1","succh1ami","succhiam1","succhiami","sucker","t0pa","tapette","test1c1e",
        "test1cle","testic1e","testicle","tette","topa","tr01a","tr0ia","tr0mbare","tr1ng1er","tr1ngler",
        "tring1er","tringler","tro1a","troia","trombare","turd","twat","vaffancu10","vaffancu1o","vaffancul0",
        "vaffanculo","vag1na","vagina","verdammt","verga","w1chsen","wank","wichsen","x0ch0ta","x0chota",
        "xana","xoch0ta","xochota","z0cc01a","z0cc0la","z0cco1a","z0ccola","z1z1","z1zi","ziz1","zizi","zocc01a",
        "zocc0la","zocco1a","zoccola"] NO-UNDO 
        GET.
        
    DEFINE STATIC PUBLIC PROPERTY LEET_IDX AS CHARACTER EXTENT 3 INITIAL ['i', 'o', 'l'] NO-UNDO 
        GET.

    DEFINE STATIC PUBLIC PROPERTY LEET AS CHARACTER EXTENT 3 INITIAL ['1', '0', '1'] NO-UNDO 
        GET.

    DEFINE PROTECTED PROPERTY alphabet AS CHARACTER NO-UNDO 
        GET.
        SET. 

    DEFINE PROTECTED TEMP-TABLE ttBlockList NO-UNDO 
        FIELD txt AS CHARACTER
        INDEX txt txt. 
        
    DEFINE PROTECTED PROPERTY minLength AS INTEGER NO-UNDO 
        GET.
        SET. 

    DEFINE PUBLIC STATIC PROPERTY DEFAULT_ALPHABET AS CHARACTER NO-UNDO 
        INITIAL 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'
        GET.

    DEFINE PUBLIC STATIC PROPERTY MAX_INT_VALUE AS INTEGER INITIAL 2147483647 NO-UNDO 
        GET.
          
    CONSTRUCTOR PUBLIC Sqids ( cAlphabet AS CHARACTER, iMinLength AS INTEGER, cBlockList AS CHARACTER EXTENT):
        DEFINE VARIABLE itr             AS INTEGER   NO-UNDO.
        DEFINE VARIABLE cAlphabetChars  AS CHARACTER NO-UNDO.
        DEFINE VARIABLE cWordLowercased AS CHARACTER NO-UNDO.
        
        EMPTY TEMP-TABLE ttBlockList NO-ERROR.
        
        IF cAlphabet = "" THEN
        DO:
            cAlphabet = DEFAULT_ALPHABET.
        END.
        
        IF LENGTH(cAlphabet,'CHARACTER') <> LENGTH(cAlphabet,'RAW') THEN
            UNDO, THROW NEW InvalidArgumentException('Alphabet cannot contain multibyte characters').
        
        IF LENGTH(cAlphabet) < 3 THEN
            UNDO, THROW NEW InvalidArgumentException('Alphabet length must be at least 3').
        
        IF LENGTH(cAlphabet) <> LENGTH(StringUtil:Unique(cAlphabet)) THEN
            UNDO, THROW NEW InvalidArgumentException('Alphabet must contain unique characters').
        
        IF iMinLength < 0 OR iMinLength > {&MIN_LENGTH_LIMIT} THEN
            UNDO, THROW NEW InvalidArgumentException(SUBSTITUTE('Minimum length has to be between 0 and &1',{&MIN_LENGTH_LIMIT})).
        
        cAlphabetChars = LC(cAlphabet).
        
        IF EXTENT(cBlockList) <> ? THEN
        DO:
            DO itr = 1 TO EXTENT(cBlockList):
                cWordLowercased = LC(cBlockList[itr]).

                CREATE ttBlockList.
                ASSIGN
                    ttBlockList.txt = cWordLowercased. 
            END.
        END.

        ASSIGN
            THIS-OBJECT:alphabet  = THIS-OBJECT:Shuffle(cAlphabet)
            THIS-OBJECT:minLength = iMinLength. 
               
    END CONSTRUCTOR.

    CONSTRUCTOR PUBLIC Sqids ( cAlphabet AS CHARACTER, iMinLength AS INTEGER):
        THIS-OBJECT(cAlphabet, iMinLength, DEFAULT_BLOCKLIST).        
    END CONSTRUCTOR.
    
    CONSTRUCTOR PUBLIC Sqids ( cAlphabet AS CHARACTER):
        THIS-OBJECT(cAlphabet, {&DEFAULT_MIN_LENGTH}, DEFAULT_BLOCKLIST).
    END CONSTRUCTOR.
    
    CONSTRUCTOR PUBLIC Sqids ():
        THIS-OBJECT(DEFAULT_ALPHABET, {&DEFAULT_MIN_LENGTH}, DEFAULT_BLOCKLIST).
        
    END CONSTRUCTOR.

    METHOD PRIVATE INTEGER EXTENT ArrayToIntArray( oArray AS OpenEdge.Core.Collections.Array ):  
        DEFINE VARIABLE res  AS INTEGER NO-UNDO EXTENT.
        DEFINE VARIABLE itr  AS INTEGER NO-UNDO INITIAL 0.
        DEFINE VARIABLE iMax AS INTEGER NO-UNDO INITIAL 0.
        
        ASSIGN
            iMax        = oArray:Size
            EXTENT(res) = iMax.
                
        DO itr = 1 TO iMax:
            res[itr] = INTEGER(CAST(oArray:GetValue(itr),OpenEdge.Core.Integer):Value).
        END.
        
        RETURN res.

    END METHOD.

    METHOD PUBLIC INTEGER DecodeOne( str AS CHARACTER ):
        DEFINE VARIABLE res AS INTEGER NO-UNDO EXTENT.
        
        res = THIS-OBJECT:Decode(str).
        
        RETURN res[1].
    END METHOD.
    
    METHOD PUBLIC INTEGER EXTENT Decode( str AS CHARACTER ):
        DEFINE VARIABLE res           AS INTEGER                         NO-UNDO EXTENT.
        DEFINE VARIABLE alphabetChars AS CHARACTER                       NO-UNDO EXTENT.
        DEFINE VARIABLE itr           AS INTEGER                         NO-UNDO INITIAL 0.
        DEFINE VARIABLE i             AS INTEGER                         NO-UNDO INITIAL 0.
        
        DEFINE VARIABLE id            AS CHARACTER                       NO-UNDO CASE-SENSITIVE.
        DEFINE VARIABLE prefix        AS CHARACTER                       NO-UNDO CASE-SENSITIVE.
        DEFINE VARIABLE offset        AS INTEGER                         NO-UNDO.
        DEFINE VARIABLE alphabet      AS CHARACTER                       NO-UNDO.
        DEFINE VARIABLE separator     AS CHARACTER                       NO-UNDO CASE-SENSITIVE.
        DEFINE VARIABLE oIdArray      AS OpenEdge.Core.Collections.Array NO-UNDO.
        
        ASSIGN
            oIdArray            = NEW OpenEdge.Core.Collections.Array()
            oIdArray:AutoExpand = TRUE.

        IF str = "" THEN
            RETURN res.
        
        alphabetChars = StringUtil:ByChars(THIS-OBJECT:alphabet).
        
        IF NOT IsFullIntersect(str, THIS-OBJECT:alphabet) THEN
            RETURN res.
        
        ASSIGN
            id       = str
            prefix   = SUBSTRING(id,1,1)
            offset   = INDEX(THIS-OBJECT:alphabet,prefix)
            alphabet = SUBSTRING(THIS-OBJECT:alphabet,offset) + SUBSTRING (THIS-OBJECT:alphabet,1,offset - 1)      
            alphabet = StringUtil:Reverse(alphabet)
            id       = SUBSTRING(id,2).
        
        mm:        
        DO WHILE LENGTH(id) > 0:
            separator = SUBSTRING(alphabet,1,1).
            
            IF ENTRY(1,id, separator) = '' THEN
                LEAVE mm.

            oIdArray:Add(NEW OpenEdge.Core.Integer(THIS-OBJECT:toNumber(ENTRY(1,id, separator),SUBSTRING(alphabet, 2)))).
 
            IF NUM-ENTRIES (id, separator) > 1 THEN
            DO:
                alphabet = Shuffle(alphabet).
            END.
            
            IF INDEX(id,separator) = 0 THEN
                id = "".
            ELSE 
                id = SUBSTRING(id,INDEX(id,separator) + 1).           
        END.
        
        RETURN ArrayToIntArray(oIdArray).
    END METHOD.

    METHOD PROTECTED INTEGER Divide( a AS INTEGER, b AS INTEGER ):
       
        RETURN INTEGER(TRUNCATE(a / b, 0)).

    END METHOD.

    METHOD PUBLIC CHARACTER EncodeOne( number AS INTEGER):
        DEFINE VARIABLE numbers AS INTEGER NO-UNDO EXTENT.
        
        ASSIGN
            EXTENT(numbers) = 1
            numbers[1]      = number.
         
        RETURN THIS-OBJECT:Encode(numbers).
    END METHOD.
    
    METHOD PUBLIC CHARACTER Encode( numbers AS INTEGER EXTENT ):
        DEFINE VARIABLE res AS CHARACTER NO-UNDO.
        DEFINE VARIABLE itr AS INTEGER   NO-UNDO.

        IF EXTENT(numbers) = ? OR EXTENT(numbers) = 0 THEN
            RETURN "".
            
        DO itr = 1 TO EXTENT(numbers):
            IF numbers[itr] < 0 OR numbers[itr] > MAX_INT_VALUE THEN
                UNDO, THROW NEW InvalidArgumentException(SUBSTITUTE('Encoding supports numbers between 0 and &1', MAX_INT_VALUE)).
        END.
        
        RETURN EncodeNumbers(numbers, 0).
        
    END METHOD.

    METHOD PROTECTED CHARACTER EncodeNumbers(  numbers AS INTEGER EXTENT, increment AS INTEGER ):
        DEFINE VARIABLE res       AS CHARACTER NO-UNDO.
        DEFINE VARIABLE offset    AS INTEGER   NO-UNDO.
        DEFINE VARIABLE num       AS INTEGER   NO-UNDO.
        DEFINE VARIABLE itr       AS INTEGER   NO-UNDO.
        DEFINE VARIABLE cAlphabet AS CHARACTER NO-UNDO EXTENT.
        DEFINE VARIABLE alphabet  AS CHARACTER NO-UNDO.
        DEFINE VARIABLE prefix    AS CHARACTER NO-UNDO.
        DEFINE VARIABLE ret       AS CHARACTER NO-UNDO INITIAL "".

        IF increment > LENGTH(THIS-OBJECT:alphabet) THEN
            UNDO, THROW NEW InvalidArgumentException('Reached max attempts to re-generate the ID').
        
        ASSIGN
            offset    = EXTENT(numbers)
            cAlphabet = StringUtil:ByChars(THIS-OBJECT:alphabet).
        
        DO itr = 1 TO EXTENT(numbers):
            offset = offset + ASC(cAlphabet[(numbers[itr] MODULO LENGTH(THIS-OBJECT:alphabet)) + 1]) + itr - 1.
        END.
    
        ASSIGN
            offset   = offset MODULO LENGTH(THIS-OBJECT:alphabet)
            offset   = (offset + increment) MODULO LENGTH(THIS-OBJECT:alphabet)
            
            alphabet = SUBSTRING(THIS-OBJECT:alphabet,offset + 1) + SUBSTRING(THIS-OBJECT:alphabet, 1, offset)         

            prefix   = SUBSTRING(alphabet,1,1)
            alphabet = StringUtil:Reverse(alphabet)
        
            ret      = prefix.

        DO itr = 1 TO EXTENT(numbers):

            num = numbers[itr].
            ret = ret + ToId(num,SUBSTRING(alphabet,2)).

            IF itr < EXTENT(numbers) THEN
            DO:
                ret = ret + SUBSTRING(alphabet,1,1).
                alphabet = Shuffle(alphabet).
            END.
        END.

        IF THIS-OBJECT:minLength > LENGTH(ret) THEN
        DO:
            ret = ret + SUBSTRING(alphabet,1,1).
            DO WHILE THIS-OBJECT:minLength - LENGTH(ret) > 0:
                alphabet = Shuffle(alphabet).
                ret = ret + SUBSTRING(alphabet,1,MINIMUM (THIS-OBJECT:minLength - LENGTH(ret), LENGTH(alphabet))).
            END.
        END.
        
        IF IsBlockedId(ret) THEN
        DO:
            ret = EncodeNumbers(numbers, increment + 1).
        END.
               
        RETURN ret.

    END METHOD.

    METHOD PROTECTED CHARACTER NormalizeString(str AS CHARACTER ):
        DEFINE VARIABLE cNewStr AS CHARACTER NO-UNDO.
        DEFINE VARIABLE itr     AS INTEGER   NO-UNDO.
        
        ASSIGN 
            cNewStr = str.
        
        DO itr = 1 TO EXTENT(LEET_IDX):
            cNewStr = REPLACE(cNewStr, LEET_IDX[itr], LEET[itr]).
        END.
        
        RETURN cNewStr.
    END METHOD.

    METHOD PROTECTED LOGICAL IsBlockedId( str AS CHARACTER ):
        DEFINE VARIABLE cNormalizeStr AS CHARACTER NO-UNDO.
        DEFINE VARIABLE cNormalizeTxt AS CHARACTER NO-UNDO.
        DEFINE VARIABLE pos           AS INTEGER   NO-UNDO.
        
        ASSIGN
            str           = LC(str)
            cNormalizeStr = NormalizeString(str).                 
                
        FOR EACH ttBlockList:
            IF LENGTH(ttBlockList.txt) <= LENGTH(str) THEN 
            DO:
                IF LENGTH(ttBlockList.txt) <= 3 THEN
                DO:                    
                    IF str = ttBlockList.txt THEN
                        RETURN TRUE.
                END.
                ELSE 
                DO:
                    IF IsWithoutNumbersInWord(ttBlockList.txt) AND INDEX(str,ttBlockList.txt) > 0 THEN
                    DO:
                        RETURN TRUE.
                    END.
        
                    cNormalizeTxt = NormalizeString(ttBlockList.txt).

                    IF INDEX(cNormalizeStr, cNormalizeTxt) = 1 THEN
                    DO:
                        RETURN TRUE.
                    END.
        
                    pos = R-INDEX(cNormalizeStr, cNormalizeTxt). 
        
                    IF pos > 0 AND pos = LENGTH(cNormalizeStr) - (LENGTH(cNormalizeTxt) - 1) THEN
                    DO:
                        RETURN TRUE.
                    END.
                END.
            END.
        END.

        RETURN FALSE.

    END METHOD.

    METHOD PROTECTED LOGICAL IsWithoutNumbersInWord ( str AS CHARACTER ):
        DEFINE VARIABLE itr AS INTEGER NO-UNDO.
        
        DO itr = 0 TO 9:
            IF INDEX(str, STRING(itr,'9')) > 0 THEN
                RETURN FALSE.
        END.
        
        RETURN TRUE.
    END METHOD.

    METHOD PROTECTED LOGICAL IsFullIntersect( str1 AS CHARACTER, str2 AS CHARACTER ):
        DEFINE VARIABLE itr    AS INTEGER   NO-UNDO.
        DEFINE VARIABLE csStr1 AS CHARACTER NO-UNDO CASE-SENSITIVE.
        DEFINE VARIABLE csStr2 AS CHARACTER NO-UNDO CASE-SENSITIVE.

        ASSIGN
            csStr1 = str1
            csStr2 = str2.

        DO itr = 1 TO LENGTH(csStr1):
            IF INDEX(csStr2, SUBSTRING(csStr1,itr,1)) = 0 THEN
            DO:
                RETURN FALSE.
            END.
        END.

        RETURN TRUE.

    END METHOD.

    METHOD PROTECTED CHARACTER Shuffle( str AS CHARACTER ):
        DEFINE VARIABLE cChars AS CHARACTER NO-UNDO EXTENT.
        DEFINE VARIABLE i      AS INTEGER   NO-UNDO.
        DEFINE VARIABLE j      AS INTEGER   NO-UNDO.
        DEFINE VARIABLE r      AS INTEGER   NO-UNDO.
        DEFINE VARIABLE ci     AS CHARACTER NO-UNDO.
        DEFINE VARIABLE cr     AS CHARACTER NO-UNDO.

        ASSIGN
            cChars = StringUtil:ByChars(str)
            i      = 0
            j      = EXTENT(cChars) - 1.
        
        DO WHILE j > 0:
            
            ASSIGN
                r             = ((i * j + ASC(cChars[i + 1]) + ASC(cCHars[j + 1])) MODULO EXTENT(cChars))
            
                ci            = cChars[i + 1]
                cr            = cChars[r + 1]
            
                cChars[i + 1] = cr
                cChars[r + 1] = ci
            
                i             = i + 1
                j             = j - 1.
        END.

        RETURN STRING(OpenEdge.Core.String:Join(cChars, "")).

    END METHOD.

    METHOD PROTECTED CHARACTER ToId( num AS INTEGER, alphabet AS CHARACTER ):
        DEFINE VARIABLE res     AS CHARACTER NO-UNDO.
        DEFINE VARIABLE cChars  AS CHARACTER NO-UNDO EXTENT.
        DEFINE VARIABLE iResult AS INTEGER   NO-UNDO.
        
        DEFINE VARIABLE i1      AS INTEGER   NO-UNDO.
        
        ASSIGN
            res     = ""
            cChars  = StringUtil:ByChars(alphabet)
            iResult = num.

        DO WHILE TRUE:
            ASSIGN
                i1      = iResult MODULO EXTENT(cChars)
                res     = cChars[i1 + 1] + res
                iResult = Divide(iResult, EXTENT(cChars)).
                
            IF iResult <= 0 THEN 
                LEAVE.
        END.

        RETURN res.
    END METHOD.

    METHOD PROTECTED INTEGER ToNumber( id AS CHARACTER, alphabet AS CHARACTER  ):
        DEFINE VARIABLE cChars  AS CHARACTER NO-UNDO CASE-SENSITIVE.
        DEFINE VARIABLE itr     AS INTEGER   NO-UNDO.
        DEFINE VARIABLE iCarry  AS INT64     NO-UNDO INITIAL 0.
        DEFINE VARIABLE cIdChar AS CHARACTER NO-UNDO CASE-SENSITIVE.
        
        cChars = alphabet.
        
        DO itr = 1 TO LENGTH(id):
            ASSIGN
                cIdChar = SUBSTRING(id,itr,1)
                iCarry  = iCarry * LENGTH(cChars)
                iCarry  = iCarry + INDEX(cChars,cIdChar) - 1.
        END.
        
        RETURN INTEGER(iCarry).
    END METHOD.

END CLASS.