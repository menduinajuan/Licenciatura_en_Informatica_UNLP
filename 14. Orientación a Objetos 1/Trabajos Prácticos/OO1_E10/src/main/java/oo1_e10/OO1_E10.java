package oo1_e10;

public class OO1_E10 {

    public static void main(String[] args) {

        Gerente alan1=new Gerente("Alan Turing");
        double aportesDeAlan=alan1.aportes();

        Gerente alan2=new Gerente("Alan Turing");
        double sueldoBasicoDeAlan=alan2.sueldoBasico();

        System.out.println("aportesDeAlan = $" + aportesDeAlan);
        System.out.println("sueldoBasicoDeAlan = $" + sueldoBasicoDeAlan);

    }

}