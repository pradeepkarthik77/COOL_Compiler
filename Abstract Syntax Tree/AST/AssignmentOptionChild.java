package AST;

public class AssignmentOptionChild extends AssignmentOption {

    public Expr c1;

    public AssignmentOptionChild(Expr c1) {
        this.c1 = c1;
    }

    @Override
    public void print() {
        System.out.print("new AssignmentOptionChild ( ");
            c1.print();
        System.out.println(" )");
    }
}
