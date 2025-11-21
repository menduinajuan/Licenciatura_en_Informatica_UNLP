package oo1_e27;

public class A {

    public String m1() {
        return "A.m1 -> " + this.m2();
    }

    public String m2() {
        return "A.m2";
    }

    public String m3() {
        return "A.m3 -> " + this.m2();
    }

}