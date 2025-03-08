WITH 
    pedido AS (
        SELECT DISTINCT  
            p.pk_pedido,
            p.fk_cliente,
            p.fk_status_pedido,
            p.data_pedido,
            p.data_vencimento,
            p.data_envio,
            p.fk_cartao_credito,
            p.valor_subtotal,
            p.valor_imposto,
            p.valor_frete,
            p.valor_total,
            c.fk_loja_cliente,
            c.fk_territorio_cliente,
            t.pk_estado_provincia  
        FROM {{ ref('stg__erp_pedido') }} p
        LEFT JOIN {{ ref('stg__erp_cliente') }} c 
            ON p.fk_cliente = c.pk_cliente
        LEFT JOIN (
            SELECT DISTINCT fk_territorio, MIN(pk_estado_provincia) AS pk_estado_provincia
            FROM {{ ref('int__prep_territorios') }}
            GROUP BY fk_territorio
        ) t  
            ON c.fk_territorio_cliente = t.fk_territorio  
    )
,   pedido_detalhes AS (
        SELECT DISTINCT  
            pk_pedido_detalhe,
            fk_pedido,
            fk_produto,
            quantidade,
            preco_unitario,
            desconto
        FROM {{ ref('stg__erp_pedido_detalhes') }}
    )
,   pedido_motivo AS (
        SELECT 
            fk_pedido, 
            ARRAY_TO_STRING(ARRAY_AGG(DISTINCT CAST(fk_motivo_venda AS VARCHAR)), ', ') AS motivos_venda
        FROM {{ ref('stg__erp_pedido_motivo') }}
        GROUP BY fk_pedido
    )
,   consolidado AS (
        SELECT 
            pd.pk_pedido_detalhe,
            pd.fk_pedido,
            p.fk_cliente,
            p.fk_loja_cliente,
            p.fk_territorio_cliente,
            p.pk_estado_provincia, 
            p.fk_status_pedido,
            p.data_pedido,
            p.data_vencimento,
            p.data_envio,
            p.fk_cartao_credito,
            p.valor_subtotal,
            p.valor_imposto,
            p.valor_frete,
            p.valor_total,
            pd.fk_produto,
            pd.quantidade,
            pd.preco_unitario,
            pd.desconto,
            pd.preco_unitario * pd.quantidade AS total_bruto,
            pd.preco_unitario * (1 - pd.desconto) * pd.quantidade AS total_liquido,

            -- 🔥 Garante um rateio correto do frete
            CAST((p.valor_frete / NULLIF(COUNT(pd.pk_pedido_detalhe) 
            OVER(PARTITION BY p.pk_pedido), 0)) AS NUMERIC(18,2)) AS frete_rateado,

            CASE 
                WHEN pd.desconto > 0 THEN TRUE 
                ELSE FALSE 
            END AS teve_desconto,

            COALESCE(pm.motivos_venda, 'Desconhecido') AS fk_motivo_venda

        FROM pedido_detalhes pd
        INNER JOIN pedido p 
            ON pd.fk_pedido = p.pk_pedido
        LEFT JOIN pedido_motivo pm
            ON p.pk_pedido = pm.fk_pedido
    )

SELECT * FROM consolidado




