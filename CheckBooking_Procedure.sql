-- Task 2 Check Booking

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