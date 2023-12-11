package AST;

public class ChildClassDefine extends ClassDefine implements ASTNode {

    public ClassList c1;

    public ChildClassDefine(ClassList c1) {
        this.c1 = c1;
    }

    @Override
    public void print() {
        System.out.print("new ChildClassDefine ( ");
            c1.print();
        System.out.println(" )");
    }
}
