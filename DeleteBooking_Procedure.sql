-- Task 3 - Delete a booking
DELIMITER //
CREATE PROCEDURE CancelBooking(IN b_id INT)
	BEGIN
		DECLARE o_id INT;
        
        SELECT orderID into o_id from Orders where bookingId = b_id;
        
        DELETE FROM OrderItems WHERE orderID = o_id;
		DELETE FROM OrderDeliveryStatus WHERE orderID = o_id;

		DELETE FROM Orders WHERE bookingID = b_id;
		DELETE FROM Bookings WHERE bookingID = b_id;
    END//
DELIMITER ;

CALL CancelBooking(4);