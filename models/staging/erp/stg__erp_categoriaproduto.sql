with
    fonte_categorias as (
        select *
        from {{ source('erp', 'ProductCategory') }}
    )
,   renomeando as (  
        select
            cast(PRODUCTCATEGORYID as int) as pk_categoriaproduto
        ,   cast(NAME as varchar) as nome_categoriaproduto
        from fonte_categorias
    )

select *
from renomeando






