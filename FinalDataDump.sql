CREATE DATABASE  IF NOT EXISTS `finproj` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `finproj`;
-- MySQL dump 10.13  Distrib 5.6.19, for osx10.7 (i386)
--
-- Host: fourthirtyonew.cxyhl5hbaqyx.us-east-1.rds.amazonaws.com    Database: finproj
-- ------------------------------------------------------
-- Server version	5.6.27-log

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
  `address_id` int(11) NOT NULL AUTO_INCREMENT,
  `shipping_name` char(40) DEFAULT NULL,
  `street` char(30) DEFAULT NULL,
  `city` char(20) DEFAULT NULL,
  `state` char(20) DEFAULT NULL,
  `zip_code` int(11) DEFAULT NULL,
  PRIMARY KEY (`address_id`,`username`),
  KEY `username` (`username`),
  CONSTRAINT `addresses_ibfk_1` FOREIGN KEY (`username`) REFERENCES `registered_users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addresses`
--

LOCK TABLES `addresses` WRITE;
/*!40000 ALTER TABLE `addresses` DISABLE KEYS */;
INSERT INTO `addresses` VALUES ('angry_joe',2,'shippingjoe2','streetystreet','citycity','st',88888),('angry_joe',5,'New Name','123 Street','Cityyy','PA',12390),('angry_joe',11,'Home','155 Corndog Dr.','State College','PA',19008),('elle',25,'elley','ells house','ellestown','ma',11111),('chuckyfin',26,'123 road street','street','123 town','GA',12345),('hans',27,'home','123 Hans street','Hans','HI',165432);
/*!40000 ALTER TABLE `addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auctioned_by`
--

DROP TABLE IF EXISTS `auctioned_by`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auctioned_by` (
  `item_id` int(11) NOT NULL,
  `reserve_price` decimal(10,2) DEFAULT NULL,
  `number_in_stock` int(11) DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  CONSTRAINT `auctioned_by_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auctioned_by`
--

LOCK TABLES `auctioned_by` WRITE;
/*!40000 ALTER TABLE `auctioned_by` DISABLE KEYS */;
INSERT INTO `auctioned_by` VALUES (9,11.00,1),(10,10.00,3),(11,10.00,7),(12,10.00,2),(13,10.00,20),(14,10.00,14),(15,199.00,1),(16,499.00,3),(17,349.00,5),(19,7.00,350),(20,3.00,5),(23,2.00,1),(24,45.00,3),(26,250.00,2),(29,12.00,1),(32,54.00,1),(33,300.00,1),(34,25.00,1),(36,34.00,1),(38,100.00,8),(41,7.00,78),(42,4.00,3),(44,0.00,4),(46,5.00,2),(48,3.00,1),(50,7.00,1),(52,1.00,7),(54,5.00,13),(56,34.00,5),(58,111.00,99),(59,18.00,12),(61,11.00,7),(63,15.00,120),(65,13.00,1),(67,15.00,27),(69,13.00,5),(71,1.00,13),(73,160.00,35),(76,13.00,1),(77,13.00,2),(80,20.00,1),(81,35.00,1),(84,6.00,1),(85,3.00,1),(86,7.00,1),(89,4.00,1),(90,7.00,1),(103,3.00,568),(110,6.00,2),(111,6.00,2),(130,20.00,7);
/*!40000 ALTER TABLE `auctioned_by` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `badge_progresses`
--

LOCK TABLES `badge_progresses` WRITE;
/*!40000 ALTER TABLE `badge_progresses` DISABLE KEYS */;
INSERT INTO `badge_progresses` VALUES ('angry_joe',1,2,'2016-04-26 20:09:35'),('angry_joe',2,5,'2016-04-24 17:11:15'),('angry_joe',3,1,'2016-03-30 02:55:50'),('angry_joe',4,1,'2016-04-24 18:29:29'),('angry_joe',5,3,'2016-04-24 18:24:04'),('bookwrm122',1,2,'2016-04-24 18:41:30'),('bookwrm122',4,1,'2016-04-27 01:39:28'),('elle',1,2,'2016-04-26 20:19:44'),('elle',2,0,'2016-03-30 02:55:50'),('elle',3,1,'2016-03-30 02:55:50'),('elle',4,1,'2016-04-26 20:38:58'),('elle',5,1,'2016-04-26 20:22:28'),('fbi_superstar',1,2,'2016-04-27 14:32:57'),('fbi_superstar',4,1,'2016-04-27 14:31:08'),('frank',1,2,'2016-04-26 20:25:47'),('frank',4,1,'2016-04-26 20:25:45'),('frank',5,1,'2016-04-26 20:26:27'),('hans',4,1,'2016-04-27 14:27:57'),('tturns22',2,2,'2016-03-30 02:55:50'),('tturns22',3,1,'2016-03-30 02:55:50');
/*!40000 ALTER TABLE `badge_progresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `badges`
--

DROP TABLE IF EXISTS `badges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `badges` (
  `badge_id` int(11) NOT NULL AUTO_INCREMENT,
  `title` char(255) DEFAULT NULL,
  `icon` char(255) DEFAULT NULL,
  `description` text,
  `total_units` int(11) DEFAULT NULL,
  PRIMARY KEY (`badge_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `badges`
--

LOCK TABLES `badges` WRITE;
/*!40000 ALTER TABLE `badges` DISABLE KEYS */;
INSERT INTO `badges` VALUES (1,'Pass 431w','img/badges/passclass.jpg','Visit your profile twice.',2),(2,'Santa Claus','img/badges/santa.jpg','Purchase 5 items in December.',5),(3,'My Valentine','img/badges/valentine.jpg','Purchase 3 items in February.',3),(4,'Inspector Gadget','img/badges/inspector.jpg','Search for an item.',1),(5,'Loud Mouth','img/badges/loudmouth.jpg','Leave 5 reviews.',5);
/*!40000 ALTER TABLE `badges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bids`
--

DROP TABLE IF EXISTS `bids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bids` (
  `amount` decimal(10,2) DEFAULT NULL,
  `bid_id` int(11) NOT NULL AUTO_INCREMENT,
  `time` datetime DEFAULT NULL,
  `username` char(20) DEFAULT NULL,
  `item_id` int(11) DEFAULT NULL,
  `bid_won` tinyint(1) NOT NULL DEFAULT '0',
  `card_number` bigint(16) unsigned zerofill NOT NULL,
  `address_id` int(11) NOT NULL,
  PRIMARY KEY (`bid_id`),
  KEY `username` (`username`),
  KEY `item_id` (`item_id`),
  KEY `bids_ibfk_3_idx` (`username`,`card_number`),
  KEY `bids_ibfk_4_idx` (`address_id`,`username`),
  CONSTRAINT `bids_ibfk_1` FOREIGN KEY (`username`) REFERENCES `registered_users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bids_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bids_ibfk_3` FOREIGN KEY (`username`, `card_number`) REFERENCES `credit_cards` (`username`, `card_number`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `bids_ibfk_4` FOREIGN KEY (`address_id`, `username`) REFERENCES `addresses` (`address_id`, `username`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bids`
--

LOCK TABLES `bids` WRITE;
/*!40000 ALTER TABLE `bids` DISABLE KEYS */;
INSERT INTO `bids` VALUES (10.00,1,'2016-04-22 21:29:57','angry_joe',10,0,0000000123456789,2),(1000.00,2,'2016-04-22 21:32:30','angry_joe',10,0,1234567812345678,2);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (0,'Toys',NULL),(1,'Music',NULL),(2,'Movies',NULL),(3,'Clothing',NULL),(4,'Accessories',NULL),(5,'Games',NULL),(6,'Tops',3),(7,'Bottoms',3),(8,'Misc',3),(9,'Shirts',6),(10,'Sweatshirts',6),(11,'Jackets',6),(12,'Socks',8),(13,'Underwear',8),(14,'Shorts',7),(15,'Pants',7),(16,'Short Sleve',9),(17,'Tank Tops',9),(18,'Long Sleeves',9),(19,'Hair Stuff',4),(20,'Jewelry',4),(21,'Shoes',4),(22,'Other Accessories',4),(23,'Music Players',1),(24,'CDs',1),(25,'Albums',24),(26,'Singles',24),(27,'Movie Players',2),(28,'VHS Movies',2),(29,'Disney Movies',28),(30,'TV Shows',2),(31,'Playstation Games',5),(32,'N64 Games',5),(33,'Gameboy Games',5),(34,'Computer Games',5),(35,'Indoor Play',0),(36,'Dolls',35),(37,'Outdoor Play',0);
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
  `card_number` bigint(16) unsigned zerofill NOT NULL DEFAULT '0000000000000000',
  `card_type` char(20) DEFAULT NULL,
  `exp_date` char(7) DEFAULT NULL,
  PRIMARY KEY (`username`,`card_number`),
  CONSTRAINT `credit_cards_ibfk_1` FOREIGN KEY (`username`) REFERENCES `registered_users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `credit_cards`
--

LOCK TABLES `credit_cards` WRITE;
/*!40000 ALTER TABLE `credit_cards` DISABLE KEYS */;
INSERT INTO `credit_cards` VALUES ('angry_joe',0000000123456789,'Discover','08/4444'),('angry_joe',1234567812345678,'Visa','04/2016'),('chuckyfin',0000000123456789,'visa','04/12/2'),('elle',0987765412345678,'Visa','03/2018'),('elle',1234567812345678,'VISA','03/14'),('hans',1234123412341234,'Discover','04/2018');
/*!40000 ALTER TABLE `credit_cards` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `seller` char(20) DEFAULT NULL,
  `description` text,
  `location` char(50) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `image` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  KEY `category_id` (`category_id`),
  KEY `items_ibfk_2_idx` (`seller`),
  CONSTRAINT `items_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `items_ibfk_2` FOREIGN KEY (`seller`) REFERENCES `sellers` (`username`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=132 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (1,'xoQTGrlox','Green Cargo Pants','New Orleans, Louisianna',15,'GreenCargoPants.jpg'),(2,'xoQTGrlox','Red Cargo Shorts','New Orleans, Louisianna',14,'RedCargoShorts.jpg'),(3,'simple10','Full House Tank Top','Houston, Texas',17,'FullTank.jpg'),(4,'simple10','Neon Mesh Penny (Blue)','Houston, Texas',9,'Pinny.jpg'),(5,'simple10','Neon Mesh Penny (Green)','Houston, Texas',9,'Pinny.jpg'),(6,'simple10','Neon Mesh Penny (Yellow)','Houston, Texas',9,'Pinny.jpg'),(7,'simple10','Neon Mesh Penny (Red)','Houston, Texas',9,'Pinny.jpg'),(8,'simple10','Neon Mesh Penny (White)','Houston, Texas',9,'Pinny.jpg'),(9,'leoNsatan','Official Captain Underpants Briefs','New York, New York',13,'CaptainUnderpantsBriefs.jpg'),(10,'leoNsatan','Novelty Cereal T - Cocoa Puffs','New York, New York',16,'CocoaPuffsShirt.jpg'),(11,'leoNsatan','Novelty Cereal T - Lucky Charms','New York, New York',16,'LuckyCharmsShirt.jpg'),(12,'leoNsatan','Novelty Cereal T - Frosted Flakes','New York, New York',16,'FrostedFlakesShirt.jpg'),(13,'leoNsatan','Novelty Cereal T - Captain Crunch','New York, New York',16,'CaptainCrunchShirt.jpg'),(14,'leoNsatan','Novelty Cereal T - Fruit Loops','New York, New York',16,'FruitLoopsShirt.jpg'),(15,'simple10','Autographed Shaq Jersey','Houston, Texas',9,'ShaqJersey.jpg'),(16,'simple10','Autographed Shaq Gym Socks','Houston, Texas',14,'ShaqSocks.jpg'),(17,'simple10','Autographed Shaq Gym Shorts','Houston, Texas',14,'ShaqShorts.jpg'),(18,'icecreamgurl','Stick-on Earrings','My Bedroom, US',20,'stickOnEarrings.jpg'),(19,'aaronsparty','Snap Bracelets','Bananas, LA',20,'snapBracelets.jpeg'),(20,'icecreamgurl','Choker Necklace','Eggplant, CA',20,'chokerNecklace.jpg'),(21,'aaronsparty','Best Friends Bracelets','Coat, IN',20,'bestFriendsBracelets.jpg'),(22,'aaronsparty','Mood Rings','Dumbledore, ME',20,'moodRings.jpg'),(23,'icecreamgurl','Toe Ring','Couch, IL',20,'toeRings.jpg'),(24,'aaronsparty','Anklets','Pillow, UT',20,'anklets.jpg'),(25,'aaronsparty','Crimping Iron','Table, HI',19,'crimpingIron.jpg'),(26,'aaronsparty','Twist-a-Braid','Crate, GA',19,'twistABraid.jpg'),(27,'aaronsparty','Scrunchies','Router, OH',19,'scrunchies.jpg'),(28,'aaronsparty','Butterfly Clips','Lamp, KY',19,'butterflyClips.jpg'),(29,'icecreamgurl','Bandana','Door, FL',19,'bandanaHeadband.jpg'),(30,'icecreamgurl','Jelly Sandals','Bikini Bottom, Ocean',21,'jellySandals.jpg'),(31,'icecreamgurl','Platform Tennis Shoes','Poster, KS',21,'platformTennisShoes.jpg'),(32,'icecreamgurl','Clogs','Bottle, RI',21,'clogs.jpg'),(33,'aaronsparty','Light Up Shoes','Shoe, MS',21,'lightUpShoes.jpg'),(34,'aaronsparty','Skechers','Fan, CT',21,'skechers.jpg'),(35,'aaronsparty','Sunglasses','Circuit Breaker, VT',22,'sunglasses.jpg'),(36,'aaronsparty','Fanny Pack','Tree, AZ',22,'fannyPack.jpg'),(37,'aaronsparty','Bucket Hat','Cactus, CO',22,'bucketHat.jpg'),(38,'xoxoCHUCKLESxoxo','Boombox','Nice, France',23,'Boombox.jpg'),(39,'xoxoCHUCKLESxoxo','CD Player','My Backyard',23,'CDPlayer.jpg'),(40,'xoxoCHUCKLESxoxo','Headphones','My Front Yard',23,'Headphones.jpeg'),(41,'fbi_superstar','No Strings Attached - *NSYNC','London, England',25,'NoStringsAttached.jpg'),(42,'fbi_superstar','Baby One More Time - Britney Spears','Munic, Germany',25,'BabyOneMoreTime.png'),(43,'aaronsparty','Aaron\'s Party - Aaron Carter','Amsterdam, Neatherlands',25,'AaronsParty.jpg'),(44,'xoxoCHUCKLESxoxo','Now That\'s What I Call Music! - Varios Artists','Washington D.C, USA',25,'Now.jpg'),(45,'xoxoCHUCKLESxoxo','Dreamstreet - Dreamstreet','Dreamstreet, USA',25,'DreamStreet.jpg'),(46,'fbi_superstar','Backstreet Boys - Backstreet Boys','Backstreet, USA',25,'BackstreetBoys.jpg'),(47,'xoxoCHUCKLESxoxo','Wide Open Spaces - Dixie Chicks','Dixie, South',25,'WideOpenSpaces.jpg'),(48,'fbi_superstar','Dookie - Green Day','Boulevard of Broken Dreams, USA',25,'Dookie.jpg'),(49,'fbi_superstar','Spice - Spice Girls','Amazon Rain Forest',25,'Spice.jpg'),(50,'xoxoCHUCKLESxoxo','The Writings on the Wall - Destiny\'s Child','Heaven, A Place on Earth',25,'TheWritingsOnTheWall.jpg'),(51,'fbi_superstar','No Diggity - Blacksteet ft. Dr Dre','Blackstreet, USA',26,'NoDiggity.jpg'),(52,'xoxoCHUCKLESxoxo','Good Vibrations - Marky Mark & The FB','Boston, MA',26,'GoodVibrations.jpg'),(53,'fbi_superstar','Can\'t Help Falling In Love - UB40','Moscow, Russia',26,'CantHelpFallingInLove.jpg'),(54,'xoxoCHUCKLESxoxo','The Sign - Ace of Base','Toms River, NJ',26,'TheSign.jpg'),(55,'fbi_superstar','Waterfalls - TLC','Islamorada, FL',26,'Waterfalls.jpg'),(56,'fbi_superstar','MMMBop - Hanson','Pawnee, Indiana',26,'MMMBop.jpg'),(57,'fbi_superstar','My Heart Will Go On - Celine Dion','The Bottom of the Ocean',26,'MyHeartWillGoOn.jpg'),(58,'elle','VHS Player','Your Mom\'s House',27,'VHS.jpg'),(59,'elle','Pulp Fiction','Pawnee, Indiana',28,'pulpFiction.jpg'),(60,'frank','Titanic','England',28,'titanic.jpg'),(61,'elle','Clueless','America',28,'clueless.jpg'),(62,'elle','Jurassic Park','An Island Somewhere',28,'jurassicPark.jpg'),(63,'frank','10 Things I Hate About You','California',28,'10Things.jpg'),(64,'frank','Pretty Woman','Compton, California',28,'prettyWoman.jpg'),(65,'frank','Shawshank Redemption','America',28,'shawshank.jpg'),(66,'elle','Little Mermaid','Unda Da C',29,'lilmermaid.jpg'),(67,'elle','Hercules','Olympus',29,'hercules.jpg'),(68,'frank','Sleeping Beauty','The Enchanted Forest',29,'sleepingBeauty.jpg'),(69,'elle','Lion King','Everything the Light Touches',29,'lionKing.jpg'),(70,'elle','A Goofy Movie','America',29,'goofyMovie.jpg'),(71,'elle','Angry Beavers','A River',30,'angryBeavers.jpg'),(72,'elle','Rocco\'s Modern Life','Australia',30,'roccos.jpg'),(73,'frank','Friends','New York, New York',30,'friends.jpg'),(74,'frank','Fresh Prince of Bel Air','Bel Air, California',30,'freshPrince.jpg'),(75,'frank','Rocket Power','Hawaii',30,'rocketPower.jpg'),(76,'angry_joe','Final Fantasy VII','Fleecie, NV',31,'finalfantasyvii.jpg'),(77,'tturns22','Crash Bandicoot','Rack, GA',31,'crashBandicoot.jpg'),(78,'tturns22','Rayman','Towel, CA',31,'rayman.jpg'),(79,'angry_joe','Tony Hawk\'s Pro Skater','Hat, MS',31,'tonyHawkProSkater.jpg'),(80,'tturns22','Pokemon Stadium','Blanket, FL',32,'pokemonStadium.jpg'),(81,'tturns22','Mario Kart 64','Fast, SC',32,'marioKart64.jpg'),(82,'angry_joe','Super Mario 64','Love, PA',32,'superMario64.jpg'),(83,'angry_joe','Goldeneye 007','Carpet, IN',32,'goldeneye007.jpg'),(84,'angry_joe','Pokemon Red','Dollar, TN',33,'pokemonRed.jpg'),(85,'angry_joe','Pokemon Blue','Paper, NY',33,'pokemonBlue.jpg'),(86,'tturns22','Harvest Moon','Chair, UT',33,'harvestMoon.png'),(87,'tturns22','Donkey Kong Country','Picture, OH',33,'donkeyKongCountry.jpg'),(88,'tturns22','The Legend of Zelda: Link\'s Awakening','Elephant, DE',33,'LinksAwakening.jpg'),(89,'tturns22','Mr. Potato Head Saves Veggie Valley','Juice, NC',34,'savesVeggieValley.jpg'),(90,'angry_joe','Putt-Putt Enters the Race','Tissue, HI',34,'puttPuttEntersTheRace.png'),(91,'angry_joe','Tonka Construction','Shoes, LA',34,'tonkaConstruction.jpg'),(92,'tturns22','FF: Case of the Missing Kelp Seeds','Bag, SD',34,'kelpSeeds.jpg'),(93,'tturns22','FF2: The Case of the Haunted Schoolhouse','Pulley, UT',34,'pulley.png'),(94,'simple10','Nerf Gun','Hollywood, CA',35,'nerfgun.jpg'),(95,'simple10','Super Soaker','Hollywood, CA',37,'supersoaker.jpg'),(96,'simple10','Polly Pocket','Hollywood, CA',36,'polly-pocket.jpeg'),(97,'simple10','Tamagotchi ','Hollywood, CA',0,'tamagotchi.jpeg'),(98,'simple10','Bop It','Hollywood, CA',0,'bopit.jpg'),(99,'simple10','Skip-It','Hollywood, CA',37,'skip-it.jpg'),(100,'frank','Furby (Grey)','Denver, CO',35,'furby-grey.jpg'),(101,'frank','Easy Bake Oven','Denver, CO',35,'easy-bake_oven.jpg'),(102,'frank','My Size Barbie','Denver, CO',36,'mySizeBarbie.jpg'),(103,'leoNsatan','Betty Spaghetty ','Denver, CO',36,'bettySpeg.jpg'),(104,'fbi_superstar','Doodle Bear (Blue)','Boston, MA',36,'doodle-blue.jpg'),(105,'fbi_superstar','Doodle Bear (Pink)','Boston, MA',36,'doodle-pink.jpg'),(106,'frank','Cat’s Cradle ','Denver, CO',0,'catscradle.jpg'),(107,'frank','Pocket Locker','Denver, CO',0,'pocketlocker.jpg'),(108,'bsb123','Furby (Pink)','Hollywood, CA',35,'furby-pink.jpg'),(109,'bsb123','Furby (Teal)','Hollywood, CA',35,'furby-teal.JPG'),(110,'bsb123','Cabbage Patch Kid - BALLERINA','Hollywood, CA',36,'cabbage-ballerina.jpeg'),(111,'bsb123','Cabbage Patch Kid - Pajama Party ','Hollywood, CA',36,'cabbage-patch-pj.jpg'),(126,'angry_joe','yoyo','town',0,'http://cdn6.bigcommerce.com/s-8ndhalpa/products/619/images/2329/yoyo-factory-shutter-yoyo-107__77966.1404229599.1280.1280.jpg?c=2'),(130,'angry_joe','bid item','here',30,'noImageAvailable.png'),(131,'fbi_superstar','Halloweentown','Pawnee, indiana',28,'noImageAvailable.png');
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ratings`
--

DROP TABLE IF EXISTS `ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ratings` (
  `item_id` int(11) NOT NULL DEFAULT '0',
  `star_ranking` int(11) DEFAULT NULL,
  `description` char(250) DEFAULT NULL,
  `review_date` date DEFAULT NULL,
  `username` char(20) NOT NULL DEFAULT '',
  PRIMARY KEY (`item_id`,`username`),
  KEY `item_id` (`item_id`),
  KEY `ratings_ibfk_2_idx` (`username`),
  CONSTRAINT `ratings_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ratings`
--

LOCK TABLES `ratings` WRITE;
/*!40000 ALTER TABLE `ratings` DISABLE KEYS */;
INSERT INTO `ratings` VALUES (1,3,'fdsafdsa','2016-04-21','angry_joe'),(2,4,'gnarly','2016-04-23','angry_joe'),(2,2,'not enough pockets','2016-04-22','chuckyFin'),(4,2,'Uncomfortable','2016-04-22','chuckyfin'),(9,2,'uncmfortable','2016-04-22','angry_joe'),(36,5,'Perfect for my capri suns and thundercats action figures','2016-04-23','angry_joe'),(51,4,'No diggity dawg this song is FAN FREAKING TASTIC.','2016-04-26','elle'),(51,5,'LUV DIS DOE. The price makes me sad but DANG.','2016-04-26','frank'),(82,4,'Love it! I just couldnt get past the pictures level.','2016-04-24','angry_joe'),(93,5,'good','0000-00-00','angry_joe'),(93,4,'liked it','0000-00-00','cattyb'),(93,4,'pretty decent','0000-00-00','cattyp'),(93,5,'great','0000-00-00','elle'),(93,5,'superfun','0000-00-00','frank'),(93,1,'I STILL CAN\'T FIND THE PULLEY','0000-00-00','hannahmontanna');
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
  `gender` char(1) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registered_users`
--

LOCK TABLES `registered_users` WRITE;
/*!40000 ALTER TABLE `registered_users` DISABLE KEYS */;
INSERT INTO `registered_users` VALUES ('aaronsparty','Aaron Carter','nicksucks','iwantcandy@gmail.com','6549871234',28,-25,NULL),('angry_joe','Josephine Arl','imangry','josephine@gmail.com','4845554321',22,40000,NULL),('bookwrm122','Mikayla Jones','feb4','momsemail@comcast.net','8888883594',22,1.25,NULL),('bsb123','Backstreet Boys','bsbrox','cuteone@gmail.com','9517538426',22,9999999999,NULL),('cattyb','Cat Benetar','meow','cb@gmail.com','1112223333',23,100,NULL),('cattyp','Catalie Portman','meeooow','catalie@gmail.com','2020202020',21,1900,NULL),('chuckyFin','Chuckie Finster','freckle','rugrats4life@lipshitz.org','1800SAFEAUTO',2,0,'M'),('elle','Elle Woods','luvHarvard','Blonde@gmail.com','4438675309',24,100000,NULL),('fbi_superstar','Burt Macklin','april','supersecretemail@gmail.com','5558675309',26,1000000000,NULL),('frank','Dr. Frankenstein','iseedeadpeople','frank@enstein.com','3245242356',56,4,NULL),('hannahmontanna','Miley Cyrus','bestOfBothWorlds','billyraymanagement@cyrus.com','2156412551',23,NULL,NULL),('hans','Hans','hans','hans@hans.hans','6101231234',99,2,'m'),('icecreamgurl','Carissa Jones','benjamin','bestyear91@gmail.com','9999993594',24,7,NULL),('jcarl20','John Carlton','pa$$word','jcarl@gmail.com','6105551234',34,20000,NULL),('laxizlyfe','Shackleford Stanwick','SHAQ','shaqstanshunpike@gmail.com','4431236758',24,1000,NULL),('leoNsatan','Leo','satan','chuck3@yahoo.com','6666666666',23,666,NULL),('manders','Amanda Jensen','helloitsme','therealamanda@gmail.com','2676445114',22,NULL,NULL),('mr_meow','Catrick Swayze','catman','catman@gmail.com','2223334444',25,10009,NULL),('simple10','Billy Bob','10isTON','chuck1@aim.com','2958395858',30,12000,NULL),('tswizzle','Taylor Swift','harryStyles4ever','tswift13@calvinharris.com','2034567899',26,NULL,NULL),('tturns22','Timmy Turner','wAnDa','crockersuckz@gmail.com','1235557894',13,2,NULL),('xoQTGrlox','Uniquoa Johnson','original','chuck2@aol.com','5849384875',18,50000,NULL),('xoxoCHUCKLESxoxo','Chuck Bevington','imsocool','originalchuck@hotwire.com','8005882300',22,99999999999,NULL),('zzzztest','testy mctestface','test','test@test.test','6105550611',18,120,NULL);
/*!40000 ALTER TABLE `registered_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rentables`
--

DROP TABLE IF EXISTS `rentables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rentables` (
  `item_id` int(11) NOT NULL,
  `serial_number` varchar(128) NOT NULL,
  `rental_in_days` int(11) DEFAULT NULL,
  `rental_price` decimal(10,2) DEFAULT NULL,
  `on_shelf` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`item_id`,`serial_number`),
  CONSTRAINT `fkw_1` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rentables`
--

LOCK TABLES `rentables` WRITE;
/*!40000 ALTER TABLE `rentables` DISABLE KEYS */;
INSERT INTO `rentables` VALUES (10,'12345',10,2.00,0),(10,'255432-r51',3,5.00,0),(12,'88888',50,75.00,1),(85,'af3129eb9',11,2.00,1);
/*!40000 ALTER TABLE `rentables` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rental_transaction`
--

DROP TABLE IF EXISTS `rental_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `rental_transaction` (
  `rental_id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` int(11) DEFAULT NULL,
  `serial_number` varchar(128) DEFAULT NULL,
  `rented_out_to_username` char(20) DEFAULT NULL,
  `sent` tinyint(1) DEFAULT '0',
  `received` tinyint(1) DEFAULT '0',
  `rental_date` datetime DEFAULT NULL,
  `due_date` datetime DEFAULT NULL,
  `was_returned` tinyint(1) DEFAULT '0',
  `address_id` int(11) DEFAULT NULL,
  `card_number` bigint(16) unsigned zerofill DEFAULT NULL,
  PRIMARY KEY (`rental_id`),
  KEY `fk_rt_1_idx` (`item_id`,`serial_number`),
  KEY `fk_rt_2_idx` (`rented_out_to_username`),
  KEY `fk_rt_3_idx` (`address_id`),
  CONSTRAINT `fk_rt_1` FOREIGN KEY (`item_id`, `serial_number`) REFERENCES `rentables` (`item_id`, `serial_number`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_rt_2` FOREIGN KEY (`rented_out_to_username`) REFERENCES `registered_users` (`username`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_rt_3` FOREIGN KEY (`address_id`) REFERENCES `addresses` (`address_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rental_transaction`
--

LOCK TABLES `rental_transaction` WRITE;
/*!40000 ALTER TABLE `rental_transaction` DISABLE KEYS */;
INSERT INTO `rental_transaction` VALUES (4,10,'12345','angry_joe',0,1,'2016-03-30 02:55:50','0000-00-00 00:00:00',1,2,1234567812345678),(5,10,'12345','angry_joe',1,1,'2016-04-05 15:16:39','0000-00-00 00:00:00',0,2,1234567812345678),(6,10,'12345','angry_joe',0,1,'2016-04-05 15:17:27','0000-00-00 00:00:00',1,2,1234567812345678),(7,10,'12345','angry_joe',0,1,'2016-04-05 15:21:44','2016-04-06 00:00:00',1,2,1234567812345678),(8,10,'12345','angry_joe',0,1,'2016-04-05 15:23:26','2016-04-15 00:00:00',1,2,NULL),(9,10,'12345','elle',0,0,'2016-04-05 15:43:02','2016-04-03 00:00:00',0,2,NULL),(10,10,'12345','angry_joe',0,1,'2016-04-13 22:16:25','2016-04-24 00:00:00',0,5,NULL),(11,12,'88888','elle',1,1,'2016-04-10 22:16:25','2016-04-24 00:00:00',1,25,NULL),(14,12,'88888','angry_joe',1,0,'2016-04-10 22:16:25','2016-04-20 22:16:25',1,2,NULL),(15,10,'255432-r51','angry_joe',0,0,'2016-04-22 21:11:30','2016-04-25 00:00:00',0,5,0000000123456789),(16,10,'12345','hans',0,0,'2016-04-27 14:29:28','2016-05-07 00:00:00',0,27,1234123412341234);
/*!40000 ALTER TABLE `rental_transaction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sales`
--

DROP TABLE IF EXISTS `sales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sales` (
  `amount` decimal(10,2) DEFAULT NULL,
  `sale_id` int(11) NOT NULL AUTO_INCREMENT,
  `time` datetime DEFAULT NULL,
  `username` char(20) NOT NULL,
  `item_id` int(11) DEFAULT NULL,
  `card_number` bigint(16) unsigned zerofill NOT NULL,
  `sent` datetime DEFAULT NULL,
  `received` datetime DEFAULT NULL,
  `address_id` int(11) NOT NULL,
  PRIMARY KEY (`sale_id`),
  KEY `username` (`username`),
  KEY `item_id` (`item_id`),
  KEY `sales_ibfk_3` (`username`,`card_number`),
  KEY `sales_ibfk_4_idx` (`address_id`),
  CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`username`) REFERENCES `registered_users` (`username`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sales_ibfk_2` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sales_ibfk_3` FOREIGN KEY (`username`, `card_number`) REFERENCES `credit_cards` (`username`, `card_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sales`
--

LOCK TABLES `sales` WRITE;
/*!40000 ALTER TABLE `sales` DISABLE KEYS */;
INSERT INTO `sales` VALUES (1.00,7,'2016-04-12 17:34:56','angry_joe',62,0000000123456789,'2016-04-21 17:31:03','0000-00-00 00:00:00',0),(1.00,10,'2016-04-13 22:36:28','angry_joe',1,1234567812345678,'2016-04-21 17:31:10','2016-04-13 22:45:31',5),(25.99,11,'2016-04-10 22:36:28','elle',91,0987765412345678,'2016-04-21 17:31:13',NULL,25),(3.00,12,'2016-04-11 22:36:28','angry_joe',1,1234567812345678,NULL,'2016-04-14 23:04:02',5),(0.00,13,'2016-04-22 03:16:40','angry_joe',93,0000000123456789,NULL,NULL,5),(12.00,14,'2016-04-22 19:17:28','chuckyfin',2,0000000123456789,NULL,NULL,26),(4.00,15,'2016-04-24 18:35:10','angry_joe',4,1234567812345678,NULL,NULL,2),(490.00,16,'2016-04-27 14:28:09','hans',51,1234123412341234,'2016-04-27 14:30:09',NULL,27);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sellers`
--

LOCK TABLES `sellers` WRITE;
/*!40000 ALTER TABLE `sellers` DISABLE KEYS */;
INSERT INTO `sellers` VALUES ('aaronsparty','Aaron Carter','1000 Shady Hotel, College Campuses, USA','Aaron','7896541230',0),('angry_joe','Josephine Arl','123 Yangry Rd, California, PA','ANGRY JOE','3216544561',700),('bsb123','Backstreet Boys','123 Best Road, Best City, AK','Kevin Richardson','9517538426',0),('elle','Elle Woods','Harvard, America','Warner','3445445334',0),('fbi_superstar','Burt Macklin','Pawnee, IN','April Ludgate','1001001000',0),('frank','Dr. Frankenstein','Geneva, Switzerland','No one','6787657678',0),('icecreamgurl','Carissa Jones','123 Something Street, Unit 4, Huron, OH','Carissaaa','8885556980',0),('leoNsatan','Film Cow','New York, New York','Caaaaarl','3213214321',0),('simple10','Simple Plan Inc.','Houston, Texas','Billy Bob','4324324321',0),('tturns22','Timmy Turner','125 Cleft Chin Drive, Town, ST','Boy Chin Wonder','7896544567',5),('xoQTGrlox','Uniquoa Johnson Co.','New Orleans, Louisianna','Uniquoa Johnson','1231231234',0),('xoxoCHUCKLESxoxo','Chuck Bevington','State College, PA','His People','3333333333',0);
/*!40000 ALTER TABLE `sellers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sold_by`
--

DROP TABLE IF EXISTS `sold_by`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sold_by` (
  `item_id` int(11) NOT NULL,
  `listed_price` decimal(10,2) DEFAULT NULL,
  `number_in_stock` int(11) DEFAULT NULL,
  PRIMARY KEY (`item_id`),
  CONSTRAINT `sold_by_ibfk_1` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sold_by`
--

LOCK TABLES `sold_by` WRITE;
/*!40000 ALTER TABLE `sold_by` DISABLE KEYS */;
INSERT INTO `sold_by` VALUES (1,12.00,1),(2,12.00,3),(3,49.00,5),(4,4.00,49),(5,4.00,50),(6,4.00,50),(7,4.00,50),(8,4.00,50),(18,29.00,2),(21,16.00,8),(22,400.00,1),(25,200.00,1),(27,4.00,28),(28,1.00,10),(30,14.00,1),(31,49.00,1),(35,35.00,1),(37,24.00,1),(39,1.00,2),(40,12.00,3),(43,34.00,1),(45,4.00,4),(47,2.00,50),(49,3.00,65),(51,490.00,5),(53,45.00,3),(55,7.00,7),(57,4.00,23),(60,18.00,7),(62,21.00,10),(64,1.00,5),(66,40.00,12),(68,12.00,54),(70,16.00,13),(72,12.00,10),(74,100.00,40),(75,123.00,433),(78,15.00,2),(79,12.00,1),(82,60.00,1),(83,8.00,2),(87,4.00,3),(88,9.00,1),(91,5.00,2),(92,11.00,3),(93,0.00,0),(94,18.00,5),(95,25.00,10),(96,24.00,26),(97,23.00,55),(98,18.00,100),(99,18.99,100),(100,15.00,15),(101,35.00,150),(102,30.00,60),(103,5.00,87),(104,12.00,65),(105,12.00,37),(106,8.99,104),(107,12.00,99),(108,15.00,43),(109,15.00,78),(131,100.00,10);
/*!40000 ALTER TABLE `sold_by` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-04-28 16:53:00
