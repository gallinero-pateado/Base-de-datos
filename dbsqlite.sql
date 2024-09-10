-- Crear tabla estado_practica
CREATE TABLE estado_practica (
    id_estado_practica INTEGER PRIMARY KEY AUTOINCREMENT,
    nom_estado_practica TEXT NOT NULL UNIQUE
);

-- Insertar valores en estado_practica
INSERT INTO estado_practica (nom_estado_practica) VALUES ('ACTIVO'), ('INACTIVO'), ('ELIMINADO');

-- Crear tabla estado_usuario
CREATE TABLE estado_usuario (
    id_estado_usuario INTEGER PRIMARY KEY AUTOINCREMENT,
    nom_estado_usuario TEXT NOT NULL UNIQUE
);

-- Insertar valores en estado_usuario
INSERT INTO estado_usuario (nom_estado_usuario) VALUES ('ACTIVO'), ('INACTIVO'), ('ELIMINADO');

-- Crear tabla estado_postulacion
CREATE TABLE estado_postulacion (
    id_estado_postulacion INTEGER PRIMARY KEY AUTOINCREMENT,
    nom_estado_postulacion TEXT NOT NULL UNIQUE
);

-- Insertar valores en estado_postulacion
INSERT INTO estado_postulacion (nom_estado_postulacion) VALUES ('ACTIVO'), ('RECHAZADO'), ('ACEPTADO');

-- Crear tabla estado_rol
CREATE TABLE estado_rol (
    id_estado_rol INTEGER PRIMARY KEY AUTOINCREMENT,
    nom_estado_rol TEXT NOT NULL UNIQUE
);

-- Insertar valores en estado_rol
INSERT INTO estado_rol (nom_estado_rol) VALUES ('ACTIVO'), ('INACTIVO');

-- Crear tabla universidad
CREATE TABLE universidad (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    sede TEXT NOT NULL
);

-- Crear tabla carrera
CREATE TABLE carrera (
    id_carrera INTEGER PRIMARY KEY AUTOINCREMENT,
    nom_carrera TEXT NOT NULL,
    id_universidad INTEGER,
    FOREIGN KEY (id_universidad) REFERENCES universidad(id)
);

-- Crear tabla usuario
CREATE TABLE usuario (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    correo TEXT NOT NULL UNIQUE,
    nombres TEXT,
    apellidos TEXT,
    fecha_nacimiento DATE,
    aÃ±o_ingreso INTEGER,
    id_universidad INTEGER,
    id_estado_usuario INTEGER,
    FOREIGN KEY (id_universidad) REFERENCES universidad(id),
    FOREIGN KEY (id_estado_usuario) REFERENCES estado_usuario(id_estado_usuario)
);

-- Crear tabla practica
CREATE TABLE practica (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo TEXT NOT NULL,
    descripcion TEXT,
    id_empresa INTEGER,
    ubicacion TEXT,
    fecha_inicio DATE,
    fecha_fin DATE,
    requisitos TEXT,
    fecha_publicacion DATE,
    fecha_expiracion DATE,
    id_estado_practica INTEGER,
    FOREIGN KEY (id_empresa) REFERENCES usuario(id),
    FOREIGN KEY (id_estado_practica) REFERENCES estado_practica(id_estado_practica)
);

-- Crear tabla postulacion
CREATE TABLE postulacion (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_usuario INTEGER,
    id_practica INTEGER,
    fecha_postulacion DATE,
    mensaje TEXT,
    id_estado_postulacion INTEGER,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id),
    FOREIGN KEY (id_practica) REFERENCES practica(id),
    FOREIGN KEY (id_estado_postulacion) REFERENCES estado_postulacion(id_estado_postulacion)
);

-- Crear tabla comentario
CREATE TABLE comentario (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_usuario INTEGER,
    id_practica INTEGER,
    comentario TEXT,
    fecha_comentario TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_padre INTEGER,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id),
    FOREIGN KEY (id_practica) REFERENCES practica(id),
    FOREIGN KEY (id_padre) REFERENCES comentario(id)
);

-- Crear tabla rol
CREATE TABLE rol (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL UNIQUE,
    descripcion TEXT,
    permisos TEXT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_estado_rol INTEGER,
    prioridad INTEGER,
    FOREIGN KEY (id_estado_rol) REFERENCES estado_rol(id_estado_rol)
);

-- Crear tabla usuario_rol
CREATE TABLE usuario_rol (
    id_usuario INTEGER,
    id_rol INTEGER,
    PRIMARY KEY (id_usuario, id_rol),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id),
    FOREIGN KEY (id_rol) REFERENCES rol(id)
);

-- Crear tabla resena_roomie
CREATE TABLE resena_roomie (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    puntuacion INTEGER CHECK (puntuacion >= 1 AND puntuacion <= 5),
    descripcion TEXT,
    id_usuario INTEGER,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);

-- Crear tabla anuncio_roomie
CREATE TABLE anuncio_roomie (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    id_usuario INTEGER,
    descripcion TEXT,
    ubicacion TEXT,
    monto_total REAL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id)
);
