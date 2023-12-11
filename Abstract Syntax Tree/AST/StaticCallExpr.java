package AST;

public class StaticCallExpr extends Expr{
	
	public String id;
	public ExprList e1;
	
	
	public StaticCallExpr(String id, ExprList e1) {
		super();
		this.id = id;
		this.e1 = e1;
	}

	@Override	
	public void print() {
		System.out.println("new StaticCallExpr(ID , " + id + ",");
		if(e1!=null)
		e1.print();
		System.out.println(")");
	}

}	