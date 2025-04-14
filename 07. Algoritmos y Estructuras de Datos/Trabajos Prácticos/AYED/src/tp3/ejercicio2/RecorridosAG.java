package tp3.ejercicio2;

import java.util.*;
import tp1.ejercicio8.Queue;
import tp3.ejercicio1.GeneralTree;

public class RecorridosAG {

    public List<Integer> numerosImparesMayoresQuePreOrden(GeneralTree<Integer> a, Integer n) {
        List<Integer> lista=new LinkedList<>();
        if ((a!=null) && (!a.isEmpty())) numerosImparesMayoresQuePreOrden(a, n, lista);
        return lista;
    }
    
    private void numerosImparesMayoresQuePreOrden(GeneralTree<Integer> a, Integer n, List<Integer> lista) {
        int dato=a.getData();
        if ((dato%2!=0) && (dato>n)) lista.add(dato);
        for (GeneralTree<Integer> child: a.getChildren())
            numerosImparesMayoresQuePreOrden(child, n, lista);
    }

    public List<Integer> numerosImparesMayoresQueInOrden(GeneralTree<Integer> a, Integer n) {
        List<Integer> lista=new LinkedList<>();
        if ((a!=null) && (!a.isEmpty())) numerosImparesMayoresQueInOrden(a, n, lista);
        return lista;
    }

    private void numerosImparesMayoresQueInOrden(GeneralTree<Integer> a, Integer n, List<Integer> lista) {
        List<GeneralTree<Integer>> children=a.getChildren();
        if (a.hasChildren()) numerosImparesMayoresQueInOrden(children.get(0), n, lista);
        int dato=a.getData();
        if ((dato%2!=0) && (dato>n)) lista.add(dato);
        for (int i=1; i<children.size(); i++)
            numerosImparesMayoresQueInOrden(children.get(i), n, lista);
    }

    public List<Integer> numerosImparesMayoresQuePostOrden(GeneralTree<Integer> a, Integer n) {
        List<Integer> lista=new LinkedList<>();
        if ((a!=null) && (!a.isEmpty())) numerosImparesMayoresQuePostOrden(a, n, lista);
        return lista;
    }

    private void numerosImparesMayoresQuePostOrden(GeneralTree<Integer> a, Integer n, List<Integer> lista) {
        for (GeneralTree<Integer> child: a.getChildren())
            numerosImparesMayoresQuePostOrden(child, n, lista);
        int dato=a.getData();
        if ((dato%2!=0) && (dato>n)) lista.add(dato);
    }

    public List<Integer> numerosImparesMayoresQuePorNiveles(GeneralTree<Integer> a, Integer n) {
        GeneralTree<Integer> ag;
        Queue<GeneralTree<Integer>> cola=new Queue<>();
        List<Integer> lista=new LinkedList<>();
        cola.enqueue(a);
        while (!cola.isEmpty()) {
            ag=cola.dequeue();
            if (!ag.isEmpty()) {
                int dato=ag.getData();
                if ((dato%2!=0) && (dato>n)) lista.add(dato);
            }
            for (GeneralTree<Integer> child: ag.getChildren())
                cola.enqueue(child);
        }
        return lista;
    }

}