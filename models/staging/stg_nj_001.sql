select 
    to_date(date_trunc('month', timestamp)) as month,
    movie_id,
    ticket_amount as tickets_sold,
    price as ticket_price,
    ticket_amount*price as revenue,
    'NJ_001' as location_id
from {{ source('silverscreen', 'nj_001') }}

