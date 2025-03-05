with 
    fonte_status_pedido as (
        select *
        from {{ source('erp', 'SalesOrderHeader') }}
    )
,   renomeando as (
        select 
            cast(status as int) as pk_status_pedido
        ,   concat('Status ', status) as descricao_status_pedido
        from fonte_status_pedido
    )

select distinct pk_status_pedido, descricao_status_pedido
from renomeando




