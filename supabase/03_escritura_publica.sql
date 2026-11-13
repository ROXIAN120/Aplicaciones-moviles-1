grant insert on public.consultas to anon, authenticated;
grant insert on public.reservas to anon, authenticated;

drop policy if exists "crear consultas validas" on public.consultas;
create policy "crear consultas validas"
  on public.consultas
  for insert
  to anon, authenticated
  with check (
    char_length(trim(nombre_cliente)) between 2 and 80
    and telefono ~ '^[67][0-9]{7}$'
    and char_length(trim(mensaje)) between 10 and 1000
    and exists (
      select 1
      from public.negocios
      where negocios.id = consultas.negocio_id
        and negocios.activo = true
    )
  );
-- Fin de las políticas de escritura pública.
drop policy if exists "crear reservas validas" on public.reservas;
create policy "crear reservas validas"
  on public.reservas
  for insert
  to anon, authenticated
  with check (
    char_length(trim(nombre_cliente)) between 2 and 80
    and telefono ~ '^[67][0-9]{7}$'
    and personas between 1 and 50
    and (fecha + hora) > timezone('America/La_Paz', now())
    and exists (
      select 1
      from public.negocios
      where negocios.id = reservas.negocio_id
        and negocios.activo = true
    )
  );

