-- List schemes

SELECT * FROM sys.schemas;
GO

/*

The error "CREATE SCHEMA' must be the only statement in the batch" occurs in SQL Server (T-SQL) because certain Data 
Definition Language (DDL) statements, including CREATE SCHEMA, must be compiled and executed in their own separate batch. 

Solution: ensure the CREATE SCHEMA statement is isolated
*/

-- Create Schemes

CREATE SCHEMA Mono;
GO

tb_rol:

id_rol
rol

tb_libro_tesoreria

id_libro_tesoreria
numero_documento (string) 
acta (string)
saldo (decimal)
mes_actual (date)
tipo_ingreso (fk)
id_clasificacion_transaccion (fk)
id_tipo_gasto (fk)
id_factura_electronica (fk)
id_tipo_ingreso (fk)
id_clasificacion_gasto (fk)

-- Auditar los movimientos que se hacen entre el libro y el wallet
tb_transaccion
id_transaccion
id_billetera
tipo_ingreso (fk hacia id_tipo_ingreso)
saldo (fk hacia id_libro_tesoreria)
gestion -- Este es el dinero que se esta manipulando
fecha_creacion

billetera
id_billetera
saldo_actual

-- Sirve para ingreso, egreso, retorno (aqui abarca el requerimiento de "el wallet debe quedar en 0", creando un Job que cada mes devuelva a la tabla principal PERO me va auditar el retorno)
tb_tipo_ingreso
id_tipo_ingreso
tipo_ingreso

-- Esto son los tags
tb_tipo_ingreso
id_tipo_ingreso
tipo_ingreso

tb_factura_electronica
id_factura_electronica (pk)
factura_electronica

tb_tipo_gasto
id_tipo_gasto
tipo_gasto 

tb_clasificacion_gasto
id_clasificacion_gasto
clasificacion_gasto

tb_clasificacion_transaccion
id_clasificacion_transaccion 
clasificacion

Libro contable de gastos en efectivo misma funcionalidad del libro mayor (Wallet)

Esta wallet a final de mes debe de cerrar en 0.

Modificable solo por admin & Tesoreria.

Entidad de provedor / cliente, esto esta relacionado a los ingresos e egresos del libro contable.

El que es cliente puede ser provedor, y el que es provedor puede ser cliente. Cuando yo creo un ingreso, no me limite registrar al usuario on behalf de esa transacción solo como cliente o provedor si no que pueden ser ambas. 

Actualizacion del Padron

Apellidos, nombre, cedula, acta de inscripcion, fecha, estado, Contacto telefono, direccion y correo,


Tabla de asistencia (Como Colegio)

fk del padron, donde obtenemos a ese usuario y lo relacionamos al registro.

Mas de 3 ausencias a un miembro del padron lo desactiva el sistema.

Actas de sistema: Registro de meetings.

titulo
fecha
persona que lo escribió (este usuario no tiene relación hacia ningún lado)
descripción
estado

Visualizar reservas del salon, la idea es que la junta directiva que calibre con el sr que lo cuida de cual es la disponibilidad. 

Quien lo alquilo
evento
horas 
detalle

Justificación del gasto: 50 mil colones en servicio de mantenimiento.

