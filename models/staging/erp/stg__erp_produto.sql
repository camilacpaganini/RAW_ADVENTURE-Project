with 
    fonte_produto as (
        select *
        from {{ source('erp', 'Product') }}
    )
,   renomeando as (
        select
            cast(PRODUCTID as int) as pk_produto
        ,   cast(PRODUCTSUBCATEGORYID as int) as fk_subcategoriaproduto
        ,   cast(NAME as varchar) as nome_produto
        ,   cast(PRODUCTNUMBER as varchar) as numero_produto
        ,   cast(LISTPRICE as numeric(18,2)) as lista_preco
        ,   cast(PRODUCTLINE as varchar) as linha_produto
        ,   cast(CLASS as varchar) as classe_produto
        ,   cast(STYLE as varchar) as estilo_produto  
        ,   cast(SELLSTARTDATE as date) as dt_inicio_vendas  
        ,   cast(DAYSTOMANUFACTURE as int) as dias_para_fabricacao
        ,   cast(MAKEFLAG as boolean) as eh_fabricado_internamente
        ,   cast(FINISHEDGOODSFLAG as boolean) as eh_produto_final
        from fonte_produto
    )

select *
from renomeando





