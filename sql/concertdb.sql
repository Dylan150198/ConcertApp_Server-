DROP DATABASE IF EXISTS `concertdb`;
CREATE DATABASE `concertdb`;
USE `concertdb`;

-- concertdb_administrator aanmaken
CREATE USER 'concertdb_user'@'%' IDENTIFIED BY 'secret';
CREATE USER 'concertdb_user'@'localhost' IDENTIFIED BY 'secret';

-- Alle rechten geven aan de administrator
GRANT ALL ON `concertdb`.* TO 'concertdb_user'@'%';
GRANT ALL ON `concertdb`.* TO 'concertdb_user'@'localhost';

-- -----------------------------------------------------
-- Table `concerts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `concerts` ;
CREATE TABLE IF NOT EXISTS `concerts` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`stage` VARCHAR(32) NOT NULL,
	`performer_id` INT UNSIGNED NOT NULL UNIQUE,
	PRIMARY KEY (`id`)
) 
ENGINE = InnoDB;
-- -----------------------------------------------------
-- Table `performers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `performers` ;
CREATE TABLE IF NOT EXISTS `performers` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(64) NOT NULL,
    `genre` VARCHAR(64) NOT NULL,
	`description` VARCHAR(128) NOT NULL,
	PRIMARY KEY (`id`)
) 
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `people`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `people` ;
CREATE TABLE IF NOT EXISTS `people` (
	`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` VARCHAR(64) NOT NULL,
	`lastname` VARCHAR(64) NOT NULL,
	`concertId` INT UNSIGNED NOT NULL UNIQUE,
	PRIMARY KEY (`id`)
) 
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Maken van foreign keys
-- -----------------------------------------------------

-- -- Concerts <Have> Performers
ALTER TABLE `concerts` 
ADD CONSTRAINT `fk_concerts_performer`
FOREIGN KEY (`performer_id`) REFERENCES `performers` (`id`)
ON DELETE CASCADE
ON UPDATE CASCADE;

-- -- People <Going to a> Concerts

ALTER TABLE `people` 
ADD CONSTRAINT `fk_people_concert`
FOREIGN KEY (`concertId`) REFERENCES `concerts` (`id`)
ON DELETE NO ACTION
ON UPDATE CASCADE;

-- -----------------------------------------------------
-- Insert test values
-- -----------------------------------------------------
-- INSERT INTO `users` (`firstname`, `lastname`, `email`, `password`) VALUES 
-- ('user-1', 'name-1', 'user1@server.nl', 'secret'),
-- ('user-2', 'name-2', 'user2@server.nl', 'secret'),
-- ('user-3', 'name-3', 'user3@server.nl', 'secret'),
-- ('user-4', 'name-4', 'user4@server.nl', 'secret');

-- INSERT INTO `producer` (`name`, `description`, `userID`) VALUES
-- ('EA', 'Description.', 1),
-- ('Epic Games', 'Description.', 2),
-- ('Mojang AB', 'Description.', 3);

-- INSERT INTO `games` (`title`, `year`, `type`, `producerID`, `userID`) VALUES
-- ('Battlefield 5', 2018, 'FIRST_PERSON_SHOOTER', 1, 1),
-- ('Fortnite', 2017, 'THIRD_PERSON_SHOOTER', 2, 2),
-- ('Minecraft', 2009, 'ADVENTURE', 3, 2);