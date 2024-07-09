-- USE THE SAME DATABASE:

-- - Write a query to retrieve all orders placed by customers, including customer details (name, phone), 
--order details (order ID, timestamp), and item details (product, amount).
-- method 1 using ON keyword
select 
	o.order_id, o.order_timestamp, p.name as product, i.amount
from 
	orders o 
inner join items i on o.order_id = i.order_id
inner join customers c on o.customer_id = c.customer_id
inner join products p on p.product_id=i.product_id;

-- 2nd method by USING keyword
select 
	o.order_id, o.order_timestamp, p.name as product, i.amount
from 
	orders o 
inner join items i using (order_id)
inner join customers c using (customer_id)
inner join products p using (product_id);


--- Write a query to fetch all products along with their suppliers' details (name, phone) 
--and the corresponding category name.

select 
	p.name, s.name, s.phone, p.category
from 
	products p
inner join suppliers s using (supplier_id)


--- Write a query to retrieve details of all orders including the product name and amount ordered for each item.

select 
	o.order_id, p.name, i.amount
from
	orders o
inner join items i using (order_id)
inner join products p using (product_id)


--- Write a query to retrieve all suppliers along with the city and country where they are located, 
-- and the products they supply.

select 
	s.name, s.location, p.name
from 
	suppliers s
inner join products p using (supplier_id)


--- Write a query to fetch details of the most recent order (by timestamp) placed by each customer, 
-- including the product details for each item in the order. 
-- [This question will use a Window Function alongside Joins]

select
	c.customer_id, c.name, rank() over (partition by c.customer_id order by o.order_timestamp desc), o.*, p.*
from
	orders o
inner join customers c using (customer_id)
inner join items i using (order_id)
inner join products p using (product_id)
