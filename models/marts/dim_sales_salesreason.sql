{{ config(materialized='table') }}

with
    staging as (
        select *
        from {{ ref('stg_sales_salesreason') }}
)   
    , transformed as (
        select

            row_number() over (order by salesreasonid) as salesreason_sk -- auto incremental surrogate key
            , salesreasonid
            , salesorderid 
            , name	
            , reasontype		
        from staging
)

select * from transformed