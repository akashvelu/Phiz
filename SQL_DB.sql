-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema fizzAppSchema
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema fizzAppSchema
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `fizzAppSchema` DEFAULT CHARACTER SET utf8 ;
USE `fizzAppSchema` ;

-- -----------------------------------------------------
-- Table `fizzAppSchema`.`Users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fizzAppSchema`.`Users` (
  `idUsers` INT NOT NULL AUTO_INCREMENT,
  `firstNameUsers` VARCHAR(45) NOT NULL,
  `lastNameUsers` VARCHAR(45) NOT NULL,
  `emailUsers` VARCHAR(45) NOT NULL,
  `usernameUsers` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idUsers`),
  UNIQUE INDEX `usernameUsers_UNIQUE` (`usernameUsers` ASC),
  UNIQUE INDEX `emailUsers_UNIQUE` (`emailUsers` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fizzAppSchema`.`Restaurants`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fizzAppSchema`.`Restaurants` (
  `idRestaurants` INT NOT NULL AUTO_INCREMENT,
  `nameRestaurants` VARCHAR(45) NOT NULL,
  `addressRestaurants` MEDIUMTEXT NOT NULL,
  `cityRestaurants` VARCHAR(45) NOT NULL,
  `stateRestaurants` VARCHAR(45) NOT NULL,
  `zipCodeRestaurants` INT NOT NULL,
  PRIMARY KEY (`idRestaurants`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fizzAppSchema`.`Dishes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fizzAppSchema`.`Dishes` (
  `idDishes` INT NOT NULL AUTO_INCREMENT,
  `nameDishes` VARCHAR(45) NOT NULL,
  `priceDishes` FLOAT NOT NULL,
  `restaurantDishes` INT NOT NULL,
  PRIMARY KEY (`idDishes`),
  INDEX `restaurantDishes_idx` (`restaurantDishes` ASC),
  CONSTRAINT `restaurantDishes`
    FOREIGN KEY (`restaurantDishes`)
    REFERENCES `fizzAppSchema`.`Restaurants` (`idRestaurants`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fizzAppSchema`.`Posts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fizzAppSchema`.`Posts` (
  `idPosts` INT NOT NULL AUTO_INCREMENT,
  `captionPosts` TINYTEXT NOT NULL,
  `userPosts` INT NOT NULL,
  `retaurantPosts` INT NOT NULL,
  `dishPosts` INT NULL,
  `picturelinkPosts` TINYTEXT NOT NULL,
  PRIMARY KEY (`idPosts`),
  INDEX `userPosts_idx` (`userPosts` ASC),
  INDEX `restaurantPosts_idx` (`retaurantPosts` ASC),
  INDEX `dishPosts_idx` (`dishPosts` ASC),
  CONSTRAINT `userPosts`
    FOREIGN KEY (`userPosts`)
    REFERENCES `fizzAppSchema`.`Users` (`idUsers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `restaurantPosts`
    FOREIGN KEY (`retaurantPosts`)
    REFERENCES `fizzAppSchema`.`Restaurants` (`idRestaurants`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `dishPosts`
    FOREIGN KEY (`dishPosts`)
    REFERENCES `fizzAppSchema`.`Dishes` (`idDishes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fizzAppSchema`.`Comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fizzAppSchema`.`Comments` (
  `idComments` INT NOT NULL AUTO_INCREMENT,
  `userComments` INT NOT NULL,
  `textComments` TINYTEXT NOT NULL,
  `postComments` INT NOT NULL,
  PRIMARY KEY (`idComments`),
  INDEX `userComments_idx` (`userComments` ASC),
  INDEX `postComments_idx` (`postComments` ASC),
  CONSTRAINT `userComments`
    FOREIGN KEY (`userComments`)
    REFERENCES `fizzAppSchema`.`Users` (`idUsers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `postComments`
    FOREIGN KEY (`postComments`)
    REFERENCES `fizzAppSchema`.`Posts` (`idPosts`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fizzAppSchema`.`Deals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fizzAppSchema`.`Deals` (
  `idDeals` INT NOT NULL AUTO_INCREMENT,
  `restaurantDeals` INT NOT NULL,
  `descriptionDeals` TINYTEXT NOT NULL,
  PRIMARY KEY (`idDeals`),
  INDEX `restaurantDeals_idx` (`restaurantDeals` ASC),
  CONSTRAINT `restaurantDeals`
    FOREIGN KEY (`restaurantDeals`)
    REFERENCES `fizzAppSchema`.`Restaurants` (`idRestaurants`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fizzAppSchema`.`RestaurantRatings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fizzAppSchema`.`RestaurantRatings` (
  `idRestaurantRatings` INT NOT NULL AUTO_INCREMENT,
  `restaurantRestaurantRatings` INT NOT NULL,
  `userRestaurantRatings` INT NOT NULL,
  `ratingRestaurantRatings` INT NOT NULL,
  PRIMARY KEY (`idRestaurantRatings`),
  UNIQUE INDEX `userRestaurantRatings_UNIQUE` (`userRestaurantRatings` ASC),
  INDEX `restaurantRestaurantRatings_idx` (`restaurantRestaurantRatings` ASC),
  CONSTRAINT `userRestaurantRatings`
    FOREIGN KEY (`userRestaurantRatings`)
    REFERENCES `fizzAppSchema`.`Users` (`idUsers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `restaurantRestaurantRatings`
    FOREIGN KEY (`restaurantRestaurantRatings`)
    REFERENCES `fizzAppSchema`.`Restaurants` (`idRestaurants`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fizzAppSchema`.`DishRatings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fizzAppSchema`.`DishRatings` (
  `idDishRatings` INT NOT NULL AUTO_INCREMENT,
  `dishDishRatings` INT NOT NULL,
  `userDishRatings` INT NOT NULL,
  `ratingDishRatings` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idDishRatings`),
  UNIQUE INDEX `userDishRatings_UNIQUE` (`userDishRatings` ASC),
  INDEX `dishDishRatings_idx` (`dishDishRatings` ASC),
  CONSTRAINT `userDishRatings`
    FOREIGN KEY (`userDishRatings`)
    REFERENCES `fizzAppSchema`.`Users` (`idUsers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `dishDishRatings`
    FOREIGN KEY (`dishDishRatings`)
    REFERENCES `fizzAppSchema`.`Dishes` (`idDishes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fizzAppSchema`.`Likes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fizzAppSchema`.`Likes` (
  `idLikes` INT NOT NULL AUTO_INCREMENT,
  `postLikes` INT NOT NULL,
  `userLikes` INT NOT NULL,
  PRIMARY KEY (`idLikes`),
  UNIQUE INDEX `userLikes_UNIQUE` (`userLikes` ASC),
  INDEX `postLikes_idx` (`postLikes` ASC),
  CONSTRAINT `userLikes`
    FOREIGN KEY (`userLikes`)
    REFERENCES `fizzAppSchema`.`Users` (`idUsers`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `postLikes`
    FOREIGN KEY (`postLikes`)
    REFERENCES `fizzAppSchema`.`Posts` (`idPosts`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
