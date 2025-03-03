with 
    dim_territorios as (
        select *
        from {{ ref('int__prep_territorios') }}
    )

select *
from dim_territorios
