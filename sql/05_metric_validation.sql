
SELECT 
    saleid,
    customerid,
    productid,
    quantity,
    unitprice,
    discount,
    costperunit,
    (quantity * unitprice * (1 - discount)) AS revenue,
    (quantity * costperunit) AS cost,
    (quantity * unitprice * (1 - discount)) - (quantity * costperunit) AS margin
FROM sales
WHERE (quantity * unitprice * (1 - discount)) - (quantity * costperunit) < 0;

-- 2. Check for invalid discounts
SELECT *
FROM sales
WHERE discount < 0 OR discount > 1;

-- 3a. Aggregate revenue by product
SELECT 
    p.productname, 
    SUM(quantity * unitprice * (1 - discount)) AS total_revenue
FROM sales s
JOIN products p ON s.productid = p.productid
GROUP BY p.productname
ORDER BY total_revenue DESC;

-- 3b. Aggregate revenue by customer
SELECT 
    c.customername, 
    SUM(quantity * unitprice * (1 - discount)) AS total_revenue
FROM sales s
JOIN customers c ON s.customerid = c.customerid
GROUP BY c.customername
ORDER BY total_revenue DESC;

-- 3c. Aggregate revenue by region
SELECT 
    r.regionname, 
    SUM(quantity * unitprice * (1 - discount)) AS total_revenue
FROM sales s
JOIN regions r ON s.regionid = r.regionid
GROUP BY r.regionname
ORDER BY total_revenue DESC;

-- 4. Quantify potential revenue loss due to missing customers (from Phase 2)
SELECT 
    SUM(quantity * unitprice * (1 - discount)) AS lost_revenue
FROM sales s
LEFT JOIN customers c ON s.customerid = c.customerid
WHERE c.customerid IS NULL;

-- Repeat for missing products
SELECT 
    SUM(quantity * unitprice * (1 - discount)) AS lost_revenue
FROM sales s
LEFT JOIN products p ON s.productid = p.productid
WHERE p.productid IS NULL;

-- Repeat for missing regions
SELECT 
    SUM(quantity * unitprice * (1 - discount)) AS lost_revenue
FROM sales s
LEFT JOIN regions r ON s.regionid = r.regionid
WHERE r.regionid IS NULL;

-- 5. Flag suspicious sales records
SELECT 
    saleid,
    customerid,
    productid,
    quantity,
    unitprice,
    discount,
    costperunit,
    CASE
        WHEN (quantity * unitprice * (1 - discount)) - (quantity * costperunit) < 0 THEN 'NEGATIVE_MARGIN'
        WHEN discount < 0 OR discount > 1 THEN 'INVALID_DISCOUNT'
        ELSE 'OK'
    END AS validation_flag
FROM sales;
