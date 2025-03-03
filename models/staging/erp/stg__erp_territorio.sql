with 
    fonte_territorios as (
        select *
        from {{ source('erp', 'SalesTerritory') }}
    )
,   renomeando as (
        select 
            cast(territoryid as int) as pk_territorio
        ,   cast(name as varchar) as nome_territorio
        ,   cast(countryregioncode as varchar) as codigo_pais_regiao
        ,   cast("group" as varchar) as grupo_territorio  
        ,   cast(modifieddate as timestamp) as modified_date_territorio
        from fonte_territorios
    )

select *
from renomeando

