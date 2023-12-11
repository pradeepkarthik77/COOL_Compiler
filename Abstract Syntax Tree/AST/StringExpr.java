package AST;

public class StringExpr extends Expr
{
	public String text;
	public StringExpr(String text)
	{
		this.text = text;
	}
	
	@Override
	public void print() {
		// TODO Auto-generated method stub
		System.out.println("new StringExpr ( "+text+")");		
	}
}
