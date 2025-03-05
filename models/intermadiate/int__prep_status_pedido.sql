with 
    status_pedido as (
        select *
        from {{ ref('stg__erp_status_pedido') }}
    )

select *
from status_pedido
