-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 24. Jun 2017 um 14:22
-- Server-Version: 10.1.21-MariaDB
-- PHP-Version: 5.6.30

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
(3, 'test', 'max65'),
(4, 'Test Project', 'Test from Stefan');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `projectmembers`
--

CREATE TABLE `projectmembers` (
  `id` int(11) NOT NULL,
  `username` varchar(30) COLLATE utf8_bin NOT NULL,
  `project_id` int(11) NOT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Daten für Tabelle `projectmembers`
--

INSERT INTO `projectmembers` (`id`, `username`, `project_id`, `admin`) VALUES
(34, 'max1', 3, 0),
(35, 'admin', 3, 0),
(36, 'max', 3, 0),
(37, 'admin2', 3, 0),
(38, 'oliver', 3, 0),
(39, 'admin2', 2, 0);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `task`
--

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
(13, 'test', 'test', 4),
(15, 'test2', 'test2', 4),
(16, 'aetaet', 'aetaet', 4),
(17, 'teatewtat', 'test3235', 4),
(18, 'afe', 'aef', 4),
(19, 'afef', 'afef', 4),
(20, 'aefa', 'aef', 4),
(21, 'test', 'test', 3);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `time`
--

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
(5, 1, '2017-06-21 16:11:34', '2017-06-21 16:13:09'),
(6, 1, '2017-06-19 14:15:31', '2017-06-19 14:16:39'),
(8, 1, '2017-06-19 14:11:43', '2017-06-19 14:15:26'),
(12, 1, '2017-06-19 14:10:58', '2017-06-19 14:11:26'),
(12, 1, '2017-06-19 14:16:42', '2017-06-19 14:16:46'),
(13, 1, '2017-06-21 16:18:32', '2017-06-21 16:18:34'),
(13, 1, '2017-06-21 16:18:37', '2017-06-21 16:18:40'),
(18, 1, '2017-06-24 12:19:22', '2017-06-24 12:19:29');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
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

INSERT INTO `user` (`id`, `username`, `password`, `type`, `company`, `email`, `firstname`, `lastname`, `address`, `city`, `country`, `zip`, `aboutme`) VALUES
(1, 'max1', 'admin', 'admin', '', '', '', '', '', '', '', '', ''),
(2, 'admin', 'admin', 'admin', '', '', '', '', '', '', '', '', ''),
(3, 'max', 'max', 'user', 'jks', 'jkldj@gmx.at', 'jj', 'jij', 'joij', 'jio', 'jlkj', '', 'jiojjjjoijoji'),
(4, 'admin2', 'admin', 'USER', 'ds', 'sd@gmal.at', 'dsd', 'sds', 'dsds', 'vdv', 'dfd', 'fdfd', '\'\'\'\'dffdf'),
(5, 'oliver', 'oliver', 'ADMIN', 'jku', 'oo@gmx.at', 'oliver', 'obern', 'natternbach', 'linz', 'at', '4040', 'wappla');

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
-- Indizes für die Tabelle `projectmembers`
--
ALTER TABLE `projectmembers`
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

--
-- Indizes für die Tabelle `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `projectmembers`
--
ALTER TABLE `projectmembers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;
--
-- AUTO_INCREMENT für Tabelle `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
