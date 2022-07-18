{{ config(materialized='table') }}

with
    staging as (
        select *
        from {{ ref('stg_sales_salesorderdetail') }}
)
    , transformed as (
        select
            row_number() over (order by salesorderdetailid) as salesorderdetail_sk -- auto incremental surrogate key
            , salesorderid		
            , salesorderdetailid		
            , carriertrackingnumber		
            , orderqty	
            , productid		
            , specialofferid		
            , unitprice		
            , unitpricediscount	
            , rowguid	
            , modifieddate			
        from staging     
)

select * from transformed