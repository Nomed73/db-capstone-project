-- Task 1 - Add Booking

DELIMITER //

create procedure AddBooking(
	IN bookingDate datetime, 
    IN tableNo varchar(45), 
    IN customerID int,
    IN staffID int ) 
BEGIN
	INSERT INTO Bookings(bookingSlot, tableNo, staffID, customerID)
	VALUES (bookingDate, tableNo, staffID, customerID);
END//

DELIMITER ;


call AddBooking('2025-04-23 18:00:00', 'T2', 2, 5);

-- Task 2 - Update Booking
DELIMITER //
CREATE PROCEDURE UpdateBooking(
		IN bID INT, 
        IN newDate DATETIME
		)
	BEGIN
		UPDATE Bookings
        SET bookingSlot = newDate
        WHERE bookingID = bID;
	END //
DELIMITER ;

CALL UpdateBooking(7, '2028-11-13 20:00:00');

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
