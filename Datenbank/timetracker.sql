-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 20. Jun 2017 um 09:28
-- Server-Version: 10.1.21-MariaDB
-- PHP-Version: 7.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `timetracker`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(200) NOT NULL,
  `project_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `category`
--

INSERT INTO `category` (`id`, `name`, `description`, `project_id`) VALUES
(1, 'testen', 'testenfgdg', 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `project`
--

DROP TABLE IF EXISTS `project`;
CREATE TABLE `project` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `project`
--

INSERT INTO `project` (`id`, `name`, `description`) VALUES
(2, 'projecta', 'vdvdfvcvcv'),
(3, 'test', 'max65');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `task`
--

DROP TABLE IF EXISTS `task`;
CREATE TABLE `task` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `description` varchar(200) NOT NULL,
  `project_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `task`
--

INSERT INTO `task` (`id`, `name`, `description`, `project_id`) VALUES
(2, 'dfd', 'fdf', 2),
(3, 'fdgfdgfdgf', 'gfg', 2),
(4, 'fdfd', 'tere', 2),
(5, 'vvc', 'vcv', 2),
(6, 'fdfd', 'gfgf', 3),
(7, 'fdsdfd', 'trtrt', 2),
(8, 'msad', 'max', 2),
(9, 'oo', 'oo', 2),
(10, 'ghghg', 'oujik', 2),
(11, 'hghg', 'gfgf', 3),
(12, 'gfdg', 'bgfh', 2);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `time`
--

DROP TABLE IF EXISTS `time`;
CREATE TABLE `time` (
  `task_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `start` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `end` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `time`
--

INSERT INTO `time` (`task_id`, `user_id`, `start`, `end`) VALUES
(3, 1, '2017-06-19 14:16:28', '2017-06-19 14:16:34'),
(6, 1, '2017-06-19 14:15:31', '2017-06-19 14:16:39'),
(8, 1, '2017-06-19 14:11:43', '2017-06-19 14:15:26'),
(12, 1, '2017-06-19 14:10:58', '2017-06-19 14:11:26'),
(12, 1, '2017-06-19 14:16:42', '2017-06-19 14:16:46');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `username` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  `type` varchar(20) NOT NULL,
  `company` varchar(30) NOT NULL,
  `email` varchar(30) NOT NULL,
  `firstname` varchar(30) NOT NULL,
  `lastname` varchar(30) NOT NULL,
  `address` varchar(50) NOT NULL,
  `city` varchar(30) NOT NULL,
  `country` varchar(30) NOT NULL,
  `zip` varchar(5) NOT NULL,
  `aboutme` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Daten für Tabelle `user`
--

INSERT INTO `user` (`username`, `password`, `type`, `company`, `email`, `firstname`, `lastname`, `address`, `city`, `country`, `zip`, `aboutme`) VALUES
('max1', 'admin', 'admin', '', '', '', '', '', '', '', '', ''),
('admin', 'admin', 'admin', '', '', '', '', '', '', '', '', ''),
('max', 'max', 'user', 'jks', 'jkldj@gmx.at', 'jj', 'jij', 'joij', 'jio', 'jlkj', '', 'jiojjjjoijoji'),
('admin2', 'admin', 'USER', 'ds', 'sd@gmal.at', 'dsd', 'sds', 'dsds', 'vdv', 'dfd', 'fdfd', '\'\'\'\'dffdf'),
('oliver', 'oliver', 'ADMIN', 'jku', 'oo@gmx.at', 'oliver', 'obern', 'natternbach', 'linz', 'at', '4040', 'wappla');

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `project`
--
ALTER TABLE `project`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `task`
--
ALTER TABLE `task`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `time`
--
ALTER TABLE `time`
  ADD PRIMARY KEY (`task_id`,`user_id`,`start`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
