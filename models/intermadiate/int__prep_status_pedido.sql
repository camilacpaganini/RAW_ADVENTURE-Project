with 
    status_pedido as (
        select * 
        from {{ ref('stg__erp_status_pedido') }}
    )
,   consolidado as (
        select
            status_pedido.pk_status_pedido,
            status_pedido.descricao_status_pedido
        from status_pedido
    )

select *
from consolidado