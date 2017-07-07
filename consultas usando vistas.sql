create view truePedidos(numero) as
select distinct contiene.pedido from contiene, platos
where platos.precio > 15 and contiene.PLATO = platos.NOMBREPLATO;
create view trueClientes (dni) as
select pedidos.cliente 
from TRUEPEDIDOS, pedidos where pedidos.CODIGO = TRUEPEDIDOS.NUMERO;*/
select clientes.dni, clientes.nombre from trueClientes, clientes
where clientes.dni = trueClientes.dni;


create view ResPorAreas(codigo, n_res) as
select distinct codigo_postal, count(codigo) from restaurantes group by CODIGO_POSTAL;
select clientes.dni, clientes.nombre, clientes.apellido, resporareas.codigo, resporareas.n_res
from clientes, resporareas
where clientes.CODIGOPOSTAL = resporareas.codigo;



