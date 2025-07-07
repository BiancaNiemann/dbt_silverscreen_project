select 
    movie_id,
    month,
    location_id,
    weekly_price as weekly_rental_cost,
    total_invoice as total_rental_cost
from {{ source('silverscreen', 'invoices') }}