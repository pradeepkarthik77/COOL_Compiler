package AST;

public class ChildClassList extends ClassList implements ASTNode{
	
	public InheritsType c1;
	public String type;
	public FeatureList c2;
	public ClassDefine c3;
	
	
	public ChildClassList(String type,InheritsType c1,FeatureList c2,ClassDefine c3)
	{
		this.type = type;
		this.c1 = c1;
		this.c2 = c2;
		this.c3 = c3;
	}
	
	@Override
	public void print() {
		// TODO Auto-generated method stub
		System.out.print("new ChildClassList: "+type+" (");
		if(c1!=null)
		c1.print();
		System.out.println(",");
		if(c2!=null)
		c2.print();
		System.out.println(",");
		if(c3!=null)
		c2.print();
		System.out.println(" )");
	}

}
