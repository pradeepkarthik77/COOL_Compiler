package AST;

public class ChildFeatureList extends FeatureList implements ASTNode {

    public Feature c1;
    public FeatureList c2;

    public ChildFeatureList(Feature c1, FeatureList c2) {
        this.c1 = c1;
        this.c2 = c2;
    }

    @Override
    public void print() {
        System.out.print("new ChildFeatureList ( ");
            c1.print();
        System.out.print(", ");
        if (c2 != null)
            c2.print();
        System.out.println(" )");
    }
}
