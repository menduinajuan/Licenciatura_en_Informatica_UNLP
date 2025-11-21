package oo1_e8;

import java.time.LocalDate;

public class Mamifero {

    private String identificador;
    private String especie;
    private LocalDate fechaNacimiento;
    private Mamifero padre;
    private Mamifero madre;

    public Mamifero() {
        
    }

    public Mamifero(String identificador) {
        this.identificador=identificador;
    }

    public String getIdentificador() {
        return identificador;
    }

    public void setIdentificador(String identificador) {
        this.identificador=identificador;
    }

    public String getEspecie() {
        return especie;
    }

    public void setEspecie(String especie) {
        this.especie=especie;
    }

    public LocalDate getFechaNacimiento() {
        return fechaNacimiento;
    }

    public void setFechaNacimiento(LocalDate fechaNacimiento) {
        this.fechaNacimiento=fechaNacimiento;
    }

    public Mamifero getPadre() {
        return padre;
    }

    public void setPadre(Mamifero padre) {
        this.padre=padre;
    }

    public Mamifero getMadre() {
        return madre;
    }

    public void setMadre(Mamifero madre) {
        this.madre=madre;
    }

    public Mamifero getAbueloPaterno() {
        return (this.getPadre()!=null && this.getPadre().getPadre()!=null) ? this.getPadre().getPadre() : null;
    }

    public Mamifero getAbuelaPaterna() {
        return (this.getPadre()!=null && this.getPadre().getMadre()!=null) ? this.getPadre().getMadre() : null;
    }

    public Mamifero getAbueloMaterno() {
        return (this.getMadre()!=null && this.getMadre().getPadre()!=null) ? this.getMadre().getPadre() : null;
    }

    public Mamifero getAbuelaMaterna() {
        return (this.getMadre()!=null && this.getMadre().getMadre()!=null) ? this.getMadre().getMadre() : null;
    }

    public boolean tieneComoAncestroA(Mamifero unMamifero) {
        return (this.getPadre()==unMamifero || this.getMadre()==unMamifero) ||
               (this.getPadre()!=null && this.getPadre().tieneComoAncestroA(unMamifero)) ||
               (this.getMadre()!=null && this.getMadre().tieneComoAncestroA(unMamifero));
    }

}