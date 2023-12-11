package AST;

public class RelExpr extends Expr{

	Expr e1, e2;
	Integer op;
	
	
	public RelExpr(Expr e1, Integer op, Expr e2) {
		super();
		this.e1 = e1;
		this.e2 = e2;
		this.op = op;
	}


	@Override
	public void print() {
		// TODO Auto-generated method stub
		System.out.println("new RelExpr (");
		e1.print();
		System.out.print(",");
		switch(op) {
		case 1: System.out.print("LT, ");
				break;
		case 2: System.out.print("LTEQ, ");
				break;
		case 3: System.out.print("EQUAL, ");
		default: System.out.print("Invalid Operator, ");
				break;
		}
		
		e2.print();
		System.out.println(")");
		
	}

}
