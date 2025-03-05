with 
    fonte_lojas as (
        select *
        from {{ source('erp', 'Store') }}
    )
,   renomeando as (
        select 
            cast(businessentityid as int) as pk_loja
        ,   cast(name as varchar) as nome_loja
        ,   cast(salespersonid as int) as fk_vendedorloja
        ,   cast(demographics as string) as dados_demograficosloja
        ,   cast(modifieddate as timestamp) as modificadoloja_em
        from fonte_lojas
    )

select *
from renomeando
