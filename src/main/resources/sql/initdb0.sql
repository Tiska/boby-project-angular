SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema catalog
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema platform
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `currency`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `currency` ;

CREATE TABLE IF NOT EXISTS `currency` (
  `ID` BIGINT NOT NULL,
  `CODE` VARCHAR(3) NOT NULL,
  `NAME` VARCHAR(50) NOT NULL,
  `PRIORITY` INT NOT NULL,
  `SYMBOL` VARCHAR(3) NULL,
  `DEFAULT_VALUE` TINYINT(1) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `value_list`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `value_list` ;

CREATE TABLE IF NOT EXISTS `value_list` (
  `ID` BIGINT NOT NULL,
  `CODE` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `CODE_UNIQUE` (`CODE` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `value_list_item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `value_list_item` ;

CREATE TABLE IF NOT EXISTS `value_list_item` (
  `ID` BIGINT NOT NULL,
  `PRIORITY` INT(4) NULL,
  `ID_VALUE_LIST` BIGINT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_value_site_item_id_value_list_idx` (`ID_VALUE_LIST` ASC),
  CONSTRAINT `fk_value_site_item_id_value_list`
    FOREIGN KEY (`ID_VALUE_LIST`)
    REFERENCES `value_list` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `address` ;

CREATE TABLE IF NOT EXISTS `address` (
  `ID` BIGINT NOT NULL,
  `ADDRESS_LINE1` VARCHAR(38) NULL,
  `ADDRESS_LINE2` VARCHAR(38) NULL,
  `ADDRESS_LINE3` VARCHAR(38) NULL,
  `ADDRESS_LINE4` VARCHAR(38) NULL,
  `POSTAL_CODE` VARCHAR(10) NULL,
  `CITY` VARCHAR(38) NULL,
  `GEOLOC_LATITUDE` FLOAT NULL,
  `GEOLOC_LONGITUDE` FLOAT NULL,
  `ADDRESS_NAME` VARCHAR(50) NULL,
  `ID_OWNER` BIGINT NULL,
  `ID_VALUE_LIST_ITEM` BIGINT NULL,
  `ID_SITE` BIGINT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_adrdess_id_owner_idx` (`ID_OWNER` ASC),
  INDEX `fk_address_id_value_list_item_idx` (`ID_VALUE_LIST_ITEM` ASC),
  INDEX `fk_address_id_site_idx` (`ID_SITE` ASC),
  CONSTRAINT `fk_adrdess_id_owner`
    FOREIGN KEY (`ID_OWNER`)
    REFERENCES `owner` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_address_id_value_list_item`
    FOREIGN KEY (`ID_VALUE_LIST_ITEM`)
    REFERENCES `value_list_item` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_address_id_site`
    FOREIGN KEY (`ID_SITE`)
    REFERENCES `site` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `language`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `language` ;

CREATE TABLE IF NOT EXISTS `language` (
  `ID` BIGINT NOT NULL,
  `CODE` CHAR(5) NULL,
  `NAME` VARCHAR(50) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `country_vat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `country_vat` ;

CREATE TABLE IF NOT EXISTS `country_vat` (
  `ID` BIGINT NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vat_rate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vat_rate` ;

CREATE TABLE IF NOT EXISTS `vat_rate` (
  `ID` BIGINT NOT NULL,
  `VALUE` INT NOT NULL,
  `ACTIVE` TINYINT(1) NULL,
  `DEFAULT_VALUE` TINYINT(1) NULL,
  `ID_COUNTRY_VAT` BIGINT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_vat_rate_id_country_vat_idx` (`ID_COUNTRY_VAT` ASC),
  CONSTRAINT `fk_vat_rate_id_country_vat`
    FOREIGN KEY (`ID_COUNTRY_VAT`)
    REFERENCES `country_vat` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `event` ;

CREATE TABLE IF NOT EXISTS `event` (
  `ID` BIGINT NOT NULL,
  `ID_PRODUCT` BIGINT NOT NULL,
  `ID_SITE` BIGINT NOT NULL,
  `ID_VALUE_LIST_ITEM` BIGINT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_event_id_product_idx` (`ID_PRODUCT` ASC),
  INDEX `fk_event_id_site_idx` (`ID_SITE` ASC),
  INDEX `fk_event_id_value_list_item_idx` (`ID_VALUE_LIST_ITEM` ASC),
  CONSTRAINT `fk_event_id_product`
    FOREIGN KEY (`ID_PRODUCT`)
    REFERENCES `product` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_id_site`
    FOREIGN KEY (`ID_SITE`)
    REFERENCES `site` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_id_value_list_item`
    FOREIGN KEY (`ID_VALUE_LIST_ITEM`)
    REFERENCES `value_list_item` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `product` ;

CREATE TABLE IF NOT EXISTS `product` (
  `ID` BIGINT NOT NULL,
  `ID_OWNER` BIGINT NOT NULL,
  `ID_EVENT` BIGINT NULL,
  `ID_CURRENCY` BIGINT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_product_id_owner_idx` (`ID_OWNER` ASC),
  INDEX `fk_product_id_currency_idx` (`ID_CURRENCY` ASC),
  INDEX `fk_product_id_event_idx` (`ID_EVENT` ASC),
  CONSTRAINT `fk_product_id_owner`
    FOREIGN KEY (`ID_OWNER`)
    REFERENCES `owner` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_id_currency`
    FOREIGN KEY (`ID_CURRENCY`)
    REFERENCES `platform`.`currency` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_id_event`
    FOREIGN KEY (`ID_EVENT`)
    REFERENCES `event` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `media_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `media_type` ;

CREATE TABLE IF NOT EXISTS `media_type` (
  `ID` BIGINT NOT NULL,
  `CODE` VARCHAR(30) NOT NULL,
  `NAME` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `media_model`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `media_model` ;

CREATE TABLE IF NOT EXISTS `media_model` (
  `ID` BIGINT NOT NULL,
  `CODE` VARCHAR(3) NOT NULL,
  `X_DIMENSION` INT NOT NULL,
  `Y_DIMENSION` INT NOT NULL,
  `MAX_SIZE` INT NOT NULL,
  `EXTENSION` VARCHAR(150) NOT NULL,
  `ID_MEDIA_TYPE` BIGINT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_media_model_id_media_type_idx` (`ID_MEDIA_TYPE` ASC),
  CONSTRAINT `fk_media_model_id_media_type`
    FOREIGN KEY (`ID_MEDIA_TYPE`)
    REFERENCES `media_type` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `media`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `media` ;

CREATE TABLE IF NOT EXISTS `media` (
  `ID` BIGINT NOT NULL,
  `URL` VARCHAR(255) NOT NULL,
  `ID_SITE` BIGINT NULL,
  `ID_PRODUCT` BIGINT NOT NULL,
  `ID_OWNER` BIGINT NULL,
  `ID_MEDIA_MODEL` BIGINT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_media_id_site_idx` (`ID_SITE` ASC),
  INDEX `fk_media_id_owner_idx` (`ID_OWNER` ASC),
  INDEX `fk_media_id_product_idx` (`ID_PRODUCT` ASC),
  INDEX `fk_media_id_media_model_idx` (`ID_MEDIA_MODEL` ASC),
  CONSTRAINT `fk_media_id_site`
    FOREIGN KEY (`ID_SITE`)
    REFERENCES `site` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_media_id_owner`
    FOREIGN KEY (`ID_OWNER`)
    REFERENCES `owner` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_media_id_product`
    FOREIGN KEY (`ID_PRODUCT`)
    REFERENCES `product` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_media_id_media_model`
    FOREIGN KEY (`ID_MEDIA_MODEL`)
    REFERENCES `media_model` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `owner`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `owner` ;

CREATE TABLE IF NOT EXISTS `owner` (
  `ID` BIGINT NOT NULL,
  `NAME` VARCHAR(128) NULL,
  `VAT_NUMBER` VARCHAR(19) NULL,
  `LICENSE_NUMBER` VARCHAR(50) NULL,
  `WEBSITE` VARCHAR(255) NULL,
  `ACCOUNT_HOLDER` VARCHAR(100) NULL,
  `IBAN_CODE` VARCHAR(45) NULL,
  `BIC_CODE` VARCHAR(11) NULL,
  `DOMAIN` VARCHAR(100) NULL,
  `THEME_COLOR` VARCHAR(10) NULL,
  `ID_CURRENCY` BIGINT NULL,
  `ID_VALUE_LIST_ITEM` BIGINT NULL,
  `ID_ADDRESS` BIGINT NULL,
  `ID_LANGUAGE` BIGINT NULL,
  `ID_VAT_RATE` BIGINT NULL,
  `ID_MEDIA` BIGINT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_owner_id_currency_idx` (`ID_CURRENCY` ASC),
  INDEX `fk_owner_id_value_list_item_idx` (`ID_VALUE_LIST_ITEM` ASC),
  INDEX `fk_owner_id_address_idx` (`ID_ADDRESS` ASC),
  INDEX `fk_owner_id_language_idx` (`ID_LANGUAGE` ASC),
  INDEX `fk_owner_id_vat_rate_idx` (`ID_VAT_RATE` ASC),
  INDEX `fk_owner_id_media_idx` (`ID_MEDIA` ASC),
  CONSTRAINT `fk_owner_id_currency`
    FOREIGN KEY (`ID_CURRENCY`)
    REFERENCES `platform`.`currency` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_owner_id_value_list_item`
    FOREIGN KEY (`ID_VALUE_LIST_ITEM`)
    REFERENCES `value_list_item` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_owner_id_address`
    FOREIGN KEY (`ID_ADDRESS`)
    REFERENCES `address` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_owner_id_language`
    FOREIGN KEY (`ID_LANGUAGE`)
    REFERENCES `platform`.`language` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_owner_id_vat_rate`
    FOREIGN KEY (`ID_VAT_RATE`)
    REFERENCES `platform`.`vat_rate` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_owner_id_media`
    FOREIGN KEY (`ID_MEDIA`)
    REFERENCES `media` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `site`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `site` ;

CREATE TABLE IF NOT EXISTS `site` (
  `ID` BIGINT NOT NULL,
  `NAME` VARCHAR(128) NULL,
  `ID_OWNER` BIGINT NOT NULL,
  `ID_ADDRESS` BIGINT NULL,
  PRIMARY KEY (`ID`),
  INDEX `OWNER` (`ID_OWNER` ASC),
  INDEX `fk_site_id_address_idx` (`ID_ADDRESS` ASC),
  CONSTRAINT `fk_site_id_owner`
    FOREIGN KEY (`ID_OWNER`)
    REFERENCES `owner` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_site_id_address`
    FOREIGN KEY (`ID_ADDRESS`)
    REFERENCES `address` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `site_section`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `site_section` ;

CREATE TABLE IF NOT EXISTS `site_section` (
  `ID` BIGINT NOT NULL,
  `NAME` VARCHAR(128) NOT NULL,
  `ID_SITE` BIGINT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `ID_SITE` (`ID_SITE` ASC),
  CONSTRAINT `fk_site_section_id_site`
    FOREIGN KEY (`ID_SITE`)
    REFERENCES `site` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `operator`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `operator` ;

CREATE TABLE IF NOT EXISTS `operator` (
  `ID` BIGINT NOT NULL,
  `LAST_NAME` VARCHAR(65) NULL,
  `FIRST_NAME` VARCHAR(65) NULL,
  `LOGIN` VARCHAR(256) NULL,
  `PASSWORD` VARCHAR(128) NOT NULL,
  `ACTIVE` TINYINT(1) NOT NULL,
  `EMAIL` VARCHAR(256) NULL,
  `FIRST_CONNECTION` TINYINT(1) NOT NULL,
  `PASSWORD_MODIF_DATE` DATETIME NULL,
  `ERROR_CONNECTION_NUMBER` INT NULL,
  `LAST_CONNECTION_DATE` DATETIME NULL,
  `ACTIVATION_TOKEN` VARCHAR(256) NULL,
  `ACTIVATION_TOKEN_EXPIRATION_DATE` DATETIME NULL,
  `LOGIN_TOKEN_HASH` VARCHAR(256) NULL,
  `LOGIN_TOKEN_EXPIRATION_DATE` DATETIME NULL,
  `PWD_INIT` VARCHAR(256) NULL,
  `PWD_INIT_TOKEN_EXPIRATION_DATE` DATETIME NULL,
  `CREA_DATE` DATETIME NOT NULL,
  `MODIF_DATE` DATETIME NOT NULL,
  `ID_OWNER` BIGINT NULL,
  `ID_VALUE_LIST_ITEM` BIGINT NOT NULL,
  `LOGIN_TOKEN_SHORTCUT` VARCHAR(12) NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_operator_id_owner_idx` (`ID_OWNER` ASC),
  INDEX `fk_operator_id_value_list_item_idx` (`ID_VALUE_LIST_ITEM` ASC),
  UNIQUE INDEX `login` (`LOGIN` ASC),
  UNIQUE INDEX `LOGIN_TOKEN_HASH_UNIQUE` (`LOGIN_TOKEN_HASH` ASC),
  CONSTRAINT `fk_operator_id_owner`
    FOREIGN KEY (`ID_OWNER`)
    REFERENCES `owner` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_operator_id_value_list_item`
    FOREIGN KEY (`ID_VALUE_LIST_ITEM`)
    REFERENCES `value_list_item` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `product_i18n`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `product_i18n` ;

CREATE TABLE IF NOT EXISTS `product_i18n` (
  `ID` BIGINT NOT NULL,
  `TITLE` VARCHAR(128) NOT NULL,
  `DESCRIPTION` TEXT NULL,
  `ID_PRODUCT` BIGINT NOT NULL,
  `ID_LANGUAGE` BIGINT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_product_i18n_id_product_idx` (`ID_PRODUCT` ASC),
  INDEX `fk_product_i18n_id_language_idx` (`ID_LANGUAGE` ASC),
  UNIQUE INDEX `INDEX_ID_PRODUCT_ET_LANGUE` (`ID_PRODUCT` ASC, `ID_LANGUAGE` ASC),
  CONSTRAINT `fk_product_i18n_id_product`
    FOREIGN KEY (`ID_PRODUCT`)
    REFERENCES `product` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_i18n_id_language`
    FOREIGN KEY (`ID_LANGUAGE`)
    REFERENCES `platform`.`language` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `value_list_item_i18n`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `value_list_item_i18n` ;

CREATE TABLE IF NOT EXISTS `value_list_item_i18n` (
  `ID` BIGINT NOT NULL,
  `VALUE` VARCHAR(50) NULL,
  `ID_VALUE_LIST_ITEM` BIGINT NOT NULL,
  `ID_LANGUAGE` BIGINT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_value_list_item_i18n_id_value_list_item_idx` (`ID_VALUE_LIST_ITEM` ASC),
  INDEX `fk_value_list_item_i18n_id_language_idx` (`ID_LANGUAGE` ASC),
  UNIQUE INDEX `INDEX_VALUE_LIST_ITEM_AND_LANG` (`ID_LANGUAGE` ASC, `ID_VALUE_LIST_ITEM` ASC),
  CONSTRAINT `fk_value_list_item_i18n_id_value_list_item`
    FOREIGN KEY (`ID_VALUE_LIST_ITEM`)
    REFERENCES `value_list_item` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_value_list_item_i18n_id_language`
    FOREIGN KEY (`ID_LANGUAGE`)
    REFERENCES `platform`.`language` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `event_date`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `event_date` ;

CREATE TABLE IF NOT EXISTS `event_date` (
  `ID` BIGINT NOT NULL,
  `START_DATE_TIME` DATETIME NOT NULL,
  `END_DATE_TIME` DATETIME NULL,
  `IS_TEMPLATE` TINYINT(1) NOT NULL,
  `ID_EVENT` BIGINT NOT NULL,
  `ID_VAT_RATE` BIGINT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_event_date_id_event_idx` (`ID_EVENT` ASC),
  INDEX `fk_event_date_id_vat_rate_idx` (`ID_VAT_RATE` ASC),
  CONSTRAINT `fk_event_date_id_event`
    FOREIGN KEY (`ID_EVENT`)
    REFERENCES `event` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_date_id_vat_rate`
    FOREIGN KEY (`ID_VAT_RATE`)
    REFERENCES `platform`.`vat_rate` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `seat_category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `seat_category` ;

CREATE TABLE IF NOT EXISTS `seat_category` (
  `ID` BIGINT NOT NULL,
  `PRIORITY` INT NOT NULL,
  `DEFAULT_CATEGORY` TINYINT(1) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rate_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rate_type` ;

CREATE TABLE IF NOT EXISTS `rate_type` (
  `ID` BIGINT NOT NULL,
  `NAME` VARCHAR(65) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rate`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rate` ;

CREATE TABLE IF NOT EXISTS `rate` (
  `ID` BIGINT NOT NULL,
  `MIN_PER_ORDER` INT(4) NULL,
  `MAX_PER_ORDER` INT(4) NULL,
  `PRIORITY` INT NULL,
  `ID_RATE_TYPE` BIGINT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_rate_id_rate_type_idx` (`ID_RATE_TYPE` ASC),
  CONSTRAINT `fk_rate_id_rate_type`
    FOREIGN KEY (`ID_RATE_TYPE`)
    REFERENCES `rate_type` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sales_allocation_rule`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sales_allocation_rule` ;

CREATE TABLE IF NOT EXISTS `sales_allocation_rule` (
  `ID` BIGINT NOT NULL,
  `MAX_QUANTITY` INT NOT NULL,
  `STOCK_LEVEL` INT NULL,
  `ID_PRODUCT` BIGINT NULL,
  `ID_EVENT_DATE` BIGINT NULL,
  `ID_RATE` BIGINT NULL,
  `ID_SEAT_CATEGORY` BIGINT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_sales_allocation_rule_id_product_idx` (`ID_PRODUCT` ASC),
  INDEX `fk_sales_allocation_rule_id_event_date_idx` (`ID_EVENT_DATE` ASC),
  INDEX `fk_sales_allocation_rule_id_seat_category_idx` (`ID_SEAT_CATEGORY` ASC),
  INDEX `fk_sales_allocation_rule_id_rate_idx` (`ID_RATE` ASC),
  CONSTRAINT `fk_sales_allocation_rule_id_product`
    FOREIGN KEY (`ID_PRODUCT`)
    REFERENCES `product` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_allocation_rule_id_event_date`
    FOREIGN KEY (`ID_EVENT_DATE`)
    REFERENCES `event_date` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_allocation_rule_id_seat_category`
    FOREIGN KEY (`ID_SEAT_CATEGORY`)
    REFERENCES `seat_category` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sales_allocation_rule_id_rate`
    FOREIGN KEY (`ID_RATE`)
    REFERENCES `rate` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `price_plan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `price_plan` ;

CREATE TABLE IF NOT EXISTS `price_plan` (
  `ID` BIGINT NOT NULL,
  `NAME` VARCHAR(65) NOT NULL,
  `START_DATE_TIME` DATETIME NULL,
  `END_DATE_TIME` DATETIME NULL,
  `ID_EVENT` BIGINT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_price_plan_id_event_idx` (`ID_EVENT` ASC),
  CONSTRAINT `fk_price_plan_id_event`
    FOREIGN KEY (`ID_EVENT`)
    REFERENCES `event` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `price`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `price` ;

CREATE TABLE IF NOT EXISTS `price` (
  `ID` BIGINT NOT NULL,
  `ID_SEAT_CATEGORY` BIGINT NOT NULL,
  `ID_PRICE_PLAN` BIGINT NOT NULL,
  `ID_RATE` BIGINT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_price_id_price_plan_idx` (`ID_PRICE_PLAN` ASC),
  INDEX `fk_price_id_site_category_idx` (`ID_SEAT_CATEGORY` ASC),
  INDEX `fk_price_id_rate_idx` (`ID_RATE` ASC),
  CONSTRAINT `fk_price_id_price_plan`
    FOREIGN KEY (`ID_PRICE_PLAN`)
    REFERENCES `price_plan` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_price_id_site_category`
    FOREIGN KEY (`ID_SEAT_CATEGORY`)
    REFERENCES `seat_category` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_price_id_rate`
    FOREIGN KEY (`ID_RATE`)
    REFERENCES `rate` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `seat_category_i18n`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `seat_category_i18n` ;

CREATE TABLE IF NOT EXISTS `seat_category_i18n` (
  `ID` BIGINT NOT NULL,
  `NAME` VARCHAR(128) NOT NULL,
  `DESCRIPTION` TEXT NULL,
  `ID_SEAT_CATEGORY` BIGINT NOT NULL,
  `ID_LANGUAGE` BIGINT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_seat_category_i18n_id_site_category_idx` (`ID_SEAT_CATEGORY` ASC),
  INDEX `fk_seat_category_i18n_id_language_idx` (`ID_LANGUAGE` ASC),
  CONSTRAINT `fk_seat_category_i18n_id_site_category`
    FOREIGN KEY (`ID_SEAT_CATEGORY`)
    REFERENCES `seat_category` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_seat_category_i18n_id_language`
    FOREIGN KEY (`ID_LANGUAGE`)
    REFERENCES `platform`.`language` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `value_price`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `value_price` ;

CREATE TABLE IF NOT EXISTS `value_price` (
  `ID` BIGINT NOT NULL,
  `PRICE_VALUE` INT NOT NULL,
  `ID_PRICE` BIGINT NOT NULL,
  `ID_CURRENCY` BIGINT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_value_price_id_price_idx` (`ID_PRICE` ASC),
  INDEX `fk_value_price_id_currency_idx` (`ID_CURRENCY` ASC),
  CONSTRAINT `fk_value_price_id_price`
    FOREIGN KEY (`ID_PRICE`)
    REFERENCES `price` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_value_price_id_currency`
    FOREIGN KEY (`ID_CURRENCY`)
    REFERENCES `platform`.`currency` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rate_i18n`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rate_i18n` ;

CREATE TABLE IF NOT EXISTS `rate_i18n` (
  `ID` BIGINT NOT NULL,
  `NAME` VARCHAR(128) NOT NULL,
  `DESCRIPTION` TEXT NULL,
  `ID_RATE` BIGINT NOT NULL,
  `ID_LANGUAGE` BIGINT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_rate_i18n_id_rate_idx` (`ID_RATE` ASC),
  INDEX `fk_rate_i18n_id_language_idx` (`ID_LANGUAGE` ASC),
  CONSTRAINT `fk_rate_i18n_id_rate`
    FOREIGN KEY (`ID_RATE`)
    REFERENCES `rate` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_rate_i18n_id_language`
    FOREIGN KEY (`ID_LANGUAGE`)
    REFERENCES `platform`.`language` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `value_fee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `value_fee` ;

CREATE TABLE IF NOT EXISTS `value_fee` (
  `ID` BIGINT NOT NULL,
  `FIXED_VALUE` INT NULL,
  `ID_CURRENCY` BIGINT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_value_fee_id_currency_idx` (`ID_CURRENCY` ASC),
  CONSTRAINT `fk_value_fee_id_currency`
    FOREIGN KEY (`ID_CURRENCY`)
    REFERENCES `platform`.`currency` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fee` ;

CREATE TABLE IF NOT EXISTS `fee` (
  `ID` BIGINT NOT NULL,
  `PERCENTAGE` INT NULL,
  `ID_VALUE_FEE` BIGINT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_fee_id_value_fee_idx` (`ID_VALUE_FEE` ASC),
  CONSTRAINT `fk_fee_id_value_fee`
    FOREIGN KEY (`ID_VALUE_FEE`)
    REFERENCES `value_fee` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asso_price_fee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `asso_price_fee` ;

CREATE TABLE IF NOT EXISTS `asso_price_fee` (
  `ID_PRICE` BIGINT NOT NULL,
  `ID_FEE` BIGINT NOT NULL,
  PRIMARY KEY (`ID_PRICE`, `ID_FEE`),
  INDEX `fk_asso_price_fee_id_fee_idx` (`ID_FEE` ASC),
  CONSTRAINT `fk_asso_price_fee_id_price`
    FOREIGN KEY (`ID_PRICE`)
    REFERENCES `price` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_asso_price_fee_id_fee`
    FOREIGN KEY (`ID_FEE`)
    REFERENCES `fee` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fee_i18n`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `fee_i18n` ;

CREATE TABLE IF NOT EXISTS `fee_i18n` (
  `ID` BIGINT NOT NULL,
  `NAME` VARCHAR(128) NOT NULL,
  `ID_FEE` BIGINT NOT NULL,
  `ID_LANGUAGE` BIGINT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_fee_i18n_id_fee_idx` (`ID_FEE` ASC),
  INDEX `fk_fee_i18n_id_language_idx` (`ID_LANGUAGE` ASC),
  CONSTRAINT `fk_fee_i18n_id_fee`
    FOREIGN KEY (`ID_FEE`)
    REFERENCES `fee` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fee_i18n_id_language`
    FOREIGN KEY (`ID_LANGUAGE`)
    REFERENCES `platform`.`language` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `asso_event_date_price_plan`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `asso_event_date_price_plan` ;

CREATE TABLE IF NOT EXISTS `asso_event_date_price_plan` (
  `ID_EVENT_DATE` BIGINT NOT NULL,
  `ID_PRICE_PLAN` BIGINT NOT NULL,
  PRIMARY KEY (`ID_EVENT_DATE`, `ID_PRICE_PLAN`),
  INDEX `fk_asso_event_date_price_plan_id_price_plan_idx` (`ID_PRICE_PLAN` ASC),
  CONSTRAINT `fk_asso_event_date_price_plan_id_event_date`
    FOREIGN KEY (`ID_EVENT_DATE`)
    REFERENCES `event_date` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_asso_event_date_price_plan_id_price_plan`
    FOREIGN KEY (`ID_PRICE_PLAN`)
    REFERENCES `price_plan` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `country_vat_i18n`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `country_vat_i18n` ;

CREATE TABLE IF NOT EXISTS `country_vat_i18n` (
  `ID` BIGINT NOT NULL,
  `NAME` VARCHAR(50) NOT NULL,
  `ID_COUNTRY_VAT` BIGINT NOT NULL,
  `ID_LANGUAGE` BIGINT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_country_vat_i18n_id_country_vat_idx` (`ID_COUNTRY_VAT` ASC),
  INDEX `fk_country_vat_i18n_id_language_idx` (`ID_LANGUAGE` ASC),
  UNIQUE INDEX `UNIQUE_VAT_LANGUAGE` (`ID_LANGUAGE` ASC, `ID_COUNTRY_VAT` ASC),
  CONSTRAINT `fk_country_vat_i18n_id_country_vat`
    FOREIGN KEY (`ID_COUNTRY_VAT`)
    REFERENCES `country_vat` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_country_vat_i18n_id_language`
    FOREIGN KEY (`ID_LANGUAGE`)
    REFERENCES `language` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `vat_rate_i18n`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `vat_rate_i18n` ;

CREATE TABLE IF NOT EXISTS `vat_rate_i18n` (
  `ID` BIGINT NOT NULL,
  `NAME` VARCHAR(50) NULL,
  `ID_VAT_RATE` BIGINT NOT NULL,
  `ID_LANGUAGE` BIGINT NOT NULL,
  INDEX `fk_vat_rate_i18n_id_vat_rate_idx` (`ID_VAT_RATE` ASC),
  INDEX `fk_vat_rate_i18n_id_language_idx` (`ID_LANGUAGE` ASC),
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `UNIQUE_VAT_RATE_LANG` (`ID_VAT_RATE` ASC, `ID_LANGUAGE` ASC),
  CONSTRAINT `fk_vat_rate_i18n_id_vat_rate`
    FOREIGN KEY (`ID_VAT_RATE`)
    REFERENCES `vat_rate` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_vat_rate_i18n_id_language`
    FOREIGN KEY (`ID_LANGUAGE`)
    REFERENCES `language` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `currency`
-- -----------------------------------------------------

INSERT INTO `currency` (`ID`, `CODE`, `NAME`, `PRIORITY`, `SYMBOL`, `DEFAULT_VALUE`) VALUES (1, 'fr', 'Euro', 1, '€', true);
INSERT INTO `currency` (`ID`, `CODE`, `NAME`, `PRIORITY`, `SYMBOL`, `DEFAULT_VALUE`) VALUES (2, 'fs', 'Franc Suisse', 3, 'F', false);
INSERT INTO `currency` (`ID`, `CODE`, `NAME`, `PRIORITY`, `SYMBOL`, `DEFAULT_VALUE`) VALUES (3, 'en', 'Livre', 2, '£', false);




-- -----------------------------------------------------
-- Data for table `value_list`
-- -----------------------------------------------------

INSERT INTO `value_list` (`ID`, `CODE`) VALUES (1, 'event_type');




-- -----------------------------------------------------
-- Data for table `value_list_item`
-- -----------------------------------------------------

INSERT INTO `value_list_item` (`ID`, `PRIORITY`, `ID_VALUE_LIST`) VALUES (1, 1, 1);
INSERT INTO `value_list_item` (`ID`, `PRIORITY`, `ID_VALUE_LIST`) VALUES (2, 2, 1);
INSERT INTO `value_list_item` (`ID`, `PRIORITY`, `ID_VALUE_LIST`) VALUES (3, 2, 1);
INSERT INTO `value_list_item` (`ID`, `PRIORITY`, `ID_VALUE_LIST`) VALUES (4, 3, 1);




-- -----------------------------------------------------
-- Data for table `language`
-- -----------------------------------------------------

INSERT INTO `language` (`ID`, `CODE`, `NAME`) VALUES (1, 'fr', 'français');




-- -----------------------------------------------------
-- Data for table `country_vat`
-- -----------------------------------------------------

INSERT INTO `country_vat` (`ID`) VALUES (1);




-- -----------------------------------------------------
-- Data for table `vat_rate`
-- -----------------------------------------------------

INSERT INTO `vat_rate` (`ID`, `VALUE`, `ACTIVE`, `DEFAULT_VALUE`, `ID_COUNTRY_VAT`) VALUES (1, 200, true, true, 1);
INSERT INTO `vat_rate` (`ID`, `VALUE`, `ACTIVE`, `DEFAULT_VALUE`, `ID_COUNTRY_VAT`) VALUES (2, 55, true, false, 1);
INSERT INTO `vat_rate` (`ID`, `VALUE`, `ACTIVE`, `DEFAULT_VALUE`, `ID_COUNTRY_VAT`) VALUES (3, 21, true, false, 1);




-- -----------------------------------------------------
-- Data for table `event`
-- -----------------------------------------------------

INSERT INTO `event` (`ID`, `ID_PRODUCT`, `ID_SITE`, `ID_VALUE_LIST_ITEM`) VALUES (1, 1, 1, 1);
INSERT INTO `event` (`ID`, `ID_PRODUCT`, `ID_SITE`, `ID_VALUE_LIST_ITEM`) VALUES (2, 2, 2, 2);




-- -----------------------------------------------------
-- Data for table `product`
-- -----------------------------------------------------

INSERT INTO `product` (`ID`, `ID_OWNER`, `ID_EVENT`, `ID_CURRENCY`) VALUES (1, 1, 1, 1);
INSERT INTO `product` (`ID`, `ID_OWNER`, `ID_EVENT`, `ID_CURRENCY`) VALUES (2, 1, 1, 2);




-- -----------------------------------------------------
-- Data for table `media_type`
-- -----------------------------------------------------

INSERT INTO `media_type` (`ID`, `CODE`, `NAME`) VALUES (1, 'PI1', 'PI1');
INSERT INTO `media_type` (`ID`, `CODE`, `NAME`) VALUES (2, 'PI2', 'PI2');




-- -----------------------------------------------------
-- Data for table `media_model`
-- -----------------------------------------------------

INSERT INTO `media_model` (`ID`, `CODE`, `X_DIMENSION`, `Y_DIMENSION`, `MAX_SIZE`, `EXTENSION`, `ID_MEDIA_TYPE`) VALUES (1, 'PI1', 200, 100, 20, 'gif,png,jpeg,jpg', 1);
INSERT INTO `media_model` (`ID`, `CODE`, `X_DIMENSION`, `Y_DIMENSION`, `MAX_SIZE`, `EXTENSION`, `ID_MEDIA_TYPE`) VALUES (2, 'PI2', 300, 375, 50, 'gif,png,jpeg,jpg', 2);




-- -----------------------------------------------------
-- Data for table `owner`
-- -----------------------------------------------------

INSERT INTO `owner` (`ID`, `NAME`, `VAT_NUMBER`, `LICENSE_NUMBER`, `WEBSITE`, `ACCOUNT_HOLDER`, `IBAN_CODE`, `BIC_CODE`, `DOMAIN`, `THEME_COLOR`, `ID_CURRENCY`, `ID_VALUE_LIST_ITEM`, `ID_ADDRESS`, `ID_LANGUAGE`, `ID_VAT_RATE`, `ID_MEDIA`) VALUES (1, 'BODY', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `owner` (`ID`, `NAME`, `VAT_NUMBER`, `LICENSE_NUMBER`, `WEBSITE`, `ACCOUNT_HOLDER`, `IBAN_CODE`, `BIC_CODE`, `DOMAIN`, `THEME_COLOR`, `ID_CURRENCY`, `ID_VALUE_LIST_ITEM`, `ID_ADDRESS`, `ID_LANGUAGE`, `ID_VAT_RATE`, `ID_MEDIA`) VALUES (2, 'ANSEL', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `owner` (`ID`, `NAME`, `VAT_NUMBER`, `LICENSE_NUMBER`, `WEBSITE`, `ACCOUNT_HOLDER`, `IBAN_CODE`, `BIC_CODE`, `DOMAIN`, `THEME_COLOR`, `ID_CURRENCY`, `ID_VALUE_LIST_ITEM`, `ID_ADDRESS`, `ID_LANGUAGE`, `ID_VAT_RATE`, `ID_MEDIA`) VALUES (3, 'TOTO', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);




-- -----------------------------------------------------
-- Data for table `site`
-- -----------------------------------------------------

INSERT INTO `site` (`ID`, `NAME`, `ID_OWNER`, `ID_ADDRESS`) VALUES (1, 'Zénith', 1, NULL);
INSERT INTO `site` (`ID`, `NAME`, `ID_OWNER`, `ID_ADDRESS`) VALUES (2, 'Chabada', 1, NULL);
INSERT INTO `site` (`ID`, `NAME`, `ID_OWNER`, `ID_ADDRESS`) VALUES (3, 'Grand Rex', 1, NULL);




-- -----------------------------------------------------
-- Data for table `site_section`
-- -----------------------------------------------------

INSERT INTO `site_section` (`ID`, `NAME`, `ID_SITE`) VALUES (1, 'salle1', 1);
INSERT INTO `site_section` (`ID`, `NAME`, `ID_SITE`) VALUES (2, 'salle2', 1);
INSERT INTO `site_section` (`ID`, `NAME`, `ID_SITE`) VALUES (3, 'salle3', 2);
INSERT INTO `site_section` (`ID`, `NAME`, `ID_SITE`) VALUES (4, 'salle4', 2);




-- -----------------------------------------------------
-- Data for table `operator`
-- -----------------------------------------------------

INSERT INTO `operator` (`ID`, `LAST_NAME`, `FIRST_NAME`, `LOGIN`, `PASSWORD`, `ACTIVE`, `EMAIL`, `FIRST_CONNECTION`, `PASSWORD_MODIF_DATE`, `ERROR_CONNECTION_NUMBER`, `LAST_CONNECTION_DATE`, `ACTIVATION_TOKEN`, `ACTIVATION_TOKEN_EXPIRATION_DATE`, `LOGIN_TOKEN_HASH`, `LOGIN_TOKEN_EXPIRATION_DATE`, `PWD_INIT`, `PWD_INIT_TOKEN_EXPIRATION_DATE`, `CREA_DATE`, `MODIF_DATE`, `ID_OWNER`, `ID_VALUE_LIST_ITEM`, `LOGIN_TOKEN_SHORTCUT`) VALUES (1, 'BODY', 'Adrien', 'abody', '123456789', true, 'abody@steamulo.com', false, NULL, NULL, NULL, NULL, NULL, '161f4d7405e05a260230c2fafa4829f5fa4ac134cbad8ee862941448c917363f1960c18e3d729b5a65b206c557cd90c5b504f15e1f950564e687a3efdbac84cc', NULL, NULL, NULL, '2014-10-20 20:00:00', '2014-10-20 20:00:00', 1, 1, NULL);
INSERT INTO `operator` (`ID`, `LAST_NAME`, `FIRST_NAME`, `LOGIN`, `PASSWORD`, `ACTIVE`, `EMAIL`, `FIRST_CONNECTION`, `PASSWORD_MODIF_DATE`, `ERROR_CONNECTION_NUMBER`, `LAST_CONNECTION_DATE`, `ACTIVATION_TOKEN`, `ACTIVATION_TOKEN_EXPIRATION_DATE`, `LOGIN_TOKEN_HASH`, `LOGIN_TOKEN_EXPIRATION_DATE`, `PWD_INIT`, `PWD_INIT_TOKEN_EXPIRATION_DATE`, `CREA_DATE`, `MODIF_DATE`, `ID_OWNER`, `ID_VALUE_LIST_ITEM`, `LOGIN_TOKEN_SHORTCUT`) VALUES (2, 'ANSEL', 'Antoine', 'aansel', 'toto', true, 'aa@aa.com', true, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2014-10-20 20:00:00', '2014-10-20 20:00:00', 2, 1, NULL);




-- -----------------------------------------------------
-- Data for table `product_i18n`
-- -----------------------------------------------------

INSERT INTO `product_i18n` (`ID`, `TITLE`, `DESCRIPTION`, `ID_PRODUCT`, `ID_LANGUAGE`) VALUES (1, 'Concert AC/CD', 'Le concert d\'Angus !', 1, 1);
INSERT INTO `product_i18n` (`ID`, `TITLE`, `DESCRIPTION`, `ID_PRODUCT`, `ID_LANGUAGE`) VALUES (2, 'cONCERT sHAKA ponk !', 'Les français sont de retour !', 2, 1);




-- -----------------------------------------------------
-- Data for table `value_list_item_i18n`
-- -----------------------------------------------------

INSERT INTO `value_list_item_i18n` (`ID`, `VALUE`, `ID_VALUE_LIST_ITEM`, `ID_LANGUAGE`) VALUES (1, 'Sport', 1, 1);
INSERT INTO `value_list_item_i18n` (`ID`, `VALUE`, `ID_VALUE_LIST_ITEM`, `ID_LANGUAGE`) VALUES (2, 'Dance', 2, 1);
INSERT INTO `value_list_item_i18n` (`ID`, `VALUE`, `ID_VALUE_LIST_ITEM`, `ID_LANGUAGE`) VALUES (3, 'Spectacle', 3, 1);
INSERT INTO `value_list_item_i18n` (`ID`, `VALUE`, `ID_VALUE_LIST_ITEM`, `ID_LANGUAGE`) VALUES (4, 'Theâtre', 4, 1);




-- -----------------------------------------------------
-- Data for table `event_date`
-- -----------------------------------------------------

INSERT INTO `event_date` (`ID`, `START_DATE_TIME`, `END_DATE_TIME`, `IS_TEMPLATE`, `ID_EVENT`, `ID_VAT_RATE`) VALUES (1, '2014-01-28 10:50:00', NULL, true, 1, 1);
INSERT INTO `event_date` (`ID`, `START_DATE_TIME`, `END_DATE_TIME`, `IS_TEMPLATE`, `ID_EVENT`, `ID_VAT_RATE`) VALUES (2, '2014-01-28 10:50:00', NULL, false, 2, 1);




-- -----------------------------------------------------
-- Data for table `sales_allocation_rule`
-- -----------------------------------------------------

INSERT INTO `sales_allocation_rule` (`ID`, `MAX_QUANTITY`, `STOCK_LEVEL`, `ID_PRODUCT`, `ID_EVENT_DATE`, `ID_RATE`, `ID_SEAT_CATEGORY`) VALUES (1, 200, 200, 1, 1, NULL, NULL);
INSERT INTO `sales_allocation_rule` (`ID`, `MAX_QUANTITY`, `STOCK_LEVEL`, `ID_PRODUCT`, `ID_EVENT_DATE`, `ID_RATE`, `ID_SEAT_CATEGORY`) VALUES (2, 500, 300, 2, 2, NULL, NULL);




-- -----------------------------------------------------
-- Data for table `value_fee`
-- -----------------------------------------------------

INSERT INTO `value_fee` (`ID`, `FIXED_VALUE`, `ID_CURRENCY`) VALUES (1, 20, 1);




-- -----------------------------------------------------
-- Data for table `fee`
-- -----------------------------------------------------

INSERT INTO `fee` (`ID`, `PERCENTAGE`, `ID_VALUE_FEE`) VALUES (1, 50, 1);




-- -----------------------------------------------------
-- Data for table `fee_i18n`
-- -----------------------------------------------------

INSERT INTO `fee_i18n` (`ID`, `NAME`, `ID_FEE`, `ID_LANGUAGE`) VALUES (1, 'izzy', 1, 1);




-- -----------------------------------------------------
-- Data for table `country_vat_i18n`
-- -----------------------------------------------------

INSERT INTO `country_vat_i18n` (`ID`, `NAME`, `ID_COUNTRY_VAT`, `ID_LANGUAGE`) VALUES (1, 'France', 1, 1);




-- -----------------------------------------------------
-- Data for table `vat_rate_i18n`
-- -----------------------------------------------------

INSERT INTO `vat_rate_i18n` (`ID`, `NAME`, `ID_VAT_RATE`, `ID_LANGUAGE`) VALUES (1, 'Taux plein', 1, 1);
INSERT INTO `vat_rate_i18n` (`ID`, `NAME`, `ID_VAT_RATE`, `ID_LANGUAGE`) VALUES (2, 'Taux réduit', 2, 1);
INSERT INTO `vat_rate_i18n` (`ID`, `NAME`, `ID_VAT_RATE`, `ID_LANGUAGE`) VALUES (3, 'Taux réduit', 3, 1);



