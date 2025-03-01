with
    fonte_subcategorias as (
        select *
        from {{ source('erp', 'ProductSubcategory') }}
    )
,   renomeando as (
        select
            cast(PRODUCTSUBCATEGORYID as int) as pk_subcategoriaproduto
        ,   cast(PRODUCTCATEGORYID as int) as fk_categoriaproduto
        ,   cast(NAME as varchar) as nome_subcategoria
        from fonte_subcategorias
    )
select *
from renomeando




