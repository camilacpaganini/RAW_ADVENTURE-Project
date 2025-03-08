WITH fonte_endereco AS (
    SELECT *
    FROM {{ source('erp', 'Address') }}
)
, renomeado AS (
    SELECT 
        CAST(addressid AS INT) AS pk_endereco,
        CAST(city AS VARCHAR) AS nome_cidade,
        CAST(stateprovinceid AS INT) AS fk_estado_provincia,
        CAST(modifieddate AS TIMESTAMP) AS modified_date_endereco
    FROM fonte_endereco
)

SELECT * FROM renomeado
