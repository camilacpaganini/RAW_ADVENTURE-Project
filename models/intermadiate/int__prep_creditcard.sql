with 
    cartao as (
        select *
        from {{ ref('stg__erp_creditcard') }}
    )
,   consolidado as (
        select
            cartao.pk_cartao_credito
        ,   cartao.tipo_cartao
        ,   cartao.numero_cartao
        ,   cartao.mes_expiracao
        ,   cartao.ano_expiracao
        ,   cartao.data_modificacao_cartao
        from cartao
    )

select *
from consolidado
