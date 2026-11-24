SELECT 
    left(trans_date,7) as month,
    country,
    COUNT(*) AS trans_count,
    SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
    SUM(amount) as trans_total_amount,
    SUM(IF(state = 'approved', amount, 0)) AS approved_total_amount
    
FROM Transactions
GROUP BY  month, country;