select 
    to_date(date_trunc('month', date)) as month,
    movie_id,
    ticket_amount as tickets_sold,
    ticket_price as ticket_price,
    ticket_amount*ticket_price as revenue,
    'NJ_002' as location_id
from {{ source('silverscreen', 'nj_002') }}