with 
    cliente as (
        select *
        from {{ ref('stg__erp_cliente') }}
    )
,   pessoa as (
        select *
        from {{ ref('stg__erp_pessoa') }}
    )
,   consolidado as (
        select
            cliente.pk_cliente
        ,   cliente.fk_pessoa_cliente
        ,   cliente.fk_loja_cliente
        ,   cliente.fk_territorio_cliente
        ,   coalesce(pessoa.nome_completo_cliente, 'Cliente Desconhecido') as nome_cliente
        ,   cliente.modified_date_cliente
        from cliente
        left join pessoa 
            on cliente.fk_pessoa_cliente = pessoa.pk_pessoa
    )

select *
from consolidado


