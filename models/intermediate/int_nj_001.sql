select 
    month,
    movie_id,
    location_id,
    sum(tickets_sold) as tickets_sold,
    sum(revenue) as revenue
from {{ ref('stg_nj_001') }}
group by month, movie_id, location_id
