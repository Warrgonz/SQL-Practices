-- =========================
-- DATABASE: LibroContable
-- =========================

CREATE DATABASE LibroContable;
GO

USE LibroContable;
GO

-- =========================
-- ROLES
-- =========================
CREATE TABLE tb_rol (
    id_rol INT IDENTITY(1,1) PRIMARY KEY,
    rol VARCHAR(50) NOT NULL
);

-- =========================
-- SEEDERS
-- =========================
CREATE TABLE tb_tipo_ingreso (
    id_tipo_ingreso INT IDENTITY(1,1) PRIMARY KEY,
    tipo_ingreso VARCHAR(50) NOT NULL
);

-- Nacional / Extrangera o DIMEX
CREATE TABLE tb_tipo_cedula (
    id_tipo_cedula INT IDENTITY(1,1) PRIMARY KEY,
    tipo_cedula VARCHAR(50) NOT NULL
);

CREATE TABLE tb_tipo_gasto (
    id_tipo_gasto INT IDENTITY(1,1) PRIMARY KEY,
    tipo_gasto VARCHAR(50) NOT NULL
);

CREATE TABLE tb_clasificacion_gasto (
    id_clasificacion_gasto INT IDENTITY(1,1) PRIMARY KEY,
    clasificacion_gasto VARCHAR(50) NOT NULL
);

CREATE TABLE tb_clasificacion_transaccion (
    id_clasificacion_transaccion INT IDENTITY(1,1) PRIMARY KEY,
    clasificacion VARCHAR(50) NOT NULL
);

-- =========================
-- PADRON
-- =========================
CREATE TABLE tb_padron (
    id_padron INT IDENTITY(1,1) PRIMARY KEY,
	nombre VARCHAR(100) NOT NULL,
    primer_apellido VARCHAR(100) NOT NULL,
	segundo_apellido VARCHAR(100) NOT NULL,
    identificacion VARCHAR(100) NOT NULL UNIQUE,
	id_tipo_cedula INT not null,
    fecha_inscripcion DATE NOT NULL DEFAULT GETDATE(),
    telefono VARCHAR(30) NOT NULL,
    direccion VARCHAR(250) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    id_rol INT NOT NULL,
    CONSTRAINT fk_padron_rol 
      FOREIGN KEY (id_rol) REFERENCES tb_rol(id_rol),
	CONSTRAINT fk_tipo_cedula 
      FOREIGN KEY (id_tipo_cedula) REFERENCES tb_tipo_cedula(id_tipo_cedula)
);

-- =========================
-- ASISTENCIA
-- =========================
CREATE TABLE tb_asistencia (
    id_asistencia INT IDENTITY(1,1) PRIMARY KEY,
    id_padron INT NOT NULL,
    fecha DATE NOT NULL DEFAULT GETDATE(),
    asistio BIT NOT NULL,
    CONSTRAINT fk_asistencia_padron 
        FOREIGN KEY (id_padron) REFERENCES tb_padron(id_padron)
);

-- =========================
-- RESERVAS DEL SALON
-- =========================
CREATE TABLE tb_reserva_salon (
    id_reserva INT IDENTITY(1,1) PRIMARY KEY,
    id_padron INT NOT NULL,
    evento VARCHAR(150) NOT NULL,
    horas INT NOT NULL,
    detalle VARCHAR(MAX),
    CONSTRAINT fk_reserva_padron 
        FOREIGN KEY (id_padron) REFERENCES tb_padron(id_padron)
);

-- =========================
-- FACTURA ELECTRONICA
-- =========================
CREATE TABLE tb_factura_electronica (
    id_factura_electronica INT IDENTITY(1,1) PRIMARY KEY,
    factura_electronica VARCHAR(MAX) NOT NULL
);


-- =========================
-- LIBRO TESORERIA
-- =========================
CREATE TABLE tb_libro_tesoreria (
    id_libro_tesoreria INT IDENTITY(1,1) PRIMARY KEY,
    numero_documento VARCHAR(50) NOT NULL,
    acta VARCHAR(100),
    saldo DECIMAL(18,2) NOT NULL,
    mes_actual DATE NOT NULL,
    justificacion_gasto VARCHAR(MAX) NULL,
    id_tipo_ingreso INT NOT NULL,
    id_clasificacion_transaccion INT NOT NULL,
    id_tipo_gasto INT NULL,
    id_factura_electronica INT NULL,
    id_clasificacion_gasto INT NULL,
    id_padron INT NOT NULL,
    CONSTRAINT fk_libro_padron 
        FOREIGN KEY (id_padron) REFERENCES tb_padron(id_padron),
    CONSTRAINT fk_libro_tipo_ingreso 
        FOREIGN KEY (id_tipo_ingreso) REFERENCES tb_tipo_ingreso(id_tipo_ingreso),
    CONSTRAINT fk_libro_clas_trans 
        FOREIGN KEY (id_clasificacion_transaccion) REFERENCES tb_clasificacion_transaccion(id_clasificacion_transaccion),
    CONSTRAINT fk_libro_tipo_gasto 
        FOREIGN KEY (id_tipo_gasto) REFERENCES tb_tipo_gasto(id_tipo_gasto),
    CONSTRAINT fk_libro_factura 
        FOREIGN KEY (id_factura_electronica) REFERENCES tb_factura_electronica(id_factura_electronica),
    CONSTRAINT fk_libro_clas_gasto 
        FOREIGN KEY (id_clasificacion_gasto) REFERENCES tb_clasificacion_gasto(id_clasificacion_gasto)
);

-- =========================
-- BILLETERA
-- =========================
CREATE TABLE tb_billetera (
    id_billetera INT IDENTITY(1,1) PRIMARY KEY,
    saldo_billetera DECIMAL(18,2) NOT NULL,
    mes_actual DATE NOT NULL,
    justificacion_gasto VARCHAR(MAX) NULL
);

/*

El objetivo que exista transacciones es para poder auditar los movimientos entre el Wallet y el libro contable, la idea es crear un
store procedure que haga:

-- insert auditoría
-- update libro
-- update wallet

*/

-- =========================
-- TRANSACCIONES (AUDITORIA)
-- =========================
CREATE TABLE tb_transaccion (
    id_transaccion INT IDENTITY(1,1) PRIMARY KEY,
    id_billetera INT NOT NULL,
    id_tipo_ingreso INT NOT NULL,
    id_libro_tesoreria INT NOT NULL,
    gestion DECIMAL(18,2) NOT NULL,
    fecha_creacion DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT fk_trans_billetera 
        FOREIGN KEY (id_billetera) REFERENCES tb_billetera(id_billetera),
    CONSTRAINT fk_trans_tipo_ingreso 
        FOREIGN KEY (id_tipo_ingreso) REFERENCES tb_tipo_ingreso(id_tipo_ingreso),
    CONSTRAINT fk_trans_libro 
        FOREIGN KEY (id_libro_tesoreria) REFERENCES tb_libro_tesoreria(id_libro_tesoreria)
);
