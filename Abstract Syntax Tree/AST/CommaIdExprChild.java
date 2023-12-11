package AST;

public class CommaIdExprChild extends CommaIdExpr{
	
	public String id;
	public String type;
	public AssignExpr e1;
	public CommaIdExpr e2;
	
	
	public CommaIdExprChild(String id,String type, AssignExpr e1,CommaIdExpr e2) {
		super();
		this.id = id;
		this.e1 = e1;
		this.type = type;
		this.e2 = e2;
	}

	@Override	
	public void print() {
		System.out.println("new CommaidExpr(ID , " + id + ":"+type+",");
		if(e1!=null)
		e1.print();
		if(e2!=null)
		e2.print();
		System.out.println(")");
	}

}	