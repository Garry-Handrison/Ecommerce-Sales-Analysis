-- E-commerce Sales & Profit Analysis
-- PostgreSQL


-- =====================================================
-- 1. TABLE SETUP
-- =====================================================

drop Table if exists sales;

create table sales (
    order_id text,
    order_date date,
    order_time time,
    order_status text,
    sales_channel text,
    customer_id text,
    customer_name text,
    customer_age int,
    gender text,
    customer_segment text,
    customer_type text,
    customer_city text,
    customer_state text,
    customer_country text,
    region text,
    customer_postal_code text,
    payment_method text,
    payment_status text,
    currency text,
    shipping_method text,
    warehouse text,
    delivery_days numeric,
    estimated_delivery_days numeric,
    delivery_status text,
    return_status text,
    return_reason text,
    customer_rating numeric,
    review_sentiment text,
    customer_review text,
    marketing_channel text,
    campaign_name text,
    coupon_code text,
    loyalty_points_earned int,
    loyalty_points_redeemed int,
    quantity int,
    gross_sales numeric,
    discount_amount numeric,
    tax_amount numeric,
    shipping_cost numeric,
    net_sales numeric,
    product_cost numeric,
    profit numeric,
    profit_margin_percentage numeric,
    customer_lifetime_value numeric,
    is_repeat_customer text,
    customer_order_count int
);

copy sales
from 'Z:\py programming\Projects prep\project\Ecommerce Project\Dataset\sales_data.csv'
with (
    format csv,
    header true,
    delimiter ','
);


-- =====================================================
-- 2. UNDERSTANDING THE DATA
-- =====================================================

-- How many rows are there?
select count(*) as total_rows
from sales;


-- What time period does the data cover?
select
    min(order_date) as first_date,
    max(order_date) as last_date
from sales;


-- Number of orders and customers
select
    count(distinct order_id) as unique_orders,
    count(distinct customer_id) as unique_customers
from sales;


-- Check whether one row represents one order
select
    order_id,
    count(*) as rows_per_order
from sales
group by order_id
having count(*) > 1;


-- Order status distribution
select
    order_status,
    count(*) as total_orders
from sales
group by order_status
order by total_orders desc;


-- Payment status
select
    payment_status,
    count(*) as total_orders
from sales
group by payment_status
order by total_orders desc;


-- Return status
select
    return_status,
    count(*) as total_orders
from sales
group by return_status
order by total_orders desc;


-- =====================================================
-- 3. DATA QUALITY CHECKS
-- =====================================================

-- Check important missing values
select
    count(*) - count(customer_id) as missing_customer_id,
    count(*) - count(order_date) as missing_order_date,
    count(*) - count(net_sales) as missing_net_sales,
    count(*) - count(profit) as missing_profit,
    count(*) - count(return_status) as missing_return_status,
    count(*) - count(coupon_code) as missing_coupon_code,
    count(*) - count(campaign_name) as missing_campaign_name
from sales;


-- Check for negative sales values
select count(*) as negative_sales_orders
from sales
where net_sales < 0
   or gross_sales < 0;


-- How many orders are making a loss?
select count(*) as loss_making_orders
from sales
where profit < 0;


-- =====================================================
-- 4. OVERALL PERFORMANCE
-- =====================================================

select
    sum(net_sales) as total_net_sales,
    avg(net_sales) as avg_net_sales,
    sum(profit) as total_profit,
    avg(profit) as avg_profit
from sales;


-- =====================================================
-- 5. PROFIT BY ORDER STATUS
-- =====================================================

-- Which order statuses contribute most to profit?
select
    order_status,
    count(*) as total_orders,
    sum(profit) as total_profit
from sales
group by order_status
order by total_profit desc;


-- Where are the loss-making orders happening?
select
    order_status,
    count(*) as loss_orders,
    avg(profit) as avg_loss
from sales
where profit < 0
group by order_status
order by loss_orders desc;


-- =====================================================
-- 6. COUPON & CAMPAIGN
-- =====================================================

-- Coupon vs no coupon
select
    case
        when coupon_code is null then 'No Coupon'
        else 'Coupon Used'
    end as coupon_status,
    count(*) as total_orders,
    avg(profit) as avg_profit
from sales
group by coupon_status
order by avg_profit desc;


-- Campaign vs no campaign
select
    case
        when campaign_name is null then 'No Campaign'
        else 'Campaign Used'
    end as campaign_status,
    count(*) as total_orders,
    avg(profit) as avg_profit
from sales
group by campaign_status
order by avg_profit desc;


-- =====================================================
-- 7. DISCOUNT & PROFIT ANALYSIS
-- =====================================================

-- Are higher discounts associated with loss-making orders?
select
    case
        when profit < 0 then 'Negative-Profit'
        else 'Positive-Profit'
    end as profit_status,
    avg(discount_amount) as avg_discount
from sales
group by profit_status
order by avg_discount;


-- Which discount levels are creating the biggest losses?
select
    case
        when discount_amount < 200 then 'Low Discount'
        when discount_amount < 1000 then 'Medium Discount'
        else 'High Discount'
    end as discount_tier,
    count(*) as loss_orders,
    avg(profit) as avg_loss
from sales
where profit < 0
group by discount_tier
order by avg_loss;


-- Do high discounts always mean low profit?
select
    case
        when discount_amount < 200 then 'Low Discount'
        when discount_amount < 1000 then 'Medium Discount'
        else 'High Discount'
    end as discount_tier,
    count(*) as profitable_orders,
    avg(profit) as avg_profit
from sales
where profit > 0
group by discount_tier
order by avg_profit desc;


-- Overall performance of each discount tier
select
    case
        when discount_amount < 200 then 'Low Discount'
        when discount_amount < 1000 then 'Medium Discount'
        else 'High Discount'
    end as discount_tier,
    count(*) as total_orders,
    avg(profit) as avg_profit,
    sum(profit) as total_profit
from sales
group by discount_tier
order by total_profit desc;


-- =====================================================
-- FINAL INSIGHTS
-- =====================================================

-- 1. Low-discount orders generated the highest total profit
--    because they had the highest order volume.
--
-- 2. Medium-discount orders had the highest average profit
--    per order.
--
-- 3. Loss-making orders had much higher average discounts
--    than profitable orders.
--
-- 4. High discounts can still be profitable in some orders,
--    but they are also associated with larger losses.
--
-- 5. Discount performance should be evaluated using both
--    order volume and profit per order.

-- MY Strategic Recommendation: 
-- Do not evaluate discount strategies solely on total profit or order volume. 
-- A successful strategy must balance both order volume and profit per order to prevent heavy discount losses.
