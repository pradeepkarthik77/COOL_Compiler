package AST;

public class BlockExpr extends Expr {

    public ExprContinue c1;

    public BlockExpr(ExprContinue c1) {
        this.c1 = c1;
    }

    @Override
    public void print() {
        System.out.print("new BlockExpr ( ");
            c1.print();
        System.out.println(" )");
    }
}
