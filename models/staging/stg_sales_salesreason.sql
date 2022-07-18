with
    source_data as (
        select
            salesreasonid	
            , name	
            , reasontype
            
        from {{ source('adventure','sales_salesreason') }}
    )

    , source_data2 as (
        select
            salesorderid	
            , salesreasonid	
    
        from {{ source('adventure','sales_salesorderheadersalesreason') }}
    )

select source_data2.salesorderid, source_data.* 
from source_data2 
left join source_data on source_data2.salesreasonid	=  source_data.salesreasonid