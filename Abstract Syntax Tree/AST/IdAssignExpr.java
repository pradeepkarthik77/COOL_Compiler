package AST;

public class IdAssignExpr extends Expr{
	
	public Expr s1;
	public String id;
	
	public IdAssignExpr(String id,Expr s1) {
		super();
		this.id = id;
		this.s1 = s1;
	}

	@Override
	public void print() {
		// TODO Auto-generated method stub
		System.out.println("new IdAssignExpr ( ID: "+id+",");
		s1.print();
		System.out.println(" )");
	}

}
