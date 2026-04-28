-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mer. 11 mars 2026 à 07:33
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `joao_aebi_deva1a_app`
--
CREATE DATABASE IF NOT EXISTS `joao_aebi_deva1a_app` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `joao_aebi_deva1a_app`;

-- --------------------------------------------------------

--
-- Structure de la table `t_files`
--

CREATE TABLE IF NOT EXISTS `t_files` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `file_size` int(11) NOT NULL,
  `mime_type` varchar(100) DEFAULT NULL,
  `storage_path` text NOT NULL,
  `folder_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `t_folders`
--

CREATE TABLE IF NOT EXISTS `t_folders` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `t_shares`
--

CREATE TABLE IF NOT EXISTS `t_shares` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `file_id` int(11) DEFAULT NULL,
  `shared_with_user_id` int(11) DEFAULT NULL,
  `permission_level` varchar(20) DEFAULT 'view',
  `expires_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `t_users`
--

CREATE TABLE IF NOT EXISTS `t_users` (
  `nick_name` varchar(30) NOT NULL,
  `email` varchar(40) NOT NULL,
  `telephone_number` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `t_users_chat`
--

CREATE TABLE IF NOT EXISTS `t_users_chat` (
  `id_users_chat` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_users_chat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `t_users_logs`
--

CREATE TABLE IF NOT EXISTS `t_users_logs` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` text NOT NULL,
  `storage_quota_gb` int(11) DEFAULT 5,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
