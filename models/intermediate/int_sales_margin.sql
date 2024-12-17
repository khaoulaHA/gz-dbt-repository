with
    purchase_src as (
        select
            product.products_id,
            sale.revenue,
            cast(product.purchase_price * sale.quantity as float64) as purchase_cost
        from {{ ref("stg_raw__product") }} as product
        join {{ ref("stg_raw__sales") }} as sale using (products_id)
    ),
    margin_src as (
        select
            products_id,
            purchase_cost,
            cast(revenue - purchase_cost as float64) as margin
        from purchase_src
    )
select *
from margin_src
