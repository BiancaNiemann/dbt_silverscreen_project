select 
    month,
    movie_id,
    location_id,
    sum(tickets_sold) as tickets_sold,
    sum(ticket_price) as ticket_price,
    sum(revenue) as revenue
from {{ ref('stg_nj_002') }}
group by month, movie_id, location_id
order by month