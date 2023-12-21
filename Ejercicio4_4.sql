CREATE TABLE SEDE(
    COD_SEDE VARCHAR(3) NOT NULL,
    NOMBRE VARCHAR(41) NOT NULL,
    DIRECCION VARCHAR(35) NOT NULL,
    CONSTRAINT PK_SEDE PRIMARY KEY(COD_SEDE)
);

CREATE TABLE DEPARTAMENTO(
    COD_DEP VARCHAR(3) NOT NULL,
    COD_SEDE VARCHAR(3) NOT NULL,
    NOMBRE VARCHAR(25) NOT NULL,
    UBICACION VARCHAR(35) NOT NULL,
    CONSTRAINT PK_DEPARPATAMENTO PRIMARY KEY(COD_SEDE, COD_DEP),
    CONSTRAINT FK_DEPARTAMENTO FOREIGN KEY(COD_SEDE) REFERENCES SEDE(COD_SEDE) ON DELETE CASCADE
);

-- SE PONE ON DELETE CASCADE, POR QUE SI NO HAY SEDE NO PUEDE HABER DEPARTAMENTO 

CREATE TABLE PROGRAMADOR(
    COD_DEP VARCHAR(3) NOT NULL,
    SECUENCIA VARCHAR(9) NOT NULL,
    NOMBRE VARCHAR(41) NOT NULL,
    AP1 VARCHAR(35) NOT NULL,
    AP2 VARCHAR(35) NULL,
    DIRECCION VARCHAR(35) NOT NULL,
    COD_SEDE VARCHAR(3) NOT NULL,
    CUENTA VARCHAR(15) NOT NULL,
    TELEFONO NUMBER(9) NOT NULL,
    TIPO VARCHAR(15) NOT NULL,
    SECUENCIA_MENTOR VARCHAR(9) NULL,
    CONSTRAINT PK_PROGRAMADOR PRIMARY KEY(COD_DEP, SECUENCIA, COD_SEDE),
    
    CONSTRAINT FK_PROGRAMADOR_DEP FOREIGN KEY(COD_DEP, COD_SEDE) REFERENCES DEPARTAMENTO(COD_DEP, COD_SEDE) ON DELETE CASCADE
);


 
ALTER TABLE PROGRAMADOR ADD CONSTRAINT FK_PROGRAMADOR_MENTOR FOREIGN KEY(SECUENCIA_MENTOR, COD_DEP, COD_SEDE) REFERENCES PROGRAMADOR(SECUENCIA, COD_DEP, COD_SEDE) ON DELETE SET NULL;


-- EN COD_DEP Y COD_SEDE SE PONE ON DELETE CASCADE, POR QUE SI NO EXISTE NINGUNO DE LOS DOS NO PUEDE ESTAR EN NINGUN LADO
-- EN SECUENCIA_MENTOR SE PONE ON DELETE SET NULL, POR QUE SI NO HAY UN MENTOR PUEDE SEGUIR HABIENDO PROGRAMADOR

CREATE TABLE EQUIPO(
    COD_EQUIPO VARCHAR(3) NOT NULL,
    DESCRIPCION VARCHAR(3) NOT NULL,
    SECUENCIA VARCHAR(9) NOT NULL,
    COD_DEP VARCHAR(3) NOT NULL,
    COD_SEDE VARCHAR(3) NOT NULL,
    CONSTRAINT PK_EQUIPO PRIMARY KEY(COD_EQUIPO),
    CONSTRAINT FK_EQUIPO FOREIGN KEY(SECUENCIA, COD_SEDE, COD_DEP) REFERENCES PROGRAMADOR(SECUENCIA, COD_SEDE, COD_DEP) ON DELETE SET NULL
);

-- EN SECUENCIA SE PONE ON DELETE SET NULL, POR QUE NO DEPENDE DE UNO SOLO PUEDE ESTAR COMPUESTO POR VARIOS

CREATE TABLE EQUIPOPROG(
    SECUENCIA VARCHAR(9) NOT NULL,
    COD_EQUIPO VARCHAR(3) NOT NULL,
    COD_DEP VARCHAR(3) NOT NULL,
    COD_SEDE VARCHAR(3) NOT NULL,
    CONSTRAINT PK_EQUIPOPROG PRIMARY KEY(SECUENCIA, COD_EQUIPO),
    CONSTRAINT FK_EQUIPOPROG_PROGRAMADOR FOREIGN KEY(SECUENCIA, COD_DEP, COD_SEDE) REFERENCES PROGRAMADOR(SECUENCIA, COD_DEP, COD_SEDE) ON DELETE CASCADE,
    CONSTRAINT FK_EQUIPOPROG_EQUIPO FOREIGN KEY(COD_EQUIPO) REFERENCES EQUIPO(COD_EQUIPO) ON DELETE CASCADE
);

-- SECUENCIA Y COD_EQUIPO SE PONE ON DELETE CASCADE, POR QUE ES DEPENDIENTE DE AMBOS SI UNO ESTA AUSENTE NO PUEDE FUNCIONAR

CREATE TABLE PROYECTO(
    COD_EQUIPO VARCHAR(3) NOT NULL,
    COD_PROYECTO VARCHAR(3) NOT NULL,
    DESCRIPCION VARCHAR(3) NOT NULL,
    FECHA_INI DATE NOT NULL,
    FECHA_FIN DATE NULL,
    COD_SUB_PROYECTO VARCHAR(3) NOT NULL,
    CONSTRAINT PK_PROYECTO PRIMARY KEY(COD_EQUIPO, COD_PROYECTO),
    CONSTRAINT FK_PROYECTO_EQUIPO FOREIGN KEY(COD_EQUIPO) REFERENCES EQUIPO(COD_EQUIPO) ON DELETE CASCADE,
    CONSTRAINT FK_PROYECTO_SUB FOREIGN KEY(COD_SUB_PROYECTO) REFERENCES PROYECTO(COD_SUB_PROYECTO) ON DELETE CASCADE
);

-- COD_EQUIPO SE PONE ON DELETE CASCADE, POR QUE LA TABLA PROYECTO DEPENDE DE EQUIPO
-- COD_SUB_PROYECTO SE PONE ON DELETE SET NULL, POR QUE PUEDE NO HABER SUBPROYECTOS
