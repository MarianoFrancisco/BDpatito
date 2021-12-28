CREATE DATABASE patitobd;
CREATE USER 'patitoOliver'@'%' IDENTIFIED BY 'Oliver12345';
GRANT ALL PRIVILEGES ON patitobd.* TO 'patitoOliver'@'%';
ALTER USER 'patitoOliver'@'%' IDENTIFIED WITH mysql_native_password BY 'Oliver12345';
FLUSH PRIVILEGES;
USE patitobd;
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
    estado BOOLEAN NOT NULL,
    CONSTRAINT PK_USUARIO PRIMARY KEY(usuario),
    CONSTRAINT FK_TO_TURNO FOREIGN KEY(idTurno) REFERENCES turno(idTurno)
	);
CREATE TABLE examen(
	codigoExamen INT NOT NULL,
    nombreExamen VARCHAR(25) NOT NULL,
    precioExamen DOUBLE NOT NULL,
    nombreMuestra VARCHAR(25) NOT NULL,
    CONSTRAINT PK_EXAMEN PRIMARY KEY(codigoExamen)
	);
CREATE TABLE subExamen(
	tipo VARCHAR(25) NOT NULL,
    nombreSub VARCHAR(25) NOT NULL,
    codigoExamen INT NOT NULL,
    CONSTRAINT PK_SUBEXAMENES PRIMARY KEY(tipo,nombreSub),
    CONSTRAINT FK_TO_EXAMEN FOREIGN KEY(codigoExamen) REFERENCES examen(codigoExamen)
);
CREATE TABLE regalias(
	numeroColegiado CHAR(16) NOT NULL,
    medico VARCHAR(25) NOT NULL,
    clinica VARCHAR(25) NOT NULL,
    numeroCuenta INT,
    direccion VARCHAR(25) NOT NULL,
    CONSTRAINT PK_REGALIAS PRIMARY KEY(numeroColegiado)
	);
CREATE TABLE paciente(
	cui CHAR(14) NOT NULL,
    sexo CHAR(1) NOT NULL,
    nombrePaciente VARCHAR(30) NOT NULL,
    edadPaciente INT NOT NULL,
    numeroPaciente INT NOT NULL,
    numeroColegiado CHAR(16),
    estado BOOLEAN NOT NULL,
    CONSTRAINT PK_PACIENTE PRIMARY KEY(cui),
    CONSTRAINT FK_TO_REGALIAS FOREIGN KEY(numeroColegiado) REFERENCES regalias(numeroColegiado)
	);
CREATE TABLE examenRealizar(
	idExamen INT NOT NULL AUTO_INCREMENT,
    fechaExamen DATE NOT NULL,
    cui CHAR(14) NOT NULL,
    nombreSubExamen VARCHAR(25) NOT NULL,
    tipo VARCHAR(25) NOT NULL,
    codigoExamen INT NOT NULL,
    CONSTRAINT PK_EXAMENREALIZAR PRIMARY KEY(idExamen),
    CONSTRAINT FK_TO_PACIENTE FOREIGN KEY(cui) REFERENCES paciente(cui),
    CONSTRAINT FK_TO_SUBEXAMEN FOREIGN KEY(tipo) REFERENCES subExamen(tipo),
    CONSTRAINT FK_TO_EXAMEN6 FOREIGN KEY(codigoExamen) REFERENCES examen(codigoExamen)
	);
CREATE TABLE reporte(
	codigoReporte INT NOT NULL,
    fechaHora DATETIME NOT NULL,
    idExamen INT NOT NULL,
    cui CHAR(14) NOT NULL,
    nombreSubExamen VARCHAR(25) NOT NULL,
    tipo VARCHAR(25) NOT NULL,
    numeroColegiado CHAR(16),
    codigoExamen INT NOT NULL,
    CONSTRAINT PK_REPORTE PRIMARY KEY(codigoReporte),
    CONSTRAINT FK_TO_EXAMENREALIZAR FOREIGN KEY(idExamen) REFERENCES examenRealizar(idExamen),
    CONSTRAINT FK_TO_PACIENTE2 FOREIGN KEY(cui) REFERENCES paciente(cui),
    CONSTRAINT FK_TO_SUBEXAMEN2 FOREIGN KEY(tipo) REFERENCES subExamen(tipo),
    CONSTRAINT FK_TO_REGALIAS2 FOREIGN KEY(numeroColegiado) REFERENCES regalias(numeroColegiado),
    CONSTRAINT FK_TO_EXAMEN7 FOREIGN KEY(codigoExamen) REFERENCES examen(codigoExamen)
	);

CREATE TABLE inventario(
	idInventario INT NOT NULL,
    fechaInicio DATE NOT NULL,
    fechaFinal DATE NOT NULL,
    descripcion VARCHAR(25),
    codigoReporte INT NOT NULL,
    cui CHAR(14) NOT NULL,
    tipo VARCHAR(25) NOT NULL,
    numeroColegiado CHAR(16),
    CONSTRAINT PK_INVENTARIO PRIMARY KEY(idInventario),
    CONSTRAINT FK_TO_REPORTE FOREIGN KEY(codigoReporte) REFERENCES reporte(codigoReporte),
    CONSTRAINT FK_TO_PACIENTE3 FOREIGN KEY(cui) REFERENCES paciente(cui),
    CONSTRAINT FK_TO_SUBEXAMEN3 FOREIGN KEY(tipo) REFERENCES subExamen(tipo),
    CONSTRAINT FK_TO_REGALIAS3 FOREIGN KEY(numeroColegiado) REFERENCES regalias(numeroColegiado)
	);
CREATE TABLE corteMes(
	fecha INT NOT NULL,
    totalGanancias DOUBLE NOT NULL,
    totalRegalias DOUBLE,
    iva DOUBLE NOT NULL,
    idInventario INT NOT NULL,
    codigoReporte INT NOT NULL,
    cui CHAR(14) NOT NULL,
    tipo VARCHAR(25) NOT NULL,
    numeroColegiado CHAR(16),
    CONSTRAINT PK_CORTEMES PRIMARY KEY(fecha),
    CONSTRAINT FK_TO_INVENTARIO FOREIGN KEY(idInventario) REFERENCES inventario(idInventario),
    CONSTRAINT FK_TO_REPORTE1 FOREIGN KEY(codigoReporte) REFERENCES reporte(codigoReporte),
    CONSTRAINT FK_TO_PACIENTE4 FOREIGN KEY(cui) REFERENCES paciente(cui),
    CONSTRAINT FK_TO_SUBEXAMEN4 FOREIGN KEY(tipo) REFERENCES subExamen(tipo),
    CONSTRAINT FK_TO_REGALIAS4 FOREIGN KEY(numeroColegiado) REFERENCES regalias(numeroColegiado)
	);
    INSERT INTO turno(idTurno, area, horarioIngreso, dias) VALUES
(1, 'Administrador','06:00', 'L,M,X,J,V,S,D'),
(2, 'Secretaria','07:00', 'L,M,X,J,V,S,D'),
(3, 'Laboratorista','07:00', 'L,M,X,J,V,S,D');
    INSERT INTO usuario(usuario,correo, passwordUsuario, tipoUsuario, idTurno, estado) VALUES
('Juana', 'juana@gmail.com','$2a$10$bTXb/uRl5aFF5nxHtlD04.Q6YaoanfQMrySIRD4yIpFo.o7SrsqHW', 2 ,2, true),
('Marco', 'marco@gmail.com','$2a$10$bTXb/uRl5aFF5nxHtlD04.Q6YaoanfQMrySIRD4yIpFo.o7SrsqHW',1 ,1, true),
('Ale', 'ale@gmail.com','$2a$10$bTXb/uRl5aFF5nxHtlD04.Q6YaoanfQMrySIRD4yIpFo.o7SrsqHW',3 ,3,true),
('Mishel', 'mishel@gmail.com','$2a$10$bTXb/uRl5aFF5nxHtlD04.Q6YaoanfQMrySIRD4yIpFo.o7SrsqHW',3 ,3,true),
('Victoria', 'vic@gmail.com','$2a$10$bTXb/uRl5aFF5nxHtlD04.Q6YaoanfQMrySIRD4yIpFo.o7SrsqHW',3 ,3,true),
('Juan', 'juan@gmail.com','$2a$10$bTXb/uRl5aFF5nxHtlD04.Q6YaoanfQMrySIRD4yIpFo.o7SrsqHW',3 ,3,true);
INSERT INTO examen(codigoExamen, nombreExamen, precioExamen, nombreMuestra) VALUES
(100, 'Hematologia',1200, 'Sangre'),
(101, 'Orina',800, 'Orina'),
(102, 'Heces',600, 'Heces')
;
INSERT INTO subExamen(tipo, nombreSub,codigoExamen) VALUES
('Completo', 'Globulos Rojos',100),
('Completo', 'Hemoglobina',100),
('Completo', 'Hematocrito',100),
('Completo', 'Basofilos',100),
('Macroscopico', 'Densidad especifica',101),
('Macroscopico', 'Aspecto',101),
('Macroscopico', 'Olor',101),
('Macroscopico', 'Color',101),
('Macroscopico', 'Restos alimenticios',102),
('Macroscopico', 'Consistencia',102),
('Macroscopico', 'Sangre',102),
('Macroscopico', 'Reaccion pH',102),
('Microscopico', 'Bacterias',101),
('Microscopico', 'Hemoglobina',101),
('Microscopico', 'Bilirrubina',101),
('Microscopico', 'Nitritos',101),
('Microscopico', 'Leucocitos',102),
('Microscopico', 'Eritrocitos',102),
('Microscopico', 'Grasas',102),
('Microscopico', 'Jabones',102)
;
INSERT INTO regalias(numeroColegiado,medico,clinica,numeroCuenta,direccion) VALUES
(522,'Mishel','Patito2',204123,'Guatemala')
;
INSERT INTO paciente(cui,sexo,nombrePaciente,edadPaciente,numeroPaciente,numeroColegiado,estado) VALUES
(1234567891234,'F','Ana',20,1234567,522,true)
;
INSERT INTO examenRealizar(fechaExamen, cui,nombreSubExamen,tipo,codigoExamen) VALUES
(CURDATE(),1234567891234,'Globulos Rojos','Completo',100)
;
INSERT INTO reporte(codigoReporte, fechaHora, idExamen, cui,nombreSubExamen,tipo,numeroColegiado,codigoExamen) VALUES
(1, NOW(),1, 1234567891234,'Globulos Rojos','Completo',522,100)
;