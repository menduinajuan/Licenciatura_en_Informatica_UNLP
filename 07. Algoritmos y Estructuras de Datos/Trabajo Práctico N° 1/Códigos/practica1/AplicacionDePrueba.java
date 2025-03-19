package practica1;

public class AplicacionDePrueba {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		
         Alumno[] arrAlumnos = new Alumno[100];
         
         // creo 2 alumnos
         
         arrAlumnos[0] = new Alumno();
         arrAlumnos[1] = new Alumno();
         
         // les asigno los datos personales
         arrAlumnos[0].setLegajo(new String("45896/8"));
         arrAlumnos[0].setDni(23654645);
         arrAlumnos[0].setApellido(new String("Gonzalez"));
         arrAlumnos[0].setNombre(new String("Jacinto"));         
         arrAlumnos[0].setEmail(new String("jaci_g@homail.com"));
         
         arrAlumnos[1].setLegajo(new String("35516/0"));
         arrAlumnos[1].setDni(29654879);
         arrAlumnos[1].setApellido(new String("Pereyra"));
         arrAlumnos[1].setNombre(new String("Felipe"));
         arrAlumnos[1].setEmail(new String("feli_p_p@homail.com"));
         
         if (args.length  == 0){
        	 System.out.println("El programa se ejecutó sin parametros");
        	 }
         else if (args.length == 1) {
        	 System.out.print("Datos del alumno en la posicion: ");
        	 System.out.println(Integer.parseInt(args[0]));
        	 System.out.println("----------------------------------");
        	 System.out.println(arrAlumnos[Integer.parseInt(args[0])].getLegajo());
        	 System.out.println(arrAlumnos[Integer.parseInt(args[0])].getDni());
        	 System.out.println(arrAlumnos[Integer.parseInt(args[0])].getApellido());
        	 System.out.println(arrAlumnos[Integer.parseInt(args[0])].getNombre());
        	 System.out.println(arrAlumnos[Integer.parseInt(args[0])].getEmail());
        	 }
	}

}
