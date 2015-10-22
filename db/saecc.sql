-- MySQL Script generated by MySQL Workbench
-- 10/22/15 00:00:10
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema saecc
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema saecc
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `saecc` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `saecc` ;

-- -----------------------------------------------------
-- Table `saecc`.`school`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saecc`.`school` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(175) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `saecc`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saecc`.`user` (
  `id` INT UNSIGNED NOT NULL,
  `user_name` VARCHAR(50) NOT NULL,
  `name` VARCHAR(175) NOT NULL,
  `password_hash` VARCHAR(175) NOT NULL,
  `auth_key` VARCHAR(128) NOT NULL,
  `access_token` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `access_token_UNIQUE` (`access_token` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `saecc`.`status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saecc`.`status` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(45) NOT NULL COMMENT 'Indica el estado en el que se encuentra el equipo que puede ser: almacenado, operativo, refacciones, descompuesto... ',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `status_UNIQUE` (`status` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `saecc`.`room`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saecc`.`room` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `available` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `saecc`.`equipment_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saecc`.`equipment_type` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `saecc`.`equipment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saecc`.`equipment` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `inventory` VARCHAR(30) NOT NULL,
  `description` VARCHAR(175) NOT NULL,
  `serial_number` VARCHAR(175) NOT NULL,
  `status_id` INT UNSIGNED NOT NULL,
  `room_id` INT UNSIGNED NOT NULL,
  `location` VARCHAR(45) NOT NULL COMMENT 'Registra la posición que se le asigna a un equipo en una sala o el nombre de una persona',
  `available` TINYINT(1) NOT NULL DEFAULT 1 COMMENT 'Este campo registra si un equipo va a estar disponible en una sala para asignarlo a un cliente',
  `type_id` INT UNSIGNED NOT NULL,
  UNIQUE INDEX `computer_inventory_id_UNIQUE` (`inventory` ASC),
  PRIMARY KEY (`id`),
  INDEX `fk_computer_status1_idx` (`status_id` ASC),
  INDEX `fk_computer_room1_idx` (`room_id` ASC),
  INDEX `fk_equipment_equipment_type1_idx` (`type_id` ASC),
  CONSTRAINT `fk_computer_status1`
    FOREIGN KEY (`status_id`)
    REFERENCES `saecc`.`status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_computer_room1`
    FOREIGN KEY (`room_id`)
    REFERENCES `saecc`.`room` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_equipment_equipment_type1`
    FOREIGN KEY (`type_id`)
    REFERENCES `saecc`.`equipment_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `saecc`.`log_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saecc`.`log_type` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL COMMENT 'indica el tipo de operación somo: alta, baja o cambio',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `saecc`.`log`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saecc`.`log` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `equipment_id` INT UNSIGNED NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  `status_id` INT UNSIGNED NOT NULL,
  `date` DATETIME NOT NULL,
  `room_id` INT UNSIGNED NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  `log_type_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_log_equipment1_idx` (`equipment_id` ASC),
  INDEX `fk_log_status1_idx` (`status_id` ASC),
  INDEX `fk_log_user1_idx` (`user_id` ASC),
  INDEX `fk_log_log_type1_idx` (`log_type_id` ASC),
  CONSTRAINT `fk_log_equipment1`
    FOREIGN KEY (`equipment_id`)
    REFERENCES `saecc`.`equipment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_log_status1`
    FOREIGN KEY (`status_id`)
    REFERENCES `saecc`.`status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_log_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `saecc`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_log_log_type1`
    FOREIGN KEY (`log_type_id`)
    REFERENCES `saecc`.`log_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `saecc`.`user_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saecc`.`user_type` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `type_UNIQUE` (`type` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `saecc`.`incident`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saecc`.`incident` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `date` DATETIME NOT NULL,
  `user_id` INT UNSIGNED NOT NULL,
  `equipment_id` INT UNSIGNED NULL,
  `room_id` INT UNSIGNED NOT NULL,
  `description` TEXT NOT NULL,
  `solved` TINYINT(1) NOT NULL DEFAULT 0,
  `date_solved` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_incident_user_type1_idx` (`user_id` ASC),
  INDEX `fk_incident_equipment1_idx` (`equipment_id` ASC),
  INDEX `fk_incident_room1_idx` (`room_id` ASC),
  CONSTRAINT `fk_incident_user_type1`
    FOREIGN KEY (`user_id`)
    REFERENCES `saecc`.`user_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_incident_equipment1`
    FOREIGN KEY (`equipment_id`)
    REFERENCES `saecc`.`equipment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_incident_room1`
    FOREIGN KEY (`room_id`)
    REFERENCES `saecc`.`room` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `saecc`.`area`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saecc`.`area` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(175) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `saecc`.`discipline`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saecc`.`discipline` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `school_id` INT UNSIGNED NOT NULL,
  `name` VARCHAR(175) NOT NULL,
  `short_name` VARCHAR(20) NOT NULL,
  `area_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_discipline_area1_idx` (`area_id` ASC),
  INDEX `fk_discipline_school1_idx` (`school_id` ASC),
  CONSTRAINT `fk_discipline_area1`
    FOREIGN KEY (`area_id`)
    REFERENCES `saecc`.`area` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_discipline_school1`
    FOREIGN KEY (`school_id`)
    REFERENCES `saecc`.`school` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `saecc`.`client`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saecc`.`client` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `user` VARCHAR(30) NOT NULL,
  `first_name` VARCHAR(175) NOT NULL,
  `last_name` VARCHAR(175) NOT NULL,
  `type_id` INT UNSIGNED NOT NULL,
  `discipline_id` INT UNSIGNED NULL,
  `status` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `user_UNIQUE` (`user` ASC),
  INDEX `fk_client_user_type1_idx` (`type_id` ASC),
  INDEX `fk_client_discipline1_idx` (`discipline_id` ASC),
  CONSTRAINT `fk_client_user_type1`
    FOREIGN KEY (`type_id`)
    REFERENCES `saecc`.`user_type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_client_discipline1`
    FOREIGN KEY (`discipline_id`)
    REFERENCES `saecc`.`discipline` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `saecc`.`assignation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `saecc`.`assignation` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `client_id` INT UNSIGNED NOT NULL,
  `equipment_id` INT UNSIGNED NOT NULL,
  `location` VARCHAR(45) NOT NULL,
  `room_id` INT UNSIGNED NOT NULL,
  `start_date` DATETIME NOT NULL,
  `end_date` DATETIME NOT NULL,
  `duration` INT UNSIGNED NOT NULL COMMENT 'el tiempo se guardará en segundos y se convertirá a horas según la vista de usuario',
  PRIMARY KEY (`id`),
  INDEX `fk_assignation_client1_idx` (`client_id` ASC),
  INDEX `fk_assignation_equipment1_idx` (`equipment_id` ASC),
  INDEX `fk_assignation_room1_idx` (`room_id` ASC),
  CONSTRAINT `fk_assignation_client1`
    FOREIGN KEY (`client_id`)
    REFERENCES `saecc`.`client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assignation_equipment1`
    FOREIGN KEY (`equipment_id`)
    REFERENCES `saecc`.`equipment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assignation_room1`
    FOREIGN KEY (`room_id`)
    REFERENCES `saecc`.`room` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;