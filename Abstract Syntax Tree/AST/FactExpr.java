package AST;

public class FactExpr extends Expr {

    public Expr c1;

    public FactExpr(Expr c1) {
        this.c1 = c1;
    }

    @Override
    public void print() {
        System.out.print("new FactExpr ( ");
            c1.print();
        System.out.println(" )");
    }
}
