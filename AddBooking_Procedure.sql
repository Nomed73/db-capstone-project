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

