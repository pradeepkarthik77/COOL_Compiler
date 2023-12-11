package AST;

public class LetExpr extends Expr{
	
	public AssignExpr s1;
	public CommaIdExpr s2;
	public Expr s3;
	public String id;
	public String type;
	
	public LetExpr(String id,String type,AssignExpr s1,CommaIdExpr s2,Expr s3) {
		super();
		this.s1 = s1;
		this.s2 = s2;
		this.s3 = s3;
		this.id = id;
		this.type = type;
	}

	@Override
	public void print() {
		// TODO Auto-generated method stub
		System.out.println("new LetExpr (ID:"+id+" TYPE:"+type+",");
		if(s1!=null)
		s1.print();
		System.out.println(",");
		if(s2!=null)
		s2.print();
		System.out.println(",");
		s3.print();
		System.out.println(" )");
	}

}
