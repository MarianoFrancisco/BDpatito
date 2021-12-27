CREATE DATABASE patitoBD;
USE patitoBD;
CREATE TABLE turno(
	idTurno INT NOT NULL AUTO_INCREMENT,
    area VARCHAR(15) NOT NULL,
    horarioIngreso TIME NOT NULL,
    dias VARCHAR(15),
    CONSTRAINT PK_MUEBLE PRIMARY KEY(idTurno)
	);
CREATE TABLE usuario(
	usuario VARCHAR(25) NOT NULL,
    correo VARCHAR(25) NOT NULL,
    passwordUsuario VARCHAR(70) NOT NULL,
    tipoUsuario INT NOT NULL,
    idTurno INT NOT NULL,
    CONSTRAINT PK_USUARIO PRIMARY KEY(usuario),
    CONSTRAINT FK_TO_TURNO FOREIGN KEY(idTurno) REFERENCES turno(idTurno)
	);
CREATE TABLE subExamen(
	tipo VARCHAR(25) NOT NULL,
    nombre VARCHAR(25) NOT NULL,
    CONSTRAINT PK_SUBEXAMENES PRIMARY KEY(tipo)
	);
CREATE TABLE muestra(
	codigoMuestra INT NOT NULL,
    nombreMuestra VARCHAR(25) NOT NULL,
    fecha DATETIME NOT NULL,
    CONSTRAINT PK_MUESTRA PRIMARY KEY(codigoMuestra)
	);
CREATE TABLE examen(
	codigoExamen INT NOT NULL,
    nombreExamen VARCHAR(25) NOT NULL,
    precioExamen DOUBLE NOT NULL,
    tipo VARCHAR(25) NOT NULL,
    codigoMuestra INT NOT NULL,
    CONSTRAINT PK_EXAMEN PRIMARY KEY(codigoExamen),
    CONSTRAINT FK_TO_SUBEXAMEN FOREIGN KEY(tipo) REFERENCES subExamen(tipo),
    CONSTRAINT FK_TO_MUESTRA FOREIGN KEY(codigoMuestra) REFERENCES muestra(codigoMuestra)
	);
CREATE TABLE paciente(
	cui CHAR(14) NOT NULL,
    sexo CHAR(1) NOT NULL,
    nombrePaciente VARCHAR(30) NOT NULL,
    edadPaciente INT,
    numeroPaciente INT,
    CONSTRAINT PK_PACIENTE PRIMARY KEY(cui)
	);
CREATE TABLE examenRealizar(
	idExamen INT NOT NULL AUTO_INCREMENT,
    fechaExamen DATE NOT NULL,
    resultados VARCHAR(45) NOT NULL,
    cui CHAR(14) NOT NULL,
    codigoExamen INT NOT NULL,
    tipo VARCHAR(25) NOT NULL,
    codigoMuestra INT NOT NULL,
    CONSTRAINT PK_EXAMENREALIZAR PRIMARY KEY(idExamen),
    CONSTRAINT FK_TO_PACIENTE FOREIGN KEY(cui) REFERENCES paciente(cui),
	CONSTRAINT FK_TO_EXAMEN FOREIGN KEY(codigoExamen) REFERENCES examen(codigoExamen),
    CONSTRAINT FK_TO_SUBEXAMEN2 FOREIGN KEY(tipo) REFERENCES subExamen(tipo),
    CONSTRAINT FK_TO_MUESTRA2 FOREIGN KEY(codigoMuestra) REFERENCES muestra(codigoMuestra)
	);
CREATE TABLE regalias(
	numeroColegiado INT NOT NULL,
    medico VARCHAR(25) NOT NULL,
    clinica VARCHAR(25) NOT NULL,
    numeroCuenta INT,
    direccion VARCHAR(25) NOT NULL,
    CONSTRAINT PK_REGALIAS PRIMARY KEY(numeroColegiado)
	);
CREATE TABLE reporte(
	codigoReporte INT NOT NULL,
    fechaHora DATETIME NOT NULL,
    idExamen INT NOT NULL,
    cui CHAR(14) NOT NULL,
    codigoExamen INT NOT NULL,
    tipo VARCHAR(25) NOT NULL,
    codigoMuestra INT NOT NULL,
    numeroColegiado INT,
    CONSTRAINT PK_REPORTE PRIMARY KEY(codigoReporte),
    CONSTRAINT FK_TO_EXAMENREALIZAR FOREIGN KEY(idExamen) REFERENCES examenRealizar(idExamen),
    CONSTRAINT FK_TO_PACIENTE2 FOREIGN KEY(cui) REFERENCES paciente(cui),
	CONSTRAINT FK_TO_EXAMEN2 FOREIGN KEY(codigoExamen) REFERENCES examen(codigoExamen),
    CONSTRAINT FK_TO_SUBEXAMEN3 FOREIGN KEY(tipo) REFERENCES subExamen(tipo),
    CONSTRAINT FK_TO_MUESTRA3 FOREIGN KEY(codigoMuestra) REFERENCES muestra(codigoMuestra),
    CONSTRAINT FK_TO_REGALIAS FOREIGN KEY(numeroColegiado) REFERENCES regalias(numeroColegiado)
	);

CREATE TABLE inventario(
	idInventario INT NOT NULL,
    fechaInicio DATE NOT NULL,
    fechaFinal DATE NOT NULL,
    descripcion VARCHAR(25),
    codigoReporte INT NOT NULL,
    cui CHAR(14) NOT NULL,
    idExamen INT NOT NULL,
    numeroColegiado INT,
    CONSTRAINT PK_INVENTARIO PRIMARY KEY(idInventario),
    CONSTRAINT FK_TO_REPORTE FOREIGN KEY(codigoReporte) REFERENCES reporte(codigoReporte),
    CONSTRAINT FK_TO_PACIENTE3 FOREIGN KEY(cui) REFERENCES paciente(cui),
    CONSTRAINT FK_TO_EXAMEN3 FOREIGN KEY(idExamen) REFERENCES examenRealizar(idExamen),
    CONSTRAINT FK_TO_REGALIAS2 FOREIGN KEY(numeroColegiado) REFERENCES regalias(numeroColegiado)
	);
CREATE TABLE corteMes(
	fecha INT NOT NULL,
    totalGanancias DOUBLE NOT NULL,
    totalRegalias DOUBLE,
    iva DOUBLE NOT NULL,
    idInventario INT NOT NULL,
    codigoReporte INT NOT NULL,
    cui CHAR(14) NOT NULL,
    idExamen INT NOT NULL,
    numeroColegiado INT,
    CONSTRAINT PK_CORTEMES PRIMARY KEY(fecha),
    CONSTRAINT FK_TO_INVENTARIO FOREIGN KEY(idInventario) REFERENCES inventario(idInventario),
    CONSTRAINT FK_TO_REPORTE1 FOREIGN KEY(codigoReporte) REFERENCES reporte(codigoReporte),
    CONSTRAINT FK_TO_PACIENTE4 FOREIGN KEY(cui) REFERENCES paciente(cui),
    CONSTRAINT FK_TO_EXAMEN4 FOREIGN KEY(idExamen) REFERENCES examenRealizar(idExamen),
    CONSTRAINT FK_TO_REGALIAS3 FOREIGN KEY(numeroColegiado) REFERENCES regalias(numeroColegiado)
	);
    INSERT INTO turno(idTurno, area, horarioIngreso, dias) VALUES
(1, 'prueba','07:00', 'L,M,X,J,V,S,D');
    INSERT INTO usuario(usuario,correo, passwordUsuario, tipoUsuario, idTurno) VALUES
('Juana', 'juana@gmail.com','$2a$10$bTXb/uRl5aFF5nxHtlD04.Q6YaoanfQMrySIRD4yIpFo.o7SrsqHW', 2 ,1),
('Marco', 'marco@gmail.com','$2a$10$bTXb/uRl5aFF5nxHtlD04.Q6YaoanfQMrySIRD4yIpFo.o7SrsqHW',1 ,1),
('Ale', 'ale@gmail.com','$2a$10$bTXb/uRl5aFF5nxHtlD04.Q6YaoanfQMrySIRD4yIpFo.o7SrsqHW',3 ,1);