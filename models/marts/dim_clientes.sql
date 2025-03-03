with 
    dim_clientes as (
        select *
        from {{ ref('int__prep_clientes') }}
    )

select *
from dim_clientes

