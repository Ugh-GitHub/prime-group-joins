
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
SELECT count(*) FROM customers;

-- How many products do we carry?
SELECT count(*) FROM products;

-- What is the total available on-hand quantity of diet pepsi?
SELECT sum(on_hand) FROM warehouse_product
JOIN products ON warehouse_product.product_id = products.id
WHERE products.description = 'diet pepsi';

-- Stretch
-- How much was the total cost for each order?
SELECT orders.id, SUM(unit_price) FROM products
JOIN line_items ON products.id = line_items.product_id
JOIN orders ON line_items.order_id = orders.id
GROUP BY orders.id
ORDER BY orders.id ASC;

-- How much has each customer spent in total?
SELECT CONCAT(customers.first_name,' ',customers.last_name), sum(unit_price) FROM products
JOIN line_items ON line_items.product_id = products.id
JOIN orders ON orders.id = line_items.order_id
JOIN addresses ON addresses.id = orders.address_id
JOIN customers ON customers.id = addresses.customer_id
GROUP BY CONCAT(customers.first_name,' ',customers.last_name);

-- How much has each customer spent in total? Customers who have spent $0 should still show up in the table. It should say 0, not NULL (research coalesce).
SELECT CONCAT(customers.first_name,' ',customers.last_name), COALESCE(sum(unit_price),0) FROM products
FULL OUTER JOIN line_items ON line_items.product_id = products.id
FULL OUTER JOIN orders ON orders.id = line_items.order_id
FULL OUTER JOIN addresses ON addresses.id = orders.address_id
FULL OUTER JOIN customers ON customers.id = addresses.customer_id
GROUP BY CONCAT(customers.first_name,' ',customers.last_name);

