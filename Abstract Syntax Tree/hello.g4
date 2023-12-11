grammar hello;

@header{
	import AST.*;
}

start returns [ASTNode node]: t1=program {$node = $t1.node; $node.print();};

program returns [Program node]: t1=classList {$node = new ChildProgram($t1.node);};

classList returns [ClassList node]	: CLASS TYPE t1=inheritsType OPENBRACE t2=featureList CLOSEBRACE SEMICOLON t3=classDefine {$node = new ChildClassList($TYPE.text,$t1.node,$t2.node,$t3.node);};

classDefine returns [ClassDefine node]: t1=classList {$node = new ChildClassDefine($t1.node);}
									  |
									  ;

inheritsType returns [InheritsType node]: INHERITS TYPE {$node = new ChildInheritsType($TYPE.text);}
										| 
										;
	
featureList returns [FeatureList node]: t1=feature SEMICOLON t2=featureList {$node = new ChildFeatureList($t1.node, $t2.node);}
									  |
									  ;

feature returns [Feature node]: ID OPENPARENTHESES t1=parameterList CLOSEPARENTHESES COLON TYPE OPENBRACE t2=expr CLOSEBRACE {$node = new FunctionFeature($ID.text,$t1.node,$TYPE.text,$t2.node);}
							  | ID COLON TYPE s1=assignmentOption {$node = new VarDefFeature($ID.text,$s1.node,$TYPE.text);};
          
parameterList returns [ParameterList node]: t1=parameter t2=commaSeparatedParameters {$node = new ChildParameterList($t1.node,$t2.node);}
										  |
										  ;

commaSeparatedParameters returns [CommaSeperatedParameters node]: COMMA t1=parameter t2=commaSeparatedParameters {$node = new CommaSeperatedParametersChild($t1.node,$t2.node);}
																|
																;

assignmentOption returns [AssignmentOption node]: ASSIGN t1=expr {$node = new AssignmentOptionChild($t1.node);}
												|
												;

parameter returns [Parameter node]: ID COLON TYPE {$node = new ParameterChild($ID.text,$TYPE.text);};

expr returns [Expr node]: t1=expr t2=atType DOT ID OPENPARENTHESES t3=exprList CLOSEPARENTHESES {$node = new ObjCallExpr($t1.node,$t2.node,$t3.node);}
						   | ID OPENPARENTHESES s1=exprList CLOSEPARENTHESES {$node = new StaticCallExpr($ID.text,$s1.node);}
						   | IF a1=expr THEN a2=expr ELSE a3=expr FI {$node = new IfExpr($a1.node,$a2.node,$a3.node);}
						   | WHILE b1=expr LOOP b2=expr POOL {$node = new WhileExpr($b1.node,$b2.node);}
						   | OPENBRACE c1=exprContinue CLOSEBRACE {$node = new BlockExpr($c1.node);}
						   | LET ID COLON TYPE d1=assignExpr d2=commaidExpr IN d3=expr {$node = new LetExpr($ID.text,$TYPE.text,$d1.node,$d2.node,$d3.node);}
						   | CASE e1=expr OF e2=caseAssign ESAC {$node = new CaseExpr($e1.node,$e2.node);}
						   | NEW TYPE {$node = new NewTypeExpr($TYPE.text);}
						   | ISVOID f1=expr {$node = new IsVoidExpr($f1.node);}
						   | g1=expr b=binop g2=expr {$node = new OpExpr($g1.node, $b.value, $g1.node);}
						   | INTCOMP h1=expr {$node = new IntCompExpr($h1.node);}
						   | i1=expr r=relop i2=expr {$node = new RelExpr($i1.node,$r.value,$i2.node);}
						   | NOT j1=expr {$node = new NotExpr($j1.node);}
						   | OPENPARENTHESES k1=expr CLOSEPARENTHESES {$node = new FactExpr($k1.node);}
						   | STRING {$node = new StringExpr($STRING.text);}
						   | ID {$node = new IdExpr($ID.text);}
						   | l=boolexp {$node = new BoolExpr($l.value);}
						   | ID ASSIGN k1=expr {$node = new IdAssignExpr($ID.text,$k1.node);}
						   ;

binop returns [Integer value]: ADD {$value=1;}
							 | SUB {$value=2;}
							 | MUL {$value=3;}
							 | DIV {$value=4;}
							 ;

relop returns [Integer value]: LT {$value=1;}
							 | LTEQ {$value=2;}
							 | EQUAL {$value=3;}
							 ;

boolexp returns [Integer value]: TRUE {$value=1;}
							   | FALSE {$value=2;}
							   ;

caseAssign returns [CaseAssign node]: ID COLON TYPE CASEASSIGN t1=expr SEMICOLON t2=caseAssignSupport {$node = new CaseAssignChild($t1.node,$t2.node);};

caseAssignSupport returns [CaseAssignSupport node]: t1=caseAssign {$node = new CaseAssignSupportChild($t1.node);}
												  |
												  ;

exprContinue returns [ExprContinue node]: t1=expr SEMICOLON t2=exprContinueSupport {$node = new ExprContinueChild($t1.node,$t2.node);};

exprContinueSupport returns [ExprContinueSupport node]: t1=exprContinue {$node = new ExprContinueSupportChild($t1.node);}
													  |
													  ;

commaidExpr returns [CommaIdExpr node]: COMMA ID COLON TYPE t1=assignExpr t2=commaidExpr {$node = new CommaIdExprChild($ID.text,$TYPE.text,$t1.node,$t2.node);}
									  |
									  ;

assignExpr returns [AssignExpr node]: ASSIGN t1=expr {$node = new AssignExprChild($t1.node);}
									|
									;

atType returns [AtType node]: AT TYPE {$node = new AtTypeChild($TYPE.text);}
							|
							;

exprList returns [ExprList node]: t1=expr t2=commaExpr {$node = new ExprListChild($t1.node,$t2.node);}
								|
								;
						   
commaExpr returns [CommaExpr node]: COMMA t1=expr t2=commaExpr {$node = new CommaExprChild($t1.node,$t2.node);}
								  |
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
