with 
    territorio as (
        select *
        from {{ ref('stg__erp_territorio') }}
    )
,   consolidado as (
        select
            territorio.pk_territorio
        ,   territorio.nome_territorio
        ,   territorio.codigo_pais_regiao
        ,   territorio.grupo_territorio
        ,   territorio.modified_date_territorio
        from territorio
    )

select *
from consolidado
