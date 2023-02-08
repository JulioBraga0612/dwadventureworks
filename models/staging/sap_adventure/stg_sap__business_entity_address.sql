with
    source_businessentityaddress as (
        select
            cast(addressid as int) as id_address
            , cast(businessentityid as int) as id_sales_person
        from {{ source('adw', 'businessentityaddress') }}     
    )

select *
from source_businessentityaddress
