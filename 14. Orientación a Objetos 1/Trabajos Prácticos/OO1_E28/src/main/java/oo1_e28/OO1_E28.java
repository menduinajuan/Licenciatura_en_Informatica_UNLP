package oo1_e28;

public class OO1_E28 {

    public static void main(String[] args) {

        // INCISO (a)

        A objeto1=new C();
        objeto1.mensajeInterface();

        A objeto2=new E();
        objeto2.mensajeInterface();

        // INCISO (b)

        B objeto3=new C();
        objeto3.mensajeAbstracto();

        B objeto4=new D();
        objeto4.mensajeAbstracto();

        B objeto5=new E();
        objeto5.mensajeAbstracto();

        // INCISO (c)

        D objeto6=new D();
        objeto6.mensajeAbstracto();
        objeto6.mensajeParticular();

        D objeto7=new E();
        objeto7.mensajeAbstracto();
        objeto7.mensajeParticular();

        // INCISO (d)

        C objeto8=new C();
        objeto8.mensajeAbstracto();
        objeto8.mensajeInterface();

        // INCISO (e)

        B objeto9=new C();
        objeto9.mensajeAbstracto();

        C objeto10=new C();
        objeto10.mensajeAbstracto();

        // INCISO (f)

        A objeto11=new C();
        objeto11.mensajeInterface();

        C objeto12=new C();
        objeto12.mensajeInterface();

    }

}