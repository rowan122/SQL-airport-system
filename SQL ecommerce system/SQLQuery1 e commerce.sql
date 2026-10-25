
-- Create Category table
CREATE TABLE Category (
    categ_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    description NVARCHAR(MAX)
);

-- Create Product table
CREATE TABLE Product (
    prod_id INT IDENTITY(1,1) PRIMARY KEY,
    categ_id INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    name NVARCHAR(100) NOT NULL,
    stock INT NOT NULL,
    description NVARCHAR(MAX),
    FOREIGN KEY (categ_id) REFERENCES Category(categ_id)
);

-- Create OrderDetails table
CREATE TABLE OrderDetails (
    od_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    prod_id INT NOT NULL,
    qty INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (prod_id) REFERENCES Product(prod_id)
);

-- Create Delivery table
CREATE TABLE Delivery (
    delivery_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    delivery_man NVARCHAR(100),
    status NVARCHAR(20) CHECK(status IN ('Shipped', 'Out_for_delivery', 'Delivered')) NOT NULL,
    shp_id INT,
    tracking_no NVARCHAR(50),
    actual_del_date DATE,
    estimated_date DATE,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Create Warehouse table
CREATE TABLE Warehouse (
    warehouse_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    location NVARCHAR(255) NOT NULL,
    contact_no NVARCHAR(15) NOT NULL,
    manager NVARCHAR(100)
);

-- Create Shipping Provider table
CREATE TABLE Shipping_Provider (
    shp_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(100) NOT NULL,
    contact_no NVARCHAR(15) NOT NULL,
    tracking_url NVARCHAR(MAX)
);

-- Create Product_Warehouse relationship table
CREATE TABLE Product_Warehouse (
    prod_id INT NOT NULL,
    warehouse_id INT NOT NULL,
    PRIMARY KEY (prod_id, warehouse_id),
    FOREIGN KEY (prod_id) REFERENCES Product(prod_id),
    FOREIGN KEY (warehouse_id) REFERENCES Warehouse(warehouse_id)
);

-- Create Shipping_Warehouse relationship table
CREATE TABLE Shipping_Warehouse (
    shp_id INT NOT NULL,
    warehouse_id INT NOT NULL,
    PRIMARY KEY (shp_id, warehouse_id),
    FOREIGN KEY (shp_id) REFERENCES Shipping_Provider(shp_id),
    FOREIGN KEY (warehouse_id) REFERENCES Warehouse(warehouse_id)
);
