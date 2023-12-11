package AST;

public class ChildParameterList extends ParameterList implements ASTNode {

    public Parameter c1;
    public CommaSeperatedParameters c2;

    public ChildParameterList(Parameter c1, CommaSeperatedParameters c2) {
        this.c1 = c1;
        this.c2 = c2;
    }

    @Override
    public void print() {
        System.out.println("new ChildParameterList ( ");
            c1.print();
        System.out.println(", ");
        if (c2 != null)
            c2.print();
        System.out.println(" )");
    }
}
