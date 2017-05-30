-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 30. Mai 2017 um 23:14
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
(1, 'Organisation', 'alles Organisatorisches (Projekt-Management)', 1),
(2, 'Analyse', 'Analyse von neue Aufgaben / Features; Aufwandschätzung', 1),
(3, 'Implementierung', 'Umsetzung der Aufgabe / Features', 1),
(4, 'Testen', 'Test der Aufgabe / Features', 1),
(5, 'Dokumentieren', 'Dokumenterien der Aufgabe / Features / Programme', 1),
(6, 'Bugfix', 'Fehlerbehebung der Aufgabe / Features', 1),
(7, 'Support', 'Support für Aufgabe / Features', 1),
(8, 'Schulung/Workshop', 'Schulen der Aufgabe / Features / Programme', 1),
(9, 'Weiterbildung', 'Weiterbildung für die Umsetzung der Aufgabe / Features', 1);

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
