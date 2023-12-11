package AST;

public class OpExpr extends Expr{

	Expr e1, e2;
	Integer op;
	
	public OpExpr(Expr e1, Integer op, Expr e2) {
		super();
		this.e1 = e1;
		this.e2 = e2;
		this.op = op;
	}


	@Override
	public void print() {
		// TODO Auto-generated method stub
		System.out.println("new OpExpr (");
		e1.print();
		System.out.println(",");
		switch(op) {
		case 1: System.out.println("PLUS, ");
				break;
		case 2: System.out.println("MINUS, ");
				break;
		case 3: System.out.println("TIMES, ");
				break;
		case 4: System.out.println("DIV, ");
				break;
		default: System.out.println("Invalid Operator, ");
				break;
		}
		
		e2.print();
		System.out.println(")");
		
	}

}
