-- phpMyAdmin SQL Dump
-- version 4.3.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Mar 16, 2016 at 04:58 AM
-- Server version: 5.6.24
-- PHP Version: 5.6.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `431wproject`
--

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE IF NOT EXISTS `addresses` (
  `username` char(20) NOT NULL DEFAULT '',
  `address_id` int(11) NOT NULL DEFAULT '0',
  `shipping_name` char(40) DEFAULT NULL,
  `street` char(30) DEFAULT NULL,
  `city` char(20) DEFAULT NULL,
  `state` char(20) DEFAULT NULL,
  `zip_code` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `badges`
--

CREATE TABLE IF NOT EXISTS `badges` (
  `badge_id` int(11) NOT NULL DEFAULT '0',
  `title` char(255) DEFAULT NULL,
  `icon` char(255) DEFAULT NULL,
  `description` text,
  `total_units` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `badge_progresses`
--

CREATE TABLE IF NOT EXISTS `badge_progresses` (
  `username` char(20) NOT NULL DEFAULT '',
  `badge_id` int(11) NOT NULL DEFAULT '0',
  `units_earned` int(11) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `bids`
--

CREATE TABLE IF NOT EXISTS `bids` (
  `amount` int(11) DEFAULT NULL,
  `bid_id` int(11) NOT NULL DEFAULT '0',
  `time` datetime DEFAULT NULL,
  `username` char(20) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `bid_won` tinyint(4) DEFAULT NULL,
  `sent` datetime DEFAULT NULL,
  `received` datetime DEFAULT NULL,
  `delivery_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE IF NOT EXISTS `categories` (
  `category_id` int(11) NOT NULL DEFAULT '0',
  `name` char(20) DEFAULT NULL,
  `parent` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `credit_cards`
--

CREATE TABLE IF NOT EXISTS `credit_cards` (
  `username` char(20) NOT NULL DEFAULT '',
  `card_number` int(11) NOT NULL DEFAULT '0',
  `card_type` char(20) DEFAULT NULL,
  `exp_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE IF NOT EXISTS `items` (
  `item_id` int(11) NOT NULL DEFAULT '0',
  `description` text,
  `location` char(50) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `physical_rentables`
--

CREATE TABLE IF NOT EXISTS `physical_rentables` (
  `rentable_id` int(11) NOT NULL DEFAULT '0',
  `serial_number` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

CREATE TABLE IF NOT EXISTS `ratings` (
  `rating_id` int(11) NOT NULL DEFAULT '0',
  `item_id` int(11) NOT NULL DEFAULT '0',
  `star_ranking` int(11) DEFAULT NULL,
  `description` char(250) DEFAULT NULL,
  `review_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `registered_users`
--

CREATE TABLE IF NOT EXISTS `registered_users` (
  `username` char(20) NOT NULL DEFAULT '',
  `name` char(40) DEFAULT NULL,
  `password` char(20) DEFAULT NULL,
  `email` char(30) DEFAULT NULL,
  `phone_number` char(14) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `annual_income` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rentable_items`
--

CREATE TABLE IF NOT EXISTS `rentable_items` (
  `rentable_id` int(11) NOT NULL DEFAULT '0',
  `description` text,
  `title` char(64) DEFAULT NULL,
  `rental_price` double DEFAULT NULL,
  `collateral_price` double DEFAULT NULL,
  `rental_time_unit` int(11) DEFAULT NULL,
  `picture` char(255) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `seller` char(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `sellers`
--

CREATE TABLE IF NOT EXISTS `sellers` (
  `username` char(20) NOT NULL DEFAULT '',
  `name` char(127) DEFAULT NULL,
  `address` char(255) DEFAULT NULL,
  `point_of_contact` char(255) DEFAULT NULL,
  `phone` char(10) DEFAULT NULL,
  `balance_due` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `test_table`
--

CREATE TABLE IF NOT EXISTS `test_table` (
  `test_key` int(10) unsigned NOT NULL,
  `test_attribute` varchar(10) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `test_table`
--

INSERT INTO `test_table` (`test_key`, `test_attribute`) VALUES
(1, 'The'),
(2, 'Hateful'),
(3, 'Eight');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`address_id`,`username`), ADD KEY `username` (`username`);

--
-- Indexes for table `badges`
--
ALTER TABLE `badges`
  ADD PRIMARY KEY (`badge_id`);

--
-- Indexes for table `badge_progresses`
--
ALTER TABLE `badge_progresses`
  ADD PRIMARY KEY (`username`,`badge_id`), ADD KEY `badge_id` (`badge_id`);

--
-- Indexes for table `bids`
--
ALTER TABLE `bids`
  ADD PRIMARY KEY (`bid_id`), ADD KEY `username` (`username`), ADD KEY `item_id` (`item_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`), ADD KEY `parent` (`parent`);

--
-- Indexes for table `credit_cards`
--
ALTER TABLE `credit_cards`
  ADD PRIMARY KEY (`username`,`card_number`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`item_id`), ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `physical_rentables`
--
ALTER TABLE `physical_rentables`
  ADD PRIMARY KEY (`rentable_id`,`serial_number`);

--
-- Indexes for table `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`rating_id`,`item_id`), ADD KEY `item_id` (`item_id`);

--
-- Indexes for table `registered_users`
--
ALTER TABLE `registered_users`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `rentable_items`
--
ALTER TABLE `rentable_items`
  ADD PRIMARY KEY (`rentable_id`), ADD KEY `category_id` (`category_id`), ADD KEY `seller` (`seller`);

--
-- Indexes for table `sellers`
--
ALTER TABLE `sellers`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `test_table`
--
ALTER TABLE `test_table`
  ADD PRIMARY KEY (`test_key`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `test_table`
--
ALTER TABLE `test_table`
  MODIFY `test_key` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `addresses`
--
ALTER TABLE `addresses`
ADD CONSTRAINT `addresses_ibfk_1` FOREIGN KEY (`username`) REFERENCES `registered_users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `badge_progresses`
--
ALTER TABLE `badge_progresses`
ADD CONSTRAINT `badge_progresses_ibfk_1` FOREIGN KEY (`username`) REFERENCES `registered_users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `badge_progresses_ibfk_2` FOREIGN KEY (`badge_id`) REFERENCES `badges` (`badge_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `bids`
--
ALTER TABLE `bids`
ADD CONSTRAINT `bids_ibfk_1` FOREIGN KEY (`username`) REFERENCES `registered_users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `bids_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
ADD CONSTRAINT `categories_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `categories` (`category_id`);

--
-- Constraints for table `credit_cards`
--
ALTER TABLE `credit_cards`
ADD CONSTRAINT `credit_cards_ibfk_1` FOREIGN KEY (`username`) REFERENCES `registered_users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `items`
--
ALTER TABLE `items`
ADD CONSTRAINT `items_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `physical_rentables`
--
ALTER TABLE `physical_rentables`
ADD CONSTRAINT `physical_rentables_ibfk_1` FOREIGN KEY (`rentable_id`) REFERENCES `rentable_items` (`rentable_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ratings`
--
ALTER TABLE `ratings`
ADD CONSTRAINT `ratings_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`) ON DELETE CASCADE;

--
-- Constraints for table `rentable_items`
--
ALTER TABLE `rentable_items`
ADD CONSTRAINT `rentable_items_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
ADD CONSTRAINT `rentable_items_ibfk_2` FOREIGN KEY (`seller`) REFERENCES `sellers` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sellers`
--
ALTER TABLE `sellers`
ADD CONSTRAINT `sellers_ibfk_1` FOREIGN KEY (`username`) REFERENCES `registered_users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
