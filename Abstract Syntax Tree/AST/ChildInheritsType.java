package AST;

public class ChildInheritsType extends InheritsType implements ASTNode {

    public String c1;

    public ChildInheritsType(String c1) {
        this.c1 = c1;
    }

    @Override
    public void print() {
        System.out.println("new InheritsType ( "+c1+")");
    }
}
