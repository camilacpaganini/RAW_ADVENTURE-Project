with 
    fonte_customer as (
        select *
        from {{ source('erp', 'Customer') }}
    )
,   renomeando as (
        select 
            cast(customerid as int) as pk_cliente
        ,   cast(personid as int) as fk_pessoa_cliente
        ,   cast(storeid as int) as fk_loja_cliente
        ,   cast(territoryid as int) as fk_territorio_cliente
        ,   cast(modifieddate as timestamp) as modified_date_cliente
        from fonte_customer
    )

select *
from renomeando




