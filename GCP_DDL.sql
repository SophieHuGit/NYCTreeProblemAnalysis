-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema new_york_trees_analysis
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `new_york_trees_analysis`;
CREATE SCHEMA IF NOT EXISTS `new_york_trees_analysis` DEFAULT CHARACTER SET UTF8;
USE `new_york_trees_analysis` ;

-- -----------------------------------------------------
-- Table `new_york_trees_analysis`.`location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_york_trees_analysis`.`location` (
  `location_id` INT(10) NOT NULL,
  `block_id` INT(10) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `zip_code` INT(10) NOT NULL,
  `borough` VARCHAR(45) NOT NULL,
  `cncldist` INT NOT NULL,
  `nta_name` VARCHAR(100) NOT NULL,
  `latitude` VARCHAR(45) NOT NULL,
  `longitude` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`location_id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `new_york_trees_analysis`.`health`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `new_york_trees_analysis`.`health`;
CREATE TABLE IF NOT EXISTS `new_york_trees_analysis`.`health` (
  `health_id` INT(10) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `health` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`health_id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `new_york_trees_analysis`.`activity`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `new_york_trees_analysis`.`activity` (
  `activity_id` INT(10) NOT NULL,
  `curb_loc` VARCHAR(45) NOT NULL,
  `steward` VARCHAR(45) NOT NULL,
  `guards` VARCHAR(45) NOT NULL,
  `sidewalk` VARCHAR(45) NOT NULL,
  `location_id` INT(10) NOT NULL,
  PRIMARY KEY (`activity_id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `new_york_trees_analysis`.`problem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `new_york_trees_analysis`.`problem`;
CREATE TABLE IF NOT EXISTS `new_york_trees_analysis`.`problem` (
  `problem_id` INT(10) NOT NULL,
  `problems` VARCHAR(200) NOT NULL,
  `root_stone` VARCHAR(45) NOT NULL,
  `root_grate` VARCHAR(45) NOT NULL,
  `root_other` VARCHAR(45) NOT NULL,
  `trunk_wire` VARCHAR(45) NOT NULL,
  `trnk_light` VARCHAR(45) NOT NULL,
  `trnk_other` VARCHAR(45) NOT NULL,
  `brch_light` VARCHAR(45) NOT NULL,
  `brch_shoe` VARCHAR(45) NOT NULL,
  `brch_other` VARCHAR(45) NOT NULL,
  `location_id` INT(10) NOT NULL,
  PRIMARY KEY (`problem_id`))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `new_york_trees_analysis`.`tree`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `new_york_trees_analysis`.`tree`;
CREATE TABLE IF NOT EXISTS `new_york_trees_analysis`.`tree` (
  `tree_id` INT(10) NOT NULL,
  `created_at` DATETIME NOT NULL,
  `tree_dbh` INT(10) NOT NULL,
  `stump_diam` INT(10) NOT NULL,
  `spc_common` VARCHAR(45) NOT NULL,
  `location_id` INT(10) NOT NULL,
  `health_id` INT(10) NOT NULL,
  `activity_id` INT(10) NOT NULL,
  `problem_id` INT(10) NOT NULL,
  PRIMARY KEY (`tree_id`),
  INDEX `health_id_idx` (`health_id` ASC),
  INDEX `location_id_idx` (`location_id` ASC),
  INDEX `problem_id_idx` (`problem_id` ASC),
  INDEX `activity _id_idx` (`activity_id` ASC),
  CONSTRAINT `health_id`
    FOREIGN KEY (`health_id`)
    REFERENCES `new_york_trees_analysis`.`health` (`health_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `location_id`
    FOREIGN KEY (`location_id`)
    REFERENCES `new_york_trees_analysis`.`location` (`location_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `problem_id`
    FOREIGN KEY (`problem_id`)
    REFERENCES `new_york_trees_analysis`.`problem` (`problem_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `activity _id`
    FOREIGN KEY (`activity_id`)
    REFERENCES `new_york_trees_analysis`.`activity` (`activity_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
