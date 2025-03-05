with 
    calendario as (
        -- Gerando uma sequência de datas de 2011-01-01 a 2015-12-31 (~5 anos)
        select 
            dateadd(day, seq4(), '2011-01-01') as data_completa
        from table(generator(rowcount => 1826)) -- 5 anos (~365 * 5 dias)
    )
,   transformado as (
        select
            cast(to_char(calendario.data_completa, 'YYYYMMDD') as int) as pk_data
        ,   calendario.data_completa
        ,   year(calendario.data_completa) as ano
        ,   month(calendario.data_completa) as mes
        ,   day(calendario.data_completa) as dia
        ,   quarter(calendario.data_completa) as trimestre
        ,   weekofyear(calendario.data_completa) as semana_ano
        ,   case 
                when dayofweek(calendario.data_completa) = 0 then 7  -- Ajuste do Sábado
                else dayofweek(calendario.data_completa)
            end as dia_semana
        ,   coalesce(
                case 
                    when dayofweek(calendario.data_completa) = 1 then 'Domingo'
                    when dayofweek(calendario.data_completa) = 2 then 'Segunda-feira'
                    when dayofweek(calendario.data_completa) = 3 then 'Terça-feira'
                    when dayofweek(calendario.data_completa) = 4 then 'Quarta-feira'
                    when dayofweek(calendario.data_completa) = 5 then 'Quinta-feira'
                    when dayofweek(calendario.data_completa) = 6 then 'Sexta-feira'
                    when dayofweek(calendario.data_completa) in (7, 0) then 'Sábado' -- Correção para sábado
                    else 'Erro na Data'  -- Capturar qualquer outro erro
                end, 'Erro na Data'
            ) as nome_dia_semana
        ,   coalesce(
                case 
                    when month(calendario.data_completa) = 1 then 'Janeiro'
                    when month(calendario.data_completa) = 2 then 'Fevereiro'
                    when month(calendario.data_completa) = 3 then 'Março'
                    when month(calendario.data_completa) = 4 then 'Abril'
                    when month(calendario.data_completa) = 5 then 'Maio'
                    when month(calendario.data_completa) = 6 then 'Junho'
                    when month(calendario.data_completa) = 7 then 'Julho'
                    when month(calendario.data_completa) = 8 then 'Agosto'
                    when month(calendario.data_completa) = 9 then 'Setembro'
                    when month(calendario.data_completa) = 10 then 'Outubro'
                    when month(calendario.data_completa) = 11 then 'Novembro'
                    when month(calendario.data_completa) = 12 then 'Dezembro'
                    else 'Desconhecido'
                end, 'Desconhecido'
            ) as nome_mes
        ,   case 
                when dayofweek(calendario.data_completa) in (1, 7) then 1
                else 0
            end as eh_fim_de_semana
        ,   case 
                when dayofweek(calendario.data_completa) = 1 then 0 -- Domingo
                else 1 -- Dias úteis
            end as eh_dia_util
        ,   case 
                when month(calendario.data_completa) in (1, 7) then 'Alta Temporada'
                else 'Baixa Temporada'
            end as categoria_temporada
        from calendario
    )

select *
from transformado




