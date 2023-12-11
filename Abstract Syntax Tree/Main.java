import java.io.IOException;

import org.antlr.v4.runtime.ANTLRFileStream;
import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.Token;

public class Main {

	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub
		ANTLRFileStream input = new ANTLRFileStream(args[0]);
        ANTLRInputStream ip = new ANTLRInputStream(input.toString());
        helloLexer lex = new helloLexer(ip);
        
//        Token token;
//        while ((token = lex.nextToken()).getType()!= -1) 
//        {
//        	System.out.println("line " + token.getLine()+ ":" + token.getStartIndex() + 
//           		 " token <" + token.getType() + ", "+token.getText() + ">");
//        }
        
        CommonTokenStream tokStream = new CommonTokenStream(lex);
        helloParser parser = new helloParser(tokStream);
        parser.start();
        
	}
}