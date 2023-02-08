with 
    
    stg_store as (
        select 
            id_sales_person
            , store_name
        from {{ref('stg_sap__store')}}
    )

    , stg_person as (
        select
            id_sales_person
            , title
            , full_name
        from {{ref('stg_sap__person')}}
    )
     
    , business_entity_adress as (
        select
            id_address
            , id_sales_person
        from {{ ref('stg_sap__business_entity_address') }}
    )

    , joined_person_store as (
        select
            stg_store.id_sales_person
            , stg_store.store_name
            , stg_person.title
            , stg_person.full_name
            , business_entity_adress.id_address
        from  stg_store 
        left join stg_person on stg_store .id_sales_person = stg_person.id_sales_person
        left join business_entity_adress on stg_person.id_sales_person = business_entity_adress.id_sales_person
    )
    , stg_customer as (
        select 
            id_customer
            , id_person
            , id_store
            , id_territory
        from {{ref('stg_sap__customer')}}
    )
    
    , int_location as (
        select *
        from {{ ref('int__location_joined') }}
    )
     
    , joined_location as (
        select
            joined_person_store.id_sales_person
            , joined_person_store.store_name
            , joined_person_store.title
            , joined_person_store.full_name
            , joined_person_store.id_address
            , id_customer
            , id_person
            , id_store
            , int_location.city
            , int_location.state_name
            , int_location.country_name
            , int_location.state_province_code
            , int_location.country_region_code
        from int_location
        left join stg_customer as cust
            on int_location.id_territory = cust.id_territory
        left join joined_person_store
            on int_location.id_territory = int_location.id_territory
    )

select *
from joined_location
