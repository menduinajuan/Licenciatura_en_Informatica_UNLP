package tp3.ejercicio1;

import java.util.*;
import tp1.ejercicio8.Queue;

public class GeneralTree<T> {

    private T data;
    private List<GeneralTree<T>> children=new LinkedList<GeneralTree<T>>();

    public GeneralTree() {
        
    }

    public GeneralTree(T data) {
        this.data=data;
    }

    public GeneralTree(T data, List<GeneralTree<T>> children) {
        this.data=data;
        this.children=children;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data=data;
    }

    public List<GeneralTree<T>> getChildren() {
        return children;
    }

    public void setChildren(List<GeneralTree<T>> children) {
        if (children!=null)
            this.children=children;
    }

    public void addChild(GeneralTree<T> child) {
        this.getChildren().add(child);
    }

    public boolean isLeaf() {
        return !this.hasChildren();
    }

    public boolean hasChildren() {
        return !this.children.isEmpty();
    }

    public boolean isEmpty(){
        return this.isLeaf() && this.getData()==null;
    }

    public void removeChild(GeneralTree<T> child) {
        if (this.hasChildren())
            children.remove(child);
    }

    public int altura() {
        return !this.isEmpty() ? alturaHelper() : -1;
    }

    private int alturaHelper() {
        if (this.isLeaf()) return 0;
        int alturaMax=-1;
        for (GeneralTree<T> child: this.getChildren())
            alturaMax=Math.max(alturaMax, child.alturaHelper());
        return alturaMax+1;
    }

    public int nivel(T dato) {
        return !this.isEmpty() ? nivelHelper(dato) : -1;
    }

    private int nivelHelper(T dato) {
        int nivel=0; int sizeActual;
        GeneralTree<T> ag;
        Queue<GeneralTree<T>> cola=new Queue<>();
        cola.enqueue(this);
        while (!cola.isEmpty()) {
            sizeActual=cola.size();
            for (int i=0; i<sizeActual; i++) {
                ag=cola.dequeue();
                if (ag.getData().equals(dato))
                    return nivel;
                for (GeneralTree<T> child: ag.getChildren())
                    cola.enqueue(child);
            }
            nivel++;
        }
        return -1;
    }

    public int ancho() {
        if (this.isEmpty()) return -1;
        return !this.isLeaf() ? anchoHelper() : 1;
    }

    private int anchoHelper() {
        int nodosActual=0, nodosMax=0;
        GeneralTree<T> ag;
        Queue<GeneralTree<T>> cola=new Queue<>();
        cola.enqueue(this);
        cola.enqueue(null);
        while (!cola.isEmpty()) {
            ag=cola.dequeue();
            if (ag!=null)
                for (GeneralTree<T> child: ag.getChildren()) {
                    cola.enqueue(child);
                    nodosActual++;
                }
            else if (!cola.isEmpty()) {
                nodosMax=Math.max(nodosMax, nodosActual);
                nodosActual=0;
                cola.enqueue(null);
            }
        }
        return nodosMax;
    }

    public List<Integer> numerosImparesMayoresQuePreOrden(Integer n) {
        List<Integer> lista=new LinkedList<>();
        if (!this.isEmpty()) numerosImparesMayoresQuePreOrden(n, lista);
        return lista;
    }

    private void numerosImparesMayoresQuePreOrden(Integer n, List<Integer> lista) {
        int dato=(Integer) this.getData();
        if ((dato%2!=0) && (dato>n)) lista.add(dato);
        for (GeneralTree<T> child: this.getChildren())
            child.numerosImparesMayoresQuePreOrden(n, lista);
    }

    public List<Integer> numerosImparesMayoresQueInOrden(Integer n) {
        List<Integer> lista=new LinkedList<>();
        if (!this.isEmpty()) numerosImparesMayoresQueInOrden(n, lista);
        return lista;
    }

    private void numerosImparesMayoresQueInOrden(Integer n, List<Integer> lista) {
        List<GeneralTree<T>> children=this.getChildren();
        if (this.hasChildren()) children.get(0).numerosImparesMayoresQueInOrden(n, lista);
        int dato=(Integer) this.getData();
        if ((dato%2!=0) && (dato>n)) lista.add(dato);
        for (int i=1; i<children.size(); i++)
            children.get(i).numerosImparesMayoresQueInOrden(n, lista);
    }

    public List<Integer> numerosImparesMayoresQuePostOrden(Integer n) {
        List<Integer> lista=new LinkedList<>();
        if (!this.isEmpty()) numerosImparesMayoresQuePostOrden(n, lista);
        return lista;
    }

    private void numerosImparesMayoresQuePostOrden(Integer n, List<Integer> lista) {
        for (GeneralTree<T> child: this.getChildren())
            child.numerosImparesMayoresQuePostOrden(n, lista);
        int dato=(Integer) this.getData();
        if ((dato%2!=0) && (dato>n)) lista.add(dato);
    }

    public List<Integer> numerosImparesMayoresQuePorNiveles(Integer n) {
        GeneralTree<T> ag;
        Queue<GeneralTree<T>> cola=new Queue<>();
        List<Integer> lista=new LinkedList<>();
        cola.enqueue(this);
        while (!cola.isEmpty()) {
            ag=cola.dequeue();
            if (!ag.isEmpty()) {
                int dato=(Integer) ag.getData();
                if ((dato%2!=0) && (dato>n)) lista.add(dato);
            }
            for (GeneralTree<T> child: ag.getChildren())
                cola.enqueue(child);
        }
        return lista;
    }

    public boolean esAncestro(T a, T b) {
        if (this.isEmpty()) return false;
        return esAncestroHelper1(a, b);
    }

    private boolean esAncestroHelper1(T a, T b) {
        boolean ok=false;
        GeneralTree<T> ag;
        GeneralTree<T> nodo=null;
        Queue<GeneralTree<T>> cola=new Queue<>();
        cola.enqueue(this);
        while ((!cola.isEmpty()) && (!ok)) {
            ag=cola.dequeue();
            if (ag.getData().equals(b) && (!ok)) return false;
            if (ag.getData().equals(a)) {
                ok=true;
                nodo=ag;
            }
            if (!ok)
                for (GeneralTree<T> child: ag.getChildren())
                    cola.enqueue(child);
        }
        return ok ? esAncestroHelper2(nodo, b) : ok;
    }

    private boolean esAncestroHelper2(GeneralTree<T> nodo, T b) {
        GeneralTree<T> ag;
        Queue<GeneralTree<T>> cola=new Queue<>();
        cola.enqueue(nodo);
        while (!cola.isEmpty()) {
            ag=cola.dequeue();
            if (ag.getData().equals(b))
                return true;
            for (GeneralTree<T> child: ag.getChildren())
                cola.enqueue(child);
        }
        return false;
    }

}