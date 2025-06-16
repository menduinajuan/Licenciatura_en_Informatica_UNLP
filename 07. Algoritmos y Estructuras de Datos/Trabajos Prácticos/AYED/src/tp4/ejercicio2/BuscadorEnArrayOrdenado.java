package tp4.ejercicio2;

public class BuscadorEnArrayOrdenado {

    private static class Resultado {

        private String descripcion;
        private long iteraciones;
        private long tiempo;

        public Resultado(String descripcion, long iteraciones, long tiempo) {
            this.descripcion=descripcion;
            this.iteraciones=iteraciones;
            this.tiempo=tiempo;
        }

        @Override
        public String toString() {
            return String.format("Resultado [descripcion=%s, iteraciones=%d, tiempo=%.3f]", descripcion, iteraciones, tiempo/1000.0);
        }

    }

    private static int[] initArrayOrdenado(int tamanio) {
        int[] datos=new int[tamanio];
        for (int i=0; i<tamanio; i++)
            datos[i]=i;
        return datos;
    }

    public static Resultado buscarlineal(String desc, int[] datos, int valor) {
        int bajo=0;
        int alto=datos.length;
        int iter=0;
        boolean encontre=false;
        long initTime=System.currentTimeMillis();
        while ((bajo<alto) && (!encontre)) {
            iter++;
            if (datos[bajo++]==valor)
                encontre=true;
        }
        long finTime=System.currentTimeMillis();
        return new Resultado(desc, iter, finTime-initTime);
    }

    public static Resultado buscarDicotomico(String desc, int[] datos, int valor) {
        int bajo=0;
        int alto=datos.length;
        int iter=0;
        boolean encontre=false;
        long initTime=System.currentTimeMillis();
        while ((bajo<alto) && (!encontre)) {
            iter++;
            int mid=(bajo+alto)/2;
            if (datos[mid]<valor)
                bajo=mid+1;
            else if (datos[mid]>valor)
                alto=mid-1;
            else
                encontre=true;
        }
        long finTime=System.currentTimeMillis();
        return new Resultado(desc, iter, finTime-initTime);
    }

    public static void main(String[] args) {
        int[] datos;
        int cantidadElementos=100000;
        datos=initArrayOrdenado(cantidadElementos);
        Resultado res=buscarlineal("Búsqueda lineal valor:" + cantidadElementos, datos, cantidadElementos);
        System.out.println(res);
        res=buscarDicotomico("Búsqueda dicotomica valor:" + cantidadElementos, datos, cantidadElementos);
        System.out.println(res);
    }

}