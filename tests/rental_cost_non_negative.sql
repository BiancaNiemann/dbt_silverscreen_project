select month, total_rental_cost
from {{ ref("final_cost_revenue_table") }}
where total_rental_cost < 0
