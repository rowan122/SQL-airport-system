CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    PhoneNumber VARCHAR(20),
    ShippingAddress TEXT
);
CREATE TABLE Orders (
    OrderID INT  PRIMARY KEY,
    CustomerID INT,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    Status VARCHAR(50) DEFAULT 'Pending',
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


CREATE TABLE Category (
    CategoryID INT  PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    DiscountPlanName VARCHAR(255),
    DiscountPercentage DECIMAL(5, 2),
    StartDate DATE,
    EndDate DATE
);

CREATE TABLE OrderDetails (
    OrderDetailID INT  PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    Subtotal DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
CREATE TABLE Deliveries (
    DeliveryID INT  PRIMARY KEY,
    OrderID INT,
    ShippingProvider VARCHAR(255),
    TrackingNumber VARCHAR(255),
    Status VARCHAR(50) DEFAULT 'Shipped',
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
CREATE TABLE Cart (
    CartID INT  PRIMARY KEY,
    CustomerID INT,
    Date DATE,
    Day INT,
    Month INT,
    Year INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);
CREATE TABLE Payments (
    PaymentID INT  PRIMARY KEY,
    PaymentType VARCHAR(50),
    Date DATE,
    Day INT,
    Month INT,
    Year INT,
    Status VARCHAR(50),
    OrderID INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);
CREATE TABLE Warehouses (
    WarehouseID INT PRIMARY KEY,
    Name VARCHAR(255) NOT NULL,
    Location VARCHAR(255),
    ContactInfo VARCHAR(255),
    Manager VARCHAR(255)
);
CREATE TABLE Delivery (
    DeliveryID INT  PRIMARY KEY,
    DeliveryMan VARCHAR(255),
    Status VARCHAR(50),
    OrderID INT,
    TrackingURL VARCHAR(255),
    ShippingProviderID INT,
    ActualDeliveryDate DATE,
    EstimatedDeliveryDate DATE,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ShippingProviderID) REFERENCES ShippingProviders(ShippingProviderID)
);





