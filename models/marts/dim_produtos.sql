with
    dim_produtos as (
        select *
        from {{ ref('int__prep_produtos') }}
    )

select *
from dim_produtos