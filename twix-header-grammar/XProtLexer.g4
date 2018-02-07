/*
 * LEXER RULES
 */

lexer grammar XProtLexer;

/////////////////////////////////////////////////////////
// --------------- DEFAULT MODE -----------------------// 
/////////////////////////////////////////////////////////

fragment WS
    : [ \t\r\n\u000C]+
    ;

WHITESPACE : WS -> skip;

fragment NAT : [0-9]+
    ;
                         
fragment INT : '-'?NAT
    ;

fragment DOT : '.';

fragment NUMBER : INT('.'NAT+)? ('e' ('+' | '-') NAT)? ;

NUMBER_VALUE : NUMBER;

BOOL : '("true"|"false")'
     ;

fragment BEGIN_ASCCONV : '### ASCCONV BEGIN' .*? '###' ;
fragment END_ASCCONV : '### ASCCONV END ###';
ASCCONV_STRING : BEGIN_ASCCONV .*? END_ASCCONV;

fragment STRING : '"' (~["]|'""')* '"';

QUOTED_STRING : STRING;

fragment BRACED_CHARS : '{' ~[{}]* '}';



BURN_PROPERTY : ( ('<Default> '   NUMBER) 
                | ('<Default> '   STRING)
                | ('<Precision> ' NUMBER)
                | ('<MinSize> '   NUMBER)
                | ('<MaxSize> '   NUMBER)
                | ('<Comment> '   STRING)
                | ('<Visible> '   STRING)
                | ('<Tooltip> '   STRING)
                | ('<Class> '     STRING)
                | ('<Label> '     STRING)
                | ('<Unit> '      STRING)
                | ('<InFile> '    STRING)
                | ('<Dll> '       STRING)
                | ('<Repr> '      STRING) 
                | ('<LimitRange> ' BRACED_CHARS)
                | ('<Limit> ' BRACED_CHARS) 
                )
                -> skip
              ;

BURN_PARAM_CARD_LAYOUT : '<ParamCardLayout' .*? '>' WS 
                         LEFT_BRACE WS 
                         ('<Repr>' WS STRING WS)*
                         ('<Control>' WS BRACED_CHARS WS)*
                         ('<Line>' WS BRACED_CHARS WS)*
                         RIGHT_BRACE
                         -> skip
                        ;
                         
BURN_DEPENDENCY : ('<Dependency.' | '<ProtocolComposer.') .*? '{' .*? '}' -> skip;


BRA : '<' -> pushMode(BRAKET);  
KET : '>';

LEFT_BRACE : '{';
RIGHT_BRACE : '}';

DEFAULT : '<Default>';

ERROR_CHARACTER : .;

/////////////////////////////////////////////////////////
// ---------------INSIDE TAG --- ----------------------// 
/////////////////////////////////////////////////////////

mode BRAKET;
PARAM_MAP_TAG_TYPE : 'ParamMap'
                    | 'Pipe'
                    | 'PipeService'
                    | 'ParamFunctor'
                    ;

PARAM_ARRAY_TAG_TYPE : 'ParamArray';
XPROTOCOL            : 'XProtocol';

SPECIAL_TAG_TYPE     : 'Name'
                     | 'ID'
                     | 'Userversion'
                     ;

EVASTRINGTABLE       : 'EVAStringTable' -> mode(EVA);
fragment TAGTYPE_CHAR : [a-zA-Z0-9_];
TAG_TYPE : TAGTYPE_CHAR+;
TAG_DOT : '.';
TAG_NAME : QUOTED_STRING;
KET_CLOSE : '>' -> popMode,type(KET);

/////////////////////////////////////////////////////////
// ---------------EVA STRING TABLE --------------------// 
/////////////////////////////////////////////////////////

mode EVA;
EVA_WHITESPACE  : [ \t\r\n\u000C]+ -> skip;
EVA_LEFT_BRACE  : '{' -> type(LEFT_BRACE),pushMode(EVASTRINGTABLE_CONTENTS);
EVA_RIGHT_BRACE : '}' -> type(RIGHT_BRACE),mode(DEFAULT_MODE);
EVA_KET_CLOSE   : '>' -> type(KET);

mode EVASTRINGTABLE_CONTENTS;
STRING_TABLE    : ~[{}]+ -> popMode;





