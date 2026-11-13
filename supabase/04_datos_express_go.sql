begin;

update public.negocios
set nombre = case telefono
      when '70000001' then 'Hamburguesas 24'
      when '70000002' then 'Pizza de Madrugada'
      when '70000003' then 'Antojitos Camba'
      when '70000004' then 'Tacos After'
      when '70000005' then 'Salchipapas El Desvelo'
      when '70000006' then 'Dulce Amanecer'
    end,
    rubro = 'Gastronomía',
    descripcion = case telefono
      when '70000001' then 'Hamburguesas artesanales disponibles de medianoche a las seis.'
      when '70000002' then 'Pizzas recién horneadas para pedidos nocturnos.'
      when '70000003' then 'Comida típica cruceña para calmar el hambre de madrugada.'
      when '70000004' then 'Tacos, burritos y combos para después de medianoche.'
      when '70000005' then 'Salchipapas y platos rápidos con atención hasta las seis.'
      when '70000006' then 'Café, postres y bebidas calientes para cerrar la noche.'
    end,
    imagen_url = case telefono
      when '70000001' then 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=900&q=80'
      when '70000002' then 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?auto=format&fit=crop&w=900&q=80'
      when '70000003' then 'https://images.unsplash.com/photo-1547592180-85f173990554?auto=format&fit=crop&w=900&q=80'
      when '70000004' then 'https://images.unsplash.com/photo-1551504734-5ee1c4a1479b?auto=format&fit=crop&w=900&q=80'
      when '70000005' then 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?auto=format&fit=crop&w=900&q=80'
      when '70000006' then 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?auto=format&fit=crop&w=900&q=80'
    end
where telefono in ('70000001', '70000002', '70000003', '70000004', '70000005', '70000006');

delete from public.productos
where negocio_id in (
  select id from public.negocios
  where telefono in ('70000001', '70000002', '70000003', '70000004', '70000005', '70000006')
);

insert into public.productos (negocio_id, nombre, descripcion, precio_bs, imagen_url, disponible)
select n.id, d.producto, d.descripcion, d.precio, d.imagen, true
from (
  values
    ('70000001', 'Doble nocturna', 'Doble carne, queso, tocino y salsa de la casa.', 42.00, 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=800&q=80'),
    ('70000001', 'Combo madrugada', 'Hamburguesa clásica, papas y bebida.', 38.00, 'https://images.unsplash.com/photo-1550547660-d9450f859349?auto=format&fit=crop&w=800&q=80'),
    ('70000002', 'Pizza pepperoni', 'Pizza mediana con pepperoni y mozzarella.', 58.00, 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?auto=format&fit=crop&w=800&q=80'),
    ('70000002', 'Pizza cuatro quesos', 'Pizza mediana con mezcla de cuatro quesos.', 64.00, 'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?auto=format&fit=crop&w=800&q=80'),
    ('70000003', 'Majadito batido', 'Arroz, charque, huevo y plátano.', 35.00, 'https://images.unsplash.com/photo-1547592180-85f173990554?auto=format&fit=crop&w=800&q=80'),
    ('70000003', 'Keperí al horno', 'Carne tierna acompañada con yuca y ensalada.', 48.00, 'https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=800&q=80'),
    ('70000004', 'Tres tacos mixtos', 'Tacos de carne, pollo y cerdo con salsas.', 32.00, 'https://images.unsplash.com/photo-1551504734-5ee1c4a1479b?auto=format&fit=crop&w=800&q=80'),
    ('70000004', 'Burrito nocturno', 'Burrito grande con carne, arroz, queso y frijoles.', 36.00, 'https://images.unsplash.com/photo-1626700051175-6818013e1d4f?auto=format&fit=crop&w=800&q=80'),
    ('70000005', 'Salchipapa especial', 'Papas, salchicha, huevo, queso y salsas.', 30.00, 'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?auto=format&fit=crop&w=800&q=80'),
    ('70000005', 'Pique nocturno', 'Carne, chorizo, papas, cebolla y locoto.', 55.00, 'https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=800&q=80'),
    ('70000006', 'Café camba', 'Café filtrado con leche cremosa.', 18.00, 'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?auto=format&fit=crop&w=800&q=80'),
    ('70000006', 'Torta de chocolate', 'Porción de torta con cacao y crema.', 22.00, 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?auto=format&fit=crop&w=800&q=80')
) as d(telefono, producto, descripcion, precio, imagen)
join public.negocios n on n.telefono = d.telefono;

commit;
