select 
    movie_id,
    movie_title,
    release_date,
    coalesce(genre, 'Unknown') as genre,
    studio,
    coalesce(rating, 'Unknown') as rating,
    coalesce(minutes, 0) as minutes
from {{ source('silverscreen', 'movie_catalogue') }}