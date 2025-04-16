-- Task 1
create view OrdersView as 
select orderID, sum(quantity) as Quantity, sum(price) as Cost
from OrderItems
group by orderID;

select * from OrdersView;

-- Task 2
SELECT 
    c.customerID AS CustomerID,
    CONCAT(c.firstName, ' ', c.lastName) AS FullName,
    o.orderID AS OrderID,
    SUM(oi.price * oi.quantity) AS Cost,
    m.name AS MenuName,
    mi.name AS CourseName
FROM Customer c
JOIN Bookings b ON c.customerID = b.customerID
JOIN Orders o ON b.bookingID = o.bookingID
JOIN OrderItems oi ON o.orderID = oi.orderID
JOIN MenuItems mi ON oi.itemID = mi.itemID
JOIN Menu_MenuItems mmi ON mi.itemID = mmi.itemID
JOIN Menu m ON m.menuID = mmi.menuID
GROUP BY c.customerID, o.orderID, m.name, mi.name
HAVING Cost > 150
ORDER BY Cost ASC;

-- Task 3
SELECT name AS MenuName
FROM Menu
WHERE menuID IN (
    SELECT mmi.menuID
    FROM Menu_MenuItems mmi
    WHERE mmi.itemID = ANY (
        SELECT oi.itemID
        FROM OrderItems oi
        WHERE oi.quantity > 2
    )
);