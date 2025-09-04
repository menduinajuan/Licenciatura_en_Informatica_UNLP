# Trabajo Práctico N° 1 - Ejercicio 1

```mermaid
erDiagram
    CLIENTE {
        int DNI PK
        string Apellido
        string Nombre
        string CUIL
        string Telefono
        string Email
        string Calle
        int Numero
        int Piso "0..1"
        string Departamento "0..1"
    }

    COMPRA {
        int NroComprobante PK
        date Fecha
        float MontoTotal
        string MedioPago
    }

    CLIENTE ||--|{ COMPRA : realiza