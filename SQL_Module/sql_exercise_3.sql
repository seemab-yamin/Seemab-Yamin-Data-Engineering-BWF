-- Using the same database you previously created perform the following tasks:


--1). Write a query to calculate the percentage contribution of each item's amount 
--to its order's total amount, grouped by order_id. (Topics: Partition BY)

-- calculate order total amount from items table using partition by window function
-- sum(i.amount) over (partition by o.order_id)

select i.amount, o.order_id, o.total_amount, round( (i.amount / sum(i.amount) over (partition by o.order_id) ) * 100, 2) as "%_contribution" from 
ecom_schema.items i, ecom_schema.orders o
where i.order_id = o.order_id;

```
amount|order_id                            |total_amount|%_contribution|
------+------------------------------------+------------+--------------+
 32.05|0077622c-f789-402f-8f27-a8ef29b92f99|      252.56|        100.00|
 52.99|007c6893-fc40-44f8-a794-741ad1bfd9c7|      834.56|        100.00|
 99.77|00860b6c-6b06-4694-8708-f7aa4375d5e4|       25.97|         46.79|
 39.54|00860b6c-6b06-4694-8708-f7aa4375d5e4|       25.97|         18.54|
 73.93|00860b6c-6b06-4694-8708-f7aa4375d5e4|       25.97|         34.67|
 65.86|00871b7a-6c23-4916-aeff-e22ee8e27ea9|      315.29|        100.00|
 10.07|00aa2373-5f66-4165-8ebf-7724b314028a|      862.98|         27.51|
 26.53|00aa2373-5f66-4165-8ebf-7724b314028a|      862.98|         72.49|
 91.49|00ce4abc-b40a-4918-a245-5489bea00786|       14.33|         50.56|
 89.47|00ce4abc-b40a-4918-a245-5489bea00786|       14.33|         49.44|
 22.43|01ae2353-d4b0-4d78-aed1-8601b1dd35e3|      477.12|        100.00|
 86.03|01c88a63-a876-47fc-a466-3b6a935d9150|      575.50|        100.00|
 86.68|02708129-1014-4295-a762-b453812395ca|      118.10|         78.20|
```


-- 2). Write a query to rank orders by their total amount within each customer, 
-- ordering them from highest to lowest total amount. (Topics: Window functions 
-- like RANK, PARTITION BY, and ORDER BY)

select c.name, o.order_id, o.total_amount, 
rank() over (partition by c.customer_id order by o.total_amount desc) 
from orders o, customers c
where o.customer_id = c.customer_id


-- 3). Write a query to calculate the average price of products supplied by each 
--supplier. Exclude suppliers who have no products in the result. 
--(Topics: JOINS, AGGREGATE FUNCTIONS, GROUP BY)

select s.name, avg(p.price) from products p, suppliers s
where p.supplier_id = s.supplier_id
group by s.supplier_id


-- 4). Write a query to count the number of products in each category. Include 
-- categories with zero products in the result set. 
--(WINDOW FUNCTIONS, AGGREGATE FUNCTIONS, JOINS, GROUP BY)

select c.name, count(p.*) from categories c left join products p 
on c.name = p.category
group by c.name;

-- 5). Write a query to retrieve the total amount spent by each customer, along with their name and phone number. Ensure customers with no orders also appear with a total amount of 0. (WINDOW FUNCTIONS, AGGREGATE FUNCTIONS, JOINS, GROUP BY)
--5). Write a query to retrieve the total amount spent by each customer, along with 
--their name and phone number. Ensure customers with no orders also appear with a 
--total amount of 0. (WINDOW FUNCTIONS, AGGREGATE FUNCTIONS, JOINS, GROUP BY)

select c.name, c.phone, coalesce(sum(o.total_amount), 0) total_amount 
from customers c left join orders o
on c.customer_id = o.customer_id
group by c.name, c.phone;
