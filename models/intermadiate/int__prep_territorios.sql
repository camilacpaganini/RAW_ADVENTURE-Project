WITH 
    territorio AS (
        SELECT 
            pk_territorio,
            nome_territorio,
            codigo_pais_regiao,
            grupo_territorio,
            modified_date_territorio
        FROM {{ ref('stg__erp_territorio') }}
    ),

    estado_provincia AS (
        SELECT 
            pk_estado_provincia, 
            nome_estado_provincia,
            codigo_estado_provincia,
            fk_territorio,
            modified_date_estado_provincia
        FROM {{ ref('stg__erp_estadocidade') }}
    ),

    cidade_agrupada AS (
        SELECT 
            fk_estado_provincia,
            LISTAGG(DISTINCT nome_cidade, ', ') WITHIN GROUP (ORDER BY nome_cidade) AS cidades
        FROM {{ ref('stg__erp_endereco') }}
        GROUP BY fk_estado_provincia
    ),

    consolidado AS (
        SELECT 
            estado_provincia.pk_estado_provincia || '-' || COALESCE(cidade_agrupada.cidades, 'Sem Cidade') AS pk_estado_cidade, -- PK composta
            estado_provincia.pk_estado_provincia,  
            territorio.pk_territorio AS fk_territorio,  
            estado_provincia.nome_estado_provincia,
            estado_provincia.codigo_estado_provincia,
            COALESCE(cidade_agrupada.cidades, 'Desconhecido') AS cidade, -- Ajuste do nome
            territorio.nome_territorio,
            territorio.codigo_pais_regiao,
            territorio.grupo_territorio,
            territorio.modified_date_territorio,
            estado_provincia.modified_date_estado_provincia
        FROM estado_provincia
        LEFT JOIN territorio 
            ON estado_provincia.fk_territorio = territorio.pk_territorio
        LEFT JOIN cidade_agrupada 
            ON estado_provincia.pk_estado_provincia = cidade_agrupada.fk_estado_provincia
    )

SELECT * FROM consolidado



