package AST;

public class NotExpr extends Expr{
	
	public Expr s1;
	
	public NotExpr(Expr s1) {
		super();
		this.s1 = s1;
	}

	@Override
	public void print() {
		// TODO Auto-generated method stub
		System.out.print("new NotExpr ( ");
		s1.print();
		System.out.println(" )");
	}

}
