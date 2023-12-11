package AST;

public class IntCompExpr extends Expr {

    public Expr c1;

    public IntCompExpr(Expr c1) {
        this.c1 = c1;
    }

    @Override
    public void print() {
        System.out.print("new IntCompExpr ( ");
            c1.print();
        System.out.println(" )");
    }
}
