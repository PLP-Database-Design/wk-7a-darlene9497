--  Question 1
WITH RECURSIVE ProductDetail_1NF AS (
    SELECT 
        OrderID,
        CustomerName,
        TRIM(SUBSTRING_INDEX(Products, ',', 1)) AS Product,
        TRIM(SUBSTRING(Products, LENGTH(SUBSTRING_INDEX(Products, ',', 1)) + 2)) AS Remaining
    FROM ProductDetail
    
    UNION ALL
    
    SELECT 
        OrderID,
        CustomerName,
        TRIM(SUBSTRING_INDEX(Remaining, ',', 1)),
        TRIM(SUBSTRING(Remaining, LENGTH(SUBSTRING_INDEX(Remaining, ',', 1)) + 2))
    FROM ProductDetail_1NF
    WHERE Remaining IS NOT NULL AND Remaining != ''
)
SELECT 
    OrderID, 
    CustomerName, 
    Product
FROM ProductDetail_1NF;



--  Question 2
--  Split the table into two tables
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

INSERT INTO Orders (OrderID, CustomerName) VALUES
(101, 'John Doe'),
(102, 'Jane Smith'),
(103, 'Emily Clark');

CREATE TABLE OrderItems (
    OrderID INT,
    Product VARCHAR(100),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO OrderItems (OrderID, Product, Quantity) VALUES
(101, 'Laptop', 2),
(101, 'Mouse', 1),
(102, 'Tablet', 3),
(102, 'Keyboard', 1),
(102, 'Mouse', 2),
(103, 'Phone', 1);
