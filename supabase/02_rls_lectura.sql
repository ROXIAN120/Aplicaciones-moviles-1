alter table public.negocios enable row level security;
alter table public.productos enable row level security;
alter table public.consultas enable row level security;
alter table public.reservas enable row level security;
alter table public.pedidos enable row level security;
alter table public.pedido_items enable row level security;

revoke all on public.negocios from anon, authenticated;
revoke all on public.productos from anon, authenticated;
revoke all on public.consultas from anon, authenticated;
revoke all on public.reservas from anon, authenticated;
revoke all on public.pedidos from anon, authenticated;
revoke all on public.pedido_items from anon, authenticated;

grant select on public.negocios to anon, authenticated;
grant select on public.productos to anon, authenticated;

drop policy if exists "lectura publica negocios activos" on public.negocios;
create policy "lectura publica negocios activos"
  on public.negocios
  for select
  to anon, authenticated
  using (activo = true);

drop policy if exists "lectura publica productos disponibles" on public.productos;
create policy "lectura publica productos disponibles"
  on public.productos
  for select
  to anon, authenticated
  using (
    disponible = true
    and exists (
      select 1
      from public.negocios
      where negocios.id = productos.negocio_id
        and negocios.activo = true
    )
  );
