with 
    dim_lojas as (
        select *
        from {{ ref('int__prep_lojas') }}
    )

select *
from dim_lojas
