create extension if not exists pgcrypto;

create table if not exists public.negocios (
  id bigint generated always as identity primary key,
  nombre text not null unique,
  rubro text not null check (rubro in ('Gastronomía', 'Turismo', 'Artesanía')),
  descripcion text not null,
  imagen_url text not null,
  telefono text not null check (telefono ~ '^[67][0-9]{7}$'),
  direccion text not null,
  activo boolean not null default true,
  creado_en timestamptz not null default now()
);
-- Fin de la definición de tablas.
create table if not exists public.productos (
  id bigint generated always as identity primary key,
  negocio_id bigint not null references public.negocios(id) on delete cascade,
  nombre text not null,
  descripcion text not null,
  precio_bs numeric(10, 2) not null check (precio_bs >= 0),
  imagen_url text not null,
  disponible boolean not null default true,
  creado_en timestamptz not null default now(),
  unique (negocio_id, nombre)
);

create table if not exists public.consultas (
  id uuid primary key default gen_random_uuid(),
  negocio_id bigint not null references public.negocios(id),
  nombre_cliente text not null check (char_length(trim(nombre_cliente)) between 2 and 80),
  telefono text not null check (telefono ~ '^[67][0-9]{7}$'),
  mensaje text not null check (char_length(trim(mensaje)) between 10 and 1000),
  creado_en timestamptz not null default now()
);

create table if not exists public.reservas (
  id uuid primary key default gen_random_uuid(),
  negocio_id bigint not null references public.negocios(id),
  nombre_cliente text not null check (char_length(trim(nombre_cliente)) between 2 and 80),
  telefono text not null check (telefono ~ '^[67][0-9]{7}$'),
  fecha date not null,
  hora time not null,
  personas integer not null check (personas between 1 and 50),
  creado_en timestamptz not null default now()
);

create table if not exists public.pedidos (
  id uuid primary key default gen_random_uuid(),
  negocio_id bigint not null references public.negocios(id),
  nombre_cliente text not null check (char_length(trim(nombre_cliente)) between 2 and 80),
  telefono text not null check (telefono ~ '^[67][0-9]{7}$'),
  estado text not null default 'pendiente'
    check (estado in ('pendiente', 'confirmado', 'rechazado', 'entregado')),
  total_bs numeric(10, 2) not null default 0 check (total_bs >= 0),
  creado_en timestamptz not null default now()
);

create table if not exists public.pedido_items (
  id bigint generated always as identity primary key,
  pedido_id uuid not null references public.pedidos(id) on delete cascade,
  producto_id bigint not null references public.productos(id),
  cantidad integer not null check (cantidad > 0),
  precio_unitario_bs numeric(10, 2) not null check (precio_unitario_bs >= 0),
  unique (pedido_id, producto_id)
);

