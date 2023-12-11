package AST;

public class IfExpr extends Expr {

    public Expr c1;
    public Expr c2;
    public Expr c3;

    public IfExpr(Expr c1, Expr c2, Expr c3) {
        this.c1 = c1;
        this.c2 = c2;
        this.c3 = c3;
    }

    @Override
    public void print() {
        System.out.print("new IfExpr ( ");
            c1.print();
        System.out.print(", ");
            c2.print();
        System.out.print(", ");
            c3.print();
        System.out.println(" )");
    }
}
