package AST;

public class AtTypeChild extends AtType
{
	
	String type;
	
	public AtTypeChild(String type)
	{
		this.type = type;
	}
	
	public void print()
	{
		System.out.println("new AtTypeChild("+type+")");
	}
}
