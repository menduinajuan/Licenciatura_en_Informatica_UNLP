package ejercicio2;

public class Balanza {
	private int cantidadDeProductos;
	private double precioTotal;
	private double pesoTotal;

	public void ponerEnCero() {
		this.cantidadDeProductos = 0;
		this.precioTotal = 0;
		this.pesoTotal = 0;
	}

	public void agregarProducto(Producto p) {
		this.cantidadDeProductos++;
		this.precioTotal += p.getPrecio();
		this.pesoTotal += p.getPeso();
	}

	public Ticket emitirTicket() {
		Ticket tick = new Ticket(this.cantidadDeProductos, this.pesoTotal, this.precioTotal);
		return tick;
	}

	public double getPesoTotal() {
		return this.pesoTotal;
	}

	public double getPrecioTotal() {
		return this.precioTotal;
	}

	public int getCantidadDeProductos() {
		return this.cantidadDeProductos;
	}

}
