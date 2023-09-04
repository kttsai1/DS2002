-- ------------------------------------------------------------------
-- 0). First, How Many Rows are in the Products Table? 45
-- ------------------------------------------------------------------
SELECT COUNT(*) FROM products;
-- ------------------------------------------------------------------
-- 1). Product Name and Unit/Quantity
-- ------------------------------------------------------------------
SELECT product_name as "Product Name", quantity_per_unit as "Unit/Qty" FROM products;
-- ------------------------------------------------------------------
-- 2). Product ID and Name of Current Products
-- ------------------------------------------------------------------

-- ------------------------------------------------------------------
-- 3). Product ID and Name of Discontinued Products
-- ------------------------------------------------------------------


-- ------------------------------------------------------------------
-- 4). Name & List Price of Most & Least Expensive Products
-- ------------------------------------------------------------------


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
SELECT Count(product_name) as "Product Name", list_price as "List Price" FROM products WHERE list_price > AVG(list_price);
-- ------------------------------------------------------------------
-- 8). Product Name & List Price of 10 Most Expensive Products 
-- ------------------------------------------------------------------
SELECT product_name as "Product Name", list_price as "List Price" FROM products ORDER BY list_price DESC LIMIT 10;

-- ------------------------------------------------------------------ 
-- 9). Count of Current and Discontinued Products 
-- ------------------------------------------------------------------


-- ------------------------------------------------------------------
-- 10). Product Name, Units on Order and Units in Stock
--      Where Quantity In-Stock is Less Than the Quantity On-Order. 
-- ------------------------------------------------------------------



-- ------------------------------------------------------------------
-- EXTRA CREDIT -----------------------------------------------------
-- ------------------------------------------------------------------


-- ------------------------------------------------------------------
-- 11). Products with Supplier Company & Address Info
-- ------------------------------------------------------------------



-- ------------------------------------------------------------------
-- 12). Number of Products per Category With Less Than 5 Units
-- ------------------------------------------------------------------



-- ------------------------------------------------------------------
-- 13). Number of Products per Category Priced Less Than $20.00
-- ------------------------------------------------------------------