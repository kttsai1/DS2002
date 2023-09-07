-- ------------------------------------------------------------------
-- 0). First, How Many Rows are in the Products Table? 
-- ------------------------------------------------------------------
SELECT COUNT(*) FROM products;
-- ------------------------------------------------------------------
-- 1). Product Name and Unit/Quantity
-- ------------------------------------------------------------------
SELECT product_name as "Product Name", quantity_per_unit as "Unit/Qty" FROM products;
-- ------------------------------------------------------------------
-- 2). Product ID and Name of Current Products
-- ------------------------------------------------------------------
SELECT id, product_name FROM products WHERE discontinued = 0;
-- ------------------------------------------------------------------
-- 3). Product ID and Name of Discontinued Products
-- ------------------------------------------------------------------
SELECT id, product_name FROM products WHERE discontinued = 1;
-- ------------------------------------------------------------------
-- 4). Name & List Price of Most & Least Expensive Products
-- ------------------------------------------------------------------
SELECT product_name as "Product Name", list_price as "List Price" FROM products WHERE list_price = (SELECT MAX(list_price) from products) 
	OR list_price = (SELECT MIN(list_price) FROM products) ORDER BY list_price DESC;

-- ------------------------------------------------------------------
-- 5). Product ID, Name & List Price Costing Less Than $20
-- ------------------------------------------------------------------
SELECT id, product_name as "Product Name", list_price as "List Price" FROM products WHERE list_price < 20;
-- ------------------------------------------------------------------
-- 6). Product ID, Name & List Price Costing Between $15 and $20
-- ------------------------------------------------------------------

SELECT id, product_name as "Product Name", list_price as "List Price" FROM products WHERE list_price > 15 AND list_price < 20;

-- ------------------------------------------------------------------
-- 7). Product Name & List Price Costing Above Average List Price
-- ------------------------------------------------------------------
SELECT product_name as "Product Name", list_price as "List Price" FROM products WHERE (SELECT AVG(list_price) FROM products);
-- ------------------------------------------------------------------
-- 8). Product Name & List Price of 10 Most Expensive Products 
-- ------------------------------------------------------------------
SELECT product_name as "Product Name", list_price as "List Price" FROM products ORDER BY list_price DESC LIMIT 10;
-- ------------------------------------------------------------------ 
-- 9). Count of Current and Discontinued Products 
-- ------------------------------------------------------------------
SELECT COUNT(discontinued) FROM products WHERE discontinued = 0;
SELECT COUNT(discontinued) FROM products WHERE discontinued = 1;
-- ------------------------------------------------------------------
-- 10). Product Name, Units on Order and Units in Stock
--      Where Quantity In-Stock is Less Than the Quantity On-Order. 
-- ------------------------------------------------------------------
SELECT product_name as "Product Name", reorder_level as "Units in Stock", target_level as "Quantity On-Order" FROM products WHERE reorder_level < target_level;
-- ------------------------------------------------------------------
-- EXTRA CREDIT -----------------------------------------------------
-- ------------------------------------------------------------------


-- ------------------------------------------------------------------
-- 11). Products with Supplier Company & Address Info
-- ------------------------------------------------------------------
SELECT p.product_name as "Product Name", s.company as "Supplier Company", s.address as "Supplier Address", s.city as "Supplier City", 
		s.state_province as "Supplier State Province", s.zip_postal_code as "Supplier Zip Code" FROM suppliers s JOIN products p ON s.id = p.supplier_ids;
-- ------------------------------------------------------------------
-- 12). Number of Products per Category With Less Than 5 Units
-- ------------------------------------------------------------------
SELECT category, COUNT(*) as units FROM products GROUP BY category HAVING units < 5;
-- ------------------------------------------------------------------
-- 13). Number of Products per Category Priced Less Than $20.00
-- ------------------------------------------------------------------
SELECT category, COUNT(list_price) as "Number of Products Less than $20" FROM products WHERE list_price < 20 GROUP BY category;
