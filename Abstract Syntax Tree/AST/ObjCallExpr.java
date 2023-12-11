package AST;

public class ObjCallExpr extends Expr {

    public Expr c1;
    public AtType c2;
    public ExprList c3;

    public ObjCallExpr(Expr c1, AtType c2, ExprList c3) {
        this.c1 = c1;
        this.c2 = c2;
        this.c3 = c3;
    }

    @Override
    public void print() {
        System.out.println("new ObjCallExpr ( ");
            c1.print();
        System.out.println(", ");
        if (c2 != null)
            c2.print();
        System.out.println(", ");
        if (c3 != null)
            c3.print();
        System.out.println(" )");
    }
}
