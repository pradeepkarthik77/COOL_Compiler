package AST;

public class NumExpr extends Expr
{
	public String text;
	public NumExpr(String text)
	{
		this.text = text;
	}
	
	@Override
	public void print() {
		// TODO Auto-generated method stub
		System.out.println("new NumExpr ( "+text+")");		
	}
}
