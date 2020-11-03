
-- Get all customers and their addresses.
SELECT concat(customers.first_name,' ',customers.last_name) AS "name",
concat(street,', ',city,', ',state,' ',zip) AS address FROM addresses
JOIN customers ON addresses.customer_id = customers.id;

-- Get all orders and their line items (orders, quantity and product).
SELECT orders.id, products.description, line_items.quantity, order_date from orders
JOIN line_items ON orders.id = line_items.order_id 
JOIN products ON products.id = line_items.product_id;

-- Which warehouses have cheetos?
SELECT warehouse FROM warehouse
JOIN warehouse_product ON warehouse.id = warehouse_product.warehouse_id
JOIN products ON products.id = warehouse_product.product_id
WHERE products.description = 'cheetos';

-- Which warehouses have diet pepsi?
SELECT warehouse FROM warehouse
JOIN warehouse_product ON warehouse.id = warehouse_product.warehouse_id
JOIN products ON products.id = warehouse_product.product_id
WHERE products.description = 'diet pepsi';

-- Get the number of orders for each customer. NOTE: It is OK if those 
-- without orders are not included in results.
SELECT CONCAT(customers.first_name,' ',customers.last_name),count(*) FROM orders
JOIN addresses ON orders.address_id = addresses.id
JOIN customers ON addresses.customer_id = customers.id
GROUP BY CONCAT(first_name,' ',last_name);

-- How many customers do we have?

-- How many products do we carry?

-- What is the total available on-hand quantity of diet pepsi?

-- Stretch
-- How much was the total cost for each order?

-- How much has each customer spent in total?

-- How much has each customer spent in total? Customers who have spent $0 should still show up in the table. It should say 0, not NULL (research coalesce).

