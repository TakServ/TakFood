-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 24, 2020 at 08:54 AM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `takfood`
--

-- --------------------------------------------------------

--
-- Table structure for table `foodtable`
--

CREATE TABLE `foodtable` (
  `id` int(11) NOT NULL,
  `idShop` text COLLATE utf8_unicode_ci NOT NULL,
  `NameFood` text COLLATE utf8_unicode_ci NOT NULL,
  `PathImage` text COLLATE utf8_unicode_ci NOT NULL,
  `Price` text COLLATE utf8_unicode_ci NOT NULL,
  `Detail` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `foodtable`
--

INSERT INTO `foodtable` (`id`, `idShop`, `NameFood`, `PathImage`, `Price`, `Detail`) VALUES
(1, '11', 'หน้าจอคอม', '/TakFood/Food/food411909.jpg', '15', 'อาหาร หน้าจอคอมพืวเตอร์'),
(2, '11', 'หูฟัง omthing', '/TakFood/Food/food502562.jpg', '699', 'ฟังดีเยี่ยม  ราคาถูกคุ้มค่า'),
(7, '11', 'กาแฟ Moccona', '/TakFood/Food/food870472.jpg', '135', 'กาแฟ หอมชื่นใจ ผมชอบมาก'),
(8, '11', 'ห้องคอม', '/TakFood/Food/food115739.jpg', '100', '1 ชม.');

-- --------------------------------------------------------

--
-- Table structure for table `usertable`
--

CREATE TABLE `usertable` (
  `id` int(11) NOT NULL,
  `ChooseType` text COLLATE utf8_unicode_ci NOT NULL,
  `Name` text COLLATE utf8_unicode_ci NOT NULL,
  `User` text COLLATE utf8_unicode_ci NOT NULL,
  `Password` text COLLATE utf8_unicode_ci NOT NULL,
  `NameShop` text COLLATE utf8_unicode_ci NOT NULL,
  `Address` text COLLATE utf8_unicode_ci NOT NULL,
  `Phone` text COLLATE utf8_unicode_ci NOT NULL,
  `UrlPicture` text COLLATE utf8_unicode_ci NOT NULL,
  `Lat` text COLLATE utf8_unicode_ci NOT NULL,
  `Lng` text COLLATE utf8_unicode_ci NOT NULL,
  `Token` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `usertable`
--

INSERT INTO `usertable` (`id`, `ChooseType`, `Name`, `User`, `Password`, `NameShop`, `Address`, `Phone`, `UrlPicture`, `Lat`, `Lng`, `Token`) VALUES
(1, 'User', 'ผู้ซื้อ', 'User', '1234', '', '', '', '', '', '', ''),
(3, 'Shop', 'ผู้ขาย', 'Shop', '1234', 'Tak Shop', 'Pattaya Memorial', '0641693959', '/TakFood/Shop/shop699770.jpg', '12.9352956', '100.8864828', ''),
(5, 'Rider', 'ผู้ส่ง', 'Rider', '1234', '', '', '', '', '', '', ''),
(10, 'Shop', 'ชัยยันต์', 'shop1', '1234', 'test shop', '97/11 หมู่7 หมู่บ้านธาราริน\r\nต.สุรศักดิ์ อ.ศรีราชา\r\nจ.ชลบุรี 20110', '0923567788', '/TakFood/Shop/shop286015.jpg', '13.1540133', '100.9620831', ''),
(11, 'Shop', 'test shop', 'shop2', '1234', 'ทดสอบ ร้านค้า 2', '200/32 ถนนเจิมจอมพล ต.ศรีราชา อ.ศรีราชา จ.ชลบุรี 20110', '038313609', '/TakFood/Shop/editShop89410.jpg', '13.1540612', '100.9622106', '');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `foodtable`
--
ALTER TABLE `foodtable`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `usertable`
--
ALTER TABLE `usertable`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `foodtable`
--
ALTER TABLE `foodtable`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `usertable`
--
ALTER TABLE `usertable`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
