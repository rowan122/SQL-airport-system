--FUNCTIONAL 

SELECT * FROM Products;
INSERT INTO Products (ProductID, Name, CategoryID, Price, StockQuantity, ReorderLevel)
VALUES (1, 'Smartphone', 1, 499.99, 50, 10);
--Delete a product
DELETE FROM Products WHERE ProductID = 1;


SELECT * FROM Customers;
--Add a customer:
INSERT INTO Customers (CustomerID, FirstName, LastName, Email, PhoneNumber, ShippingAddress)
VALUES (13, 'John', 'Doe', 'john.doe@example.com', '1234567890', '123 Main St');

SELECT * FROM Orders
--Place an order
INSERT INTO Orders (OrderID, CustomerID, OrderDate, Status, TotalAmount)
VALUES (11, 1, '2024-12-20', 'Pending', 149.99);

SELECT * FROM Delivery
--Assign a delivery
INSERT INTO Delivery (DeliveryID, OrderID, ShippingProviderID, DeliveryMan, Status, EstimatedDeliveryDate)
VALUES (15, 1, 1, 'John', 'Shipped', '2024-12-22');

--Update delivery status
UPDATE Delivery
SET Status = 'Delivered', ActualDeliveryDate = '2024-12-23'
WHERE DeliveryID = 1;

--Update stock
UPDATE Products
SET StockQuantity = StockQuantity - 50
WHERE ProductID = 14;


--NONFUNCTIONAL

--performance 
CREATE INDEX idx_product_id ON Products (ProductID);
CREATE INDEX idx_customer_id ON Customers (CustomerID);
  --explain
 SELECT * FROM Products WHERE CategoryID = 1;
  
  --Scalability: manage large number of orders 
  CREATE PARTITION FUNCTION OrderDatePartitionFunction (DATE)
AS RANGE RIGHT FOR VALUES ('2024-01-01', '2025-01-01');
 
 --sequrity
 -- Encrypt data protect customer information 
UPDATE Customers
SET Email = ENCRYPTBYKEY(KEY_GUID('EncryptionKey'), 'customer@example.com')
WHERE CustomerID = 1;

-- Decrypt data
SELECT CONVERT(VARCHAR, DECRYPTBYKEY(Email)) AS DecryptedEmail
FROM Customers
WHERE CustomerID = 1;

--Parameterized: to prevent SQL injection attacks
DECLARE @CustomerID INT = 1;
SELECT * FROM Customers WHERE CustomerID = @CustomerID;
 
--Enable Add/Delete Operations by Users
  --Insert with Explicit ProductID (if not AUTO_INCREMENT/IDENTITY)
CREATE PROCEDURE AddProduct(
    @ProductID INT, 
    @Name VARCHAR(255), 
    @CategoryID INT, 
    @Price DECIMAL(10, 2), 
    @StockQuantity INT
)
AS
BEGIN
    INSERT INTO Products (ProductID, Name, CategoryID, Price, StockQuantity, ReorderLevel)
    VALUES (@ProductID, @Name, @CategoryID, @Price, @StockQuantity, 10);
END;

--permissions 
  --admins only can take this actions  
CREATE ROLE Admin;
GRANT DELETE, INSERT, UPDATE ON Products TO Admin;

--backup data 
BACKUP LOG  E Commerce  TO DISK = 'C:\backups\E Commerce _log_backup.trn';

--check running current queries 
SELECT * FROM sys.dm_exec_requests WHERE status = 'running';













