{{ config(materialized='table') }}

with
    staging as (
        select *
        from {{ ref('stg_sales_salesterritory') }}
)
    , transformed as (
        select

            row_number() over (order by territoryid) as territory_sk -- auto incremental surrogate key
            , territoryid
            , name
            , countryregioncode
            , salesytd
            , saleslastyear
            , costytd
            , costlastyear	
            , rowguid
            , modifieddate		
        from staging     
)

select * from transformed