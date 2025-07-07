select *
from {{ source('silverscreen', 'invoices') }}