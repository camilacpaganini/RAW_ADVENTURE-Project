WITH 
    territorio AS (
        SELECT 
            pk_territorio,
            nome_territorio,
            codigo_pais_regiao,
            grupo_territorio,
            modified_date_territorio
        FROM {{ ref('stg__erp_territorio') }}
    )
,   estado_provincia AS (
        SELECT 
            pk_estado_provincia,
            nome_estado_provincia,
            codigo_estado_provincia,
            fk_territorio,
            modified_date_estado_provincia
        FROM {{ ref('stg__erp_estadocidade') }}
    )
,   consolidado AS (
        SELECT 
            CAST(territorio.pk_territorio AS STRING) || '-' || 
            COALESCE(CAST(estado_provincia.pk_estado_provincia AS STRING), '-1') AS pk_territorio_estado
        ,   territorio.pk_territorio AS fk_territorio
        ,   estado_provincia.pk_estado_provincia AS fk_estado_provincia
        ,   territorio.nome_territorio
        ,   estado_provincia.nome_estado_provincia
        ,   territorio.codigo_pais_regiao
        ,   estado_provincia.codigo_estado_provincia
        ,   territorio.grupo_territorio
        ,   territorio.modified_date_territorio
        ,   estado_provincia.modified_date_estado_provincia
        FROM territorio
        LEFT JOIN estado_provincia 
            ON territorio.pk_territorio = estado_provincia.fk_territorio
    )

SELECT * FROM consolidado

