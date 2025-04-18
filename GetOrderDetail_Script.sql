-- Task 2 Get Order Detail
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