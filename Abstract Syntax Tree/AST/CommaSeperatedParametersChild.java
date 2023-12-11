package AST;

public class CommaSeperatedParametersChild extends CommaSeperatedParameters {

    public Parameter c1;
    public CommaSeperatedParameters c2;

    public CommaSeperatedParametersChild(Parameter c1, CommaSeperatedParameters c2) {
        this.c1 = c1;
        this.c2 = c2;
    }

    @Override
    public void print() {
        System.out.println("new CommaSeperatedParametersChild ( ");
            c1.print();
        System.out.println(", ");
        if (c2 != null)
            c2.print();
        System.out.println(" )");
    }
}
