-- Crear tabla estado_practica
CREATE TABLE estado_practica (
    id_estado_practica BIGINT AUTO_INCREMENT PRIMARY KEY,
    nom_estado_practica VARCHAR(255) NOT NULL UNIQUE
);

-- Insertar valores en estado_practica
INSERT INTO estado_practica (nom_estado_practica) VALUES ('ACTIVO'), ('INACTIVO'), ('ELIMINADO');

-- Crear tabla estado_usuario
CREATE TABLE estado_usuario (
    id_estado_usuario BIGINT AUTO_INCREMENT PRIMARY KEY,
    nom_estado_usuario VARCHAR(255) NOT NULL UNIQUE
);

-- Insertar valores en estado_usuario
INSERT INTO estado_usuario (nom_estado_usuario) VALUES ('ACTIVO'), ('INACTIVO'), ('ELIMINADO');

-- Crear tabla estado_postulacion
CREATE TABLE estado_postulacion (
    id_estado_postulacion BIGINT AUTO_INCREMENT PRIMARY KEY,
    nom_estado_postulacion VARCHAR(255) NOT NULL UNIQUE
);

-- Insertar valores en estado_postulacion
INSERT INTO estado_postulacion (nom_estado_postulacion) VALUES ('ACTIVO'), ('RECHAZADO'), ('ACEPTADO');

-- Crear tabla estado_rol
CREATE TABLE estado_rol (
    id_estado_rol BIGINT AUTO_INCREMENT PRIMARY KEY,
    nom_estado_rol VARCHAR(255) NOT NULL UNIQUE
);

-- Insertar valores en estado_rol
INSERT INTO estado_rol (nom_estado_rol) VALUES ('ACTIVO'), ('INACTIVO');

-- Crear tabla universidad
CREATE TABLE universidad (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    sede VARCHAR(255) NOT NULL
);

-- Crear tabla carrera
CREATE TABLE carrera (
    id_carrera BIGINT AUTO_INCREMENT PRIMARY KEY,
    nom_carrera VARCHAR(255) NOT NULL,
    id_universidad BIGINT,
    FOREIGN KEY (id_universidad) REFERENCES universidad(id)
);

-- Crear tabla usuario
CREATE TABLE usuario (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    correo VARCHAR(255) NOT NULL UNIQUE,
    nombres VARCHAR(255),
    apellidos VARCHAR(255),
    fecha_nacimiento DATE,
    año_ingreso INT,
    id_universidad BIGINT,
    id_estado_usuario BIGINT,
    FOREIGN KEY (id_universidad) REFERENCES universidad(id),
    FOREIGN KEY (id_estado_usuario) REFERENCES estado_usuario(id_estado_usuario)
);

-- Crear tabla practica
CREATE TABLE practica (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    descripcion TEXT,
    id_empresa BIGINT,
    ubicacion VARCHAR(255),
    fecha_inicio DATE,
    fecha_fin DATE,
    requisitos TEXT,
    fecha_publicacion DATE,
    fecha_expiracion DATE,
    id_estado_practica BIGINT,
    FOREIGN KEY (id_empresa) REFERENCES usuario(id),
    FOREIGN KEY (id_estado_practica) REFERENCES estado_practica(id_estado_practica)
);

-- Crear tabla postulacion
CREATE TABLE postulacion (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    id_usuario BIGINT,
    id_practica BIGINT,
    fecha_postulacion DATE,
    mensaje TEXT,
    id_estado_postulacion BIGINT,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id),
    FOREIGN KEY (id_practica) REFERENCES practica(id),
    FOREIGN KEY (id_estado_postulacion) REFERENCES estado_postulacion(id_estado_postulacion)
);

-- Crear tabla comentario
CREATE TABLE comentario (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    id_usuario BIGINT,
    id_practica BIGINT,
    comentario TEXT,
    fecha_comentario TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_padre BIGINT,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id),
    FOREIGN KEY (id_practica) REFERENCES practica(id),
    FOREIGN KEY (id_padre) REFERENCES comentario(id)
);

-- Crear tabla rol
CREATE TABLE rol (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL UNIQUE,
    descripcion TEXT,
    permisos JSON,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_estado_rol BIGINT,
    prioridad INT,
    FOREIGN KEY (id_estado_rol) REFERENCES estado_rol(id_estado_rol)
);

-- Crear tabla usuario_rol
CREATE TABLE usuario_rol (
    id_usuario BIGINT,
    id_rol BIGINT,
    PRIMARY KEY (id_usuario, id_rol),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id),
    FOREIGN KEY (id_rol) REFERENCES rol(id)
);

-- Crear tabla resena_roomie
CREATE TABLE resena_roomie (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    puntuacion INT CHECK (puntuacion >= 1 AND puntuacion <= 5),
    descripcion TEXT,
    id_usuario BIGINT,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);

-- Crear tabla anuncio_roomie
CREATE TABLE anuncio_roomie (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    id_usuario BIGINT,
    descripcion TEXT,
    ubicacion VARCHAR(255),
    monto_total DECIMAL(10, 2),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);
