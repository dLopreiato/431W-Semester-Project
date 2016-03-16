-- MySQL dump 10.13  Distrib 5.6.19, for osx10.7 (i386)
--
-- Host: 127.0.0.1    Database: 431
-- ------------------------------------------------------
-- Server version	5.7.10

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `addresses`
--

DROP TABLE IF EXISTS `addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `addresses` (
  `username` char(20) NOT NULL DEFAULT '',
  `address_id` int(11) NOT NULL DEFAULT '0',
  `shipping_name` char(40) DEFAULT NULL,
  `street` char(30) DEFAULT NULL,
  `city` char(20) DEFAULT NULL,
  `state` char(20) DEFAULT NULL,
  `zip_code` int(11) DEFAULT NULL,
  PRIMARY KEY (`address_id`,`username`),
  KEY `username` (`username`),
  CONSTRAINT `addresses_ibfk_1` FOREIGN KEY (`username`) REFERENCES `registered_users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addresses`
--

LOCK TABLES `addresses` WRITE;
/*!40000 ALTER TABLE `addresses` DISABLE KEYS */;
/*!40000 ALTER TABLE `addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `badge_progresses`
--

DROP TABLE IF EXISTS `badge_progresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `badge_progresses` (
  `username` char(20) NOT NULL DEFAULT '',
  `badge_id` int(11) NOT NULL DEFAULT '0',
  `units_earned` int(11) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL,
  PRIMARY KEY (`username`,`badge_id`),
  KEY `badge_id` (`badge_id`),
  CONSTRAINT `badge_progresses_ibfk_1` FOREIGN KEY (`username`) REFERENCES `registered_users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `badge_progresses_ibfk_2` FOREIGN KEY (`badge_id`) REFERENCES `badges` (`badge_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `badge_progresses`
--

LOCK TABLES `badge_progresses` WRITE;
/*!40000 ALTER TABLE `badge_progresses` DISABLE KEYS */;
/*!40000 ALTER TABLE `badge_progresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `badges`
--

DROP TABLE IF EXISTS `badges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `badges` (
  `badge_id` int(11) NOT NULL DEFAULT '0',
  `title` char(255) DEFAULT NULL,
  `icon` char(255) DEFAULT NULL,
  `description` text,
  `total_units` int(11) DEFAULT NULL,
  PRIMARY KEY (`badge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `badges`
--

LOCK TABLES `badges` WRITE;
/*!40000 ALTER TABLE `badges` DISABLE KEYS */;
/*!40000 ALTER TABLE `badges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bids`
--

DROP TABLE IF EXISTS `bids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bids` (
  `amount` float DEFAULT NULL,
  `bid_id` int(11) NOT NULL DEFAULT '0',
  `time` datetime DEFAULT NULL,
  `username` char(20) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `bid_won` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`bid_id`),
  KEY `username` (`username`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `bids_ibfk_1` FOREIGN KEY (`username`) REFERENCES `registered_users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bids_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bids`
--

LOCK TABLES `bids` WRITE;
/*!40000 ALTER TABLE `bids` DISABLE KEYS */;
/*!40000 ALTER TABLE `bids` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL DEFAULT '0',
  `name` char(20) DEFAULT NULL,
  `parent` int(11) DEFAULT NULL,
  PRIMARY KEY (`category_id`),
  KEY `parent` (`parent`),
  CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `categories` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `credit_cards`
--

DROP TABLE IF EXISTS `credit_cards`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `credit_cards` (
  `username` char(20) NOT NULL DEFAULT '',
  `card_number` int(11) NOT NULL DEFAULT '0',
  `card_type` char(20) DEFAULT NULL,
  `exp_date` date DEFAULT NULL,
  PRIMARY KEY (`username`,`card_number`),
  CONSTRAINT `credit_cards_ibfk_1` FOREIGN KEY (`username`) REFERENCES `registered_users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit_cards`
--

LOCK TABLES `credit_cards` WRITE;
/*!40000 ALTER TABLE `credit_cards` DISABLE KEYS */;
/*!40000 ALTER TABLE `credit_cards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items` (
  `item_id` int(11) NOT NULL DEFAULT '0',
  `description` text,
  `location` char(50) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `items_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `physical_rentables`
--

DROP TABLE IF EXISTS `physical_rentables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `physical_rentables` (
  `rentable_id` int(11) NOT NULL DEFAULT '0',
  `serial_number` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`rentable_id`,`serial_number`),
  CONSTRAINT `physical_rentables_ibfk_1` FOREIGN KEY (`rentable_id`) REFERENCES `rentable_items` (`rentable_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `physical_rentables`
--

LOCK TABLES `physical_rentables` WRITE;
/*!40000 ALTER TABLE `physical_rentables` DISABLE KEYS */;
/*!40000 ALTER TABLE `physical_rentables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ratings`
--

DROP TABLE IF EXISTS `ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ratings` (
  `rating_id` int(11) NOT NULL DEFAULT '0',
  `item_id` int(11) NOT NULL DEFAULT '0',
  `star_ranking` int(11) DEFAULT NULL,
  `description` char(250) DEFAULT NULL,
  `review_date` date DEFAULT NULL,
  PRIMARY KEY (`rating_id`,`item_id`),
  KEY `item_id` (`item_id`),
  CONSTRAINT `ratings_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ratings`
--

LOCK TABLES `ratings` WRITE;
/*!40000 ALTER TABLE `ratings` DISABLE KEYS */;
/*!40000 ALTER TABLE `ratings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registered_users`
--

DROP TABLE IF EXISTS `registered_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registered_users` (
  `username` char(20) NOT NULL DEFAULT '',
  `name` char(40) DEFAULT NULL,
  `password` char(20) DEFAULT NULL,
  `email` char(30) DEFAULT NULL,
  `phone_number` char(14) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `annual_income` double DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registered_users`
--

LOCK TABLES `registered_users` WRITE;
/*!40000 ALTER TABLE `registered_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `registered_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rent_transactions`
--

DROP TABLE IF EXISTS `rent_transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rent_transactions` (
  `username` char(20) NOT NULL,
  `rentable_id` int(11) NOT NULL,
  `serial_number` int(11) NOT NULL,
  `time_rented` datetime DEFAULT NULL,
  `time_due` datetime DEFAULT NULL,
  `returned` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`username`,`rentable_id`,`serial_number`),
  KEY `rentable_id` (`rentable_id`,`serial_number`),
  CONSTRAINT `rent_transactions_ibfk_1` FOREIGN KEY (`username`) REFERENCES `registered_users` (`username`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `rent_transactions_ibfk_2` FOREIGN KEY (`rentable_id`) REFERENCES `rentable_items` (`rentable_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `rent_transactions_ibfk_3` FOREIGN KEY (`rentable_id`, `serial_number`) REFERENCES `physical_rentables` (`rentable_id`, `serial_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rent_transactions`
--

LOCK TABLES `rent_transactions` WRITE;
/*!40000 ALTER TABLE `rent_transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `rent_transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rentable_items`
--

DROP TABLE IF EXISTS `rentable_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rentable_items` (
  `rentable_id` int(11) NOT NULL DEFAULT '0',
  `description` text,
  `title` char(64) DEFAULT NULL,
  `rental_price` double DEFAULT NULL,
  `collateral_price` double DEFAULT NULL,
  `rental_time_unit` int(11) DEFAULT NULL,
  `picture` char(255) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `seller` char(20) DEFAULT NULL,
  PRIMARY KEY (`rentable_id`),
  KEY `category_id` (`category_id`),
  KEY `seller` (`seller`),
  CONSTRAINT `rentable_items_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `rentable_items_ibfk_2` FOREIGN KEY (`seller`) REFERENCES `sellers` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rentable_items`
--

LOCK TABLES `rentable_items` WRITE;
/*!40000 ALTER TABLE `rentable_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `rentable_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales`
--

DROP TABLE IF EXISTS `sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales` (
  `amount` float DEFAULT NULL,
  `sale_id` int(11) NOT NULL DEFAULT '0',
  `time` datetime DEFAULT NULL,
  `username` char(20) NOT NULL,
  `item_id` int(11) DEFAULT NULL,
  `card_number` int(11) NOT NULL,
  `sent` datetime DEFAULT NULL,
  `received` datetime DEFAULT NULL,
  `delivery_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`sale_id`),
  KEY `username` (`username`),
  KEY `item_id` (`item_id`),
  KEY `sales_ibfk_3` (`username`,`card_number`),
  CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`username`) REFERENCES `registered_users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sales_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sales_ibfk_3` FOREIGN KEY (`username`, `card_number`) REFERENCES `credit_cards` (`username`, `card_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales`
--

LOCK TABLES `sales` WRITE;
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
/*!40000 ALTER TABLE `sales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sellers`
--

DROP TABLE IF EXISTS `sellers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sellers` (
  `username` char(20) NOT NULL DEFAULT '',
  `name` char(127) DEFAULT NULL,
  `address` char(255) DEFAULT NULL,
  `point_of_contact` char(255) DEFAULT NULL,
  `phone` char(10) DEFAULT NULL,
  `balance_due` double DEFAULT NULL,
  PRIMARY KEY (`username`),
  CONSTRAINT `sellers_ibfk_1` FOREIGN KEY (`username`) REFERENCES `registered_users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sellers`
--

LOCK TABLES `sellers` WRITE;
/*!40000 ALTER TABLE `sellers` DISABLE KEYS */;
/*!40000 ALTER TABLE `sellers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test_table`
--

DROP TABLE IF EXISTS `test_table`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test_table` (
  `test_key` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `test_attribute` varchar(10) NOT NULL,
  PRIMARY KEY (`test_key`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test_table`
--

LOCK TABLES `test_table` WRITE;
/*!40000 ALTER TABLE `test_table` DISABLE KEYS */;
INSERT INTO `test_table` VALUES (1,'The'),(2,'Hateful'),(3,'Eight');
/*!40000 ALTER TABLE `test_table` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-03-16 11:26:33
