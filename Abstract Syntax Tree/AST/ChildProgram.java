package AST;

public class ChildProgram extends Program implements ASTNode{
	
	public ClassList c1;
	
	public ChildProgram(ClassList c1)
	{
		this.c1 = c1;
	}
	
	@Override
	public void print() {
		// TODO Auto-generated method stub
		System.out.println("new ChildProgram ( ");
		c1.print();
		System.out.println(" )");
	}

}
