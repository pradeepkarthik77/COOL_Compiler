package AST;

public class IdExpr extends Expr
{

	public String text;
	
	public IdExpr(String s1) {
		super();
		this.text = s1;
	}

	@Override
	public void print() {
		// TODO Auto-generated method stub
		System.out.print("new IdExpr ("+text+")");
	}

}
