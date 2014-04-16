-- phpMyAdmin SQL Dump
-- version 3.3.8
-- http://www.phpmyadmin.net
--
-- Serveur: localhost
-- G�n�r� le : Ven 24 Juin 2011 � 08:02
-- Version du serveur: 6.0.0
-- Version de PHP: 5.2.9-2

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de donn�es: `dspdb`
--

-- --------------------------------------------------------

--
-- Structure de la table `char_equip`
--

DROP TABLE IF EXISTS `char_equip`;
CREATE TABLE IF NOT EXISTS `char_equip` (
  `charid` int(10) unsigned NOT NULL,
  `main` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `sub` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `ranged` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `ammo` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `head` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `body` tinyint(2) unsigned NOT NULL DEFAULT '1',
  `hands` tinyint(2) unsigned NOT NULL DEFAULT '2',
  `legs` tinyint(2) unsigned NOT NULL DEFAULT '3',
  `feet` tinyint(2) unsigned NOT NULL DEFAULT '4',
  `neck` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `waist` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `ear1` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `ear2` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `ring1` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `ring2` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `back` tinyint(2) unsigned NOT NULL DEFAULT '0',
  `link` tinyint(2) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`charid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=41;