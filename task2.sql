use  ecommerce;
-- Insert sample customers
INSERT INTO Customers (name, email, phone, address)
VALUES 
('Aditi Sharma', 'aditi@example.com', '9876543210', 'Pune'),
('Rohan Patil', NULL, '9123456780', 'Mumbai'),          -- email is NULL
('Meera Desai', 'meera@example.com', NULL, 'Nashik');   -- phone is NULL

-- Insert categories
INSERT INTO Categories (category_name)
VALUES ('Electronics'), ('Clothing'), ('Books');

-- Insert products (with some NULL category_id)
INSERT INTO Products (name, price, category_id)
VALUES
('Laptop', 55000, 1),
('T-Shirt', 500, 2),
('Novel', 300, 3),
('Smartwatch', 4000, NULL);     -- missing category → NULL

-- Insert orders
INSERT INTO Orders (customer_id, order_date, total_amount)
VALUES
(1, '2025-11-15', 56000),
(3, '2025-11-15', 300);

-- Insert order details
INSERT INTO OrderDetails (order_id, product_id, quantity)
VALUES
(1, 1, 1),
(1, 4, 1),
(2, 3, 1);

------------------------------------------------------
-- UPDATE statements
------------------------------------------------------

-- Update missing email for Rohan
UPDATE Customers
SET email = 'rohan@example.com'
WHERE customer_id = 2;

-- Update price of product
UPDATE Products
SET price = price + 100
WHERE product_id = 3;

-- Update multiple rows (increase all clothing items)
UPDATE Products
SET price = price + 50
WHERE category_id = 2;

------------------------------------------------------
-- DELETE statements
------------------------------------------------------

-- Delete a customer
ALTER TABLE Orders
DROP FOREIGN KEY orders_ibfk_1;

ALTER TABLE Orders
ADD CONSTRAINT orders_ibfk_1
FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
ON DELETE CASCADE;

ALTER TABLE OrderDetails 
DROP FOREIGN KEY orderdetails_ibfk_1;

ALTER TABLE OrderDetails 
ADD CONSTRAINT orderdetails_ibfk_1 
FOREIGN KEY (order_id) REFERENCES Orders(order_id)
ON DELETE CASCADE;


DELETE FROM Customers WHERE customer_id = 3;

-- Delete products that have NULL category
DELETE FROM OrderDetails
WHERE product_id IN (
    SELECT product_id 
    FROM Products 
    WHERE category_id IS NULL
);
DELETE FROM Products
WHERE category_id IS NULL;


