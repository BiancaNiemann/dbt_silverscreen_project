select *
from {{ source('silverscreen', 'movie_catalogue') }}