with
    purchase_src as (
        select
            product.products_id,
            sale.orders_id,
            sale.revenue,
            sale.quantity,
            sale.date_date,
            cast(product.purchase_price * sale.quantity as float64) as purchase_cost
        from {{ ref("stg_raw__product") }} as product
        join {{ ref("stg_raw__sales") }} as sale using (products_id)
    ),
    margin_src as (
        select
            products_id,
            orders_id,
            purchase_cost,
            revenue,
            quantity,
            date_date,
            cast(revenue - purchase_cost as float64) as margin
        from purchase_src
    )
select      orders_id,
            products_id,
            date_date,
            purchase_cost,
            revenue,
            quantity,
            margin
from margin_src
