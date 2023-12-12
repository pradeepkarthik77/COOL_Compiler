grammar rules;
@header{
import AST.*;
 import java.util.Hashtable;
 import java.util.Enumeration;
 import java.io.*;
}
@members
{
Hashtable<String, String> hashTable = new Hashtable<String, String>();

public void printHT()
{
	System.out.println("\nHashTable: ");
	Enumeration names;
	String key;
	names = hashTable.keys();
	while(names.hasMoreElements()) {
		key = (String) names.nextElement();
		System.out.println("Key: " +key+ " & Value: " + hashTable.get(key));
	}
}
}

start returns [ASTnode node]							:	t1=body {$node = $t1.node; $node.print(); printHT();};

body returns [Body node]					            :	t1=top_declaration t2=body {$node = new BodyTopDecls($t1.node, $t2.node);}
														|	t3=top_declaration {$node = new BodyTopDecl($t3.node);};

top_declaration returns [TopDeclaration node]           :	data_declarations
                                                        |   newtype_declarations
						                                |	newtype_declarations deriving
		    			                                | 	data_declarations deriving
		    			                                | 	class_declarations
		    			                                | 	instance_declarations
		    			                                | 	default_declarations
		    			                                | 	foreign_import
		    			                                | 	t=declarations {$node = $t.node;};

deriving				                                :	DERIVING LPAREN dclasses RPAREN
                                                        |   DERIVING dclasses;

dclasses				                                :	qcon COMMA dclasses | qcon;

qvar returns [String txt]								:	UID DOT ID {$txt = $UID.text + $DOT.text + $ID.text;}
														|	ID {$txt = $ID.text;}
														|	UID {$txt = $UID.text;};

qcon returns [String txt]                               :	UID DOT UID {$txt = $UID.text + $DOT.text + $UID.text;}
														|	UID {$txt = $UID.text;};

qvcon returns [String txt]                              :	UID {$txt = $UID.text;}
														|	ID {$txt = $ID.text;};

types returns [TypesClass node, String funTypes]	    :	t1=type ARROW t2=types {$node = new TypesList($t1.node, $t2.node); $funTypes = $t2.funTypes;}
                                                        |   t3=type {$node = $t3.node; $funTypes = $t3.funType;};

type returns [TypeClass node, String funType]           :   d1=qcon d2=type {$node = new TypeConstr($d1.text, $d2.node); $funType = $d2.funType;}
                                                        |	t1=qcon {$node = new AtypeCon($t1.txt); $funType = $t1.text;}
                                                        |   t2=ID {$node = new AtypeId($t2.text); $funType = $t2.text;}
						                                |	t3=qcon LPAREN RPAREN {$node = new AtypeConParen($t3.txt); $funType = $t3.text;} 
                                                        |   LPAREN t4=types RPAREN {$node = new AtypeParen($t4.node); $funType = "some Function";}
						                                |	LPAREN t5=type_list RPAREN {$node =  $t5.node; $funType = "Tuple";};

type_list returns [TypeListClass node]                  :	t1=type COMMA t2=type_list {$node = new TypeList($t1.node, $t2.node);}
														|	t3=type {$node = new TypesL($t3.node);};

// Default declarations
default_declarations	                                :	DEFAULT LPAREN types RPAREN;

// Declarations
declarations returns [Declarations node]                 : 	t1=decl t2=declarations {$node = new DeclDecls($t1.node, $t2.node);}
														|	t3=decl {$node = $t3.node;};

decl returns [Decl node]                                :	t1=gendecl {$node = $t1.node;}
						                                |	t2=funlhs t3=rhs {$node = new DeclFunLhsRhs($t2.node, $t3.node);}
						                                |	t4=ID t5=rhs {$node = new DeclVar($t4.text, $t5.node); if($t5.rhsType != null) {hashTable.put($t4.text, $t5.rhsType);}};

funlhs returns [FunLhs node]			                :	d1=ID t1=pats {$node = new FunLhsPat($d1.text, $t1.node);};

rhs returns [Rhs node, String rhsType]                  :	ASSIGN t2=list_comprehensions {$node = $t2.node; $rhsType = $t2.listType;}
														|	ASSIGN t1=expression {$node = $t1.node; $rhsType = $t1.expType;}
                                                        |   ASSIGN t3=function_application {$node = $t3.node;}
						                                |	RARROW t4=expression {$node = $t4.node;}
						                                |	ASSIGN t5=expression WHERE t6=declarations {$node = new RhsWhere($t5.node, $t6.node);}
						                                |	g1=gdrhs {$node = $g1.node;}
						                                | 	g2=gdrhs WHERE g3=declarations {$node = new RhsGrdDecls($g2.node, $g3.node);};

gdrhs returns [GdRhs node]	                            :	VBAR g1=expression ASSIGN g2=expression g3=gdrhs {$node = new Guards($g1.node, $g2.node, $g3.node);}
                                                        |   VBAR t1=expression ASSIGN t2=expression {$node = new Guard($t1.node, $t2.node);};

pats returns [Pats node]	                            :	t1=pat t2=pats {$node = new PatPats($t1.node, $t2.node);}
														|	t3=pat {$node = $t3.node;};

pat returns [Pat node]							       	:	t1=ID {$node = new PatId($t1.text);} 
						                                |	qcon {$node = new PatCon($qcon.text);}
						                                |	literal {$node = new PatLit($literal.text);}
						                                |	t2=WILDCARD {$node = new PatWild($t2.text);}
						                                | 	LPAREN pat RPAREN {$node = new PatParen($pat.node);}
						                                |	LBRACKET pat RBRACKET {$node = new PatBrac($pat.node);}
						                                |	t3=pat COLON t4=pat {$node = new PatCons($t3.node, $t4.node);}
						                                |   list_comprehensions {$node = new PatListComp($list_comprehensions.node);}
						                                |	LPAREN f1=funlhs RPAREN {$node = $f1.node;}
						                                |	p1=pat COMMA p2=pat {$node = new PatTuple($p1.node, $p2.node);};

gendecl returns [GenDecl node]                          :	d1=ID DOUBLE_COLON t1=context DOUBLEARROW t2=types {$node = new GenDeclCon($d1.text, $t1.node, $t2.node); hashTable.put($d1.text, $t2.funTypes);}
						                                |	d2=ID DOUBLE_COLON t3=types {$node = new GenDeclType($d2.text, $t3.node); hashTable.put($d2.text, $t3.funTypes);}
						                                |	fixity INTEGER ops;

context returns [ASTnode node]                          :	t1=classes {$node = new ConClasses($t1.node);}
						                                |	LPAREN t2=classes RPAREN {$node = new ConClassesParen($t2.node);};

classes returns [ASTnode node]                          :	t1=cls COMMA t2=classes {$node = new ClassList($t1.node, $t2.node);}
														|	t3=cls {$node = new Cls($t3.node);};

cls returns [ASTnode node]                              : 	q1=qcon d1=ID {$node = new ClassID($q1.txt, $d1.text);}
						                                |	q2=qcon d2=ID t1=type {$node = new ClassType($q2.txt, $d2.text, $t1.node);};

ops						                                :	op COMMA ops | op;

fixity					                                :	INFIXL | INFIXR | INFIX;

case_alternatives returns [CaseAlternatives node]       :	t1=case_alternative t2=case_alternatives {$node = new CaseAlters($t1.node, $t2.node);}
						                                |	t3=case_alternative {$node = $t3.node;};
						                                
case_alternative returns [CaseAlternative node]         :	t1=pat ARROW t2=expression {$node = new Case($t1.node, $t2.node);};

stmts returns [Stmnts node]					            :	t1=stmt t2=stmts {$node = new LetStmts($t1.node, $t2.node); }
														| 	t3=stmt {$node = $t3.node;};

stmt		returns [Stmt node]			            	:	t1=expression {$node = new Stm($t1.node);}
						                                |	t2=pat ARROW t3=expression {$node = new StmExp($t2.node, $t3.node); }
						                                |   t4=pat ASSIGN t5=expression {$node = new StmPat($t4.node, $t5.node); }
						                                |   t6= pat ASSIGN t7=expression DOUBLE_COLON t8=types {$node = new StmTyp($t6.node, $t7.node,$t8.node); }
						                                |	LET t9=declarations {$node = new StmDecl($t9.node);};

expression returns [Expression node, String expType]    : 	t0=ID {$node = new IDexp($t0.text);}
                                                        |   BACKSLASH t1=pats ARROW t2=expression {$node = new LambdaExp($t1.node, $t2.node);}
       					                                | 	IF t5=expression THEN t6=expression ELSE t7=expression {$node = new IfExp($t5.node, $t6.node, $t7.node);}
				       	                                | 	CASE c1=expression OF c2=case_alternatives {$node = new CaseExp($c1.node, $c2.node);}
				       	                                | 	LET le1=declarations IN le2=expression {$node = new LetState($le1.node, $le2.node); }
				       	                                | 	DO d1=stmts {$node = new DoBlock($d1.node);}
			       		                                | 	l1=literal {$node = $l1.node; $expType = $l1.litType;}
						                                | 	fa=function_application {$node = new ExpFunApp($fa.node);}
						                                | 	lc=list_comprehensions {$node = new ExpListComp($lc.node);}
						                                | 	t3=expression t=op t4=expression {$node = new BinopExp($t3.node, $t.txt, $t4.node);}
						                                | 	MINUS m1=expression {$node = new ExpMinus($m1.node);};

function_application returns [FunctionApplication node] : 	d1=ID t1=pats {$node = new FunApp($d1.text, $t1.node);}
						                                |	d2=ID LPAREN t2=pats RPAREN {$node = new FunAppParen($d2.text, $t2.node);}
						                                |   q1=qvcon t3=pats {$node = new FunAppQPats($q1.txt, $t3.node);}
						                                |   q2=qvcon {$node = new FunQvcon($q2.txt);};

list_comprehensions returns [ListComprehension node, String listType]              
														:	LPAREN t1 = expression RPAREN {$node = new ListExp($t1.node); $listType = "(" + $t1.expType + ")";}
						                                | 	LPAREN t2=exps RPAREN {$node = $t2.node; $listType = "(" + $t2.expsType + ")";}
                                                        |   LBRACKET t3=exps RBRACKET {$node = $t3.node; $listType = "[" + $t3.expsType + "]";}
						                                | 	LBRACKET t4=expression RANGE RBRACKET {$node = new ListExpsR($t4.node); System.out.println("Infinite Range"); $listType = "[" + $t4.expType + "]";}
						                                | 	LBRACKET t5=expression RANGE t6=expression RBRACKET
						                                	{
						                                		$node = new ListtwoExp($t5.node, $t6.node);
						                                		if($t5.expType == $t6.expType){
					                                				$listType = "[" + $t5.expType + "]";	
						                                		}						                    
						                                		else{
						                                			$listType = "Type mismatch " + $t5.expType + " and " + $t6.expType + "\n";
						                                		}
											            	}
						                                | 	LBRACKET t7=expression COMMA t8=expression RANGE t9=expression RBRACKET
						                                	{
						                                		$node = new ListtwoExps($t7.node, $t8.node,$t9.node);
						                                		System.out.println("Pat ranged");
					                                			if($t7.expType == $t8.expType && $t8.expType == $t9.expType){
					                                				$listType = "[" + $t7.expType + "]";	
						                                		}						                    
						                                		else{
						                                			$listType = "Type mismatch " + $t7.expType + " and " + $t8.expType + " and " + $t9.expType + "\n";
						                                		}
						                                	}
						                                | 	LBRACKET t10=expression VBAR t11=gens RBRACKET {$node = new ListtwoExpsVbar($t10.node, $t11.node);}
						                                |   LBRACKET RBRACKET {$node = new ListCompEmpty();} ;

gens returns [Gens node]				            	:	t1=gen COMMA t2=gens {$node = new GenExp($t1.node, $t2.node);}
														| 	t3=gen  {$node = new GenExps($t3.node);}; 
														
gen	returns [Gen node]					            	:	t1=pat RARROW t2=expression {$node = new GensExp($t1.node, $t2.node);}
						                                |	LET t3=declarations  {$node = new GensExpsR($t3.node);}
						                                |	t4=expression {$node = new GenExpsR($t4.node);};

exps 	returns [Exprs node, String expsType ]          :	t1=expression COMMA t2=exps {$node = new Exps($t1.node, $t2.node); $expsType = $t1.expType + "," + $t2.expsType;}
														|	t3=expression {$node = new ExpsR($t3.node); $expsType = $t3.expType;} ;

op returns [int txt]	                                : 	PLUS {$txt = 1;}
						                                | 	MINUS {$txt = 2;}
						                                | 	MULT {$txt = 3;}
						                                | 	DIV {$txt = 4;}
						                                | 	EQUALS {$txt = 5;}
						                                | 	NOT_EQUALS {$txt = 6;}
						                                | 	LESS_THAN {$txt = 7;}
						                                | 	GREATER_THAN {$txt = 8;}
						                                | 	LESS_THAN_EQUAL {$txt = 9;}
						                                | 	GREATER_THAN_EQUAL {$txt = 10;}
						                                | 	AND {$txt = 11;}
						                                | 	OR {$txt = 12;}
						                                | 	COLON {$txt = 13;}
						                                | 	CONCAT {$txt = 14;}
						                                |	RARROW {$txt = 15;}
                                                        |   BACKTICK ID BACKTICK {$txt = 16;}
                                                        |   BACKTICK UID BACKTICK {$txt = 17;};

literal returns [Literal node, String litType]          : 	t1=INTEGER {$node = new LitNum($t1.text); $litType = "Integer";}
						                                | 	f1=FLOAT {$node = new LitFloat($f1.text); $litType = "Float";}
						                                | 	c1=CHAR {$node = new LitChar($c1.text); $litType = "Char";}
						                                | 	s1=STRING {$node = new LitString($s1.text); $litType = "String";};


// Data declarations
data_declarations		                                :	DATA qcon ASSIGN constrs
                                                        |   DATA qcon ID ASSIGN constrs
                                                        |   DATA context DOUBLEARROW qcon ASSIGN constrs;

constrs					                                :	UID
						                                |	contypes
						                                |	UID	LFLOWER fields RFLOWER;

fields 					                                :	field COMMA fields | field;
field					                                :	ID DOUBLE_COLON type;


contypes				                                :	type VBAR contypes
                                                        |   type ID VBAR contypes
                                                        |   type
                                                        |   type ID;

// New type declarations

newtype_declarations	                                :	NEWTYPE qcon ASSIGN new_constr
                                                        |   NEWTYPE qcon pats ASSIGN new_constr
                                                        |   NEWTYPE context DOUBLEARROW qcon ASSIGN new_constr;

new_constr				                                :	UID type
						                                |	UID LFLOWER ID DOUBLE_COLON type RFLOWER;

// Class Declarations
class_declarations		                                :	CLASS qcon ID WHERE cdecls
                                                        |   CLASS context DOUBLEARROW qcon ID WHERE cdecls;

cdecls					                                :	cdecl cdecls | cdecl;

cdecl					                                :	ID DOUBLE_COLON types
						                                |	ID DOUBLE_COLON context DOUBLEARROW types
						                                |   DEFAULT ID DOUBLE_COLON types
            			                                |	DEFAULT ID DOUBLE_COLON context DOUBLEARROW types
            			                                |   TYPE qcon ID;


// Instance declaration
instance_declarations	                                :	INSTANCE qcon inst WHERE idecls
						                                |	INSTANCE scontext DOUBLEARROW inst WHERE idecls;

inst					                                :	qcon
						                                |	LPAREN qcon vars RPAREN
						                                | 	LPAREN vars RPAREN
						                                |	LBRACKET ID RBRACKET;

scontext				                                :	qcon
						                                |	LPAREN simple_classes RPAREN;

simple_classes			                                :	qcon ID COMMA simple_classes
						                                |	qcon ID;

idecls					                                :	idecl idecls | idecl;
idecl					                                :	funlhs rhs
						                                |	ID rhs;

vars					                                :	ID vars | ID;

// Foreign imports
foreign_import			                                :	FOREIGN IMPORT calling_convention STRING gendecl
                                                        |   FOREIGN EXPORT calling_convention STRING gendecl;

calling_convention		                                :	STDCALL
                  		                                | 	CCALL
                  		                                | 	CAPI
	      				                                | 	CPPCALL
      					                                | 	JSCALL
	      				                                |	REC
	      				                                |   SAFE
	      				                                |   UNSAFE;



//KEYWORDS:
AS   		 	: 'as'      		 	;
CASE 		 	: 'case'    		 	;
DEFAULT  	 	: 'default' 		 	;
DO   		 	: 'do'      		 	;
ELSE 		 	: 'else'    		 	;
HIDING   	 	: 'hiding'  		 	;
IF   		 	: 'if'      		 	;
IMPORT   	 	: 'import'  		 	;
IN   		 	: 'in'      		 	;
INFIX		 	: 'infix'   		 	;
INFIXL   	 	: 'infixl'  		 	;
INFIXR   	 	: 'infixr'  		 	;
LET  		 	: 'let'     		 	;
MODULE   	 	: 'module'  		 	;
OF   		 	: 'of'      		 	;
QUALIFIED    	: 'qualified'   	 	;
THEN 		 	: 'then'    		 	;
WHERE		 	: 'where'   		 	;
WILDCARD 	 	: '_'       		 	;
FORALL   	 	: 'forall'  		 	;
FOREIGN  	 	: 'foreign' 		 	;
EXPORT   	 	: 'export'  		 	;
SAFE 		 	: 'safe'    		 	;
INTERRUPTIBLE 	: 'interruptible'       ;
UNSAFE   	 	: 'unsafe'  		 	;
MDO  		 	: 'mdo'     		 	;
FAMILY   	 	: 'family'  		 	;
ROLE 		 	: 'role'    		 	;
STDCALL  	 	: 'stdcall' 		 	;
CCALL		 	: 'ccall'   		 	;
CAPI 		 	: 'capi'    		 	;
CPPCALL  	 	: 'cplusplus'   	 	;
JSCALL   	 	: 'javascript'  	 	;
REC  		 	: 'rec'     		 	;
GROUP	  	 	: 'group'			 	;
BY   		 	: 'by'      		 	;
USING		 	: 'using'   		 	;
PATTERN  	 	: 'pattern' 		 	;
STOCK		 	: 'stock'   		 	;
ANYCLASS 	 	: 'anyclass'		 	;
VIA  		 	: 'via'     		 	;


//OBJECT RELATED KEYWORDS: (justification provided in text)
DATA			: 'data'				;
TYPE			: 'type'				;
CLASS			: 'class'				;
INSTANCE		: 'instance'			;
NEWTYPE			: 'newtype'				;
DERIVING		: 'deriving'			;

//OPERATORS:
PLUS			: '+'					;
MINUS			: '-'					;
MULT			: '*'					;
DIV				: '/'					;
MOD				: '%'					;
EQUALS 			: '=='					;
NOT_EQUALS		: '/='					;
LESS_THAN		: '<'					;
GREATER_THAN	: '>'					;
LESS_THAN_EQUAL : '<='					;
GREATER_THAN_EQUAL : '>='				;
AND				: '&&'					;
OR				: '||'					;
NOT				: 'not'					;
BITWISE_AND		: '&'					;
VBAR	 		: '|'					;
XOR 			: 'xor'					;
ASSIGN 			: '='					;
DOT 			: '.'					;
COLON 			: ':'					;
CONCAT 			: '++'					;

//SYMBOLS:
DOLLAR 			: '$'					;
LBRACKET 		: '['					;
RBRACKET 		: ']'					;
RANGE 			: '..'					;
BACKSLASH 		: '\\'					;
LPAREN 			: '('					;
RPAREN 			: ')'					;
COMMA			: ','					;
BACKTICK 		: '`'					;
SEMICOLON		: ';'					;
LFLOWER			: '{'					;
RFLOWER			: '}'					;
DOUBLEARROW		: '=>'					;
RARROW			: '<-'					;

// Type Annotations and Bindings
DOUBLE_COLON 	: '::'					;
BIND_RIGHT 		: '>>='					;
BANG 			: '!'					;

// Other Operators
HASH 			: '#'					;
QUESTION 		: '?'					;
AT 				: '@'					;
CARET 			: '^'					;
TILDE 			: '~'					;
DEFINE 			: ':='					;

// White Characters:
WS 				: [ \t]+ -> skip		;
NEWLINE 		: '\r'? '\n' -> skip	;
TAB 			: [\t]+					;

//COMMENTS:
COMMENT 		: '--' ~[\r\n]* -> skip	;
MULTI_LINE_COMMENT: '{-' .*? '-}'->skip	;

//IDENTIFIERS:
UID				: [A-Z][a-zA-Z0-9]*  ;
ID 				: [a-zA-Z][a-zA-Z0-9_]*	;

//CONSTANTS
INTEGER 		: [0-9]+															;
FLOAT 			: ([0-9]+ '.' [0-9]* | '.' [0-9]+ | [0-9]+) ([eE] [+\-]? [0-9]+)?	;
CHAR 			: '\'' ~'\'' '\''													;
STRING 			: '"' ( '\\' . | ~('\n'|'\r'|'"') )* '"'							;

//OTHER TOKENS:
ARROW 			: '->'					;