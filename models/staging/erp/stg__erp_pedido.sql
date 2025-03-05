with 
    fonte_pedido as (
        select * 
        from {{ source('erp', 'SalesOrderHeader') }}
    )
,   renomeado as (
        select 
            cast(SALESORDERID as int) as pk_pedido
        ,   cast(CUSTOMERID as int) as fk_cliente
        ,   cast(STATUS as int) as fk_status_pedido
        ,   cast(ORDERDATE as date) as data_pedido
        ,   cast(DUEDATE as date) as data_vencimento
        ,   cast(SHIPDATE as date) as data_envio
        ,   cast(CREDITCARDID as int) as fk_cartao_credito
        ,   cast(SUBTOTAL as numeric(18,2)) as valor_subtotal
        ,   cast(TAXAMT as numeric(18,2)) as valor_imposto
        ,   cast(FREIGHT as numeric(18,2)) as valor_frete
        ,   cast(TOTALDUE as numeric(18,2)) as valor_total
        from fonte_pedido
    )

select *
from renomeado


