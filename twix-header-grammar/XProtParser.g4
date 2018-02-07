/*
 * PARSER RULES
 */

parser grammar XProtParser;

options { tokenVocab=XProtLexer; }

header : xprot*
         ASCCONV_STRING*
       ;

xprot : xprot_tag 
        LEFT_BRACE
        special_node*
        node*
        BURN_DEPENDENCY*
        RIGHT_BRACE
        ;

xprot_tag : BRA XPROTOCOL KET;

special_node : (param_special | param_eva);
node : (param_map | param_array | param_generic | BURN_PARAM_CARD_LAYOUT);

param_special : param_special_tag
                (QUOTED_STRING | NUMBER_VALUE)
              ;

param_special_tag : BRA SPECIAL_TAG_TYPE KET;

param_eva : param_eva_tag
            LEFT_BRACE
            STRING_TABLE
            RIGHT_BRACE
          ;

param_eva_tag : BRA EVASTRINGTABLE KET;


param_array : param_array_tag
              LEFT_BRACE
              DEFAULT
              node
              array_value*
              RIGHT_BRACE
              ;

param_array_tag : BRA 
                  PARAM_ARRAY_TAG_TYPE 
                  TAG_DOT 
                  TAG_NAME 
                  KET;


param_map : param_map_tag
            LEFT_BRACE
            node*
            RIGHT_BRACE
            ;

param_map_tag : BRA 
                  PARAM_MAP_TAG_TYPE 
                  TAG_DOT 
                  TAG_NAME 
                  KET;

array_value : LEFT_BRACE
              arr_val_item*
              RIGHT_BRACE
              ;

arr_val_item : QUOTED_STRING #String
             | NUMBER_VALUE  #Number
             | array_value   #AnArrayVal
             ;

param_generic : param_generic_tag
                LEFT_BRACE 
                param_generic_val*
                RIGHT_BRACE
                ;

param_generic_val : ASCCONV_STRING
                  | QUOTED_STRING 
                  | NUMBER_VALUE  
                  ; 

param_generic_tag : BRA
                    TAG_TYPE
                    (TAG_DOT TAG_NAME)?
                    KET
                    ;
                  



          

