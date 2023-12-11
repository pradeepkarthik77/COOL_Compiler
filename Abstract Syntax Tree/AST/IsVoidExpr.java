package AST;

public class IsVoidExpr extends Expr {

    public Expr c1;

    public IsVoidExpr(Expr c1) {
        this.c1 = c1;
    }

    @Override
    public void print() {
        System.out.print("new IsVoidExpr ( ");
            c1.print();
        System.out.println(" )");
    }
}
