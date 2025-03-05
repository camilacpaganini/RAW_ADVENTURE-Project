with 
    dim_status_pedido as (
        select *
        from {{ ref('int__prep_status_pedido') }}
    )

select *
from dim_status_pedido
