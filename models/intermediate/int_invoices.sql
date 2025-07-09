select 
    month,
    movie_id,
    location_id,
    sum(total_rental_cost) as total_rental_cost
from {{ ref('stg_invoices') }}
group by month, movie_id, location_id
