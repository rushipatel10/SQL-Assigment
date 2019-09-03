-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Sep 02, 2019 at 12:05 PM
-- Server version: 5.5.43-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `country_club`
--

-- --------------------------------------------------------

--
-- Table structure for table `Facilities`
--

CREATE TABLE IF NOT EXISTS `Facilities` (
  `facid` int(1) NOT NULL DEFAULT '0',
  `name` varchar(15) DEFAULT NULL,
  `membercost` decimal(2,1) DEFAULT NULL,
  `guestcost` decimal(3,1) DEFAULT NULL,
  `initialoutlay` int(5) DEFAULT NULL,
  `monthlymaintenance` int(4) DEFAULT NULL,
  PRIMARY KEY (`facid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Facilities`
--

INSERT INTO `Facilities` (`facid`, `name`, `membercost`, `guestcost`, `initialoutlay`, `monthlymaintenance`) VALUES
(2, 'Badminton Court', 0.0, 15.5, 4000, 50),
(3, 'Table Tennis', 0.0, 5.0, 320, 10),
(7, 'Snooker Table', 0.0, 5.0, 450, 15),
(8, 'Pool Table', 0.0, 5.0, 400, 15);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
