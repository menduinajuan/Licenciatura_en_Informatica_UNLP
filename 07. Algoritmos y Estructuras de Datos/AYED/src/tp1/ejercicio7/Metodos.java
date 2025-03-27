package tp1.ejercicio7;

import java.util.*;

public class Metodos {

    public static void imprimirLista1nteger1(List<Integer> lista) {
        for (int i: lista)
            System.out.print(i + " ");
    }

    public static void imprimirLista1nteger2(List<Integer> lista) {
        for (int i=0; i<lista.size(); i++)
            System.out.print(lista.get(i) + " ");
    }

    public static void imprimirLista1nteger3(List<Integer> lista) {
        Iterator<Integer> it=lista.iterator();
        while (it.hasNext()) 
            System.out.print(it.next() + " ");
    }

    public static void imprimirLista1nteger4(List<Integer> lista) {
        Iterator it=lista.iterator();
        while (it.hasNext()) 
            System.out.print(((Integer)it.next()) + " ");
    }

    public static void cargarListaEstudiantes(List<Estudiante> lista) {

        lista.add(new Estudiante("Juan", "Menduiña", "e1@gmail.com"));
        lista.add(new Estudiante("Demian", "Panigo", "e2@gmail.com"));
        lista.add(new Estudiante("Matías", "Guaymás", "e3@gmail.com"));

        List<Estudiante> lista2=new LinkedList<>(lista);
        // List<Estudiante> lista2=new LinkedList<>();
        // lista2.addAll(lista);

        System.out.println("\n\nESTUDIANTES DE LA LISTA 1 (original):");
        imprimirListaEstudiantes(lista);

        System.out.println("\nESTUDIANTES DE LA LISTA 2 (original):");
        imprimirListaEstudiantes(lista2);

        lista.get(0).setNombre(lista.get(2).getNombre());
        lista.get(2).setNombre(lista.get(0).getNombre());

        System.out.println("\nESTUDIANTES DE LA LISTA 1 (modificada):");
        imprimirListaEstudiantes(lista);

        System.out.println("\nESTUDIANTES DE LA LISTA 2 (modificada):");
        imprimirListaEstudiantes(lista2);

    }

    public static void imprimirListaEstudiantes(List<Estudiante> lista) {
        for (Estudiante e: lista)
            System.out.println(e.tusDatos());
    }

    public static void agregarAListaEstudiantes(List<Estudiante> lista, Estudiante... estudiantes) {
        for (Estudiante e: estudiantes)
            if (!lista.contains(e))
                lista.add(e);
    }

    public static boolean esCapicua(ArrayList<Integer> lista) {
        int n=lista.size();
        for (int i=0; i<n/2; i++)
            if (!lista.get(i).equals(lista.get(n-1-i)))
                return false;
        return true;
    }

    public static List<Integer> calcularSucesion(int n) {
        List<Integer> lista=new ArrayList<>();
        calcular(lista,n);
        return lista;
    }

    private static void calcular(List<Integer> lista, int n) {
        lista.add(n);
        if (n==1)
            return;
        if (n%2==0)
            calcular(lista,n/2);
        else
            calcular(lista,3*n+1);
    }

    public static void invertirArrayList(ArrayList<Integer> lista) {
        if (lista.size()<=1) 
            return;
        Integer first=lista.remove(0);
        invertirArrayList(lista);
        lista.add(first);
    }

    public static int sumarLinkedList(LinkedList<Integer> lista) {
        if (lista.isEmpty())
            return 0;
        return lista.removeFirst() + sumarLinkedList(lista);
    }

    public static ArrayList<Integer> combinarOrdenado(ArrayList<Integer> lista1, ArrayList<Integer> lista2) {
        ArrayList<Integer> lista=new ArrayList<>();
        int i=0;
        int j=0;
        while ((i<lista1.size()) && (j<lista2.size()))
            if (lista1.get(i)<=lista2.get(j))
                lista.add(lista1.get(i++));
            else
                lista.add(lista2.get(j++));
        while (i<lista1.size())
            lista.add(lista1.get(i++));
        while (j<lista2.size())
            lista.add(lista2.get(j++));
        return lista;
    }

}