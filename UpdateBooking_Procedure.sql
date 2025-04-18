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