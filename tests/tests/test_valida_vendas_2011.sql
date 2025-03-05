/*   
    Este teste garante que as vendas brutas de 2011 estão
    corretas com o valor auditado fornecido por Carlos:
    $12.646.112,16
*/

with
    vendas_em_2011 as (
        select sum(total_bruto) as soma_total_bruto
        from {{ ref('fato_pedidos') }}
        where data_pedido between '2011-01-01' and '2011-12-31'
    )

select soma_total_bruto
from vendas_em_2011
where soma_total_bruto not between 12646112.00 and 12646113.00
