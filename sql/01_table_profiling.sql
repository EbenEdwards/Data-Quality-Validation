SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN saleid IS NULL THEN 1 ELSE 0 END) AS missing_saleid,
    SUM(CASE WHEN customerid IS NULL THEN 1 ELSE 0 END) AS missing_customerid,
    SUM(CASE WHEN productid IS NULL THEN 1 ELSE 0 END) AS missing_productid,
    SUM(CASE WHEN regionid IS NULL THEN 1 ELSE 0 END) AS missing_regionid
FROM sales;
