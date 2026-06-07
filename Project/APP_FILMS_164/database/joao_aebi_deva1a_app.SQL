-- OM 2021.02.17
-- FICHIER MYSQL POUR FAIRE FONCTIONNER LES EXEMPLES
-- DE REQUETES MYSQL
-- Database: MACCAUD_OLIVIER_INFO1X_FILMS_164_2023

-- Destruction de la BD si elle existe.
-- Pour être certain d'avoir la dernière version des données

DROP DATABASE IF EXISTS joao_aebi_deva1a_app;

-- Création d'un nouvelle base de donnée

CREATE DATABASE IF NOT EXISTS joao_aebi_deva1a_app;

-- Utilisation de cette base de donnée

USE joao_aebi_deva1a_app;
-- --------------------------------------------------------

-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mer. 25 mars 2026 à 07:25
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

-- --------------------------------------------------------

--
-- Structure de la table `t_files`
--

DROP TABLE IF EXISTS `t_files`;
CREATE TABLE `t_files` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `file_size` int(11) NOT NULL,
  `mime_type` varchar(100) DEFAULT NULL,
  `storage_path` text NOT NULL,
  `folder_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `t_folders`
--

DROP TABLE IF EXISTS `t_folders`;
CREATE TABLE `t_folders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `t_folders`
--

INSERT INTO `t_folders` (`id`, `name`, `parent_id`, `user_id`, `created_at`) VALUES
(1, 'Dossier_1', NULL, 1, '2026-03-11 06:37:25'),
(2, 'Dossier_2', NULL, 2, '2026-03-11 06:37:25'),
(3, 'Dossier_3', NULL, 3, '2026-03-11 06:37:25'),
(4, 'Dossier_4', NULL, 4, '2026-03-11 06:37:25'),
(5, 'Dossier_5', NULL, 5, '2026-03-11 06:37:25'),
(6, 'Dossier_6', NULL, 6, '2026-03-11 06:37:25'),
(7, 'Dossier_7', NULL, 7, '2026-03-11 06:37:25'),
(8, 'Dossier_8', NULL, 8, '2026-03-11 06:37:25'),
(9, 'Dossier_9', NULL, 9, '2026-03-11 06:37:25'),
(10, 'Dossier_10', NULL, 10, '2026-03-11 06:37:25'),
(11, 'Dossier_11', 1, 11, '2026-03-11 06:37:25'),
(12, 'Dossier_12', 2, 12, '2026-03-11 06:37:25'),
(13, 'Dossier_13', 3, 13, '2026-03-11 06:37:25'),
(14, 'Dossier_14', 4, 14, '2026-03-11 06:37:25'),
(15, 'Dossier_15', 5, 15, '2026-03-11 06:37:25'),
(16, 'Dossier_16', 6, 16, '2026-03-11 06:37:25'),
(17, 'Dossier_17', 7, 17, '2026-03-11 06:37:25'),
(18, 'Dossier_18', 8, 18, '2026-03-11 06:37:25'),
(19, 'Dossier_19', 9, 19, '2026-03-11 06:37:25'),
(20, 'Dossier_20', 10, 20, '2026-03-11 06:37:25');

-- --------------------------------------------------------

--
-- Structure de la table `t_shares`
--

DROP TABLE IF EXISTS `t_shares`;
CREATE TABLE `t_shares` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `file_id` int(11) DEFAULT NULL,
  `shared_with_user_id` int(11) DEFAULT NULL,
  `permission_level` varchar(20) DEFAULT 'view',
  `expires_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `t_users`
--

DROP TABLE IF EXISTS `t_users`;
CREATE TABLE `t_users` (
  `nick_name` varchar(30) NOT NULL,
  `email` varchar(40) NOT NULL,
  `telephone_number` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `t_users`
--

INSERT INTO `t_users` (`nick_name`, `email`, `telephone_number`) VALUES
('User1', 'user1@example.com', '+41791234501'),
('User2', 'user2@example.com', '+41791234502'),
('User3', 'user3@example.com', '+41791234503'),
('User4', 'user4@example.com', '+41791234504'),
('User5', 'user5@example.com', '+41791234505'),
('User6', 'user6@example.com', '+41791234506'),
('User7', 'user7@example.com', '+41791234507'),
('User8', 'user8@example.com', '+41791234508'),
('User9', 'user9@example.com', '+41791234509'),
('User10', 'user10@example.com', '+41791234510'),
('User11', 'user11@example.com', '+41791234511'),
('User12', 'user12@example.com', '+41791234512'),
('User13', 'user13@example.com', '+41791234513'),
('User14', 'user14@example.com', '+41791234514'),
('User15', 'user15@example.com', '+41791234515'),
('User16', 'user16@example.com', '+41791234516'),
('User17', 'user17@example.com', '+41791234517'),
('User18', 'user18@example.com', '+41791234518'),
('User19', 'user19@example.com', '+41791234519'),
('User20', 'user20@example.com', '+41791234520');

-- --------------------------------------------------------

--
-- Structure de la table `t_users_chat`
--

DROP TABLE IF EXISTS `t_users_chat`;
CREATE TABLE `t_users_chat` (
  `id_users_chat` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `t_users_chat`
--

INSERT INTO `t_users_chat` (`id_users_chat`) VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12),
(13),
(14),
(15),
(16),
(17),
(18),
(19),
(20);

-- --------------------------------------------------------

--
-- Structure de la table `t_users_logs`
--

DROP TABLE IF EXISTS `t_users_logs`;
CREATE TABLE `t_users_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` text NOT NULL,
  `storage_quota_gb` int(11) DEFAULT 5,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `t_users_logs`
--

INSERT INTO `t_users_logs` (`id`, `username`, `email`, `password_hash`, `storage_quota_gb`, `created_at`) VALUES
(1, 'user_1', 'user1@example.com', '$2y$10$abcdefghijklmnopqrstuvwxyz123456', 5, '2026-03-11 06:37:25'),
(2, 'user_2', 'user2@example.com', '$2y$10$abcdefghijklmnopqrstuvwxyz123456', 5, '2026-03-11 06:37:25'),
(3, 'user_3', 'user3@example.com', '$2y$10$abcdefghijklmnopqrstuvwxyz123456', 5, '2026-03-11 06:37:25'),
(4, 'user_4', 'user4@example.com', '$2y$10$abcdefghijklmnopqrstuvwxyz123456', 5, '2026-03-11 06:37:25'),
(5, 'user_5', 'user5@example.com', '$2y$10$abcdefghijklmnopqrstuvwxyz123456', 5, '2026-03-11 06:37:25'),
(6, 'user_6', 'user6@example.com', '$2y$10$abcdefghijklmnopqrstuvwxyz123456', 5, '2026-03-11 06:37:25'),
(7, 'user_7', 'user7@example.com', '$2y$10$abcdefghijklmnopqrstuvwxyz123456', 5, '2026-03-11 06:37:25'),
(8, 'user_8', 'user8@example.com', '$2y$10$abcdefghijklmnopqrstuvwxyz123456', 5, '2026-03-11 06:37:25'),
(9, 'user_9', 'user9@example.com', '$2y$10$abcdefghijklmnopqrstuvwxyz123456', 5, '2026-03-11 06:37:25'),
(10, 'user_10', 'user10@example.com', '$2y$10$abcdefghijklmnopqrstuvwxyz123456', 5, '2026-03-11 06:37:25'),
(11, 'user_11', 'user11@example.com', '$2y$10$abcdefghijklmnopqrstuvwxyz123456', 5, '2026-03-11 06:37:25'),
(12, 'user_12', 'user12@example.com', '$2y$10$abcdefghijklmnopqrstuvwxyz123456', 5, '2026-03-11 06:37:25'),
(13, 'user_13', 'user13@example.com', '$2y$10$abcdefghijklmnopqrstuvwxyz123456', 5, '2026-03-11 06:37:25'),
(14, 'user_14', 'user14@example.com', '$2y$10$abcdefghijklmnopqrstuvwxyz123456', 5, '2026-03-11 06:37:25'),
(15, 'user_15', 'user15@example.com', '$2y$10$abcdefghijklmnopqrstuvwxyz123456', 5, '2026-03-11 06:37:25'),
(16, 'user_16', 'user16@example.com', '$2y$10$abcdefghijklmnopqrstuvwxyz123456', 5, '2026-03-11 06:37:25'),
(17, 'user_17', 'user17@example.com', '$2y$10$abcdefghijklmnopqrstuvwxyz123456', 5, '2026-03-11 06:37:25'),
(18, 'user_18', 'user18@example.com', '$2y$10$abcdefghijklmnopqrstuvwxyz123456', 5, '2026-03-11 06:37:25'),
(19, 'user_19', 'user19@example.com', '$2y$10$abcdefghijklmnopqrstuvwxyz123456', 5, '2026-03-11 06:37:25'),
(20, 'user_20', 'user20@example.com', '$2y$10$abcdefghijklmnopqrstuvwxyz123456', 5, '2026-03-11 06:37:25');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `t_files`
--
ALTER TABLE `t_files`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `t_folders`
--
ALTER TABLE `t_folders`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `t_shares`
--
ALTER TABLE `t_shares`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `t_users_chat`
--
ALTER TABLE `t_users_chat`
  ADD PRIMARY KEY (`id_users_chat`);

--
-- Index pour la table `t_users_logs`
--
ALTER TABLE `t_users_logs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `t_files`
--
ALTER TABLE `t_files`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `t_folders`
--
ALTER TABLE `t_folders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT pour la table `t_shares`
--
ALTER TABLE `t_shares`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `t_users_chat`
--
ALTER TABLE `t_users_chat`
  MODIFY `id_users_chat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT pour la table `t_users_logs`
--
ALTER TABLE `t_users_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
