package oo1_e27;

public class C extends B {

    @Override
    public String m1() {
        return "C.m1 -> " + super.m1();
    }

    @Override
    public String m2() {
        return "C.m2";
    }

    @Override
    public String m3() {
        return super.m3() + " -> C.m3()";
    }

}