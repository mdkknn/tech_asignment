--a. 
SELECT * FROM Consumers WHERE last_name = 'Smith';

--b. 
SELECT DATE_FORMAT(order_timestamp, '%y-%m') as month, SUM(order_amount_usd) as sum
FROM Orders
GROUP BY DATE_FORMAT(order_timestamp, '%y-%m')
ORDER BY desc
LIMIT 1;

--c. 
SELECT merchant_name, SUM(order_amount_usd) as total_sales FROM Orders o
LEFT JOIN Merchants m
IN o.merchant_id = m.merchant_id
GROUP BY merchant_name
ORDER BY desc
LIMIT 1;

--d. 
SELECT COUNT (*) FROM Consumers c
LEFT JOIN Orders o
IN c.consumer_id = o.consumer_id
WHERE o.order_id = NULL
;

--e. 
SELECT AVG(comp.num)
FROM (
	SELECT COUNT(complaint_id) AS num FROM Complaints
GROUP BY (consumer_id) as comp);

--f. 
SELECT merchant_name, COUNT(merchant_id) as num
FROM Merchants m
LEFT JOIN Orders o
IN m.merchant_id = o.merchant_id
LEFT JOIN Complaints c
IN o.consumer_id = c.consumer_id
ORDER BY num desc;
