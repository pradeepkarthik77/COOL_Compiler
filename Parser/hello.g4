grammar hello;

program   : classList # start
          ;
    
classList: classDefine SEMICOLON
		 | classDefine SEMICOLON classList
		 ;
    
classDefine 
		: CLASS TYPE inheritsType OPENBRACE featureList CLOSEBRACE # classDef
        ;

inheritsType: INHERITS TYPE # oneinherit
			| 				# noinherit
			;

featureList
    : feature SEMICOLON featureList # featureSequence
    |                              # emptyFeatures
    ;
    
feature
    : ID OPENPARENTHESES parameterList CLOSEPARENTHESES COLON TYPE OPENBRACE exprSequence CLOSEBRACE # function
    | ID COLON TYPE assignmentOption # varDef
    ;

parameterList
    : parameter commaSeparatedParameters # multipleParameters
    |                                   # noParameters
    ;

commaSeparatedParameters
    : COMMA parameter commaSeparatedParameters # commaSeparatedParamSequence
    |                                         # singleParameter
    ;

exprSequence
    : expr exprSequence # exprSequences
    |                  # noExpr
    ;

assignmentOption
    : ASSIGN expr       # assignedExpr
    |                   # noAssignment
    ;

parameter : ID COLON TYPE # param;

expr      : expr atType DOT ID OPENPARENTHESES exprList CLOSEPARENTHESES # objectCall
          | ID OPENPARENTHESES exprList CLOSEPARENTHESES # staticCall
          | IF expr THEN expr ELSE expr FI # if
          | WHILE expr LOOP expr POOL # while
          | OPENBRACE exprContinue CLOSEBRACE  # block
          | LET ID COLON TYPE assignExpr commaidExpr IN expr # let
          | CASE expr OF caseAssign ESAC # switch
          | NEW TYPE # newObject
          | ISVOID expr # void
          | expr MUL expr # mul
          | expr DIV expr # div
          | expr ADD expr # add
          | expr SUB expr # sub
          | INTCOMP expr # invert
          | expr LT expr # lt
          | expr LTEQ expr # lteq
          | expr EQUAL expr # equal
          | NOT expr # not
          | OPENPARENTHESES expr CLOSEPARENTHESES # factExpr
          | STRING # string
          | NUM # num
          | ID # id
          | TRUE # true
          | FALSE # false
          | ID ASSIGN expr # assign
          ;

caseAssign: ID COLON TYPE CASEASSIGN expr SEMICOLON
		  | ID COLON TYPE CASEASSIGN expr SEMICOLON caseAssign
		  ;

exprContinue: expr SEMICOLON
			| expr SEMICOLON exprContinue
			;

commaidExpr: COMMA ID COLON TYPE assignExpr commaidExpr
		   |
		   ;

assignExpr: ASSIGN expr # oneAssign
		  |				# noAssign
		  ;
      
atType: AT TYPE #singleatType
	  | 		#noatType
	  ;
	  
exprList: expr commaExpr # oneexprList
		| 					 # noexprList
		;

commaExpr: COMMA expr commaExpr # continueComma
		 |						# endComma
		 ;
          
fragment A : [aA];
fragment B : [bB];
fragment C : [cC];
fragment D : [dD];
fragment E : [eE];
fragment F : [fF];
fragment H : [hH];
fragment I : [iI];
fragment L : [lL];
fragment N : [nN];
fragment O : [oO];
fragment P : [pP];
fragment R : [rR];
fragment S : [sS];
fragment T : [tT];
fragment V : [vV];
fragment W : [wW];


CLASS: C L A S S;
INHERITS: I N H E R I T S;
SEMICOLON: ';';
OPENBRACE: '{';
CLOSEBRACE: '}';
COLON: ':';
COMMA: ',';
OPENPARENTHESES: '(';
CLOSEPARENTHESES: ')';
DOT: '.';
AT: '@';
INTCOMP: '~';
NEW: N E W;
ADD: '+';
SUB: '-';
MUL: '*';
DIV: '/';
EQUAL: '=';
LT: '<';
LTEQ: '<=';
ASSIGN: '<-';
NOT: N O T;
TRUE: 'true';
FALSE: 'false';
STRING: '"' (('\\'|'\t'|'\r\n'|'\r'|'\n'|'\\"') | ~('\\'|'\t'|'\r'|'\n'|'"'))* '"';
IF: I F;
THEN: T H E N;
ELSE: E L S E;
FI: F I;
WHILE: W H I L E;
LOOP: L O O P;
POOL: P O O L;
CASE: C A S E;
OF: O F;
ESAC: E S A C;
LET: L E T;
IN: I N;
CASEASSIGN: '=>';
ISVOID: I S V O I D;
ID: [a-z_][a-zA-Z0-9_]*;
NUM: [0-9]+;
TYPE: [A-Z][a-zA-Z_0-9]*;
SINGLECOMMENT: '--' ~[\r\n]* -> skip;
MULTICOMMENT: '(*' .*? '*)' -> skip;
WS: [ \n\t\r]+ -> skip;
