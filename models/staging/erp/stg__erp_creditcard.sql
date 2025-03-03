with 
    fonte_cartao as (
        select *
        from {{ source('erp', 'CreditCard') }}
    )
,   renomeando as (
        select 
            cast(creditcardid as int) as pk_cartao_credito
        ,   cast(cardtype as varchar) as tipo_cartao
        ,   cast(cardnumber as varchar) as numero_cartao
        ,   cast(expmonth as int) as mes_expiracao
        ,   cast(expyear as int) as ano_expiracao
        ,   cast(modifieddate as timestamp) as data_modificacao_cartao
        from fonte_cartao
    )

select *
from renomeando

