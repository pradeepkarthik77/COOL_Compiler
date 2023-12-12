grammar hello;
@header
{
 import java.util.Hashtable;
 import java.util.Enumeration;
 import java.io.*;
}
@members
{
Hashtable<String, String> hashtable = new Hashtable<String, String>();

public void printHT()
{
	Enumeration names;
	String key;
	names = hashtable.keys();
	while(names.hasMoreElements()) {
		key = (String) names.nextElement();
		System.out.println("Key: " +key+ " & Value: " + hashtable.get(key));
	}
}
}

start : t1=stmlist {System.out.println($t1.type);};
stmlist returns [String type]: declist t1=assignstm {$type=$t1.type;};
declist: decl declist 
		| ;
decl: type1 ID decls[$type1.val] SEMI {hashtable.put($ID.text, $type1.val);};
decls[String i] : COMMA ID decls[$i] {hashtable.put($ID.text, $i);}
	| ;
type1 returns [ String val]: INT {$val = $INT.text;}
	| FLOAT {$val = $FLOAT.text;}
	| DOUBLE {$val = $DOUBLE.text;}
	| SHORT {$val = $SHORT.text;}
	| LONG {$val = $LONG.text;};
assignstm returns [String type]: ID EQL t1=exp SEMI {if(hashtable.containsKey($ID.text))
														{if(hashtable.get($ID.text).equals($t1.type)){$type=$t1.type;}
															else {$type="mismatch";}
														}else {$type="error";}};
exp returns [String type]: t1=exp PLUS t2=term {if($t1.type.equals($t2.type)){$type=$t1.type;}else {$type="mismatch";}}
   | t3=exp MINUS t4=term {if($t3.type.equals($t4.type)){$type=$t3.type;}else {$type="mismatch";}}
    | t5=term {$type=$t5.type;};
term returns [String type]: t1=term TIMES t2=factor {if($t1.type.equals($t2.type)){$type=$t1.type;}else {$type="mismatch";}}
	| t3=term DIV t4=factor {if($t3.type.equals($t4.type)){$type=$t3.type;}else {$type="mismatch";}}
	| t5=factor {$type=$t5.type;};
factor returns [String type] : ID {if(hashtable.containsKey($ID.text)){$type=hashtable.get($ID.text);}else {$type="error";}}
	| NUM {$type="integer";}
	| LPAREN t1=exp RPAREN {$type=$t1.type;};	  
	
	   
EQL : '='; 
LPAREN : '(';  
RPAREN  : ')';
COMMA: ',';
SEMI : ';';
PLUS  : '+';
MINUS : '-' ;
TIMES: '*';
DIV : '/';
NUM  : [0-9]+;
INT : 'integer';
FLOAT : 'float';
DOUBLE: 'double';
LONG: 'long';
SHORT: 'short';
ID: [a-zA-Z][a-zA-Z0-9_]*;
WS : [ \r\n\t] + -> skip ;