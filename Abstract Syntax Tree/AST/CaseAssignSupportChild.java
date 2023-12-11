package AST;

public class CaseAssignSupportChild extends CaseAssignSupport {

    public CaseAssign c1;

    public CaseAssignSupportChild(CaseAssign c1) {
        this.c1 = c1;
    }

    @Override
    public void print() {
        System.out.println("new CaseAssignSupportChild ( ");
            c1.print();
        System.out.println(" )");
    }
}
