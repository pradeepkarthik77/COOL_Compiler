package AST;

public class WhileExpr extends Expr {

    public Expr c1;
    public Expr c2;

    public WhileExpr(Expr c1, Expr c2) {
        this.c1 = c1;
        this.c2 = c2;
    }

    @Override
    public void print() {
        System.out.println("new WhileExpr ( ");
            c1.print();
        System.out.println(", ");
            c2.print();
        System.out.println(" )");
    }
}
