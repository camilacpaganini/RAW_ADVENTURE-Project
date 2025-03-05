with 
    fonte_motivo_venda as (
        select *
        from {{ source('erp', 'SalesReason') }}
    )
,   renomeando as (
        select 
            cast(salesreasonid as int) as pk_motivo_venda
        ,   cast(name as varchar) as nome_motivo_venda
        ,   cast(reasontype as varchar) as tipo_motivo_venda
        from fonte_motivo_venda
    )

select *
from renomeando
