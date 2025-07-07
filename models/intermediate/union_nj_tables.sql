select *
from {{ ref('int_nj_001') }}
union
select *
from {{ ref('int_nj_002') }}
union
select *
from {{ ref('int_nj_003') }}
