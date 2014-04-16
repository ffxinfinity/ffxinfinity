-- MySQL dump 10.13  Distrib 5.5.29, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: dspdb
-- ------------------------------------------------------
-- Server version	5.5.29-0ubuntu0.12.04.1

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
-- Table structure for table `mob_family_system`
--

DROP TABLE IF EXISTS `mob_family_system`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mob_family_system` (
  `familyid` smallint(4) unsigned NOT NULL,
  `family` tinytext,
  `systemid` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `system` tinytext,
  `mobsize` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `link_radius` smallint(5) unsigned NOT NULL DEFAULT '10',
  `speed` tinyint(3) unsigned NOT NULL DEFAULT '40',
  `HP` tinyint(3) unsigned NOT NULL DEFAULT '100',
  `MP` tinyint(3) unsigned NOT NULL DEFAULT '100',
  `STR` smallint(4) unsigned NOT NULL DEFAULT '3',
  `DEX` smallint(4) unsigned NOT NULL DEFAULT '3',
  `VIT` smallint(4) unsigned NOT NULL DEFAULT '3',
  `AGI` smallint(4) unsigned NOT NULL DEFAULT '3',
  `INT` smallint(4) unsigned NOT NULL DEFAULT '3',
  `MND` smallint(4) unsigned NOT NULL DEFAULT '3',
  `CHR` smallint(4) unsigned NOT NULL DEFAULT '3',
  `ATT` smallint(4) unsigned NOT NULL DEFAULT '3',
  `DEF` smallint(4) unsigned NOT NULL DEFAULT '3',
  `ACC` smallint(4) unsigned NOT NULL DEFAULT '3',
  `EVA` smallint(4) unsigned NOT NULL DEFAULT '3',
  `Slash` float NOT NULL DEFAULT '1',
  `Pierce` float NOT NULL DEFAULT '1',
  `H2H` float NOT NULL DEFAULT '1',
  `Impact` float NOT NULL DEFAULT '1',
  `Fire` float NOT NULL DEFAULT '1',
  `Ice` float NOT NULL DEFAULT '1',
  `Wind` float NOT NULL DEFAULT '1',
  `Earth` float NOT NULL DEFAULT '1',
  `Lightning` float NOT NULL DEFAULT '1',
  `Water` float NOT NULL DEFAULT '1',
  `Light` float NOT NULL DEFAULT '1',
  `Dark` float NOT NULL DEFAULT '1',
  `Element` float NOT NULL DEFAULT '0',
  PRIMARY KEY (`familyid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=128;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mob_family_system`
--

LOCK TABLES `mob_family_system` WRITE;
/*!40000 ALTER TABLE `mob_family_system` DISABLE KEYS */;
INSERT INTO `mob_family_system` VALUES (1,'Acrolith',3,'Arcana',1,10,40,90,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (2,'Adamantoise',14,'Lizard',3,10,30,120,90,2,5,1,6,6,4,3,3,3,3,4,1,1,1,1,1,1.25,1,0.875,1.125,0.875,1,1,4);
INSERT INTO `mob_family_system` VALUES (3,'Aern',15,'Luminian',0,10,40,120,140,1,1,1,1,1,1,1,3,3,3,3,1,1,1,1,1,1,1,1,1,1,0.5,1,0);
INSERT INTO `mob_family_system` VALUES (4,'Ahriman',9,'Demon',0,15,40,87,140,2,3,5,3,1,2,2,3,3,3,3,1,1,1,1,0.75,0.75,0.75,0.75,0.75,0.75,0.75,0.75,8);
INSERT INTO `mob_family_system` VALUES (5,'Amoeban',21,'Voragean',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (6,'Amphiptere',8,'Bird',4,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (7,'AnimatedWeapon-Archery',18,'Unclassified',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (8,'AnimatedWeapon-Axe',18,'Unclassified',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (9,'AnimatedWeapon-Club',18,'Unclassified',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (10,'AnimatedWeapon-Club',18,'Unclassified',1,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1.25,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (11,'AnimatedWeapon-Dagger',18,'Unclassified',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (12,'AnimatedWeapon-Greataxe',18,'Unclassified',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (13,'AnimatedWeapon-Greatkatana',18,'Unclassified',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (14,'AnimatedWeapon-Greatsword',18,'Unclassified',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (15,'AnimatedWeapon-Handtohand',18,'Unclassified',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (16,'AnimatedWeapon-Instrument',18,'Unclassified',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (17,'AnimatedWeapon-Katana',18,'Unclassified',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (18,'AnimatedWeapon-Marksmanship',18,'Unclassified',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (19,'AnimatedWeapon-Polearm',18,'Unclassified',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (20,'AnimatedWeapon-Scythe',18,'Unclassified',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (21,'AnimatedWeapon-Shield',18,'Unclassified',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (22,'AnimatedWeapon-Shield',18,'Unclassified',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,0.875,0.875,0.875,0.875,0.875,0.875,0.875,0.875,0);
INSERT INTO `mob_family_system` VALUES (23,'AnimatedWeapon-Staff',18,'Unclassified',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (24,'AnimatedWeapon-Sword',18,'Unclassified',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (25,'Antica',7,'Beastmen',0,10,40,116,140,1,3,1,2,2,3,3,3,3,3,3,1,1,1,1,1,1,1.25,0.5,1,1,1,0.5,8);
INSERT INTO `mob_family_system` VALUES (26,'Antlion',20,'Vermin',1,10,40,120,125,1,3,4,3,4,4,5,3,2,3,3,1,1,1,1,1,1,1.125,0.875,1,1,1.25,0.875,8);
INSERT INTO `mob_family_system` VALUES (27,'Apkallu',8,'Bird',0,10,40,105,90,3,2,1,6,6,4,5,3,3,3,3,1,1,1,1,1,1,1,1.125,0.875,0.5,1,1,6);
INSERT INTO `mob_family_system` VALUES (28,'Automaton-Harlequin',18,'Unclassified',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (29,'Automaton-Sharpshot',18,'Unclassified',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (30,'Automaton-Stormwaker',18,'Unclassified',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (31,'Automaton-Valoredge',18,'Unclassified',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (32,'Avatar-Atomos',5,'Avatar',1,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (33,'Avatar-Alexander',5,'Avatar',4,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (34,'Avatar-Carbuncle',5,'Avatar',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (35,'Avatar-Diabolos',5,'Avatar',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1.125,1,0);
INSERT INTO `mob_family_system` VALUES (36,'Avatar-Fenrir',5,'Avatar',1,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,0.875,0.875,0.875,0.875,0.875,0.875,1,0.875,0);
INSERT INTO `mob_family_system` VALUES (37,'Avatar-Garuda',5,'Avatar',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,0.875,1,0.875,0.875,0.875,0.875,0.875,0.875,0);
INSERT INTO `mob_family_system` VALUES (38,'Avatar-Ifrit',5,'Avatar',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,0.875,0.875,0.875,0.875,0.875,1,0.875,0.875,0);
INSERT INTO `mob_family_system` VALUES (39,'Avatar-Ixion',5,'Avatar',2,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (40,'Avatar-Leviathan',5,'Avatar',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,0.875,0.875,0.875,0.875,1,0.875,0.875,0.875,0);
INSERT INTO `mob_family_system` VALUES (41,'Avatar-Odin',5,'Avatar',2,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1.125,1,0);
INSERT INTO `mob_family_system` VALUES (42,'Avatar-Odin',5,'Avatar',2,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,0,0,0,0,0,0,0,0,0,0,0,0,0);
INSERT INTO `mob_family_system` VALUES (43,'Avatar-Ramuh',5,'Avatar',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,0.875,0.875,0.875,1,0.875,0.875,0.875,0.875,0);
INSERT INTO `mob_family_system` VALUES (44,'Avatar-Shiva',5,'Avatar',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,0.875,0.875,0.875,0.875,0.875,0.875,0.875,0);
INSERT INTO `mob_family_system` VALUES (45,'Avatar-Titan',5,'Avatar',1,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,0.875,0.875,1,0.875,0.875,0.875,0.875,0.875,0);
INSERT INTO `mob_family_system` VALUES (46,'Bat',8,'Bird',0,10,40,95,120,1,3,3,3,3,3,5,3,3,3,3,1,1.25,1,1,1,1.125,1.25,1,1.125,1,1.25,0.5,3);
INSERT INTO `mob_family_system` VALUES (47,'Bats',8,'Bird',0,10,40,87,120,1,3,4,3,3,3,5,3,3,3,3,1,1.25,1,1,1,1.125,1.25,1,1.125,1,1.25,0.5,3);
INSERT INTO `mob_family_system` VALUES (48,'Bee',20,'Vermin',0,10,40,87,120,1,3,3,2,3,3,5,3,3,3,3,1,1.25,1,1,1,1.25,1,1,1,1,1,1,3);
INSERT INTO `mob_family_system` VALUES (49,'Beetle',20,'Vermin',1,10,40,117,110,1,3,2,4,5,5,6,3,2,3,3,1,1,1,1,1,1.25,1,1,1,1,1.25,1,4);
INSERT INTO `mob_family_system` VALUES (50,'Beetle',20,'Vermin',1,10,40,117,110,1,3,2,4,5,5,6,3,2,3,3,0.5,0.5,0.5,0.5,1,1.25,1,1,1,1,1.25,1,4);
INSERT INTO `mob_family_system` VALUES (51,'Behemoth',6,'Beast',4,10,40,110,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,6);
INSERT INTO `mob_family_system` VALUES (52,'Bhoot',19,'Undead',1,10,40,70,140,6,3,6,3,1,5,4,3,3,3,3,0.75,0.75,0.5,0.5,1.25,0.5,1,1,1,1,1.25,0.5,2);
INSERT INTO `mob_family_system` VALUES (53,'Biotechnological',18,'Unclassified',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (54,'Biotechnological',18,'Unclassified',2,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (55,'Bird',8,'Bird',0,10,40,106,120,1,3,5,3,3,3,5,3,3,3,3,1,1.25,1,1,1,1.25,0.875,1,1,1,1,1,1);
INSERT INTO `mob_family_system` VALUES (56,'Bomb',3,'Arcana',0,10,40,97,140,6,3,6,3,1,5,4,3,3,3,3,1,1,1,1,1.25,0.5,0.5,0.5,0.5,0.5,0.5,0.5,1);
INSERT INTO `mob_family_system` VALUES (57,'Buffalo',6,'Beast',2,10,40,130,120,1,2,3,3,4,4,5,3,2,3,3,1,1,1,1,1,1,1,1,1,1.125,1,1,2);
INSERT INTO `mob_family_system` VALUES (58,'Bugard',14,'Lizard',1,10,40,115,110,1,2,2,3,4,4,3,3,3,3,3,1,1,1,1,1,1.125,1,1,1,1,1,1,1);
INSERT INTO `mob_family_system` VALUES (59,'Bugbear',7,'Beastmen',1,10,40,125,90,3,2,1,6,6,4,5,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1.25,1,5);
INSERT INTO `mob_family_system` VALUES (60,'CaitSith',18,'Unclassified',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (61,'Cardian',3,'Arcana',0,10,40,109,140,1,3,1,3,1,1,3,3,3,3,3,1,1,1,1,0.75,0.75,0.75,0.75,0.75,0.75,0.875,0.75,6);
INSERT INTO `mob_family_system` VALUES (62,'Cerberus',6,'Beast',3,10,40,100,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,1);
INSERT INTO `mob_family_system` VALUES (63,'Chariot',4,'ArchaicMachine',3,10,40,90,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,1,1.125,1,1.125,0.875,1,0.875,1,0);
INSERT INTO `mob_family_system` VALUES (64,'Chigoe',20,'Vermin',0,10,40,120,90,3,2,1,6,6,4,5,3,3,3,3,1,1,1,1,1.125,1.125,1,1,1,1,1,1,4);
INSERT INTO `mob_family_system` VALUES (65,'Clionid',21,'Voragean',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (66,'Clot',1,'Amorph',1,10,40,100,120,1,3,3,4,3,6,2,3,3,3,3,0.5,0.5,0.25,0.25,1.25,1,1,1,1,0.5,1,1,6);
INSERT INTO `mob_family_system` VALUES (67,'Clot',1,'Amorph',1,10,40,100,120,1,3,3,4,3,6,2,3,3,3,3,0.25,0.25,0.125,0.125,1.562,1.25,1.25,1.25,1.25,0.625,1.25,1.25,6);
INSERT INTO `mob_family_system` VALUES (68,'Cluster',3,'Arcana',0,10,40,95,140,6,3,6,3,1,5,4,3,3,3,3,1,1,1,1,1.25,1,1,1,1,1,1,1,1);
INSERT INTO `mob_family_system` VALUES (69,'Cluster',3,'Arcana',0,10,40,95,140,6,3,6,3,1,5,4,3,3,3,3,0.875,0.875,0.875,0.875,1.375,1.125,1.125,1.125,1.125,1.125,1.125,1.125,1);
INSERT INTO `mob_family_system` VALUES (70,'Cockatrice',8,'Bird',1,10,40,118,140,6,3,6,3,1,5,4,3,3,3,3,1,1,1,1,1,1.25,1.25,0.875,1,1,1,1,4);
INSERT INTO `mob_family_system` VALUES (71,'Coeurl',6,'Beast',1,10,50,94,90,1,1,4,2,6,6,2,3,3,3,3,1,1,1,1,1,1,1,1.25,0.875,1,1,1,5);
INSERT INTO `mob_family_system` VALUES (72,'Colibri',8,'Bird',0,10,60,90,140,4,4,5,5,1,3,4,3,3,3,3,1,1.25,1,1,0.875,1,0.5,0.875,0.875,0.875,1,0.875,3);
INSERT INTO `mob_family_system` VALUES (73,'Corpselights',19,'Undead',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,8);
INSERT INTO `mob_family_system` VALUES (74,'Corse',19,'Undead',1,10,40,111,140,1,3,3,3,1,5,1,3,3,3,3,0.875,0.5,1.125,1.25,1.25,0.875,0.75,0.75,0.75,0.75,1.25,0.5,8);
INSERT INTO `mob_family_system` VALUES (75,'Crab',2,'Aquan',0,10,40,108,120,4,3,1,5,3,3,4,3,3,3,3,0.9,0.9,0.9,0.9,1,1.25,1,1,1.25,0.875,1,1,6);
INSERT INTO `mob_family_system` VALUES (76,'Crab',2,'Aquan',0,10,40,108,120,4,3,1,5,3,3,4,3,3,3,3,0.9,0.9,0.9,0.9,0.875,1,0.875,0.875,1,0.75,0.875,0.875,6);
INSERT INTO `mob_family_system` VALUES (77,'Crab',2,'Aquan',0,10,40,108,120,4,3,1,5,3,3,4,3,3,3,3,1,1,1,1,1,1.25,1,1,1.25,0.875,1,1,6);
INSERT INTO `mob_family_system` VALUES (78,'Craver',12,'Empty',0,10,40,120,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (79,'Crawler',20,'Vermin',1,10,40,105,120,3,3,4,3,3,6,5,3,5,3,3,1,1,1,1,1,1.25,1,1,1.25,1,1.125,1.25,4);
INSERT INTO `mob_family_system` VALUES (80,'Dhalmel',6,'Beast',1,10,40,110,120,3,4,4,4,4,4,5,3,3,3,3,1,1,1,1,1,1,1.25,1,1.25,1,1,1,4);
INSERT INTO `mob_family_system` VALUES (81,'Diremite',20,'Vermin',1,10,40,86,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,1,1,1,1,1,1.25,1.25,1,3);
INSERT INTO `mob_family_system` VALUES (82,'Djinn',3,'Arcana',0,10,40,70,140,6,3,6,3,1,5,4,3,3,3,3,1,1,1,1,1.125,1,1,1,1,1,1,1,1);
INSERT INTO `mob_family_system` VALUES (83,'Doll',3,'Arcana',1,10,40,108,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,0.5,0.5,0.5,0.5,0.625,0.5,0.5,0.5,2);
INSERT INTO `mob_family_system` VALUES (84,'Doll',3,'Arcana',1,10,40,108,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,0.25,0.25,0.25,0.25,0.313,0.25,0.25,0.25,2);
INSERT INTO `mob_family_system` VALUES (85,'Doll',3,'Arcana',1,10,40,108,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,1,1,1,1,1.25,1,1,1,2);
INSERT INTO `mob_family_system` VALUES (86,'Doomed',19,'Undead',2,10,40,110,120,1,3,3,3,3,6,5,3,3,3,3,1.125,1,0.875,0.875,1.25,1,1,1,1,1,1.25,0.5,8);
INSERT INTO `mob_family_system` VALUES (87,'Dragon',10,'Dragon',2,10,40,125,90,1,3,1,3,6,3,1,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,8);
INSERT INTO `mob_family_system` VALUES (88,'Draugar',19,'Undead',0,10,40,90,140,1,3,4,3,1,5,4,3,3,3,3,0.875,0.5,1.125,1.25,1.25,0.875,1,1,1,1,1.25,0.5,8);
INSERT INTO `mob_family_system` VALUES (89,'Draugar',19,'Undead',0,10,40,90,140,1,3,4,3,1,5,4,3,3,3,3,0.875,0.5,1.125,1.25,1.125,0.875,1,1,1,1,1.125,0.5,8);
INSERT INTO `mob_family_system` VALUES (90,'Dvergr',9,'Demon',1,10,40,90,140,6,3,3,3,1,5,4,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,0.875,0);
INSERT INTO `mob_family_system` VALUES (91,'DvergrSkull',9,'Demon',0,10,40,92,140,6,3,3,3,1,5,4,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (92,'DynamisStatue-Goblin',18,'Unclassified',3,10,20,30,120,1,1,4,1,3,3,1,3,3,3,3,0.5,0.5,0.5,0.5,1,1,1,1,1.25,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (93,'DynamisStatue-Orc',18,'Unclassified',3,10,20,30,100,1,2,1,1,5,3,3,3,3,3,3,0.5,0.5,0.5,0.5,1,1,1,1,1.25,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (94,'DynamisStatue-Quadav',18,'Unclassified',3,10,20,30,110,1,1,3,2,4,3,3,3,3,3,3,0.5,0.5,0.5,0.5,1,1,1,1,1.25,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (95,'DynamisStatue-Yagudo',18,'Unclassified',3,10,20,30,120,1,2,5,1,3,4,2,3,3,3,3,0.5,0.5,0.5,0.5,1,1,1,1,1.25,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (96,'Eft',14,'Lizard',0,10,40,115,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,1.125,1.25,0.875,0.875,0.875,0.875,0.875,0.875,1);
INSERT INTO `mob_family_system` VALUES (97,'Eft',14,'Lizard',0,10,40,115,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,1,1.25,1,1,1,1,1,1,1);
INSERT INTO `mob_family_system` VALUES (98,'Eft',14,'Lizard',0,10,40,115,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,1,1.25,1,1,1,1,1,1,1);
INSERT INTO `mob_family_system` VALUES (99,'Elemental-Air',11,'Elemental',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,0.25,0.25,0.25,0.25,1,1.25,0.75,0.75,1,1,1,1,3);
INSERT INTO `mob_family_system` VALUES (100,'Elemental-Dark',11,'Elemental',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,0.25,0.25,0.25,0.25,1,1,1,1,1,1,1.25,0.75,8);
INSERT INTO `mob_family_system` VALUES (101,'Elemental-Earth',11,'Elemental',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,0.25,0.25,0.25,0.25,1,1,1.25,0.75,0.75,1,1,1,4);
INSERT INTO `mob_family_system` VALUES (102,'Elemental-Fire',11,'Elemental',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,0.25,0.25,0.25,0.25,0.75,0.75,1,1,1,1.25,1,1,1);
INSERT INTO `mob_family_system` VALUES (103,'Elemental-Ice',11,'Elemental',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,0.25,0.25,0.25,0.25,1.25,0.75,0.75,1,1,1,1,1,2);
INSERT INTO `mob_family_system` VALUES (104,'Elemental-Light',11,'Elemental',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,0.25,0.25,0.25,0.25,1,1,1,1,1,1,0.75,1.25,7);
INSERT INTO `mob_family_system` VALUES (105,'Elemental-Lightning',11,'Elemental',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,0.25,0.25,0.25,0.25,1,1,1,1.25,0.75,0.75,1,1,5);
INSERT INTO `mob_family_system` VALUES (106,'Elemental-Water',11,'Elemental',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,0.25,0.25,0.25,0.25,0.75,1,1,1,1.25,0.75,1,1,6);
INSERT INTO `mob_family_system` VALUES (107,'Eruca',20,'Vermin',1,10,40,92,120,1,3,4,3,3,6,5,3,5,3,3,1,1,1,1,1,1,1,1,1,1.125,1.125,1.125,1);
INSERT INTO `mob_family_system` VALUES (108,'Eruca',20,'Vermin',1,10,40,92,120,1,3,4,3,3,6,5,3,5,3,3,0,1,1,1,1,1,1,1,1,1.125,1.125,1.125,1);
INSERT INTO `mob_family_system` VALUES (109,'Euvhi',15,'Luminian',0,10,40,100,140,1,3,3,3,1,5,4,3,3,3,3,1,1,1,1,1.25,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (110,'EvilWeapon',3,'Arcana',0,10,40,105,120,1,3,4,3,3,3,4,3,5,3,3,1,1,1,1,1.25,0.9,0.9,0.9,0.9,0.9,1.25,0.9,3);
INSERT INTO `mob_family_system` VALUES (111,'EvilWeapon',3,'Arcana',0,10,40,105,120,1,3,4,3,3,3,4,3,5,3,3,1,1,1,1,1.25,0.9,0.9,0.9,0.9,0.9,1.25,0.9,3);
INSERT INTO `mob_family_system` VALUES (112,'Flan',1,'Amorph',1,10,40,70,140,6,3,6,3,1,5,4,3,3,3,3,0.875,1,0.75,0.75,1.25,1.25,1.25,1.125,1.125,1.125,1.125,1.125,6);
INSERT INTO `mob_family_system` VALUES (113,'Fly',20,'Vermin',0,10,40,92,90,1,3,4,3,6,6,5,3,3,3,3,1,1.25,1,1,1,1.25,0.875,1,1,1,1,1,3);
INSERT INTO `mob_family_system` VALUES (114,'Flytrap',17,'Plantoid',0,10,40,90,90,1,3,4,3,6,6,2,3,3,3,3,1,1,1,1,1.25,1.125,1,1,1,1,0.875,1,3);
INSERT INTO `mob_family_system` VALUES (115,'Fomor',19,'Undead',0,10,40,105,90,2,5,3,6,2,3,4,3,3,3,3,1,1,1,1,1.125,0.5,1,1,1,1,1.125,0.5,8);
INSERT INTO `mob_family_system` VALUES (116,'Funguar',17,'Plantoid',0,10,40,102,110,1,3,3,4,4,3,4,3,3,3,3,1,1,1,1,1,1,1,1,1,0.5,1.25,0.5,8);
INSERT INTO `mob_family_system` VALUES (117,'Gargouille',9,'Demon',0,10,40,110,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,8);
INSERT INTO `mob_family_system` VALUES (118,'Gargoyle',9,'Demon',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,0.875,2);
INSERT INTO `mob_family_system` VALUES (119,'Gear',4,'ArchaicMachine',0,10,40,90,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,1,1.125,1,1,0.875,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (120,'Gears',4,'ArchaicMachine',1,10,40,90,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,1,1.125,1,1,0.875,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (121,'Ghost',19,'Undead',1,10,40,104,140,6,3,6,3,1,5,4,3,3,3,3,0.75,0.75,0.5,0.5,1.25,0.5,1,1,1,1,1.25,0.5,2);
INSERT INTO `mob_family_system` VALUES (122,'Ghrah',16,'Luminion',0,10,40,120,140,1,1,1,2,1,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,7);
INSERT INTO `mob_family_system` VALUES (123,'Ghrah',16,'Luminion',0,10,40,120,140,1,1,1,2,1,3,3,3,3,3,3,0.75,0.75,0.75,0.75,1,1,1,1,1,1,1,1,7);
INSERT INTO `mob_family_system` VALUES (124,'Ghrah',16,'Luminion',0,10,40,120,140,1,1,1,2,1,3,3,3,3,3,3,0.875,0.875,0.875,0.875,1,1,1,1,1,1,1,1,7);
INSERT INTO `mob_family_system` VALUES (125,'GiantBird',8,'Bird',1,10,40,130,120,1,3,4,3,3,3,5,3,3,3,3,0.75,1.25,1,0.75,1,1.25,0.5,1,1,1,1,1,7);
INSERT INTO `mob_family_system` VALUES (126,'Gigas',7,'Beastmen',1,10,40,125,100,1,2,1,1,5,4,1,3,3,3,3,1,1,1,1,1,0.875,1,1.125,0.5,1,1,1,2);
INSERT INTO `mob_family_system` VALUES (127,'Gigas',7,'Beastmen',1,10,40,125,100,1,2,1,1,5,4,1,3,3,3,3,0,0,0,0,1,0.875,1,1.125,0.5,1,1,1,2);
INSERT INTO `mob_family_system` VALUES (128,'Gigas',7,'Beastmen',1,10,40,125,100,1,2,1,1,5,4,1,3,3,3,3,0,1,1,1,1,1,0.875,1,1.125,0.5,1,1,2);
INSERT INTO `mob_family_system` VALUES (129,'Gigas',7,'Beastmen',1,10,40,125,100,1,2,1,1,5,4,1,3,3,3,3,1,1,1,1,1,0.875,1,1.125,0.5,1,1,1,2);
INSERT INTO `mob_family_system` VALUES (130,'Gigas',7,'Beastmen',1,10,40,125,100,1,2,1,1,5,4,1,3,3,3,3,1,1,1,1,0,0,0,0,0,0,0,0,2);
INSERT INTO `mob_family_system` VALUES (131,'Gnat',20,'Vermin',0,10,40,90,120,4,1,4,2,3,6,6,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,8);
INSERT INTO `mob_family_system` VALUES (132,'Gnole',7,'Beastmen',1,10,40,120,90,3,2,1,6,6,4,5,3,3,3,3,1,1,1,1,1,1.125,1,1,1.125,1,1,0.875,8);
INSERT INTO `mob_family_system` VALUES (133,'Goblin',7,'Beastmen',0,10,40,91,120,1,3,5,3,4,4,4,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1.25,1,1);
INSERT INTO `mob_family_system` VALUES (134,'God',18,'Unclassified',3,10,40,120,140,1,1,1,1,1,1,1,3,1,3,1,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (135,'Golem',3,'Arcana',1,10,40,130,130,2,3,3,3,3,6,5,3,3,3,3,1,1,1,1,1,1,1,1,1.125,1,1,1,7);
INSERT INTO `mob_family_system` VALUES (136,'Goobbue',17,'Plantoid',1,10,40,112,90,3,2,2,6,6,4,5,3,3,3,3,1,1,1,1,1.25,1,1,1,1.125,1,1,1.25,6);
INSERT INTO `mob_family_system` VALUES (137,'Gorger',12,'Empty',0,10,40,112,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (138,'Gorger',12,'Empty',1,10,40,112,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (139,'Hecteyes',1,'Amorph',1,10,40,87,140,6,3,6,3,1,5,2,3,3,3,3,1,1,0.75,0.75,1,1,1,1,1,1,1,0.875,8);
INSERT INTO `mob_family_system` VALUES (140,'Hippogryph',8,'Bird',1,10,60,90,140,4,1,4,2,1,5,4,3,3,3,3,1,1.25,1,1,1,1,1,1.25,1,1,1,1,7);
INSERT INTO `mob_family_system` VALUES (141,'Hippogryph',8,'Bird',1,10,60,90,140,4,1,4,2,1,5,4,3,3,3,3,1,1.25,1,1,0.5,0.5,0.5,0.625,0.5,0.5,0.5,0.5,7);
INSERT INTO `mob_family_system` VALUES (142,'Hound',19,'Undead',1,10,40,102,120,1,3,3,4,4,5,6,3,3,3,3,1.688,1.5,1.5,1.5,1.875,1.313,1.5,1.5,1.5,1.5,1.875,1.313,8);
INSERT INTO `mob_family_system` VALUES (143,'Hound',19,'Undead',1,10,40,102,120,1,3,3,4,4,5,6,3,3,3,3,1.125,1,1,1,1.25,0.875,1,1,1,1,1.25,0.875,8);
INSERT INTO `mob_family_system` VALUES (144,'Hpemde',15,'Luminian',1,10,40,90,120,4,1,4,2,3,6,6,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (145,'Humanoid-Elvaan',13,'Humanoid',0,10,40,100,90,2,5,3,6,6,2,4,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (146,'Humanoid-Galka',13,'Humanoid',0,10,40,120,100,3,4,1,5,5,4,6,3,3,3,3,1,1,1,1,1.125,1.125,1.125,1.125,1.125,1.125,1.125,1.125,0);
INSERT INTO `mob_family_system` VALUES (147,'Humanoid-Galka',13,'Humanoid',0,10,40,120,100,3,4,1,5,5,4,6,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (148,'Humanoid-Galka',13,'Humanoid',0,10,40,120,100,3,4,1,5,5,4,6,3,3,3,3,1,1,1,1,1.125,1,1,1,1,1,1.126,0.875,0);
INSERT INTO `mob_family_system` VALUES (149,'Humanoid-Hume',13,'Humanoid',0,10,40,90,110,3,3,2,3,2,2,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (150,'Humanoid-Hume',13,'Humanoid',0,10,40,90,110,4,4,4,4,4,4,4,3,3,3,3,1,1,1,1,0.875,0.875,0.875,0.875,0.875,0.875,0.875,0.875,0);
INSERT INTO `mob_family_system` VALUES (151,'Humanoid-Mithra',13,'Humanoid',0,10,40,80,110,5,1,5,2,4,5,6,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (152,'Humanoid-Mithra',13,'Humanoid',0,10,40,80,110,5,1,5,2,4,5,6,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (153,'Humanoid-Tarutaru',13,'Humanoid',0,10,40,70,140,6,4,5,3,1,5,4,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (154,'Humanoid-Tarutaru',13,'Humanoid',0,10,40,70,140,6,4,5,3,1,5,4,3,3,3,3,0.75,0.75,0.75,0.75,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (155,'HybridElemental-Air',11,'Elemental',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (156,'HybridElemental-Dark',11,'Elemental',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (157,'HybridElemental-Earth',11,'Elemental',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (158,'HybridElemental-Fire',11,'Elemental',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (159,'HybridElemental-Ice',11,'Elemental',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (160,'HybridElemental-Light',11,'Elemental',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (161,'HybridElemental-Lightning',11,'Elemental',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (162,'HybridElemental-Water',11,'Elemental',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (163,'Hydra',10,'Dragon',4,10,40,90,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,0.875,1,1,1,1,1,1,1,1,6);
INSERT INTO `mob_family_system` VALUES (164,'Hydra',10,'Dragon',4,10,40,90,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,0.875,1,1,1,1.125,1.125,1,1,0.875,6);
INSERT INTO `mob_family_system` VALUES (165,'Imp',9,'Demon',0,10,70,70,140,6,3,3,3,1,5,4,3,3,3,3,1,1.25,1,1,1.125,1,1,1,1,1,1.125,0.875,8);
INSERT INTO `mob_family_system` VALUES (166,'Imp',9,'Demon',0,10,70,70,140,6,3,3,3,1,5,4,3,3,3,3,1,1.25,1,1,1,0.875,0.875,0.875,0.875,0.875,1,0.75,8);
INSERT INTO `mob_family_system` VALUES (167,'Karakul',6,'Beast',1,10,40,90,110,1,3,4,3,4,3,5,3,3,3,3,1,1,1,1,1.25,1,1,1,1.25,1,1,1,4);
INSERT INTO `mob_family_system` VALUES (168,'Khimaira',3,'Arcana',3,10,40,90,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,1,1.125,1,1.125,1,1,1,1,5);
INSERT INTO `mob_family_system` VALUES (169,'Kindred',9,'Demon',0,15,50,108,140,1,2,4,4,1,2,4,3,3,3,3,1,1,1,1,0.75,0.75,0.75,0.75,0.75,0.75,1.25,0.75,8);
INSERT INTO `mob_family_system` VALUES (170,'Ladybug',20,'Vermin',0,10,40,87,120,4,1,4,2,3,6,6,3,3,3,3,1,1.25,1,1,1,1.125,0.5,1,1,1,1,1,3);
INSERT INTO `mob_family_system` VALUES (171,'Lamiae',7,'Beastmen',0,10,40,100,140,3,3,3,1,1,2,2,3,3,3,3,1,1,1,1,1,1.125,1,1,1.125,0.875,1,1,8);
INSERT INTO `mob_family_system` VALUES (172,'Leech',1,'Amorph',0,10,40,90,90,1,3,2,3,6,6,5,3,3,3,2,1,1,0.75,0.75,1,1,1,1,1,0.5,1.25,1,6);
INSERT INTO `mob_family_system` VALUES (173,'Limule',21,'Voragean',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (174,'Lizard',14,'Lizard',1,10,40,92,120,2,3,2,3,4,4,5,3,3,3,3,1,1,1,1,1,1.25,1.25,1,1,1,1,1,1);
INSERT INTO `mob_family_system` VALUES (175,'MagicPot',3,'Arcana',2,10,40,80,140,3,3,5,3,1,1,3,3,3,3,3,1,1,1.25,1.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,7);
INSERT INTO `mob_family_system` VALUES (176,'MamoolJa',7,'Beastmen',2,10,40,100,120,2,1,3,3,3,3,3,3,3,3,2,1,1,1,1,1,1.125,0.875,1,1,1,0.875,1,3);
INSERT INTO `mob_family_system` VALUES (177,'MamoolJaKnight',7,'Beastmen',3,10,40,120,120,2,1,1,3,3,3,3,3,3,3,3,1,1,1,1,1,1.125,1.125,1,1,1,1,1,3);
INSERT INTO `mob_family_system` VALUES (178,'Mandragora',17,'Plantoid',0,10,40,107,120,3,3,4,5,4,4,2,3,3,3,3,1,1.25,1,1,1.25,1.25,1.25,1,1.25,1,0.875,1.25,4);
INSERT INTO `mob_family_system` VALUES (179,'Manticore',6,'Beast',1,10,40,140,130,1,3,3,3,2,2,2,3,3,3,3,1,1,1,1,0.5,1,0.5,1,1,1.25,1,1,3);
INSERT INTO `mob_family_system` VALUES (180,'Marid',6,'Beast',2,10,40,150,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,1,1.125,1,1,1,1,1,1,4);
INSERT INTO `mob_family_system` VALUES (181,'MemoryReceptacle',12,'Empty',2,10,0,200,0,1,3,5,4,2,2,5,3,3,3,3,2,2,2,2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0.2,0);
INSERT INTO `mob_family_system` VALUES (182,'Merrow',7,'Beastmen',0,10,40,100,120,3,3,3,2,3,3,2,3,3,3,3,1,1,1,1,1,1,1,1,1.125,0.875,1,1,6);
INSERT INTO `mob_family_system` VALUES (183,'Mimic',3,'Arcana',0,10,0,90,90,1,3,4,3,6,6,5,3,3,3,3,0.5,0.5,0.5,0.5,1,1,1,1,1,1,0.875,1.125,7);
INSERT INTO `mob_family_system` VALUES (184,'Moblin',7,'Beastmen',0,10,40,92,140,1,1,4,3,1,1,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1.25,1,5);
INSERT INTO `mob_family_system` VALUES (185,'Moogle',18,'Unclassified',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (186,'Morbol',17,'Plantoid',1,10,40,140,100,1,2,1,3,5,4,4,3,3,3,3,1,1,1,1,1.25,1,1,1,1,0.5,1,1,4);
INSERT INTO `mob_family_system` VALUES (187,'Murex',21,'Voragean',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (188,'Opo-opo',6,'Beast',0,10,40,110,90,1,3,4,3,6,6,2,3,3,3,3,1,1,1,1,1,1.25,1,1,1,1,1,1,5);
INSERT INTO `mob_family_system` VALUES (189,'Orc',7,'Beastmen',1,10,40,108,100,1,3,3,6,4,5,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1.25,1,1,1);
INSERT INTO `mob_family_system` VALUES (190,'OrcishWarmachine',7,'Beastmen',1,10,40,123,100,4,6,4,5,5,1,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1.25,1,1,1);
INSERT INTO `mob_family_system` VALUES (191,'Orobon',2,'Aquan',1,10,40,90,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,1,1,1,1,1.125,0.875,1,1,6);
INSERT INTO `mob_family_system` VALUES (192,'Peiste',14,'Lizard',1,10,40,90,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,1,1.125,1,1,1,1,1,1,6);
INSERT INTO `mob_family_system` VALUES (193,'PetWyvern',10,'Dragon',0,10,40,70,90,1,2,1,3,6,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,0.875,1.125,0);
INSERT INTO `mob_family_system` VALUES (194,'Phuabo',15,'Luminian',2,10,40,90,140,1,3,4,3,1,5,4,3,3,3,3,1,1,1,1,1,1,1,1,1,0.5,1,1,0);
INSERT INTO `mob_family_system` VALUES (195,'Pixie',18,'Unclassified',0,10,40,90,100,4,6,4,5,5,1,3,3,3,3,3,0.375,0.375,0.375,0.375,0.375,0.375,0.375,0.375,0.375,0.375,0.375,0.375,3);
INSERT INTO `mob_family_system` VALUES (196,'Poroggo',7,'Beastmen',0,10,40,70,140,6,3,6,3,1,5,4,3,3,3,3,1,1,1,1,1,1.125,1,1,1.125,0.5,0.5,1,6);
INSERT INTO `mob_family_system` VALUES (197,'Pugil',2,'Aquan',1,10,40,90,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,1,1.25,1,1,1.25,0.5,1,1,6);
INSERT INTO `mob_family_system` VALUES (198,'Puk',10,'Dragon',0,10,40,93,90,1,3,4,3,6,6,2,3,3,3,3,1,1.25,1,1,1,1.125,1,1,1,1,1,1,3);
INSERT INTO `mob_family_system` VALUES (199,'Qiqirn',7,'Beastmen',0,10,40,88,140,4,1,4,1,1,4,4,3,3,3,3,1,1,1,1,1,1,1.125,1,1,1,1,1,4);
INSERT INTO `mob_family_system` VALUES (200,'Quadav',7,'Beastmen',0,10,40,120,110,2,3,2,5,4,5,3,3,2,3,3,1,1.25,1,1,1.125,1,1,1,1,1,1.125,0.875,6);
INSERT INTO `mob_family_system` VALUES (201,'Quadav',7,'Beastmen',1,10,40,120,110,2,3,2,5,4,5,3,3,2,3,3,1,1,1,1,0.5,0.563,0.5,0.5,0.625,0.438,0.5,0.5,6);
INSERT INTO `mob_family_system` VALUES (202,'Quadav',7,'Beastmen',1,10,40,112,110,2,3,2,5,4,5,3,3,2,3,3,1,1,1,1,1,1.125,1,1,1.25,0.875,1,1,6);
INSERT INTO `mob_family_system` VALUES (203,'Qutrub',19,'Undead',0,10,40,100,140,1,3,3,3,1,5,4,3,3,3,3,2,2,2,2,2.25,1.75,2,2,2,2,2.25,1,8);
INSERT INTO `mob_family_system` VALUES (204,'Qutrub',19,'Undead',0,10,40,100,140,1,3,3,3,1,5,4,3,3,3,3,1,1,1,1,1.125,0.875,1,1,1,1,1.125,0.5,8);
INSERT INTO `mob_family_system` VALUES (205,'Qutrub',19,'Undead',0,10,40,100,140,1,3,3,3,1,5,4,3,3,3,3,1.875,1.875,1.875,1.875,2.109,1.64,1.875,1.875,1.875,1.875,2.109,0.937,8);
INSERT INTO `mob_family_system` VALUES (206,'Rabbit',6,'Beast',0,10,40,96,120,3,1,4,2,4,4,6,3,3,3,3,1,1,1,1,1,1,1,1,1.25,1.25,1,1.25,4);
INSERT INTO `mob_family_system` VALUES (317,'RabbitWithCure',6,'Beast',0,10,40,98,120,3,1,4,2,4,4,6,3,3,3,3,1,1,1,1,1,1,1,1,1.25,1.25,1,1.25,4);
INSERT INTO `mob_family_system` VALUES (318,'SnowyRabbit',6,'Beast',0,10,40,101,120,3,1,4,2,4,4,6,3,3,3,3,1,1,1,1,1,1,1,1,1.25,1.25,1,1.25,4);
INSERT INTO `mob_family_system` VALUES (207,'Rafflesia',17,'Plantoid',0,10,40,90,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,1.125,1,1,1,1,1,1,1,4);
INSERT INTO `mob_family_system` VALUES (208,'Ram',6,'Beast',3,10,40,120,100,1,3,4,3,5,1,3,3,3,3,3,1,1,1,1,1,0.875,1,1,1,1,1,1,4);
INSERT INTO `mob_family_system` VALUES (209,'Rampart',4,'ArchaicMachine',2,10,40,90,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,1,1.125,1,1,0.875,1,1,1,5);
INSERT INTO `mob_family_system` VALUES (210,'Raptor',14,'Lizard',1,10,60,95,120,4,1,4,2,4,4,1,3,3,3,3,1,1,1,1,0.875,1,1,1,1,1.25,1,1,1);
INSERT INTO `mob_family_system` VALUES (211,'Ruszor',2,'Aquan',1,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,0.5,0.5,0.875,1,1,1,1,2);
INSERT INTO `mob_family_system` VALUES (212,'Sabotender',17,'Plantoid',0,10,40,100,90,3,2,1,6,6,4,2,3,3,3,3,1,1,1,1,1,1.25,1,1,1,0.5,0.875,1.25,6);
INSERT INTO `mob_family_system` VALUES (213,'Sahagin',7,'Beastmen',0,10,40,107,110,2,2,1,4,4,1,2,3,3,3,3,1,1,1,1,1,1,1,1,1.25,0.5,1,1,6);
INSERT INTO `mob_family_system` VALUES (214,'Sandworm',1,'Amorph',0,10,0,130,180,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,1,1,1.25,0.875,1,1,1.25,0.875,4);
INSERT INTO `mob_family_system` VALUES (215,'Sandworm',1,'Amorph',5,10,0,130,180,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,0.5,0.5,1.125,0.25,0.25,0.5,1,0.5,4);
INSERT INTO `mob_family_system` VALUES (216,'Sapling',17,'Plantoid',0,10,40,85,120,3,2,4,3,3,3,5,3,3,3,3,1,1,1,1,1.25,1,1,1,1,1,0.875,1.25,4);
INSERT INTO `mob_family_system` VALUES (217,'Scorpion',20,'Vermin',1,10,40,105,120,1,3,4,3,3,6,5,3,3,3,3,1,1,1,1,1,1.25,1,1,1,0.875,1.25,0.875,4);
INSERT INTO `mob_family_system` VALUES (218,'SeaMonk',2,'Aquan',1,10,40,110,140,6,3,6,3,1,5,4,3,3,3,3,1,1,1,1,1,1.25,1,1,1.25,0.5,1,1,6);
INSERT INTO `mob_family_system` VALUES (219,'SeaMonk',2,'Aquan',1,10,40,110,140,6,3,6,3,1,5,4,3,3,3,3,0,1,1,1,1,1.25,1,1,1.25,0.5,1,1,6);
INSERT INTO `mob_family_system` VALUES (220,'Seether',12,'Empty',1,10,50,117,90,1,3,2,3,6,6,5,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (221,'Shadow',19,'Undead',0,10,40,100,90,2,5,3,6,6,2,4,3,3,3,3,1,1,1,1,1.25,1,1,1,1,1,1.25,0.5,8);
INSERT INTO `mob_family_system` VALUES (222,'Shadow',19,'Undead',0,10,40,100,90,2,5,3,6,6,2,4,3,3,3,3,1,1,1,1,1.125,0.5,1,1,1,1,1.125,0.5,8);
INSERT INTO `mob_family_system` VALUES (223,'Shadow',19,'Undead',0,10,40,100,90,2,5,3,6,6,2,4,3,3,3,3,1,1,1,1,1.125,1,1,1,1,1,1.125,0.5,8);
INSERT INTO `mob_family_system` VALUES (224,'ShadowLord',18,'Unclassified',1,10,40,120,140,1,1,1,1,1,1,1,3,1,3,1,1,1,1,1,1,1,1,1,1,1,1.125,1,8);
INSERT INTO `mob_family_system` VALUES (225,'ShadowLord',18,'Unclassified',1,10,40,120,140,1,1,1,1,1,1,1,3,1,3,1,1,1,1,1,1,1,1,1,1,1,1,1,8);
INSERT INTO `mob_family_system` VALUES (226,'Sheep',6,'Beast',1,10,40,120,110,1,3,4,3,5,4,5,3,3,3,3,1,1,1,1,1.25,1,1,1,1.25,1,1,1,4);
INSERT INTO `mob_family_system` VALUES (227,'Skeleton',19,'Undead',0,10,40,95,140,1,3,3,3,1,5,1,3,3,3,3,0.875,0.5,1.125,1.25,1.25,0.875,1,1,1,1,1.25,0.5,4);
INSERT INTO `mob_family_system` VALUES (228,'Slime',1,'Amorph',1,10,40,100,120,1,3,3,4,3,6,1,3,3,3,3,0.5,0.5,0.25,0.25,1.5,1.5,1.5,1.5,1.5,0.75,1.5,1.5,6);
INSERT INTO `mob_family_system` VALUES (229,'Slime',1,'Amorph',1,10,40,100,120,1,3,3,4,3,6,1,3,3,3,3,0.5,0.5,0.25,0.25,1.25,1,1,1,1,0.5,1,1,6);
INSERT INTO `mob_family_system` VALUES (230,'Slime',1,'Amorph',1,10,40,100,120,1,3,3,4,3,6,1,3,3,3,3,0.5,0.5,0.25,0.25,1.5,1.125,1.125,1.125,1.125,0.625,1.125,1.125,6);
INSERT INTO `mob_family_system` VALUES (231,'Slug',1,'Amorph',1,10,40,90,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,1,1.125,1,1,1,1,1,1,6);
INSERT INTO `mob_family_system` VALUES (232,'Snoll',3,'Arcana',0,10,40,89,140,6,3,6,3,1,5,4,3,3,3,3,1,1,1,1,1.125,1,1,1,1,1,1,1,2);
INSERT INTO `mob_family_system` VALUES (233,'Soulflayer',9,'Demon',0,10,40,100,140,6,3,3,3,1,5,4,3,3,3,3,1,1,1,1,0.875,0.875,1,1,1.125,1,1.125,0.5,6);
INSERT INTO `mob_family_system` VALUES (234,'Spheroid',3,'Arcana',0,10,40,90,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,1,1,1,1,1.25,1,1,1,5);
INSERT INTO `mob_family_system` VALUES (235,'Spider',20,'Vermin',0,10,40,87,130,1,3,5,3,2,6,5,3,3,3,3,1,1,1,1,1,1.25,1,1,1,1,1,1,4);
INSERT INTO `mob_family_system` VALUES (236,'Structure',18,'Unclassified',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (237,'Structure',18,'Unclassified',2,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0);
INSERT INTO `mob_family_system` VALUES (238,'Structure',18,'Unclassified',1,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (239,'Structure',18,'Unclassified',2,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (240,'Tauri',9,'Demon',1,10,40,123,130,1,3,3,3,3,6,5,3,3,3,3,1,1,1.25,1.5,1,1,1,1,1,1,1.25,1,8);
INSERT INTO `mob_family_system` VALUES (241,'Thinker',12,'Empty',1,10,50,132,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (242,'Tiger',6,'Beast',1,10,80,111,120,1,1,4,2,3,6,5,3,3,3,3,1,1,1,1,1.25,0.875,1,1,1.25,1,1,1,5);
INSERT INTO `mob_family_system` VALUES (243,'Tonberry',7,'Beastmen',0,10,40,87,140,3,1,3,2,1,5,2,3,3,4,3,1,1,1,1,1,1.25,1,1,1,1,0.5,1,7);
INSERT INTO `mob_family_system` VALUES (244,'Tonberry',7,'Beastmen',0,10,40,87,140,3,1,3,2,1,5,2,3,3,4,3,1,1,1,1,0.66,0.825,0.66,0.66,0.66,0.66,0.33,0.66,7);
INSERT INTO `mob_family_system` VALUES (245,'Treant',17,'Plantoid',2,10,40,120,120,1,2,1,2,3,1,3,3,3,3,3,1,1,1,1,1.25,1,1,1,1,1,1,1.25,4);
INSERT INTO `mob_family_system` VALUES (246,'Troll',7,'Beastmen',1,10,40,120,120,1,2,1,3,3,3,3,3,3,3,3,1,1,1,1,0.875,1,1,1,1,1.125,1,1,1);
INSERT INTO `mob_family_system` VALUES (247,'Tubes',18,'Unclassified',0,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (248,'Turret-Orc',18,'Unclassified',4,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (249,'Turret-Quadav',18,'Unclassified',4,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (250,'Turret-Yagudo',18,'Unclassified',4,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (251,'Uragnite',2,'Aquan',1,10,40,120,90,2,5,1,6,6,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1.25,0.875,1,1,6);
INSERT INTO `mob_family_system` VALUES (252,'Vampyr',19,'Undead',1,10,40,100,120,1,3,3,4,3,6,6,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,8);
INSERT INTO `mob_family_system` VALUES (253,'Wamoura',20,'Vermin',1,10,40,90,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,0.5,1.125,1,1,1,1,1,1,1);
INSERT INTO `mob_family_system` VALUES (254,'Wamouracampa',20,'Vermin',1,10,40,90,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,0.875,1.125,1,1,1,1,1,1,1);
INSERT INTO `mob_family_system` VALUES (255,'Wanderer',12,'Empty',0,10,40,20,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (256,'Weeper',12,'Empty',0,10,50,110,90,2,2,4,3,6,6,5,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (257,'Wivre',14,'Lizard',3,10,40,140,90,2,5,1,6,6,3,3,3,3,3,3,1,1,1,1,1,1.125,1.125,1,1,1,1,1,4);
INSERT INTO `mob_family_system` VALUES (258,'Worm',1,'Amorph',0,10,0,70,200,4,3,6,4,3,4,4,3,3,3,3,1,1,1,1,1,1,1.25,0.875,1,1,1.25,0.875,4);
INSERT INTO `mob_family_system` VALUES (259,'Wyrm',10,'Dragon',4,10,40,120,90,1,3,1,3,6,3,1,3,3,3,3,1,1,1,1,1,1,1.125,1,1,1,1,1,3);
INSERT INTO `mob_family_system` VALUES (260,'Wyrm',10,'Dragon',4,10,40,120,90,1,3,1,3,6,3,1,3,3,3,3,1,1,1,1,0.875,0.875,1,1,1,1,1,1,1);
INSERT INTO `mob_family_system` VALUES (261,'Wyrm',10,'Dragon',4,10,40,120,90,1,3,1,3,6,3,1,3,3,3,3,1,1,1,1,0.875,1,1,1,1,1,1,1,2);
INSERT INTO `mob_family_system` VALUES (262,'Wyrm',10,'Dragon',4,10,40,120,90,1,3,1,3,6,3,1,3,3,3,3,1,1,1,1,1,0.875,1,1,1,1,1,1,1);
INSERT INTO `mob_family_system` VALUES (263,'Wyrm',10,'Dragon',4,10,40,120,90,1,3,1,3,6,3,1,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,1);
INSERT INTO `mob_family_system` VALUES (264,'Wyrm',10,'Dragon',4,10,40,120,90,1,3,1,3,6,3,1,3,3,3,3,1,1,1,1,1,1,1,1,1,1.125,1,1,1);
INSERT INTO `mob_family_system` VALUES (265,'Wyvern',10,'Dragon',1,10,50,115,90,1,2,1,3,6,3,3,3,3,3,3,1,1,1,1,0.5,1.125,0.875,1,1,1,0.375,1.25,2);
INSERT INTO `mob_family_system` VALUES (266,'Wyvern',10,'Dragon',1,10,50,115,90,1,2,1,3,6,3,3,3,3,3,3,1,1,1,1,0.5,1,0.875,1,1,1,0.375,1.25,3);
INSERT INTO `mob_family_system` VALUES (267,'Wyvern',10,'Dragon',1,10,50,115,90,1,2,1,3,6,3,3,3,3,3,3,1,1,1,1,0.5,1,0.875,1,1,1,1.25,0.375,7);
INSERT INTO `mob_family_system` VALUES (268,'Wyvern/Undead',10,'Dragon',1,10,40,109,90,1,2,1,3,6,3,3,3,3,3,3,1,1,1,1,0.5,1,0.875,1,1,1,0.375,1.25,8);
INSERT INTO `mob_family_system` VALUES (269,'Xzomit',15,'Luminian',0,10,50,100,110,3,2,3,2,4,5,1,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (270,'Yagudo',7,'Beastmen',0,10,40,85,120,2,2,5,2,4,5,2,3,3,3,3,1,1,1,1,1,1.25,1,1,1,1,1,1,3);
INSERT INTO `mob_family_system` VALUES (271,'Yovra',15,'Luminian',3,10,40,80,140,4,3,5,3,1,2,2,3,3,3,3,1,1,1,1,1,1,1,1,0.5,1,1,1.125,0);
INSERT INTO `mob_family_system` VALUES (272,'Zdei',16,'Luminion',0,10,40,100,140,3,3,3,3,1,3,4,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (274,'KingV',20,'Vermin',3,10,40,90,120,4,3,4,3,3,6,5,3,3,3,3,1,1,1,1,1,1.25,1,1,1,0.875,1.25,0.875,4);
INSERT INTO `mob_family_system` VALUES (273,'Serket',20,'Vermin',3,10,40,90,120,3,3,4,3,3,6,5,3,3,3,3,1,1,1,1,1,1.25,1,1,1,0.875,1.25,0.875,4);
INSERT INTO `mob_family_system` VALUES (275,'MiniAdam',14,'Lizard',5,10,40,120,90,2,5,1,6,6,4,3,3,3,3,3,1,1,1,1,1,1.25,1,0.875,1.125,0.875,1,1,4);
INSERT INTO `mob_family_system` VALUES (276,'BigWorm',1,'Amorph',3,10,0,70,180,6,3,6,3,1,2,4,3,3,3,3,1,1,1,1,1,1,1.25,0.875,1,1,1.25,0.875,4);
INSERT INTO `mob_family_system` VALUES (277,'Genbu',14,'Lizard',5,10,30,120,90,2,5,1,6,6,4,3,3,3,3,3,1,1,1,1,1,1.25,1,0.875,1.125,0.875,1,1,4);
INSERT INTO `mob_family_system` VALUES (278,'Seiryu',10,'Dragon',3,10,60,109,90,1,2,1,3,6,3,3,3,3,3,3,1,1,1,1,0.5,1,0.875,1,1,1,1.25,0.375,7);
INSERT INTO `mob_family_system` VALUES (279,'Byakko',6,'Beast',3,10,60,111,120,1,1,4,2,3,6,5,3,3,3,3,1,1,1,1,1.25,0.875,1,1,1.25,1,1,1,5);
INSERT INTO `mob_family_system` VALUES (280,'Suzaku',8,'Bird',3,10,60,130,120,1,3,4,3,4,4,5,3,3,3,2,0.75,1.25,1,0.75,1,1.25,0.5,1,1,1,1,1,7);
INSERT INTO `mob_family_system` VALUES (281,'Kirin',6,'Beast',3,10,60,140,130,1,3,3,3,4,4,2,3,3,3,3,1,1,1,1,1,1,1.25,1,1,1,1,1,3);
INSERT INTO `mob_family_system` VALUES (282,'Grav_iton',7,'Beastmen',1,10,40,91,140,3,1,3,2,1,5,4,3,3,3,2,1,1,1,1,1,1.25,1,1,1,1,0.5,1,7);
INSERT INTO `mob_family_system` VALUES (284,'Vampyr',19,'Undead',3,10,40,100,120,1,3,3,4,3,6,6,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,8);
INSERT INTO `mob_family_system` VALUES (285,'MamoolJa',7,'Beastmen',4,10,40,112,120,2,1,3,3,4,4,3,3,3,3,3,1,1,1,1,1,1.125,0.875,1,1,1,0.875,1,3);
INSERT INTO `mob_family_system` VALUES (286,'Vulpangue',10,'Dragon',1,10,40,100,90,6,4,3,3,6,6,5,3,2,3,3,3,1.25,1,1,1,1.125,1,0,1,1,1,1,3);
INSERT INTO `mob_family_system` VALUES (287,'Chamrosh',8,'Bird',3,10,60,80,140,4,4,5,5,1,3,4,3,3,3,3,1,1.25,1,1,0.875,1,0.5,0.875,0.875,0.875,1,0.875,3);
INSERT INTO `mob_family_system` VALUES (288,'CheeseHoarder',7,'Beastmen',2,10,40,90,140,4,1,4,1,1,4,4,3,3,3,3,1,1,1,1,1,1,1.125,1,1,1,1,1,4);
INSERT INTO `mob_family_system` VALUES (289,'BrassBorer',20,'Vermin',2,10,40,90,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,0.875,1.125,1,1,1,1,1,1,1);
INSERT INTO `mob_family_system` VALUES (290,'Claret',1,'Amorph',2,10,40,100,120,1,3,3,4,3,6,6,3,3,3,3,0.25,0.25,0.125,0.125,1.562,1.25,1.25,1.25,1.25,0.625,1.25,1.25,6);
INSERT INTO `mob_family_system` VALUES (291,'Ob',18,'Unclassified',1,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (292,'Velionis',19,'Undead',1,10,40,90,140,1,3,4,3,1,5,4,3,3,3,3,0.875,0.5,1.125,1.25,1.125,0.875,1,1,1,1,1.125,0.5,8);
INSERT INTO `mob_family_system` VALUES (293,'Chigre',20,'Vermin',2,10,40,120,90,6,6,1,6,6,4,5,3,3,3,3,1,1,1,1,1.125,1.125,1,1,1,1,1,1,4);
INSERT INTO `mob_family_system` VALUES (294,'LilApkallu',8,'Bird',1,10,40,120,90,3,2,1,6,6,4,5,3,3,3,3,1,1,1,1,1,1,1,1.125,0.875,0.5,1,1,6);
INSERT INTO `mob_family_system` VALUES (295,'IrizIma',6,'Beast',3,10,40,90,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,1,1.125,1,1,1,1,1,1,4);
INSERT INTO `mob_family_system` VALUES (296,'LividrootAmoo',17,'Plantoid',1,10,40,120,100,1,2,1,3,5,4,4,3,3,3,3,1,1,1,1,1.25,1,1,1,1,0.5,1,1,4);
INSERT INTO `mob_family_system` VALUES (297,'IririSamariri',7,'Beastmen',1,10,40,70,140,6,3,6,3,1,5,4,3,3,3,3,1,1,1,1,1,1.125,1,1,1.125,0.5,0.5,1,6);
INSERT INTO `mob_family_system` VALUES (298,'Anantaboga',10,'Dragon',3,10,40,120,90,1,3,1,3,6,3,1,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,8);
INSERT INTO `mob_family_system` VALUES (299,'Dextrose',1,'Amorph',1,10,40,70,140,6,3,6,3,1,5,4,3,3,3,3,0.875,1,0.75,0.75,1.25,1.25,1.25,1.125,1.125,1.125,1.125,1.125,6);
INSERT INTO `mob_family_system` VALUES (300,'Reacton',3,'Arcana',2,10,40,70,140,6,3,6,3,1,5,4,3,3,3,3,1,1,1,1,1.25,0.5,0.5,0.5,0.5,0.5,0.5,0.5,1);
INSERT INTO `mob_family_system` VALUES (301,'Verdelet',9,'Demon',1,10,70,65,140,6,3,3,3,1,5,4,3,3,3,3,1,1.25,1,1,1.125,1,1,1,1,1,1.125,0.875,8);
INSERT INTO `mob_family_system` VALUES (302,'Wulgaru',3,'Arcana',2,10,40,90,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (303,'ZareehklTheJu',19,'Undead',1,10,40,100,140,1,3,3,3,1,5,4,3,3,3,3,2,2,2,2,2.25,1.75,2,2,2,2,2.25,1,8);
INSERT INTO `mob_family_system` VALUES (304,'ArmedGears',4,'ArchaicMachine',1,10,40,90,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,1,1.125,1,1,0.875,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (305,'GotohZhaTheRe',7,'Beastmen',2,10,40,100,120,2,1,3,3,3,3,3,3,3,3,3,1,1,1,1,1,1.125,0.875,1,1,1,0.875,1,3);
INSERT INTO `mob_family_system` VALUES (306,'Dea',14,'Lizard',4,10,40,120,90,2,5,1,6,6,3,3,3,3,3,3,1,1,1,1,1,1.125,1.125,1,1,1,1,1,4);
INSERT INTO `mob_family_system` VALUES (307,'Achamoth',20,'Vermin',2,10,40,90,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,0.5,1.125,1,1,1,1,1,1,1);
INSERT INTO `mob_family_system` VALUES (308,'Khromasoul',7,'Beastmen',2,10,40,120,120,1,2,1,3,3,3,3,3,3,3,3,1,1,1,1,0.875,1,1,1,1,1.125,1,1,1);
INSERT INTO `mob_family_system` VALUES (309,'Nosferatu',19,'Undead',2,10,40,100,120,1,3,3,4,3,6,6,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,8);
INSERT INTO `mob_family_system` VALUES (310,'ExperimentalLa',7,'Beastmen',1,10,40,100,140,3,3,3,1,1,2,2,3,3,3,3,1,1,1,1,1,1.125,1,1,1.125,0.875,1,1,8);
INSERT INTO `mob_family_system` VALUES (311,'MahjlaefThePai',9,'Demon',1,10,40,100,140,6,3,3,3,1,5,4,3,3,3,3,1,1,1,1,0.875,0.875,1,1,1.125,1,1.125,0.5,6);
INSERT INTO `mob_family_system` VALUES (312,'Nuhn',2,'Aquan',4,10,40,90,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,1,1,1,1,1.125,0.875,1,1,6);
INSERT INTO `mob_family_system` VALUES (313,'Tinnin',10,'Dragon',5,10,40,90,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,0.875,1,1,1,1,1,1,1,1,6);
INSERT INTO `mob_family_system` VALUES (314,'Sarameya',6,'Beast',4,10,40,90,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,1);
INSERT INTO `mob_family_system` VALUES (315,'Tyger',3,'Arcana',5,10,40,90,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,1,1.125,1,1.125,1,1,1,1,5);
INSERT INTO `mob_family_system` VALUES (316,'Pandemonium',9,'Demon',3,10,40,100,140,6,3,3,3,1,5,4,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,0.875,0);
INSERT INTO `mob_family_system` VALUES (319,'Avatar-Shiva',5,'Avatar',1,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,1,0.875,0.875,0.875,0.875,0.875,0.875,0.875,0);
INSERT INTO `mob_family_system` VALUES (320,'Avatar-Ramuh',5,'Avatar',1,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,0.875,0.875,0.875,1,0.875,0.875,0.875,0.875,0);
INSERT INTO `mob_family_system` VALUES (321,'Avatar-Titan',5,'Avatar',1,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,0.875,0.875,1,0.875,0.875,0.875,0.875,0.875,0);
INSERT INTO `mob_family_system` VALUES (322,'Avatar-Ifrit',5,'Avatar',1,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,0.875,0.875,0.875,0.875,0.875,1,0.875,0.875,0);
INSERT INTO `mob_family_system` VALUES (323,'Avatar-Leviathan',5,'Avatar',1,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,0.875,0.875,0.875,0.875,1,0.875,0.875,0.875,0);
INSERT INTO `mob_family_system` VALUES (324,'Avatar-Garuda',5,'Avatar',1,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,0.875,1,0.875,0.875,0.875,0.875,0.875,0.875,0);
INSERT INTO `mob_family_system` VALUES (325,'Avatar-Fenrir',5,'Avatar',1,10,40,100,120,3,3,3,3,3,3,3,3,3,3,3,1,1,1,1,0.875,0.875,0.875,0.875,0.875,0.875,1,0.875,0);
INSERT INTO `mob_family_system` VALUES (326,'TrollGurfurlur',7,'Beastmen',2,10,40,120,120,1,2,1,3,3,3,3,3,3,3,3,1,1,1,1,0.875,1,1,1,1,1.125,1,1,1);
INSERT INTO `mob_family_system` VALUES (327,'Goblin',7,'Beastmen',0,10,40,91,120,2,3,4,3,3,3,1,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1.25,1,1);
INSERT INTO `mob_family_system` VALUES (328,'Gigas',7,'Beastmen',1,10,40,125,100,1,2,2,2,5,4,5,3,3,3,3,1,1,1,1,1,0.875,1,1.125,0.5,1,1,1,2);
INSERT INTO `mob_family_system` VALUES (329,'AbsoluteVirtue', 15, 'Luminian', 0, 10, 40, 120, 140, 1, 1, 1, 1, 1, 1, 1, 3, 3, 3, 3, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0.5, 1, 0);
INSERT INTO `mob_family_system` VALUES (330,'PetGenbu',14,'Lizard',5,10,30,120,90,2,5,1,6,6,4,3,3,3,3,3,1,1,1,1,1,1.25,1,0.875,1.125,0.875,1,1,4);
INSERT INTO `mob_family_system` VALUES (331,'PetSeiryu',10,'Dragon',3,10,60,109,90,1,2,1,3,6,3,3,3,3,3,3,1,1,1,1,0.5,1,0.875,1,1,1,1.25,0.375,7);
INSERT INTO `mob_family_system` VALUES (332,'PetByakko',6,'Beast',3,10,60,111,120,1,1,4,2,3,6,5,3,3,3,3,1,1,1,1,1.25,0.875,1,1,1.25,1,1,1,5);
INSERT INTO `mob_family_system` VALUES (333,'PetSuzaku',8,'Bird',3,10,60,130,120,1,3,4,3,4,4,5,3,3,3,2,0.75,1.25,1,0.75,1,1.25,0.5,1,1,1,1,1,7);
INSERT INTO `mob_family_system` VALUES (334,'Orc',7,'Beastmen',1,10,40,108,100,1,3,3,6,4,5,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1.25,1,1,1);
INSERT INTO `mob_family_system` VALUES (335,'Maat',13,'Humanoid',0,10,40,90,110,3,3,2,3,2,2,3,3,3,3,3,1,1,1,1,1,1,1,1,1,1,1,1,0);
INSERT INTO `mob_family_system` VALUES (336,'ZM4-Tonberry',7,'Beastmen',1,10,40,91,140,3,1,3,2,1,5,4,3,3,3,2,1,1,1,1,1,1.25,1,1,1,1,0.5,1,7);
INSERT INTO `mob_family_system` VALUES (337,'Quadav',7,'Beastmen',0,10,40,120,110,2,3,2,5,4,5,3,3,2,3,3,1,1.25,1,1,1.125,1,1,1,1,1,1.125,0.875,6);
INSERT INTO `mob_family_system` VALUES (338,'Twitherym',20,'Vermin',0,10,40,92,90,1,3,4,3,6,6,5,3,3,3,3,1,1.25,1,1,1,1.25,0.875,1,1,1,1,1,3);
INSERT INTO `mob_family_system` VALUES (339,'Chapuli',20,'Vermin',1,10,40,105,120,3,3,4,3,3,6,5,3,5,3,3,1,1,1,1,1,1.25,1,1,1.25,1,1.125,1.25,4);
INSERT INTO `mob_family_system` VALUES (340,'Mantis',20,'Vermin',1,1,40,105,120,3,3,4,3,3,6,5,3,5,3,3,1,1,1,1,1,1.25,1,1,1.25,1,1.125,1.25,4);
INSERT INTO `mob_family_system` VALUES (341,'Blossom',1,'Amorph',0,10,0,130,180,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,1,1,1.25,0.875,1,1,1.25,0.875,4);
INSERT INTO `mob_family_system` VALUES (342,'Velkk',7,'Beastmen',0,10,40,116,140,1,3,1,2,2,3,3,3,3,3,3,1,1,1,1,1,1,1.25,0.5,1,1,1,0.5,8);
INSERT INTO `mob_family_system` VALUES (343,'Heartwing',3,'Arcana',0,10,40,90,90,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,1,1,1,1,1.25,1,1,1,5);
INSERT INTO `mob_family_system` VALUES (344,'Cracklaw',2,'Aquan',0,10,40,108,120,4,3,1,5,3,3,4,3,3,3,3,0.9,0.9,0.9,0.9,0.875,1,0.875,0.875,1,0.75,0.875,0.875,6);
INSERT INTO `mob_family_system` VALUES (345,'Bloated_Acuex',1,'Amorph',1,10,40,100,120,1,3,3,4,3,6,1,3,3,3,3,0.5,0.5,0.25,0.25,1.5,1.5,1.5,1.5,1.5,0.75,1.5,1.5,6);
INSERT INTO `mob_family_system` VALUES (346,'Knotted_Root',1,'Amorph',0,0,0,70,200,4,3,6,4,3,4,4,3,3,3,3,1,1,1,1,1,1,1.25,0.875,1,1,1.25,0.875,4);
INSERT INTO `mob_family_system` VALUES (347,'Golem',3,'Asperous_Marolith',1,10,40,130,130,2,3,3,3,3,6,5,3,3,3,3,1,1,1,1,1,1,1,1,1.125,1,1,1,7);
INSERT INTO `mob_family_system` VALUES (348,'Matamata',14,'Lizard',3,10,30,120,90,2,5,1,6,6,4,3,3,3,3,4,1,1,1,1,1,1.25,1,0.875,1.125,0.875,1,1,4);
INSERT INTO `mob_family_system` VALUES (349,'Geyser',1,'Amorph',0,10,0,130,180,1,3,4,3,6,6,5,3,3,3,3,1,1,1,1,1,1,1.25,0.875,1,1,1.25,0.875,4);
INSERT INTO `mob_family_system` VALUES (350,'Iron_Giant',3,'Arcana',1,10,40,130,130,2,3,3,3,3,6,5,3,3,3,3,1,1,1,1,1,1,1,1,1.125,1,1,1,7);

/*!40000 ALTER TABLE `mob_family_system` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-02-14 20:02:03