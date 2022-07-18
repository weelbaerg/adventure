with
    source_data as (
        select
            productid		
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
            , rowguid
            , modifieddate	
    
        from {{ source('adventure','product') }}
    )

    , source_data_2 as (
        select
            salesorderid		
            , productid		
    
        from {{ source('adventure','sales_salesorderdetail') }}
    )

select source_data_2.salesorderid, source_data.* 
from source_data_2 
left join source_data on source_data_2.productid =  source_data.productid