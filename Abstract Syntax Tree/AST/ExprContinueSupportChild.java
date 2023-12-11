package AST;

public class ExprContinueSupportChild extends ExprContinueSupport {

    public ExprContinue c1;

    public ExprContinueSupportChild(ExprContinue c1) {
        this.c1 = c1;
    }

    @Override
    public void print() {
        System.out.println("new ExprContinueSupportChild ( ");
            c1.print();
        System.out.println(" )");
    }
}
