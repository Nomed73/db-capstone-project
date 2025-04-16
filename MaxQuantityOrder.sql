-- Task 1
DELIMITER //

create procedure GetMaxQuantity()
	begin
		select max(quantity) as "Max Quantity in Order" 
        from OrderItems;
	end //

DELIMITER ;

call GetMaxQuantity();

-- Task 2
prepare GetOrderDetail from 
'	select o.orderID, oi.quantity, (oi.quantity * oi.price) as Cost
	from Orders o 
	join OrderItems oi on o.orderID = oi.orderID
	join Bookings b on o.bookingID = b.bookingID
    join Customer c on c.customerID = b.customerID
 	where c.customerID = ?
';

set @id = 1;
execute GetOrderDetail using @id;


-- Task 3
DELIMITER //

CREATE PROCEDURE CancelOrder(IN order_id INT)
BEGIN
    DELETE FROM Orders WHERE orderID = order_id;
    SELECT CONCAT('Order ', order_id, ' is cancelled') AS Confirmation;
END //

DELIMITER ;

call CancelOrder(1);

select * from Orders;
