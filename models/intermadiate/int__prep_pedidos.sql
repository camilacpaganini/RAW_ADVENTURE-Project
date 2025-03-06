with 
    pedido as (
        select 
            p.*,
            c.fk_loja_cliente,   -- Adicionando FK_LOJA
            c.fk_territorio_cliente  -- Adicionando FK_TERRITÓRIO
        from {{ ref('stg__erp_pedido') }} p
        left join {{ ref('stg__erp_cliente') }} c 
            on p.fk_cliente = c.pk_cliente
    )

,   pedido_detalhes as (
        select * from {{ ref('stg__erp_pedido_detalhes') }}
    )

,   pedido_motivo as (
        select 
            fk_pedido, 
            listagg(cast(fk_motivo_venda as varchar), ', ') within group (order by fk_motivo_venda) as motivos_venda
        from {{ ref('stg__erp_pedido_motivo') }}
        group by fk_pedido
    )

,   consolidado as (
        select 
            pedido_detalhes.pk_pedido_detalhe
        ,   pedido_detalhes.fk_pedido
        ,   pedido.fk_cliente
        ,   pedido.fk_loja_cliente  
        ,   pedido.fk_territorio_cliente  
        ,   pedido.fk_status_pedido
        ,   pedido.data_pedido
        ,   pedido.data_vencimento
        ,   pedido.data_envio
        ,   pedido.fk_cartao_credito
        ,   pedido.valor_subtotal
        ,   pedido.valor_imposto
        ,   pedido.valor_frete
        ,   pedido.valor_total
        ,   pedido_detalhes.fk_produto
        ,   pedido_detalhes.quantidade
        ,   pedido_detalhes.preco_unitario
        ,   pedido_detalhes.desconto
        ,   pedido_detalhes.preco_unitario * pedido_detalhes.quantidade as total_bruto
        ,   pedido_detalhes.preco_unitario * (1 - pedido_detalhes.desconto) * pedido_detalhes.quantidade as total_liquido
        ,   coalesce(pedido.valor_frete / nullif(count(*) over(partition by pedido.pk_pedido), 0), 0) as frete_rateado
        ,   case
                when pedido_detalhes.desconto > 0 then true
                else false
            end as teve_desconto
        ,   coalesce(pedido_motivo.motivos_venda, 'Desconhecido') as fk_motivo_venda
        from pedido_detalhes
        inner join pedido on pedido_detalhes.fk_pedido = pedido.pk_pedido
        left join pedido_motivo on pedido.pk_pedido = pedido_motivo.fk_pedido
    )

select *
from consolidado


