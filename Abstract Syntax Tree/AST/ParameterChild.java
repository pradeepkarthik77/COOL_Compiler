package AST;

public class ParameterChild extends Parameter{
	
	public String id;
	public String type;
	
	
	public ParameterChild(String id,String type) {
		super();
		this.id = id;
		this.type = type;
	}

	@Override	
	public void print() {
		System.out.print("new ParameterChild(ID , " + id);
		System.out.print(":"+type);
		System.out.println(")");
	}

}	