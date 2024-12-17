select orders_id, date_date, sum(revenue ) as revenue, sum(quantity) as qty , sum(purchase_cost) as purchase_cost, sum(margin) as margin
from {{ ref("int_sales_margin") }}
group by orders_id, date_date
order by date_date