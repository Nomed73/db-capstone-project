-- Task 1
DELIMITER //

create procedure GetMaxQuantity()
	begin
		select max(quantity) as "Max Quantity in Order" 
        from OrderItems;
	end //

DELIMITER ;

call GetMaxQuantity();





