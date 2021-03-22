-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 28, 2021 at 11:29 AM
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
(7, '11', 'กาแฟ Moccona', '/TakFood/Food/food870472.jpg', '135', 'กาแฟ หอมชื่นใจ ผมชอบมาก สนุกสนานาสหกดฟหกดฟหกดฟดฟหกดฟหกดฟหกดฟหกดฟหกดฟกด'),
(8, '11', 'ห้องคอม', '/TakFood/Food/food115739.jpg', '100', '1 ชม.'),
(9, '3', 'ขนมจีน', '/TakFood/Food/food525234.jpg', '89', 'บุฟเฟ'),
(10, '3', 'ขนมจีน (2)', '/TakFood/Food/food862010.jpg', '89', 'บุฟเฟ');

-- --------------------------------------------------------

--
-- Table structure for table `ordertable`
--

CREATE TABLE `ordertable` (
  `id` int(11) NOT NULL,
  `OrderDateTime` text COLLATE utf8_unicode_ci NOT NULL,
  `idUser` text COLLATE utf8_unicode_ci NOT NULL,
  `NameUser` text COLLATE utf8_unicode_ci NOT NULL,
  `idShop` text COLLATE utf8_unicode_ci NOT NULL,
  `NameShop` text COLLATE utf8_unicode_ci NOT NULL,
  `Distance` text COLLATE utf8_unicode_ci NOT NULL,
  `Transport` text COLLATE utf8_unicode_ci NOT NULL,
  `idFood` text COLLATE utf8_unicode_ci NOT NULL,
  `NameFood` text COLLATE utf8_unicode_ci NOT NULL,
  `Price` text COLLATE utf8_unicode_ci NOT NULL,
  `Amount` text COLLATE utf8_unicode_ci NOT NULL,
  `Sum` text COLLATE utf8_unicode_ci NOT NULL,
  `idRider` text COLLATE utf8_unicode_ci NOT NULL,
  `Status` text COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `ordertable`
--

INSERT INTO `ordertable` (`id`, `OrderDateTime`, `idUser`, `NameUser`, `idShop`, `NameShop`, `Distance`, `Transport`, `idFood`, `NameFood`, `Price`, `Amount`, `Sum`, `idRider`, `Status`) VALUES
(1, '2021-01-18 17:43:36', '1', '', '11', 'ทดสอบ ร้านค้า 2', '25.67', '285', '[1]', '[หน้าจอคอม]', '[15]', '[1]', '[15]', 'none', 'UserOrder'),
(3, '2021-01-18 17:56:29', '1', '', '11', 'ทดสอบ ร้านค้า 2', '25.67', '285', '[2]', '[หูฟัง omthing]', '[699]', '[1]', '[699]', 'none', 'UserOrder'),
(5, '2021-01-18 17:59:31', '1', 'ผู้ซื้อ', '11', 'ทดสอบ ร้านค้า 2', '25.67', '285', '[7]', '[กาแฟ Moccona]', '[135]', '[1]', '[135]', 'none', 'UserOrder'),
(6, '2021-01-21 14:01:35', '15', 'ผู้ซื้อ คนที่2', '11', 'ทดสอบ ร้านค้า 2', '25.67', '285', '[1, 2, 7]', '[หน้าจอคอม, หูฟัง omthing, กาแฟ Moccona]', '[15, 699, 135]', '[2, 1, 1]', '[30, 699, 135]', 'none', 'UserOrder'),
(7, '2021-01-25 11:16:49', '15', 'ผู้ซื้อ คนที่2', '3', 'Tak Shop', '0.0', '35', '[9, 10]', '[ขนมจีน, ขนมจีน (2)]', '[89, 89]', '[1, 2]', '[89, 178]', 'none', 'UserOrder');

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
(1, 'User', 'ผู้ซื้อ', 'User', '1234', '', '', '', '', '', '', 'cHn5B6-xQX-_Oxa2obdJes:APA91bFizwrYeHYh3yobwn8n8mBvLBYI3uP8O_Fw3Sq-ctDZ-0WcVMHipUpAdLcaLNPDKZJUBUAq9cCWXrUuhZqs1V0i5vMgzmw3LIOl98bo5-sA_DDYmrGKe3FU9uqZmUJ_NLJdnolv'),
(3, 'Shop', 'ผู้ขาย', 'Shop', '1234', 'Tak Shop', 'Pattaya Memorial', '0641693959', '/TakFood/Shop/shop699770.jpg', '12.9352956', '100.8864828', 'cHn5B6-xQX-_Oxa2obdJes:APA91bFizwrYeHYh3yobwn8n8mBvLBYI3uP8O_Fw3Sq-ctDZ-0WcVMHipUpAdLcaLNPDKZJUBUAq9cCWXrUuhZqs1V0i5vMgzmw3LIOl98bo5-sA_DDYmrGKe3FU9uqZmUJ_NLJdnolv'),
(5, 'Rider', 'ผู้ส่ง', 'Rider', '1234', '', '', '', '', '', '', 'f37alRLmQfi_Rcak4Uw0rQ:APA91bGgZm8bxPywu-Q5WB1KogVDuOq1yf7esX2n5_V8YiUvQi5QyaEfiDT6yVyPBWI9stIaeYG4V20mF5f8LFXeYLli_up1wXa3vUCVguvAxmsneOu85gzCiBD7qL8EcQzLiZn-Y1Dh'),
(10, 'Shop', 'ชัยยันต์', 'shop1', '1234', 'test shop', '97/11 หมู่7 หมู่บ้านธาราริน\r\nต.สุรศักดิ์ อ.ศรีราชา\r\nจ.ชลบุรี 20110', '0923567788', '/TakFood/Shop/shop286015.jpg', '13.1540133', '100.9620831', 'f37alRLmQfi_Rcak4Uw0rQ:APA91bGgZm8bxPywu-Q5WB1KogVDuOq1yf7esX2n5_V8YiUvQi5QyaEfiDT6yVyPBWI9stIaeYG4V20mF5f8LFXeYLli_up1wXa3vUCVguvAxmsneOu85gzCiBD7qL8EcQzLiZn-Y1Dh'),
(11, 'Shop', 'test shop', 'shop2', '1234', 'ทดสอบ ร้านค้า 2', '200/32 ถนนเจิมจอมพล ต.ศรีราชา อ.ศรีราชา จ.ชลบุรี 20110', '038313609', '/TakFood/Shop/editShop89410.jpg', '13.1540612', '100.9622106', 'cHn5B6-xQX-_Oxa2obdJes:APA91bFizwrYeHYh3yobwn8n8mBvLBYI3uP8O_Fw3Sq-ctDZ-0WcVMHipUpAdLcaLNPDKZJUBUAq9cCWXrUuhZqs1V0i5vMgzmw3LIOl98bo5-sA_DDYmrGKe3FU9uqZmUJ_NLJdnolv'),
(15, 'User', 'ผู้ซื้อ คนที่2', 'User2', '1234', '', '', '', '', '', '', 'cHn5B6-xQX-_Oxa2obdJes:APA91bFizwrYeHYh3yobwn8n8mBvLBYI3uP8O_Fw3Sq-ctDZ-0WcVMHipUpAdLcaLNPDKZJUBUAq9cCWXrUuhZqs1V0i5vMgzmw3LIOl98bo5-sA_DDYmrGKe3FU9uqZmUJ_NLJdnolv');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `foodtable`
--
ALTER TABLE `foodtable`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ordertable`
--
ALTER TABLE `ordertable`
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `ordertable`
--
ALTER TABLE `ordertable`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `usertable`
--
ALTER TABLE `usertable`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
