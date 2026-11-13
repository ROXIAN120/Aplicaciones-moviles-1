insert into public.negocios (
  nombre,
  rubro,
  descripcion,
  imagen_url,
  telefono,
  direccion,
  activo
)
values
  ('Hamburguesas 24', 'Gastronomía', 'Hamburguesas artesanales disponibles de medianoche a las seis.', 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=900&q=80', '70000001', 'Av. Cañoto 451', true),
  ('Pizza de Madrugada', 'Gastronomía', 'Pizzas recién horneadas para pedidos nocturnos.', 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?auto=format&fit=crop&w=900&q=80', '70000002', 'Calle Sucre 120', true),
  ('Antojitos Camba', 'Gastronomía', 'Comida típica cruceña para calmar el hambre de madrugada.', 'https://images.unsplash.com/photo-1547592180-85f173990554?auto=format&fit=crop&w=900&q=80', '70000003', 'Av. Roca y Coronado 880', true),
  ('Tacos After', 'Gastronomía', 'Tacos, burritos y combos para después de medianoche.', 'https://images.unsplash.com/photo-1551504734-5ee1c4a1479b?auto=format&fit=crop&w=900&q=80', '70000004', 'Av. San Martín 640', true),
  ('Salchipapas El Desvelo', 'Gastronomía', 'Salchipapas y platos rápidos con atención hasta las seis.', 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?auto=format&fit=crop&w=900&q=80', '70000005', 'Calle Libertad 225', true),
  ('Dulce Amanecer', 'Gastronomía', 'Café, postres y bebidas calientes para cerrar la noche.', 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?auto=format&fit=crop&w=900&q=80', '70000006', 'Calle René Moreno 310', true)
on conflict (nombre) do update set
  rubro = excluded.rubro,
  descripcion = excluded.descripcion,
  imagen_url = excluded.imagen_url,
  telefono = excluded.telefono,
  direccion = excluded.direccion,
  activo = excluded.activo;

insert into public.productos (
  negocio_id,
  nombre,
  descripcion,
  precio_bs,
  imagen_url,
  disponible
)
select n.id, datos.nombre, datos.descripcion, datos.precio_bs, datos.imagen_url, true
from (
  values
    ('Hamburguesas 24', 'Doble nocturna', 'Doble carne, queso, tocino y salsa de la casa.', 42.00, 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=800&q=80'),
    ('Hamburguesas 24', 'Combo madrugada', 'Hamburguesa clásica, papas y bebida.', 38.00, 'https://images.unsplash.com/photo-1550547660-d9450f859349?auto=format&fit=crop&w=800&q=80'),
    ('Pizza de Madrugada', 'Pizza pepperoni', 'Pizza mediana con pepperoni y mozzarella.', 58.00, 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?auto=format&fit=crop&w=800&q=80'),
    ('Pizza de Madrugada', 'Pizza cuatro quesos', 'Pizza mediana con mezcla de cuatro quesos.', 64.00, 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?auto=format&fit=crop&w=800&q=80'),
    ('Antojitos Camba', 'Majadito batido', 'Arroz, charque, huevo y plátano.', 35.00, 'https://images.unsplash.com/photo-1547592180-85f173990554?auto=format&fit=crop&w=800&q=80'),
    ('Antojitos Camba', 'Keperí al horno', 'Carne tierna acompañada con yuca y ensalada.', 48.00, 'https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=800&q=80'),
    ('Tacos After', 'Tres tacos mixtos', 'Tacos de carne, pollo y cerdo con salsas.', 32.00, 'https://images.unsplash.com/photo-1551504734-5ee1c4a1479b?auto=format&fit=crop&w=800&q=80'),
    ('Tacos After', 'Burrito nocturno', 'Burrito grande con carne, arroz, queso y frijoles.', 36.00, 'https://images.unsplash.com/photo-1626700051175-6818013e1d4f?auto=format&fit=crop&w=800&q=80'),
    ('Salchipapas El Desvelo', 'Salchipapa especial', 'Papas, salchicha, huevo, queso y salsas.', 30.00, 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?auto=format&fit=crop&w=800&q=80'),
    ('Salchipapas El Desvelo', 'Pique nocturno', 'Carne, chorizo, papas, cebolla y locoto.', 55.00, 'https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=800&q=80'),
    ('Dulce Amanecer', 'Café camba', 'Café filtrado con leche cremosa.', 18.00, 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?auto=format&fit=crop&w=800&q=80'),
    ('Dulce Amanecer', 'Torta de chocolate', 'Porción de torta con cacao y crema.', 22.00, 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?auto=format&fit=crop&w=800&q=80')
) as datos(negocio, nombre, descripcion, precio_bs, imagen_url)
join public.negocios n on n.nombre = datos.negocio
on conflict (negocio_id, nombre) do update set
  descripcion = excluded.descripcion,
  precio_bs = excluded.precio_bs,
  imagen_url = excluded.imagen_url,
  disponible = excluded.disponible;
