with 
    motivo_venda as (
        select *
        from {{ ref('stg__erp_motivo_venda') }}
    )

select *
from motivo_venda
