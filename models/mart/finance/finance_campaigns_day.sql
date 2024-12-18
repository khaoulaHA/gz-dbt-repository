select date_date ,
(operational_margin - ads_cost) as ads_margin,
ROUND(average_basket,2) AS average_basket,
operational_margin,
ads_cost,
ads_impression,
ads_click,
quantity,
revenue,
purchase_cost,
margin,
shipping_fee,
logcost,
ship_cost
from {{ ref('int_campaigns_day') }} 
FULL OUTER JOIN  {{ ref('finance_days') }} using (date_date)
ORDER BY date_date DESC