with
    source_person as (
        select
            cast( businessentityid as int) as id_businessentity
            , cast(title as string) as title
            , cast(firstname as string) as firstname
            , cast(middlename as string) as middlename
            , cast(lastname as string) as lastname
            , cast(persontype as string) as persontype
            , cast(namestyle as string) as namestyle
            , cast(suffix as string) as suffix
            , cast(modifieddate as TIMESTAMP) as date_modificed
            , cast(rowguid as string) as rowguid	
            , cast(emailpromotion as string) as emailpromotion
        from {{source('adw', 'person' )}}
    )
    select *
    from source_person