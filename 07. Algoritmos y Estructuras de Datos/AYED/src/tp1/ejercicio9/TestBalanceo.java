package tp1.ejercicio9;

import java.util.*;

public class TestBalanceo {

    public static boolean esBalanceado(String S) {

        boolean ok=true;

        List<Character> cierre=new LinkedList();
        cierre.add(')');
        cierre.add(']');
        cierre.add('}');

        if ((S.length()%2!=0) || (S.length()>0 && cierre.contains(S.charAt(0))))
            ok=false;

        else {

            List<Character> apertura=new LinkedList();
            apertura.add('(');
            apertura.add('[');
            apertura.add('{');

            Stack<Character> pila=new Stack();
            Character actual, elemAper;

            int i=0;
            while ((i<S.length()) && (ok)) {
                actual=S.charAt(i);
                if (apertura.contains(actual))
                    pila.push(actual);
                else {
                    if (!pila.isEmpty()) {
                        elemAper=pila.pop();
                        if (apertura.indexOf(elemAper)!=cierre.indexOf(actual))
                            ok=false;
                    }
                }
                i++;
            }
            if (!pila.isEmpty())
                ok=false;

        }

        return ok;

    }

}