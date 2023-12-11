package AST;

public class CaseAssignChild extends CaseAssign {

    public Expr c1;
    public CaseAssignSupport c2;

    public CaseAssignChild(Expr c1, CaseAssignSupport c2) {
        this.c1 = c1;
        this.c2 = c2;
    }

    @Override
    public void print() {
        System.out.print("new CaseAssignChild ( ");
            c1.print();
        System.out.print(", ");
        if (c2 != null)
            c2.print();
        System.out.println(" )");
    }
}
