package oo1_e27;

public class B extends A {

    @Override
    public String m1() {
        return "B.m1 -> " + this.m2();
    }

    @Override
    public String m2() {
        return "B.m2 -> " + super.m2();
    }

    @Override
    public String m3() {
        return "B.m3 -> " + super.m3() + " -> " + this.m2();
    }

}