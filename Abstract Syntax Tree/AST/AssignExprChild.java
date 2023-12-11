package AST;

public class AssignExprChild extends AssignExpr {

    public Expr c1;

    public AssignExprChild(Expr c1) {
        this.c1 = c1;
    }

    @Override
    public void print() {
        System.out.print("new AssignExprChild ( ");
            c1.print();
        System.out.println(" )");
    }
}