WITH DateBounds AS (
    SELECT
        MIN([date]) AS start_date,
        MAX([date]) AS end_date
    FROM sales
),
DateSeries AS (
    -- Anchor member
    SELECT start_date AS calendar_date
    FROM DateBounds

    UNION ALL

    -- Recursive member (NO aggregates here)
    SELECT DATEADD(DAY, 1, calendar_date)
    FROM DateSeries
    CROSS JOIN DateBounds
    WHERE calendar_date < end_date
)
SELECT
    ds.calendar_date
FROM DateSeries ds
LEFT JOIN sales s
    ON ds.calendar_date = s.[date]
WHERE s.[date] IS NULL
ORDER BY ds.calendar_date
OPTION (MAXRECURSION 0);
