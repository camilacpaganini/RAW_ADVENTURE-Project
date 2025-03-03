with 
    fonte_pessoa as (
        select *
        from {{ source('erp', 'Person') }}
    )
,   renomeando as (
        select 
            cast(businessentityid as int) as pk_pessoa
        ,   coalesce(firstname, '') || ' ' || coalesce(lastname, '') as nome_completo_cliente
        from fonte_pessoa
    )

select *
from renomeando
