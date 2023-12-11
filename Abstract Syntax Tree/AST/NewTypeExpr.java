package AST;

public class NewTypeExpr extends Expr {
	
	String type;
	
	public NewTypeExpr(String val)
	{
		this.type = val;
	}
	
	@Override
	public void print() {
		System.out.println("new NewTypeExpr("+type+")");
	}

}