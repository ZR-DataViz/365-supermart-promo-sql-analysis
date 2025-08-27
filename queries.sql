/* 
  Project: 365 Super Mart SQL Analysis
  File: subqueries.sql
  Author: Zohair Raza
  Date: 27/08/2025
  Notes: Tested on MySQL(365 Super Mart SQL Analysis)
  Description: This file contains SQL queries and subqueries used to analyze sales performance, promotional campaigns, and customer behavior for 365 Super Mart.
*/




--Top Performing Stores (by Incremental Revenue)
SELECT 
    s.store_id,
    s.city, 
    SUM((f.quantity_sold_after_promo - f.quantity_sold_before_promo) * f.base_price) AS IR

FROM dim_stores s
    JOIN fact_events f 
    ON s.store_id = f.store_id
    JOIN dim_campaigns c 
    ON f.campaign_id = c.campaign_id

GROUP BY s.store_id, s.city

ORDER BY IR DESC

LIMIT 10;




--Bottom Performing Stores (by Incremental Sold Units)
SELECT 
    s.store_id,
    s.city,
    SUM(f.quantity_sold_after_promo - f.quantity_sold_before_promo) as ISU

FROM dim_stores s
    JOIN fact_events f 
    ON s.store_id = f.store_id
    JOIN dim_campaigns c 
    ON f.campaign_id = c.campaign_id

GROUP BY s.store_id, s.city

ORDER BY ISU ASC

LIMIT 10;




--Store Performance by City (Average Incremental Revenue)
SELECT 
    s.city,
    COUNT(*) as store_count,
    AVG((f.quantity_sold_after_promo - f.quantity_sold_before_promo) * f.base_price) as AvgIR

FROM dim_stores s
    JOIN fact_events f 
    ON s.store_id = f.store_id
    JOIN dim_campaigns c 
    ON f.campaign_id = c.campaign_id

GROUP BY s.city

ORDER BY AvgIR DESC;




--Highest Incremental Revenue by Promotion Type
SELECT 
    f.promo_type,
    SUM((f.quantity_sold_after_promo - f.quantity_sold_before_promo) * f.base_price) as IR

FROM fact_events f

GROUP BY f.promo_type

ORDER BY IR DESC

LIMIT 2;




--Lowest Incremental Sold Units by Promotion Type
SELECT 
    f.promo_type,
    SUM(f.quantity_sold_after_promo - f.quantity_sold_before_promo) as ISU

FROM fact_events f

GROUP BY f.promo_type

ORDER BY ISU ASC

LIMIT 2;




--Comparing Promotion Effectiveness
SELECT
    CASE
        WHEN f.promo_type LIKE '%OFF' THEN 'Discount'
        WHEN f.promo_type IN ('BOGOF', '500 Cashback') THEN f.promo_type
        ELSE 'Other'
    END AS PromoCategory,
    SUM((f.quantity_sold_after_promo - f.quantity_sold_before_promo) * f.base_price) as IR,
    SUM(f.quantity_sold_after_promo - f.quantity_sold_before_promo) as ISU

FROM fact_events f

GROUP BY PromoCategory;




--Profit Margin vs. Sold Units
SELECT 
    f.promo_type,
    SUM(f.quantity_sold_after_promo - f.quantity_sold_before_promo) AS ISU,
    AVG(d.cost_margin) AS AvgMargin

FROM fact_events f
    JOIN dim_products p 
    ON f.product_code = p.product_code
    JOIN cost_margin d 
    ON f.product_code = d.product_code

GROUP BY f.promo_type

ORDER BY ISU DESC, AvgMargin DESC;




--Top Performing Categories (by Sales Lift)
SELECT 
    p.category,
    SUM(f.quantity_sold_after_promo - f.quantity_sold_before_promo) as SalesLift

FROM fact_events f
    JOIN dim_products p 
    ON f.product_code = p.product_code

GROUP BY p.category

ORDER BY SalesLift DESC;




--Top Performing Products (by Sales Lift)
SELECT * 
FROM (
    SELECT 
        p.product_code,
        p.product_name,
        SUM(f.quantity_sold_after_promo - f.quantity_sold_before_promo) as SalesLift

    FROM fact_events f
        JOIN dim_products p 
        ON f.product_code = p.product_code

    GROUP BY p.product_code, p.product_name

    ORDER BY SalesLift DESC

    LIMIT 5
) AS Top5

UNION ALL

SELECT * 
FROM (
    SELECT 
        p.product_code,
        p.product_name,
        SUM(f.quantity_sold_after_promo - f.quantity_sold_before_promo) as 
        
    FROM fact_events f
        JOIN dim_products p 
        ON f.product_code = p.product_code

    GROUP BY p.product_code, p.product_name

    ORDER BY SalesLift ASC

    LIMIT 5
) AS bottom_5;





--Category and Promotion Effectiveness
SELECT 
    p.category,
    f.promo_type,
    SUM((f.quantity_sold_after_promo - f.quantity_sold_before_promo) * f.base_price) as IR

FROM fact_events f
    JOIN dim_products p 
    ON f.product_code = p.product_code

GROUP BY p.category, f.promo_type

ORDER BY p.category, IR DESC;












