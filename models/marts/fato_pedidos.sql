with 
    fato_pedidos as (
        select *
        from {{ ref('int__prep_pedidos') }}
    )

select *
from fato_pedidos
