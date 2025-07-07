{{
    config(
        materialized='table'
    )
}}

select 
    unt.movie_id,
    movie_title,
    genre,
    studio,
    unt.month,
    unt.location_id,
    total_rental_cost,
    tickets_sold,
    revenue
from {{ ref('union_nj_tables') }} as unt
left join int_invoices as inv
    on unt.movie_id = inv.movie_id
    and unt.month = inv.month
    and unt.location_id = inv.location_id
left join stg_movie_cat mov
on unt.movie_id = mov.movie_id
order by unt.location_id, unt.month, unt.movie_id

