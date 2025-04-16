-- Task 1
INSERT INTO Bookings (bookingID, bookingSlot, tableNo, staffID, customerID) VALUES
(6, '2022-10-10 18:00:00', '5', 2, 1),
(7, '2022-11-12 18:00:00', '3', 3, 3),
(8, '2022-10-11 18:00:00', '2', 4, 2),
(9, '2022-10-13 18:00:00', '2', 1, 1);

-- Task 2

DELIMITER //
Create Procedure CheckBooking(IN bookingDate date, IN tableNo varchar(45))
BEGIN
	declare bookingCount int;
    
    select count(*) into bookingCount
    from Bookings
    where date(bookingSlot) = bookingDate and tableNo = tableNo;
    
    if bookingCount > 0 then
		SELECT CONCAT('TABLE ', TableNo, ' is already booked') AS 'Booking Status';
	else
		SELECT CONCAT('TABLE ', TableNo, ' is available') AS 'Booking Status';
	end if;
END //
DELIMITER ;

call CheckBooking('2025-04-16 20:00:00', 'T4');

-- Task 3
DELIMITER //

CREATE PROCEDURE AddValidBooking(
    IN bookingSlot DATETIME,
    IN tableNumber VARCHAR(45)
)
BEGIN
    DECLARE existingBookings INT;

    START TRANSACTION;

    -- Check if the table is already booked on that exact date (ignoring time if needed)
    SELECT COUNT(*) INTO existingBookings
    FROM Bookings
    WHERE DATE(bookingSlot) = DATE(bookingSlot)  -- match just the date portion
      AND tableNo = tableNumber;

    IF existingBookings > 0 THEN
        ROLLBACK;
        SELECT CONCAT('Table ', tableNumber, ' is already booked - booking cancelled') AS 'Booking status';
    ELSE
        INSERT INTO Bookings (bookingSlot, tableNo, staffID, customerID)
        VALUES (bookingSlot, tableNumber, 2, 1);  -- Default staff/customer

        COMMIT;
        SELECT CONCAT('Table ', tableNumber, ' successfully booked for ', bookingSlot) AS 'Booking status';
    END IF;
END //

DELIMITER ;


CALL AddValidBooking('2022-12-17 19:00:00', '6');

