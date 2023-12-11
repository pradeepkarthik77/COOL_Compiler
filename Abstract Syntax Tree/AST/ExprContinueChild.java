package AST;

public class ExprContinueChild extends ExprContinue {

    public Expr c1;
    public ExprContinueSupport c2;

    public ExprContinueChild(Expr c1, ExprContinueSupport c2) {
        this.c1 = c1;
        this.c2 = c2;
    }

    @Override
    public void print() {
        System.out.println("new ExprContinueChild ( ");
            c1.print();
        System.out.println(", ");
        if (c2 != null)
            c2.print();
        System.out.println(" )");
    }
}
