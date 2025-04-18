-- Task 3 Cancel Order Procedure
DELIMITER //

DROP PROCEDURE IF EXISTS CancelOrder;

CREATE PROCEDURE CancelOrder(IN order_id INT)
BEGIN
    -- Step 1: Delete from OrderItems first
    DELETE FROM OrderItems WHERE orderID = order_id;

    -- Step 2: Then delete from OrderDeliveryStatus
    DELETE FROM OrderDeliveryStatus WHERE orderID = order_id;

    -- Step 3: Now delete from Orders table
    DELETE FROM Orders WHERE orderID = order_id;

    -- Step 4: Confirmation message
    SELECT CONCAT('Order ', order_id, ' is cancelled') AS Confirmation;
END //

DELIMITER ;
SET FOREIGN_KEY_CHECKS = 0;

call CancelOrder(1);
SET FOREIGN_KEY_CHECKS = 1;
select * from Orders;