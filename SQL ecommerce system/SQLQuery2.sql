INSERT INTO category (CategoryID, Name, DiscountPlanName, DiscountPercentage, StartDate, EndDate)
VALUES
(1, 'Electronics', 'Holiday Sale', 15.00, '2024-12-01', '2024-12-31'),
(2, 'Clothing', 'Black Friday Discount', 20.00, '2024-11-20', '2024-11-30'),
(3, 'Books', 'Summer Sale', 10.00, '2024-06-01', '2024-06-30');
INSERT INTO category (CategoryID, Name, DiscountPlanName, DiscountPercentage, StartDate, EndDate)
VALUES  
(9, 'Home Appliances', 'Winter Sale', 25.00, '2024-12-01', '2024-12-31'),
(10, 'Toys', 'Toy Discount', 10.00, '2024-12-01', '2024-12-31'),
(11, 'Sports Equipment', 'New Year Offer', 15.00, '2024-12-01', '2024-12-31'),
(12, 'Furniture', 'Clearance Sale', 30.00, '2024-11-01', '2024-11-30'),
(13, 'Beauty & Personal Care', 'Holiday Gift', 20.00, '2024-12-01', '2024-12-31'),
(14, 'Food & Beverages', 'Seasonal Discount', 5.00, '2024-12-01', '2024-12-31'),
(15, 'Automotive', 'Black Friday Offer', 18.00, '2024-11-20', '2024-11-30'),
(16, 'Books', 'Back to School Sale', 10.00, '2024-08-01', '2024-08-31');

INSERT INTO Products (ProductID, Name, CategoryID, Price, StockQuantity, ReorderLevel)
VALUES
(11, 'Refrigerator', 1, 499.99, 15, 5),  
(12, 'Air Conditioner', 1, 249.99, 20, 10), 
(13, 'Action Figure', 2, 25.99, 200, 30),
(14, 'Basketball', 3, 29.99, 150, 20), 
(15, 'Resistance Bands', 3, 19.99, 180, 25),  
(16, 'Blender', 1, 79.99, 50, 15),  
(17, 'Toy Car', 2, 9.99, 300, 50),  
(18, 'Tennis Racket', 3, 49.99, 60, 10),  
(19, 'Wristwatch', 2, 39.99, 100, 20),  
(20, 'Camping Tent', 3, 89.99, 75, 10);  

INSERT INTO Customers (CustomerID, FirstName, LastName, Email, PhoneNumber, ShippingAddress)
VALUES
(1, 'Alice', 'Johnson', 'alice.johnson@example.com', '2345678901', '789 Pine St, Springfield'),
(2, 'Bob', 'Brown', 'bob.brown@example.com', '3456789012', '101 Maple St, Springfield'),
(3, 'Charlie', 'Davis', 'charlie.davis@example.com', '4567890123', '321 Oak St, Springfield'),
(4, 'David', 'Miller', 'david.miller@example.com', '5678901234', '654 Pine St, Springfield'),
(5, 'Eva', 'Wilson', 'eva.wilson@example.com', '6789012345', '987 Elm St, Springfield'),
(6, 'Frank', 'Moore', 'frank.moore@example.com', '7890123456', '123 Birch St, Springfield'),
(7, 'Grace', 'Taylor', 'grace.taylor@example.com', '8901234567', '543 Cedar St, Springfield'),
(8, 'Helen', 'Anderson', 'helen.anderson@example.com', '9012345678', '765 Willow St, Springfield'),
(9, 'Isaac', 'Thomas', 'isaac.thomas@example.com', '0123456789', '876 Fir St, Springfield'),
(10, 'Jack', 'Jackson', 'jack.jackson@example.com', '1234567890', '234 Redwood St, Springfield'),
(11, 'Lily', 'White', 'lily.white@example.com', '2345678901', '345 Ash St, Springfield'),
(12, 'Mike', 'Harris', 'mike.harris@example.com', '3456789012', '456 Maple St, Springfield');

INSERT INTO ShippingProviders (ShippingProviderID, Name, ContactNumber, TrackingURL)
VALUES
(1, 'DHL', '555-4321', 'https://www.dhl.com/en/express/tracking.html'),
(2, 'USPS', '555-8765', 'https://www.usps.com/manage/track.htm'),
(3, 'FedEx', '555-1234', 'https://www.fedex.com/en-us/tracking.html'),
(4, 'UPS', '555-5678', 'https://www.ups.com/track'),
(5, 'Royal Mail', '555-2345', 'https://www.royalmail.com/track-your-item'),
(6, 'Canada Post', '555-6789', 'https://www.canadapost.ca/trackweb/en'),
(7, 'Australia Post', '555-3456', 'https://auspost.com.au/mypost/track'),
(8, 'Japan Post', '555-8764', 'https://www.post.japanpost.jp/index_en.html'),
(9, 'La Poste', '555-9012', 'https://www.laposte.fr/particulier/outils/suivi-colis'),
(10, 'TNT', '555-6543', 'https://www.tnt.com/express/en_us/site/home.html'),
(11, 'Purolator', '555-9876', 'https://www.purolator.com/en/shipping-tools/track'),
(12, 'Singapore Post', '555-4327', 'https://www.singpost.com/track-items');

INSERT INTO Cart (CartID, CustomerID, Date, Day, Month, Year)
VALUES
(1, 3, '2024-12-17', 17, 12, 2024),
(2, 4, '2024-12-18', 18, 12, 2024),
(3, 5, '2024-12-19', 19, 12, 2024),
(4, 6, '2024-12-20', 20, 12, 2024),
(5, 7, '2024-12-21', 21, 12, 2024),
(6, 8, '2024-12-22', 22, 12, 2024),
(7, 9, '2024-12-23', 23, 12, 2024),
(8, 10, '2024-12-24', 24, 12, 2024),
(9, 11, '2024-12-25', 25, 12, 2024),
(10, 12, '2024-12-26', 26, 12, 2024);
INSERT INTO Orders (OrderID, CustomerID, OrderDate, Status, TotalAmount)
VALUES
(1, 3, '2024-12-17', 'Shipped', 519.98),
(2, 4, '2024-12-18', 'Pending', 35.98),
(3, 5, '2024-12-19', 'Shipped', 149.99),
(4, 6, '2024-12-20', 'Shipped', 349.50),
(5, 7, '2024-12-21', 'Pending', 129.75),
(6, 8, '2024-12-22', 'Shipped', 215.00),
(7, 9, '2024-12-23', 'Pending', 89.99),
(8, 10, '2024-12-24', 'Shipped', 199.99),
(9, 11, '2024-12-25', 'Pending', 79.95),
(10, 12, '2024-12-26', 'Shipped', 299.99);

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Price, City)
VALUES
(1, 1, 11, 29.99, 'Springfiel  '), 
(2, 2, 12, 19.99, 'Springfiel  '), 
(3, 3, 13, 49.99, 'Shelbyvil  '),  
(4, 4, 14, 99.99, 'Capital C  '); 

INSERT INTO Payments (PaymentID, PaymentType, Date, Day, Month, Year, Status, OrderID)
VALUES
(1, 'Credit Card', '2024-12-17', 17, 12, 2024, 'Completed', 1),
(2, 'Debit Card', '2024-12-18', 18, 12, 2024, 'Pending', 2),
(3, 'PayPal', '2024-12-19', 19, 12, 2024, 'Completed', 3),
(4, 'Credit Card', '2024-12-20', 20, 12, 2024, 'Completed', 4),
(5, 'Bank Transfer', '2024-12-21', 21, 12, 2024, 'Pending', 5);

INSERT INTO Warehouses (WarehouseID, Name, Location, ContactInfo, Manager)
VALUES
(1, 'Warehouse A', '789 Warehouse Blvd, Springfield', '555-1122', 'Emily Davis'),
(2, 'Warehouse B', '101 Storage Rd, Springfield', '555-3344', 'David Lee'),
(3, 'Warehouse C', '202 Logistics St, Shelbyville', '555-5566', 'Rachel Green'),
(4, 'Warehouse D', '303 Distribution Ave, Capital City', '555-7788', 'John Smith'),
(5, 'Warehouse E', '404 Freight Ln, Springfield', '555-9900', 'Michael Johnson'),
(6, 'Warehouse F', '505 Storage Blvd, Capital City', '555-2233', 'Sarah White'),
(7, 'Warehouse G', '606 Cargo Rd, Shelbyville', '555-4455', 'Jessica Brown'),
(8, 'Warehouse H', '707 Warehouse Dr, Springfield', '555-6677', 'William Clark'),
(9, 'Warehouse I', '808 Depot St, Capital City', '555-8899', 'Daniel Martinez'),
(10, 'Warehouse J', '909 Shipping Rd, Shelbyville', '555-1234', 'Nancy Williams');

INSERT INTO Delivery(DeliveryID, OrderID, ShippingProviderID, DeliveryMan, Status, EstimatedDeliveryDate, ActualDeliveryDate)
VALUES
(1, 1, 3, 'Martha', 'Delivered', '2024-12-19', '2024-12-19'),
(2, 2, 4, 'Chris', 'Shipped', '2024-12-20', '2024-12-21'),
(3, 3, 5, 'Sophia', 'Shipped', '2024-12-21', '2024-12-22'),
(4, 4, 6, 'Jake', 'Delivered', '2024-12-22', '2024-12-22'),
(5, 5, 7, 'Liam', 'Shipped', '2024-12-23', '2024-12-24'),
(6, 6, 8, 'Olivia', 'Delivered', '2024-12-24', '2024-12-24'),
(7, 7, 9, 'James', 'Shipped', '2024-12-25', '2024-12-26'),
(8, 8, 10, 'Daniel', 'Delivered', '2024-12-26', '2024-12-26'),
(9, 9, 11, 'Emma', 'Shipped', '2024-12-27', '2024-12-28'),
(10, 10, 12, 'Isabella', 'Delivered', '2024-12-28', '2024-12-28');



