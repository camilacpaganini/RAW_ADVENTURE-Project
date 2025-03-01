with 
    produto as (
        select *
        from {{ ref('stg__erp_produto') }}
    )
,   subcategoria as (
        select *
        from {{ ref('stg__erp_subcategoriaproduto') }}
    )
,   categoria as (
        select *
        from {{ ref('stg__erp_categoriaproduto') }}
    )
,   consolidado as (
        select
            produto.pk_produto
        ,   produto.fk_subcategoriaproduto
        ,   subcategoria.fk_categoriaproduto
        ,   produto.nome_produto
        ,   produto.numero_produto
        ,   produto.lista_preco
        ,   produto.linha_produto
        ,   produto.classe_produto
        ,   produto.estilo_produto  
        ,   produto.dt_inicio_vendas  
        ,   produto.dias_para_fabricacao
        ,   produto.eh_fabricado_internamente
        ,   produto.eh_produto_final
        ,   coalesce(subcategoria.nome_subcategoria, 'Sem Subcategoria') as nome_subcategoria
        ,   coalesce(categoria.nome_categoriaproduto, 'Sem Categoria') as nome_categoriaproduto
        from produto
        left join subcategoria on produto.fk_subcategoriaproduto = subcategoria.pk_subcategoriaproduto
        left join categoria on subcategoria.fk_categoriaproduto = categoria.pk_categoriaproduto
    )

select *
from consolidado

