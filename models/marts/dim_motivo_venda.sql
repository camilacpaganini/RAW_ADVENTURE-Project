with 
    dim_motivo_venda as (
        select *
        from {{ ref('int__prep_motivo_venda') }}
    )

select *
from dim_motivo_venda
