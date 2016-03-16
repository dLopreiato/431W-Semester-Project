-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Mar 16, 2016 at 10:19 PM
-- Server version: 10.1.9-MariaDB
-- PHP Version: 5.5.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `431w_project`
--

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `username` char(20) NOT NULL DEFAULT '',
  `address_id` int(11) NOT NULL DEFAULT '0',
  `shipping_name` char(40) DEFAULT NULL,
  `street` char(30) DEFAULT NULL,
  `city` char(20) DEFAULT NULL,
  `state` char(20) DEFAULT NULL,
  `zip_code` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `auctioned_by`
--

CREATE TABLE `auctioned_by` (
  `item_id` int(11) NOT NULL,
  `username` char(20) NOT NULL,
  `reserve_price` decimal(10,2) DEFAULT NULL,
  `number_in_stock` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `badges`
--

CREATE TABLE `badges` (
  `badge_id` int(11) NOT NULL DEFAULT '0',
  `title` char(255) DEFAULT NULL,
  `icon` char(255) DEFAULT NULL,
  `description` text,
  `total_units` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `badge_progresses`
--

CREATE TABLE `badge_progresses` (
  `username` char(20) NOT NULL DEFAULT '',
  `badge_id` int(11) NOT NULL DEFAULT '0',
  `units_earned` int(11) DEFAULT NULL,
  `last_updated` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `bids`
--

CREATE TABLE `bids` (
  `amount` decimal(10,0) DEFAULT NULL,
  `bid_id` int(11) NOT NULL DEFAULT '0',
  `time` datetime DEFAULT NULL,
  `username` char(20) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `bid_won` tinyint(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL DEFAULT '0',
  `name` char(20) DEFAULT NULL,
  `parent` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `credit_cards`
--

CREATE TABLE `credit_cards` (
  `username` char(20) NOT NULL DEFAULT '',
  `card_number` int(11) NOT NULL DEFAULT '0',
  `card_type` char(20) DEFAULT NULL,
  `exp_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `item_id` int(11) NOT NULL DEFAULT '0',
  `description` text,
  `location` char(50) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `physical_rentables`
--

CREATE TABLE `physical_rentables` (
  `rentable_id` int(11) NOT NULL DEFAULT '0',
  `serial_number` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

CREATE TABLE `ratings` (
  `rating_id` int(11) NOT NULL DEFAULT '0',
  `item_id` int(11) NOT NULL DEFAULT '0',
  `star_ranking` int(11) DEFAULT NULL,
  `description` char(250) DEFAULT NULL,
  `review_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `registered_users`
--

CREATE TABLE `registered_users` (
  `username` char(20) NOT NULL DEFAULT '',
  `name` char(40) DEFAULT NULL,
  `password` char(20) DEFAULT NULL,
  `email` char(30) DEFAULT NULL,
  `phone_number` char(14) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `annual_income` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `rentable_items`
--

CREATE TABLE `rentable_items` (
  `rentable_id` int(11) NOT NULL DEFAULT '0',
  `description` text,
  `title` char(64) DEFAULT NULL,
  `rental_price` decimal(10,0) DEFAULT NULL,
  `collateral_price` decimal(10,0) DEFAULT NULL,
  `rental_time_unit` int(11) DEFAULT NULL,
  `picture` char(255) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `seller` char(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `rent_transactions`
--

CREATE TABLE `rent_transactions` (
  `username` char(20) NOT NULL,
  `rentable_id` int(11) NOT NULL,
  `serial_number` int(11) NOT NULL,
  `time_rented` datetime DEFAULT NULL,
  `time_due` datetime DEFAULT NULL,
  `returned` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `amount` decimal(10,0) DEFAULT NULL,
  `sale_id` int(11) NOT NULL DEFAULT '0',
  `time` datetime DEFAULT NULL,
  `username` char(20) NOT NULL,
  `item_id` int(11) DEFAULT NULL,
  `card_number` int(11) NOT NULL,
  `sent` datetime DEFAULT NULL,
  `received` datetime DEFAULT NULL,
  `delivery_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `sellers`
--

CREATE TABLE `sellers` (
  `username` char(20) NOT NULL DEFAULT '',
  `name` char(127) DEFAULT NULL,
  `address` char(255) DEFAULT NULL,
  `point_of_contact` char(255) DEFAULT NULL,
  `phone` char(10) DEFAULT NULL,
  `balance_due` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `sold_by`
--

CREATE TABLE `sold_by` (
  `item_id` int(11) NOT NULL,
  `username` char(20) NOT NULL,
  `listed_price` decimal(10,2) DEFAULT NULL,
  `number_in_stock` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`address_id`,`username`),
  ADD KEY `username` (`username`);

--
-- Indexes for table `auctioned_by`
--
ALTER TABLE `auctioned_by`
  ADD PRIMARY KEY (`item_id`,`username`),
  ADD KEY `username` (`username`);

--
-- Indexes for table `badges`
--
ALTER TABLE `badges`
  ADD PRIMARY KEY (`badge_id`);

--
-- Indexes for table `badge_progresses`
--
ALTER TABLE `badge_progresses`
  ADD PRIMARY KEY (`username`,`badge_id`),
  ADD KEY `badge_id` (`badge_id`);

--
-- Indexes for table `bids`
--
ALTER TABLE `bids`
  ADD PRIMARY KEY (`bid_id`),
  ADD KEY `username` (`username`),
  ADD KEY `item_id` (`item_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`),
  ADD KEY `parent` (`parent`);

--
-- Indexes for table `credit_cards`
--
ALTER TABLE `credit_cards`
  ADD PRIMARY KEY (`username`,`card_number`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`item_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `physical_rentables`
--
ALTER TABLE `physical_rentables`
  ADD PRIMARY KEY (`rentable_id`,`serial_number`);

--
-- Indexes for table `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`rating_id`,`item_id`),
  ADD KEY `item_id` (`item_id`);

--
-- Indexes for table `registered_users`
--
ALTER TABLE `registered_users`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `rentable_items`
--
ALTER TABLE `rentable_items`
  ADD PRIMARY KEY (`rentable_id`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `seller` (`seller`);

--
-- Indexes for table `rent_transactions`
--
ALTER TABLE `rent_transactions`
  ADD PRIMARY KEY (`username`,`rentable_id`,`serial_number`),
  ADD KEY `rentable_id` (`rentable_id`,`serial_number`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`sale_id`),
  ADD KEY `username` (`username`),
  ADD KEY `item_id` (`item_id`),
  ADD KEY `sales_ibfk_3` (`username`,`card_number`);

--
-- Indexes for table `sellers`
--
ALTER TABLE `sellers`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `sold_by`
--
ALTER TABLE `sold_by`
  ADD PRIMARY KEY (`item_id`,`username`),
  ADD KEY `username` (`username`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `addresses`
--
ALTER TABLE `addresses`
  ADD CONSTRAINT `addresses_ibfk_1` FOREIGN KEY (`username`) REFERENCES `registered_users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `auctioned_by`
--
ALTER TABLE `auctioned_by`
  ADD CONSTRAINT `auctioned_by_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `auctioned_by_ibfk_2` FOREIGN KEY (`username`) REFERENCES `sellers` (`username`) ON DELETE NO ACTION ON UPDATE CASCADE;

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
-- Constraints for table `rent_transactions`
--
ALTER TABLE `rent_transactions`
  ADD CONSTRAINT `rent_transactions_ibfk_1` FOREIGN KEY (`username`) REFERENCES `registered_users` (`username`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `rent_transactions_ibfk_2` FOREIGN KEY (`rentable_id`) REFERENCES `rentable_items` (`rentable_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `rent_transactions_ibfk_3` FOREIGN KEY (`rentable_id`,`serial_number`) REFERENCES `physical_rentables` (`rentable_id`, `serial_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`username`) REFERENCES `registered_users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sales_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sales_ibfk_3` FOREIGN KEY (`username`,`card_number`) REFERENCES `credit_cards` (`username`, `card_number`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sellers`
--
ALTER TABLE `sellers`
  ADD CONSTRAINT `sellers_ibfk_1` FOREIGN KEY (`username`) REFERENCES `registered_users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sold_by`
--
ALTER TABLE `sold_by`
  ADD CONSTRAINT `sold_by_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `sold_by_ibfk_2` FOREIGN KEY (`username`) REFERENCES `sellers` (`username`) ON DELETE NO ACTION ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
