with 
    fonte_pedido_detalhes as (
        select * 
        from {{ source('erp', 'SalesOrderDetail') }}
    )
,   renomeado as (
        select 
            SALESORDERID::varchar || '-' || SALESORDERDETAILID::varchar as pk_pedido_detalhe
        ,   cast(SALESORDERID as int) as fk_pedido
        ,   cast(PRODUCTID as int) as fk_produto
        ,   cast(ORDERQTY as int) as quantidade
        ,   cast(UNITPRICE as numeric(18,4)) as preco_unitario
        ,   cast(UNITPRICEDISCOUNT as numeric(18,4)) as desconto
        from fonte_pedido_detalhes
    )

select *
from renomeado
