{{ config(materialized='table') }}

with
    staging as (
        select *
        from {{ ref('stg_product') }}
)
    , transformed as (
        select


            row_number() over (order by productid) as product_sk -- auto incremental surrogate key
            , productid	
            , salesorderid 
            , name		
            , productnumber		
            , makeflag
            , finishedgoodsflag
            , color
            , safetystocklevel
            , reorderpoint
            , standardcost
            , listprice
            , size
            , sizeunitmeasurecode
            , weightunitmeasurecode
            , weight	
            , daystomanufacture	
            , productline
            , class
            , style
            , productsubcategoryid	
            , productmodelid	
            , sellstartdate	
            , sellenddate
            , discontinueddate		
        from staging     
)

select * from transformed