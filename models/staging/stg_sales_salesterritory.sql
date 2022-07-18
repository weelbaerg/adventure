with
    source_data as (
        select
            territoryid
            , name
            , countryregioncode
            , salesytd
            , saleslastyear
            , costytd
            , costlastyear	
            , rowguid
            , modifieddate
    
        from {{ source('adventure','sales_salesterritory') }}
    )

select * from source_data