package AST;

public class FunctionFeature extends Feature implements ASTNode
{
	public String id;
	public String type;
	public ParameterList e1;
	public Expr e2;
	
	
	public FunctionFeature(String id, ParameterList e1,String type,Expr e2) {
		super();
		this.id = id;
		this.e1 = e1;
		this.e2 = e2;
		this.type = type;
	}

	@Override	
	public void print() {
		System.out.println("new FunctionFeature(ID , " + id + ",");
		if(e1!=null)
		e1.print();
		System.out.println(":"+type+",");
		e2.print();
		System.out.println(")");
	}
	

}
