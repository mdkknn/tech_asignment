--a. Find all orders made by consumers with the last name "Smith"
SELECT * FROM Consumers WHERE last_name = 'Smith';

--b. Which month had the largest sales volume ever? (hint: sales volume is some aggregation of order amount)
SELECT DATE_FORMAT(order_timestamp, '%y-%m') as month, SUM(order_amount_usd) as sum
FROM Orders
GROUP BY DATE_FORMAT(order_timestamp, '%y-%m')
ORDER BY desc
LIMIT 1;

--c. Which merchant has had the largest total sales volume?
SELECT merchant_name, SUM(order_amount_usd) as total_sales FROM Orders o
LEFT JOIN Merchants m
IN o.merchant_id = m.merchant_id
GROUP BY merchant_name
ORDER BY desc
LIMIT 1;

--d. How many consumers have never made an order?
SELECT COUNT (*) FROM Consumers c
LEFT JOIN Orders o
IN c.consumer_id = o.consumer_id
WHERE o.order_id = NULL
;

--e. How many complaints have been made per consumer on average?
SELECT AVG(comp.num)
FROM (
	SELECT COUNT(complaint_id) AS num FROM Complaints
GROUP BY (consumer_id) as comp);

--f. Can you propose a simple query whose results might help us to understand if certain merchants tend to cause more complaints?
SELECT merchant_name, COUNT(merchant_id) as num
FROM Merchants m
LEFT JOIN Orders o
IN m.merchant_id = o.merchant_id
LEFT JOIN Complaints c
IN o.consumer_id = c.consumer_id
ORDER BY num desc;
