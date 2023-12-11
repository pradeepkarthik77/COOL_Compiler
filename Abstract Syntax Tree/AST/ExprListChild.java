package AST;

public class ExprListChild extends ExprList {

    public Expr c1;
    public CommaExpr c2;

    public ExprListChild(Expr c1, CommaExpr c2) {
        this.c1 = c1;
        this.c2 = c2;
    }

    @Override
    public void print() {
        System.out.print("new ExprListChild ( ");
            c1.print();
        System.out.print(", ");
        if (c2 != null)
            c2.print();
        System.out.println(" )");
    }
}
