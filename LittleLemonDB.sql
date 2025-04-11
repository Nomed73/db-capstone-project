-- MySQL Script generated by MySQL Workbench
-- Fri Apr 11 10:03:26 2025
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `LittleLemonDB` ;

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8 ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Customer` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Customer` (
  `customerID` INT NOT NULL,
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`customerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Staff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Staff` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Staff` (
  `staffID` INT NOT NULL,
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `contactNumber` VARCHAR(45) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `salary` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`staffID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Bookings` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Bookings` (
  `bookingID` INT NOT NULL,
  `bookingSlot` VARCHAR(45) NOT NULL,
  `tableNo` VARCHAR(45) NOT NULL,
  `staffID` INT NOT NULL,
  `customerID` INT NOT NULL,
  PRIMARY KEY (`bookingID`),
  INDEX `staddID_idx` (`staffID` ASC) VISIBLE,
  INDEX `customerID_idx` (`customerID` ASC) VISIBLE,
  CONSTRAINT `staffID`
    FOREIGN KEY (`staffID`)
    REFERENCES `LittleLemonDB`.`Staff` (`staffID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `customerID`
    FOREIGN KEY (`customerID`)
    REFERENCES `LittleLemonDB`.`Customer` (`customerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Menu` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menu` (
  `menuID` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `cuisine` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`menuID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`MenuItems`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`MenuItems` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`MenuItems` (
  `itemID` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `type` VARCHAR(255) NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`itemID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menu_MenuItems`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Menu_MenuItems` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menu_MenuItems` (
  `menuID` INT NOT NULL,
  `itemID` INT NOT NULL,
  INDEX `menuID_idx` (`menuID` ASC) VISIBLE,
  INDEX `itemID_idx` (`itemID` ASC) VISIBLE,
  CONSTRAINT `menuID`
    FOREIGN KEY (`menuID`)
    REFERENCES `LittleLemonDB`.`Menu` (`menuID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `itemID`
    FOREIGN KEY (`itemID`)
    REFERENCES `LittleLemonDB`.`MenuItems` (`itemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`Orders` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `orderID` INT NOT NULL,
  `bookingID` INT NOT NULL,
  `orderDate` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`orderID`),
  INDEX `bookingID_idx` (`bookingID` ASC) VISIBLE,
  CONSTRAINT `bookingID`
    FOREIGN KEY (`bookingID`)
    REFERENCES `LittleLemonDB`.`Bookings` (`bookingID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`OrderItems`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`OrderItems` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`OrderItems` (
  `orderID` INT NOT NULL,
  `itemID` INT NOT NULL,
  `quantity` INT NOT NULL,
  `price` DECIMAL(10,2) NOT NULL,
  INDEX `orderID_idx` (`orderID` ASC) VISIBLE,
  INDEX `fk_ordered_itemID_idx` (`itemID` ASC) VISIBLE,
  CONSTRAINT `fk_orderedItems_orderID`
    FOREIGN KEY (`orderID`)
    REFERENCES `LittleLemonDB`.`Orders` (`orderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ordered_itemID`
    FOREIGN KEY (`itemID`)
    REFERENCES `LittleLemonDB`.`MenuItems` (`itemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`OrderDeliveryStatus`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `LittleLemonDB`.`OrderDeliveryStatus` ;

CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`OrderDeliveryStatus` (
  `orderDeliverID` INT NOT NULL,
  `orderID` INT NOT NULL,
  `deliveryDate` DATETIME NOT NULL,
  `deliveryStatus` INT NOT NULL,
  PRIMARY KEY (`orderDeliverID`),
  INDEX `orderOD_idx` (`orderID` ASC) VISIBLE,
  CONSTRAINT `orderOD`
    FOREIGN KEY (`orderID`)
    REFERENCES `LittleLemonDB`.`Orders` (`orderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
