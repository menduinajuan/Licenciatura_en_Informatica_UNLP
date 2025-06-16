package tp5.ejercicio5;

public class Persona {

    private String tipo;
    private String nombre;
    private String domicilio;
    private boolean cobro;

    public Persona(String tipo, String nombre, String domicilio, boolean cobro) {
        this.tipo=tipo;
        this.nombre=nombre;
        this.domicilio=domicilio;
        this.cobro=cobro;
    }

    public void setTipo(String tipo) {
        this.tipo=tipo;
    }

    public void setNombre(String nombre) {
        this.nombre=nombre;
    }

    public void setDomicilio(String domicilio) {
        this.domicilio=domicilio;
    }

    public void setCobro(boolean cobro) {
        this.cobro=cobro;
    }

    public String getTipo() {
        return tipo;
    }

    public String getNombre() {
        return nombre;
    }

    public String getDomicilio() {
        return domicilio;
    }

    public boolean isCobro() {
        return cobro;
    }

    public boolean cumple() {
        return tipo.equals("Jubilado") && !cobro;
    }

    @Override
    public String toString() {
        return nombre;
    }

}