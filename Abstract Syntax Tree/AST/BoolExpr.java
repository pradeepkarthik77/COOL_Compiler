package AST;

public class BoolExpr extends Expr {

	Integer op;
	
	public BoolExpr(Integer op) {
		super();
		this.op = op;
	}


	@Override
	public void print() {
		// TODO Auto-generated method stub
		System.out.println("new BoolExpr (");
		switch(op) {
		case 1: System.out.print("TRUE");
				break;
		case 2: System.out.print("FALSE");
				break;
		default: System.out.print("Invalid Expr");
				break;
		}
		System.out.println(")");
		
	}

}
