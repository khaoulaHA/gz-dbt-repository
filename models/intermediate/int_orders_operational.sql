with
    source as (
        select orders_marg.orders_id, 
               orders_marg.date_date, 
               orders_marg.revenue, 
               orders_marg.qty , 
               orders_marg.purchase_cost,
               orders_marg.margin,
               ship.shipping_fee,
               ship.logcost,
               ship.ship_cost
        from {{ ref("int_orders_margin") }} as orders_marg
        join {{ ref("stg_raw__ship") }} as ship using (orders_id)
    ),  -- Operational_margin = margin + shipping_fee - log_cost - ship_cost
    opt_margin as (
        select
            orders_id,
            date_date,
            (margin + shipping_fee - logcost - ship_cost) as opt_margin,
            qty,
            revenue,
            margin
        from source
    )

select *
from opt_margin
