-- Generado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   en:        2024-10-02 15:14:29 CLST
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE ciudad (
    codigo_ciudad    NUMBER(3) NOT NULL,
    nombre_ciudad    VARCHAR2(30) NOT NULL,
    pais_codigo_pais NUMBER(3) NOT NULL
);

ALTER TABLE ciudad ADD CONSTRAINT ciudad_pk PRIMARY KEY ( codigo_ciudad,
                                                          pais_codigo_pais );

CREATE TABLE comuna (
    codigo_comuna        NUMBER(3) NOT NULL,
    nombre_comuna        VARCHAR2(40) NOT NULL,
    region_codigo_region NUMBER(2) NOT NULL
);

ALTER TABLE comuna ADD CONSTRAINT comuna_pk PRIMARY KEY ( codigo_comuna );

CREATE TABLE detalle_reserva (
    reserva_codigo_reserva       NUMBER(10) NOT NULL,
    habitacion_codigo_habitacion NUMBER(3) NOT NULL,
    fecha_inicio                 DATE NOT NULL,
    fecha_termino                DATE NOT NULL
);

CREATE TABLE empleado (
    run             NUMBER(10) NOT NULL,
    nombre_completo VARCHAR2(30) NOT NULL,
    telefono        NUMBER(12) NOT NULL
);

ALTER TABLE empleado ADD CONSTRAINT empleado_pk PRIMARY KEY ( run );

CREATE TABLE empleado_hora (
    run              NUMBER(10) NOT NULL,
    valor_hora       NUMBER(5) NOT NULL,
    horas_trabajadas NUMBER(2) NOT NULL
);

ALTER TABLE empleado_hora ADD CONSTRAINT empleado_hora_pk PRIMARY KEY ( run );

CREATE TABLE empleado_planta (
    run            NUMBER(10) NOT NULL,
    fecha_contrato DATE NOT NULL,
    salario        NUMBER(7) NOT NULL,
    meta           NUMBER(2) NOT NULL,
    bono           NUMBER(6) NOT NULL
);

ALTER TABLE empleado_planta ADD CONSTRAINT empleado_planta_pk PRIMARY KEY ( run );

CREATE TABLE habitacion (
    codigo_habitacion                      NUMBER(3) NOT NULL,
    numero_habitacion                      NUMBER(4) NOT NULL,
    hotel_id_hotel                         NUMBER(2) NOT NULL, 
--  ERROR: Column name length exceeds maximum allowed length(30) 
    tipo_habitacion_codigo_tipo_habitacion NUMBER(1) NOT NULL
);

ALTER TABLE habitacion ADD CONSTRAINT habitacion_pk PRIMARY KEY ( codigo_habitacion );

CREATE TABLE hotel (
    id_hotel             NUMBER(2) NOT NULL,
    nombre_sucursal      VARCHAR2(25) NOT NULL,
    direccion            VARCHAR2(30) NOT NULL,
    telefono             NUMBER(10) NOT NULL,
    email                VARCHAR2(40),
    encaargado           VARCHAR2(30) NOT NULL,
    comuna_codigo_comuna NUMBER(3) NOT NULL,
    categoria            NUMBER(1) NOT NULL
);

ALTER TABLE hotel ADD CONSTRAINT hotel_pk PRIMARY KEY ( id_hotel );

CREATE TABLE pais (
    codigo_pais NUMBER(3) NOT NULL,
    nombre_pais VARCHAR2(25) NOT NULL,
    gentilicio  VARCHAR2(25) NOT NULL
);

ALTER TABLE pais ADD CONSTRAINT pais_pk PRIMARY KEY ( codigo_pais );

CREATE TABLE pasajero (
    identificacion              VARCHAR2(15) NOT NULL,
    nombre_pasajero             VARCHAR2(30) NOT NULL,
    direccion                   VARCHAR2(35),
    email_pasajero              VARCHAR2(50),
    telefono_pasajero           VARCHAR2(12) NOT NULL,
    ciudad_codigo_ciudad        NUMBER(3) NOT NULL,
    ciudad_pais_codigo_pais     NUMBER(3) NOT NULL,
    pais_codigo_pais            NUMBER(3) NOT NULL,
    tipo_documento_codigo_tipo  NUMBER(1) NOT NULL,
    tipo_numero_cod_tipo_numero NUMBER(1) NOT NULL
);

ALTER TABLE pasajero ADD CONSTRAINT pasajero_pk PRIMARY KEY ( identificacion );

CREATE TABLE region (
    codigo_region NUMBER(2) NOT NULL,
    nombre_region VARCHAR2(25) NOT NULL
);

ALTER TABLE region ADD CONSTRAINT region_pk PRIMARY KEY ( codigo_region );

CREATE TABLE reserva (
    codigo_reserva          NUMBER(10) NOT NULL,
    fecha_llamada           DATE NOT NULL,
    pasajero_identificacion VARCHAR2(15) NOT NULL,
    empleado_run            NUMBER(10) NOT NULL
);

ALTER TABLE reserva ADD CONSTRAINT reserva_pk PRIMARY KEY ( codigo_reserva );

CREATE TABLE tipo_documento (
    codigo_tipo NUMBER(1) NOT NULL,
    nombre_tipo VARCHAR2(20) NOT NULL
);

ALTER TABLE tipo_documento ADD CONSTRAINT tipo_documento_pk PRIMARY KEY ( codigo_tipo );

CREATE TABLE tipo_habitacion (
    codigo_tipo_habitacion NUMBER(1) NOT NULL,
    nombre_tipo_habitacion VARCHAR2(15) NOT NULL
);

ALTER TABLE tipo_habitacion ADD CONSTRAINT tipo_habitacion_pk PRIMARY KEY ( codigo_tipo_habitacion );

CREATE TABLE tipo_numero (
    cod_tipo_numero    NUMBER(1) NOT NULL,
    nomnre_tipo_numero VARCHAR2(10) NOT NULL
);

ALTER TABLE tipo_numero ADD CONSTRAINT tipo_numero_pk PRIMARY KEY ( cod_tipo_numero );

ALTER TABLE ciudad
    ADD CONSTRAINT ciudad_pais_fk FOREIGN KEY ( pais_codigo_pais )
        REFERENCES pais ( codigo_pais );

ALTER TABLE comuna
    ADD CONSTRAINT comuna_region_fk FOREIGN KEY ( region_codigo_region )
        REFERENCES region ( codigo_region );

ALTER TABLE detalle_reserva
    ADD CONSTRAINT detalle_reserva_habitacion_fk FOREIGN KEY ( habitacion_codigo_habitacion )
        REFERENCES habitacion ( codigo_habitacion );

ALTER TABLE detalle_reserva
    ADD CONSTRAINT detalle_reserva_reserva_fk FOREIGN KEY ( reserva_codigo_reserva )
        REFERENCES reserva ( codigo_reserva );

ALTER TABLE empleado_hora
    ADD CONSTRAINT empleado_hora_empleado_fk FOREIGN KEY ( run )
        REFERENCES empleado ( run );

ALTER TABLE empleado_planta
    ADD CONSTRAINT empleado_planta_empleado_fk FOREIGN KEY ( run )
        REFERENCES empleado ( run );

ALTER TABLE habitacion
    ADD CONSTRAINT habitacion_hotel_fk FOREIGN KEY ( hotel_id_hotel )
        REFERENCES hotel ( id_hotel );

ALTER TABLE habitacion
    ADD CONSTRAINT habitacion_tipo_habitacion_fk FOREIGN KEY ( tipo_habitacion_codigo_tipo_habitacion )
        REFERENCES tipo_habitacion ( codigo_tipo_habitacion );

ALTER TABLE hotel
    ADD CONSTRAINT hotel_comuna_fk FOREIGN KEY ( comuna_codigo_comuna )
        REFERENCES comuna ( codigo_comuna );

ALTER TABLE pasajero
    ADD CONSTRAINT pasajero_ciudad_fk FOREIGN KEY ( ciudad_codigo_ciudad,
                                                    ciudad_pais_codigo_pais )
        REFERENCES ciudad ( codigo_ciudad,
                            pais_codigo_pais );

ALTER TABLE pasajero
    ADD CONSTRAINT pasajero_pais_fk FOREIGN KEY ( pais_codigo_pais )
        REFERENCES pais ( codigo_pais );

ALTER TABLE pasajero
    ADD CONSTRAINT pasajero_tipo_documento_fk FOREIGN KEY ( tipo_documento_codigo_tipo )
        REFERENCES tipo_documento ( codigo_tipo );

ALTER TABLE pasajero
    ADD CONSTRAINT pasajero_tipo_numero_fk FOREIGN KEY ( tipo_numero_cod_tipo_numero )
        REFERENCES tipo_numero ( cod_tipo_numero );

ALTER TABLE reserva
    ADD CONSTRAINT reserva_empleado_fk FOREIGN KEY ( empleado_run )
        REFERENCES empleado ( run );

ALTER TABLE reserva
    ADD CONSTRAINT reserva_pasajero_fk FOREIGN KEY ( pasajero_identificacion )
        REFERENCES pasajero ( identificacion );

--  ERROR: No Discriminator Column found in Arc Arc_2 - constraint trigger for Arc cannot be generated 

--  ERROR: No Discriminator Column found in Arc Arc_2 - constraint trigger for Arc cannot be generated

--  ERROR: No Discriminator Column found in Arc FKArc_1 - constraint trigger for Arc cannot be generated 

--  ERROR: No Discriminator Column found in Arc FKArc_1 - constraint trigger for Arc cannot be generated



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            15
-- CREATE INDEX                             0
-- ALTER TABLE                             29
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   5
-- WARNINGS                                 0
