SELECT s.*
FROM sales AS s
LEFT JOIN customers AS c
    ON s.customerid = c.customerid
WHERE c.customerid IS NULL;

SELECT s.*
FROM sales AS s
LEFT JOIN products AS p
    ON s.productid = p.productid
WHERE p.productid IS NULL;

SELECT s.*
FROM sales AS s
LEFT JOIN regions AS r
    ON s.regionid = r.regionid
WHERE r.regionid IS NULL;

SELECT
    SUM(CASE WHEN c.customerid IS NULL THEN 1 ELSE 0 END) AS missing_customer_count,
    SUM(CASE WHEN p.productid IS NULL THEN 1 ELSE 0 END) AS missing_product_count,
    SUM(CASE WHEN r.regionid IS NULL THEN 1 ELSE 0 END) AS missing_region_count
FROM sales AS s
LEFT JOIN customers AS c ON s.customerid = c.customerid
LEFT JOIN products AS p ON s.productid = p.productid
LEFT JOIN regions AS r ON s.regionid = r.regionid;
