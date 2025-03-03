with 
    dim_cartoes as (
        select *
        from {{ ref('int__prep_creditcard') }}
    )

select *
from dim_cartoes
