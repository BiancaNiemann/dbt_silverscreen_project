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
    coalesce(total_rental_cost, 0) as total_rental_cost,
    tickets_sold as total_tickets_sold,
    revenue as total_revenue,
    (revenue-(coalesce(total_rental_cost, 0))) as profit
from {{ ref('union_nj_tables') }} as unt
left join {{ ref('int_invoices') }} as inv
    on unt.movie_id = inv.movie_id
    and unt.month = inv.month
    and unt.location_id = inv.location_id
left join {{ ref('stg_movie_cat') }} as mov
on unt.movie_id = mov.movie_id


