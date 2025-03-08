WITH fonte_estadocidade AS (
    SELECT *
    FROM {{ source('erp', 'StateProvince') }}
)
, renomeado AS (
    SELECT 
        CAST(stateprovinceid AS INT) AS pk_estado_provincia
    ,   CAST(stateprovincecode AS VARCHAR) AS codigo_estado_provincia
    ,   CAST(countryregioncode AS VARCHAR) AS codigo_pais_regiao
    ,   CAST(name AS VARCHAR) AS nome_estado_provincia
    ,   CAST(territoryid AS INT) AS fk_territorio
    ,   CAST(modifieddate AS TIMESTAMP) AS modified_date_estado_provincia
    ,   stateprovinceid::VARCHAR || '-' || COALESCE(territoryid::VARCHAR, '-1') AS pk_territorio_estado
    FROM fonte_estadocidade
)

SELECT * FROM renomeado
