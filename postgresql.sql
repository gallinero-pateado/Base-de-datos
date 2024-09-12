-- Crear tabla estado_practica
create table estado_practica (
  id_estado_practica bigint primary key generated always as identity,
  nom_estado_practica text not null unique
);

-- Insertar valores en estado_practica
insert into
  estado_practica (nom_estado_practica)
values
  ('ACTIVO'),
  ('INACTIVO'),
  ('ELIMINADO');

-- Crear tabla estado_usuario
create table estado_usuario (
  id_estado_usuario bigint primary key generated always as identity,
  nom_estado_usuario text not null unique
);

-- Insertar valores en estado_usuario
insert into
  estado_usuario (nom_estado_usuario)
values
  ('ACTIVO'),
  ('INACTIVO'),
  ('ELIMINADO');

-- Crear tabla estado_postulacion
create table estado_postulacion (
  id_estado_postulacion bigint primary key generated always as identity,
  nom_estado_postulacion text not null unique
);

-- Insertar valores en estado_postulacion
insert into
  estado_postulacion (nom_estado_postulacion)
values
  ('ACTIVO'),
  ('RECHAZADO'),
  ('ACEPTADO');

-- Crear tabla estado_rol
create table estado_rol (
  id_estado_rol bigint primary key generated always as identity,
  nom_estado_rol text not null unique
);

-- Insertar valores en estado_rol
insert into
  estado_rol (nom_estado_rol)
values
  ('ACTIVO'),
  ('INACTIVO');

-- Crear tabla universidad
create table universidad (
  id bigint primary key generated always as identity,
  nombre text not null,
  sede text not null
);

-- Crear tabla carrera
create table carrera (
  id_carrera bigint primary key generated always as identity,
  nom_carrera text not null,
  id_universidad bigint,
  foreign key (id_universidad) references universidad (id)
);

-- Crear tabla usuario
create table usuario (
  id bigint primary key generated always as identity,
  correo text not null unique,
  nombres text,
  apellidos text,
  fecha_nacimiento date,
  año_ingreso int,
  id_universidad bigint,
  id_estado_usuario bigint,
  foreign key (id_universidad) references universidad (id),
  foreign key (id_estado_usuario) references estado_usuario (id_estado_usuario)
);

-- Crear tabla practica
create table practica (
  id bigint primary key generated always as identity,
  titulo text not null,
  descripcion text,
  id_empresa bigint,
  ubicacion text,
  fecha_inicio date,
  fecha_fin date,
  requisitos text,
  fecha_publicacion date,
  fecha_expiracion date,
  id_estado_practica bigint,
  foreign key (id_empresa) references usuario (id),
  foreign key (id_estado_practica) references estado_practica (id_estado_practica)
);

-- Crear tabla postulacion
create table postulacion (
  id bigint primary key generated always as identity,
  id_usuario bigint,
  id_practica bigint,
  fecha_postulacion date,
  mensaje text,
  id_estado_postulacion bigint,
  foreign key (id_usuario) references usuario (id),
  foreign key (id_practica) references practica (id),
  foreign key (id_estado_postulacion) references estado_postulacion (id_estado_postulacion)
);

-- Crear tabla comentario
create table comentario (
  id bigint primary key generated always as identity,
  id_usuario bigint,
  id_practica bigint,
  comentario text,
  fecha_comentario timestamp default current_timestamp,
  id_padre bigint,
  foreign key (id_usuario) references usuario (id),
  foreign key (id_practica) references practica (id),
  foreign key (id_padre) references comentario (id)
);

-- Crear tabla rol
create table rol (
  id bigint primary key generated always as identity,
  nombre text not null unique,
  descripcion text,
  permisos json,
  fecha_creacion timestamp default current_timestamp,
  id_estado_rol bigint,
  prioridad int,
  foreign key (id_estado_rol) references estado_rol (id_estado_rol)
);

-- Crear tabla usuario_rol
create table usuario_rol (
  id_usuario bigint,
  id_rol bigint,
  primary key (id_usuario, id_rol),
  foreign key (id_usuario) references usuario (id),
  foreign key (id_rol) references rol (id)
);

-- Crear tabla resena_roomie
create table resena_roomie (
  id bigint primary key generated always as identity,
  puntuacion int check (
    puntuacion >= 1
    and puntuacion <= 5
  ),
  descripcion text,
  id_usuario bigint,
  foreign key (id_usuario) references usuario (id)
);

-- Crear tabla anuncio_roomie
create table anuncio_roomie (
  id bigint primary key generated always as identity,
  id_usuario bigint,
  descripcion text,
  ubicacion text,
  monto_total decimal(10, 2),
  foreign key (id_usuario) references usuario (id)
);
