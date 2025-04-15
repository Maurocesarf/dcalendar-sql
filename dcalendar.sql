WITH date_series AS (
    SELECT generate_series(DATE '2017-01-01', DATE '2025-12-31', INTERVAL '1 day')::DATE AS Date
)
SELECT 
    Date,
    EXTRACT(YEAR FROM Date) AS Year,
    EXTRACT(YEAR FROM Date) AS YearNumber,
    EXTRACT(QUARTER FROM Date) AS QuarterOfYear,
    EXTRACT(MONTH FROM Date) AS MonthOfYear,
    EXTRACT(DAY FROM Date) AS DayOfMonth,
    EXTRACT(YEAR FROM Date) * 10000 + EXTRACT(MONTH FROM Date) * 100 + EXTRACT(DAY FROM Date) AS DateInt,
    TO_CHAR(Date, 'Mon') AS MonthName,
    TO_CHAR(Date, 'Mon') || '/' || EXTRACT(YEAR FROM Date) AS MonthInCalendar,
    'Q' || EXTRACT(QUARTER FROM Date) || '/' || EXTRACT(YEAR FROM Date) AS QuarterInCalendar,
    EXTRACT(ISODOW FROM Date) AS DayInWeek,
    TO_CHAR(Date, 'Day') AS DayOfWeekName,
    Date + (7 - EXTRACT(ISODOW FROM Date)) * INTERVAL '1 day' AS WeekEnding,
    EXTRACT(WEEK FROM Date) AS WeekNumber,
    EXTRACT(YEAR FROM Date) * 10000 + EXTRACT(MONTH FROM Date) * 100 AS MonthnYear,
    EXTRACT(YEAR FROM Date) * 10000 + EXTRACT(QUARTER FROM Date) * 100 AS QuarterInYear,
    RIGHT(EXTRACT(YEAR FROM Date)::TEXT, 2) AS ShortYear,
    'FY' || 
    CASE 
        WHEN EXTRACT(MONTH FROM Date) >= 7 THEN (EXTRACT(YEAR FROM Date) + 1)::TEXT 
        ELSE RIGHT(EXTRACT(YEAR FROM Date)::TEXT, 2)
    END AS FY
FROM date_series limit 10