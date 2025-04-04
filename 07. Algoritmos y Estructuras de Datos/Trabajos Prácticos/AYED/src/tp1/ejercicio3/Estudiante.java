package tp1.ejercicio3;

public class Estudiante extends Persona {

    private int comision;
    private String direccion;

    public Estudiante(String nombre, String apellido, String email, int comision, String direccion) {
        super(nombre, apellido, email);
        this.comision=comision;
        this.direccion=direccion;
    }

    public void setComision(int comision) {
        this.comision=comision;
    }

    public void setDireccion(String direccion) {
        this.direccion=direccion;
    }

    public int getComision() {
        return comision;
    }

    public String getDireccion() {
        return direccion;
    }

    @Override
    public String tusDatos() {
        return "ESTUDIANTE: " + super.tusDatos() + "; Comisión: " + getComision() + "; Dirección: " + getDireccion();
    }

}