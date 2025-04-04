package tp1.ejercicio3;

public abstract class Persona {

    private String nombre;
    private String apellido;
    private String email;

    public Persona(String nombre, String apellido, String email) {
        this.nombre=nombre;
        this.apellido=apellido;
        this.email=email;
    }

    public void setNombre(String nombre) {
        this.nombre=nombre;
    }

    public void setApellido(String apellido) {
        this.apellido=apellido;
    }

    public void setEmail(String email) {
        this.email=email;
    }

    public String getNombre() {
        return nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public String getEmail() {
        return email;
    }

    public String tusDatos() {
        return "Nombre: " + getNombre() + "; Apellido: " + getApellido() + "; Email: " + getEmail();
    }

}