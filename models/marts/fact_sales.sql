{{ config(materialized='table') }}

with 
    sales_creditcard as (
        select
        creditcard_sk 
        , creditcardid
        , cardtype	
        from {{ref('dim_sales_creditcard')}}
    )

, sales_customer as (
        select
        customer_sk
        , customerid
        , firstname	
        , middlename	
        , lastname
        , fullname
        from {{ref('dim_sales_customer')}}
    )

, person_address as (
        select
          address_sk
        , addressid
        , city	
        , stateprovinceid
        from {{ref('dim_person_address')}}
)

, sales_product as (
        select
        product_sk
        , salesorderid
        , productid
        , name
        from {{ref('dim_product')}}
)

, sales_salesreason as (
        select
        salesreason_sk
        , salesreasonid
        , salesorderid
        , name
        , reasontype	
        from {{ref('dim_sales_salesreason')}}
)

, sales_salesorderdetail as (
        select
        salesorderdetail_sk
        , salesorderid
        , orderqty		
        , unitprice		
        , unitpricediscount
        , productid		
        from {{ref('dim_sales_salesorderdetail')}}
)

, sales_salesterritory as (
        select
        territory_sk
        , territoryid
        , name
        from {{ref('dim_sales_salesterritory')}}
)

, sales_orders_with_sk as (
        select
        sales_salesorderheader.salesorderid
        , sales_salesorderdetail.salesorderdetail_sk as salesorderdetail_fk
        , product.product_sk as product_fk
        , product.productid
        , product.name as product_name 
        , sales_customer.customer_sk as customer_fk
        , sales_customer.customerid
        , sales_customer.firstname as customer_firstname
        , sales_customer.middlename as custumer_middlename
        , sales_customer.lastname as customer_lastname
        , sales_customer.fullname as customer_fullname
        , sales_creditcard.creditcard_sk as creditcard_fk
        , sales_creditcard.creditcardid
        , sales_creditcard.cardtype as card_type
        , sales_salesterritory.territory_sk as territory_fk
        , sales_salesterritory.name as country
        , person_address.address_sk as address_sk
        , person_address.stateprovinceid
        , person_address.city
        , sales_salesreason.salesreason_sk as salesreason_fk
        , sales_salesreason.name as salesreason_name
        , sales_salesorderheader.orderdate
        , sales_salesorderheader.duedate	
        , sales_salesorderheader.shipdate
        , sales_salesorderheader.status
        , sales_salesorderheader.freight
        , sales_salesorderdetail.unitprice
        , sales_salesorderdetail.unitpricediscount
        , sales_salesorderdetail.orderqty
        , sales_salesorderheader.totaldue
        , sales_salesorderheader.subtotal
         from {{ref('stg_sales_salesorderheader')}} sales_salesorderheader
        left join sales_creditcard sales_creditcard on sales_salesorderheader.creditcardid = sales_creditcard.creditcardid
        left join sales_customer sales_customer on sales_salesorderheader.customerid = sales_customer.customerid
        left join sales_salesterritory sales_salesterritory on sales_salesorderheader.territoryid = sales_salesterritory.territoryid
        left join sales_salesorderdetail sales_salesorderdetail on sales_salesorderheader.salesorderid = sales_salesorderdetail.salesorderid
        left join sales_salesreason sales_salesreason on sales_salesorderheader.salesorderid = sales_salesreason.salesorderid
        left join product product on sales_salesorderheader.salesorderid = product.salesorderid
        left join person_address person_address on sales_salesorderheader.billtoaddressid = person_address.addressid
)
select * from sales_orders_with_sk