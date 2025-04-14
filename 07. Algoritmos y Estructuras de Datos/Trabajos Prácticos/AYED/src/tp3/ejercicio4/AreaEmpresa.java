package tp3.ejercicio4;

public class AreaEmpresa {

    private String id;
    private int tardanza;

    public AreaEmpresa(String id, int tardanza) {
        this.id=id;
        this.tardanza=tardanza;
    }

    public void setId(String id) {
        this.id=id;
    }

    public void setTardanza(int tardanza) {
        this.tardanza=tardanza;
    }

    public String getId() {
        return id;
    }

    public int getTardanza() {
        return tardanza;
    }

}