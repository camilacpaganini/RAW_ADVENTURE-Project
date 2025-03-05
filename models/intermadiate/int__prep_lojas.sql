with 
    lojas as (
        select *
        from {{ ref('stg__erp_lojas') }}
    )
,   consolidado as (
        select
            lojas.pk_loja
        ,   lojas.nome_loja
        ,   lojas.fk_vendedorloja
        ,   lojas.dados_demograficosloja
        ,   lojas.modificadoloja_em
        from lojas
    )

select *
from consolidado
