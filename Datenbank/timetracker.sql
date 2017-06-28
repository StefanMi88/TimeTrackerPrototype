-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 28. Jun 2017 um 20:47
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
  `description` text NOT NULL,
  `category` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Daten für Tabelle `project`
--

INSERT INTO `project` (`id`, `name`, `description`, `category`) VALUES
(1, 'TimeTracker Prototype', 'Create a time tracker prototype as Java webapp', 'Development');

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
(40, 'admin', 2, 0),
(41, 'admin2', 2, 0),
(42, 'admin', 1, 0);

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
(1, ' Frontend', 'Develop Frontend', 1),
(2, 'Backend', 'Develop Backend', 1);

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
(1, 2, '2017-06-28 18:41:03', '2017-06-28 18:46:35'),
(2, 2, '2017-06-27 15:00:00', '2017-06-27 19:00:00');

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
(2, 'admin', 'admin', 'admin', 'JKU', 'admin@jku.at', 'Stefan', 'Mitmansgruber', 'Wimmer-Höhe 14', 'Gutau', 'AT', '4293', 'Testadmin!'),
(6, 'JuliaP', 'test', 'USER', 'Sparkasse OÖ', 'julia@test.at', 'Julia', 'Pammer', 'Wimmer-Höhe 14', 'Gutau', 'Österreich', '4293', 'Testuser');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;
--
-- AUTO_INCREMENT für Tabelle `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
