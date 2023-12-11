package AST;

public class CaseExpr extends Expr {

    public Expr c1;
    public CaseAssign c2;

    public CaseExpr(Expr c1, CaseAssign c2) {
        this.c1 = c1;
        this.c2 = c2;
    }

    @Override
    public void print() {
        System.out.print("new CaseExpr ( ");
            c1.print();
        System.out.print(", ");
            c2.print();
        System.out.println(" )");
    }
}
