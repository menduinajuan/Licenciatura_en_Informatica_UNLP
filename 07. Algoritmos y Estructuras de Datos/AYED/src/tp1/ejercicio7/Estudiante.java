package tp1.ejercicio7;

public class Estudiante {

    private String nombre;
    private String apellido;
    private String email;

    public Estudiante(String nombre, String apellido, String email) {
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
        return "ESTUDIANTE: " + "Nombre: " + getNombre() + "; Apellido: " + getApellido() + "; Email: " + getEmail();
    }

    @Override
    public boolean equals(Object o){
        boolean result=false;
        if ((o!=null) && (o instanceof Estudiante)) {
            Estudiante e=(Estudiante) o;
            if ((e.getNombre()==this.getNombre()) && (e.getApellido()==this.getApellido()) && (e.getEmail()==this.getEmail()))
                result=true;
        }
        return result;
    }

}