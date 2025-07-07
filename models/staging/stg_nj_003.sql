select 
    to_date(date_trunc('month', timestamp)) as month,
    details as movie_id,
    amount as tickets_sold,
    price as ticket_price,
    amount*price as revenue,
    'NJ_003' as location_id
from {{ source('silverscreen', 'nj_003') }}
where product_type = 'ticket'