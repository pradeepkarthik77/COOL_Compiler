package AST;

public class VarDefFeature extends Feature implements ASTNode {

    public AssignmentOption c1;
    public String id;
    public String type;

    public VarDefFeature(String id,AssignmentOption c1,String type) {
        this.c1 = c1;
        this.id = id;
        this.type = type;
    }

    @Override
    public void print() {
    	System.out.print("new VarDefFeature(ID , " + id + ",");
		if(c1!=null)
		c1.print();
		System.out.print(":"+type);
		System.out.println(")");
    }
}
