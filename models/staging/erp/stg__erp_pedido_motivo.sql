with 
    fonte_pedido_motivo as (
        select * 
        from {{ source('erp', 'SalesOrderHeaderSalesReason') }}
    )
,   renomeado as (
        select 
            cast(SALESORDERID as int) as fk_pedido
        ,   cast(SALESREASONID as int) as fk_motivo_venda
        from fonte_pedido_motivo
    )

select *
from renomeado

