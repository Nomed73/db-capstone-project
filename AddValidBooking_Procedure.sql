-- Task 3 Add Valid Booking
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