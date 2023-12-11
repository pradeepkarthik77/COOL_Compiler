package AST;

public class CommaExprChild extends CommaExpr {

    public Expr c1;
    public CommaExpr c2;

    public CommaExprChild(Expr c1, CommaExpr c2) {
        this.c1 = c1;
        this.c2 = c2;
    }

    @Override
    public void print() {
        System.out.print("new CommaExprChild ( ");
            c1.print();
        System.out.print(", ");
        if (c2 != null)
            c2.print();
        System.out.println(" )");
    }
}
