
/*Hay que tener en cuenta el orden de definir las tablas, ya que si
ponemos una tabla con una FK que hace referencia a otra tabla no definida todavía,
da error*/


CREATE TABLE Restaurantes(
 codigo NUMBER(8) NOT NULL,
 nombre CHAR(20) NOT NULL,
 calle CHAR(30) NOT NULL,
 codigo_postal CHAR(5) NOT NULL,
 comision NUMBER(8,2) NULL,
 CONSTRAINT pk_restaurante PRIMARY KEY (codigo)
);

CREATE TABLE AreasCobertura (
 codigoRes Number(8) NOT NULL, 
 codigoPostal Char(5) NOT NULL,
 CONSTRAINT pk_areas PRIMARY KEY(codigoRes, codigoPostal),
 CONSTRAINT fk_areas FOREIGN KEY(codigoRes) REFERENCES Restaurantes(codigo)
);

CREATE TABLE Horarios (
 codRes Number(8) NOT NULL, 
 dia_semana Char(1) NOT NULL, 
 hora_apertura Date NOT NULL,
 hora_cierre Date NOT NULL,
 CONSTRAINT pk_Hora PRIMARY KEY(codRes, dia_semana),
 CONSTRAINT fk_Horarios FOREIGN KEY(codRes) REFERENCES Restaurantes(codigo)
);

create table Platos (
 resCod Number(8) NOT NULL,
 nombrePlato Char(20) NOT NULL, 
 precio Number(8,2) NULL, 
 descripcion Char(30) NULL, 
 categoria Char(10) NULL,
 CONSTRAINT pk_Platos Primary key (resCod, nombrePlato),
 CONSTRAINT fk_Platos FOREIGN KEY(resCod) REFERENCES Restaurantes(codigo)
);

CREATE TABLE Clientes (
 DNI CHAR(9) NOT NULL,
 nombre CHAR(20) NOT NULL,
 apellido CHAR(20) NOT NULL,
 calle CHAR(20) NULL,
 numero NUMBER(4) NULL,
 piso CHAR(5) NULL,
 localidad CHAR(15) NULL,
 codigoPostal CHAR(5) NULL,
 telefono CHAR(9) NULL,
 usuario CHAR(8) NOT NULL,
 contraseña CHAR(8) DEFAULT ' Nopass ',
 CONSTRAINT pk_Clientes PRIMARY KEY(DNI),
 CONSTRAINT un_Usuario UNIQUE(usuario)
);

CREATE TABLE Descuentos (
 codigodescuento NUMBER(8) NOT NULL,
 fecha_caducidad DATE NULL,
 porcentaje_descuento NUMBER(3) NOT NULL,
 CONSTRAINT pk_descuento PRIMARY KEY (codigodescuento),
 CONSTRAINT ck_descuento_porcentaje_0_100 CHECK (porcentaje_descuento > 0 AND porcentaje_descuento<=100)
);

CREATE TABLE Pedidos(
 codigo NUMBER(8) NOT NULL,
 estado CHAR(9) DEFAULT 'REST' NOT NULL,
 fecha_hora_pedido DATE NOT NULL,
 fecha_hora_entrega DATE,
 importe_total NUMBER(8,2),
 cliente CHAR(9) NOT NULL,
 codigodescuento NUMBER(8),
 CONSTRAINT pk_pedido PRIMARY KEY (codigo),
 CONSTRAINT fk_pedido_cliente FOREIGN KEY (cliente) REFERENCES Clientes (DNI),
 CONSTRAINT fk_pedido_descuento FOREIGN KEY (codigodescuento) REFERENCES Descuentos (codigodescuento) ON DELETE SET NULL,
 CONSTRAINT ck_pedido_estado CHECK (estado IN ('REST', 'CANCEL', 'RUTA','ENTREGADO','RECHAZADO'))
);

CREATE TABLE Contiene (
 restaura NUMBER(8),
 plato CHAR(25),
 pedido NUMBER(8),
 precio_con_comision NUMBER(8,2) NULL,
 unidades NUMBER(4) NOT NULL,
 CONSTRAINT pk_contiene PRIMARY KEY (restaura, plato, pedido),
 CONSTRAINT fk_contiene_plato FOREIGN KEY (restaura, plato) REFERENCES Platos (resCod, nombrePlato) ON DELETE CASCADE,
 CONSTRAINT fk_contiene_pedido FOREIGN KEY (pedido) REFERENCES Pedidos (codigo) ON DELETE CASCADE
);

CREATE INDEX I_CatPlatos ON Platos(categoria);

CREATE SEQUENCE Seq_CodPedidos INCREMENT BY 1 START WITH 1 NOMAXVALUE;