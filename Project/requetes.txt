============================================================
  REQUÊTES SQL DU PROJET
  Base de données : joao_aebi_deva1a_app
  Tables : t_folders, t_files, t_shares, t_users, t_users_chat, t_users_logs
============================================================

------------------------------------------------------------
  TABLE : t_folders (DOSSIERS)
------------------------------------------------------------

-- 1. Afficher tous les dossiers (ordre ASC)
SELECT id, id AS id_genre, name AS intitule_genre, created_at AS date_ins_genre
FROM t_folders ORDER BY id ASC;

-- 2. Afficher tous les dossiers (ordre DESC)
SELECT id, id AS id_genre, name AS intitule_genre, created_at AS date_ins_genre
FROM t_folders ORDER BY id DESC;

-- 3. Afficher un dossier par son ID
SELECT id, id AS id_genre, name AS intitule_genre, created_at AS date_ins_genre
FROM t_folders WHERE id = %(value_id_genre_selected)s;

-- 4. Afficher un dossier (pour UPDATE/DELETE)
SELECT id AS id_genre, name AS intitule_genre, created_at AS date_ins_genre
FROM t_folders WHERE id = %(value_id_genre)s;

-- 5. Afficher tous les dossiers (pour liste déroulante)
SELECT id AS id_genre, name AS intitule_genre FROM t_folders ORDER BY id ASC;

-- 6. Ajouter un nouveau dossier
INSERT INTO t_folders (id, name) VALUES (NULL, %(value_intitule_genre)s);

-- 7. Modifier un dossier
UPDATE t_folders
SET name = %(value_name_genre)s, created_at = %(value_date_genre_essai)s
WHERE id = %(value_id_genre)s;

-- 8. Supprimer un dossier (détacher d'abord les fichiers)
UPDATE t_files SET folder_id = NULL WHERE folder_id = %(value_id_genre)s;
DELETE FROM t_folders WHERE id = %(value_id_genre)s;


------------------------------------------------------------
  TABLE : t_files (FICHIERS)
------------------------------------------------------------

-- 9. Afficher tous les fichiers avec leur dossier associé
SELECT t_files.id AS id_film, t_files.name AS nom_film,
       t_files.file_size AS duree_film, t_files.storage_path AS description_film,
       t_files.created_at AS date_sortie_film, '' AS cover_link_film,
       GROUP_CONCAT(t_folders.name) AS GenresFilms
FROM t_files
LEFT JOIN t_folders ON t_files.folder_id = t_folders.id
GROUP BY t_files.id;

-- 10. Afficher un fichier par son ID
SELECT t_files.id AS id_film, t_files.name AS nom_film,
       t_files.file_size AS duree_film, t_files.storage_path AS description_film,
       t_files.created_at AS date_sortie_film, '' AS cover_link_film,
       GROUP_CONCAT(t_folders.id) AS GenresFilms
FROM t_files
LEFT JOIN t_folders ON t_files.folder_id = t_folders.id
WHERE t_files.id = %(value_id_film_selected)s;

-- 11. Afficher un fichier (pour UPDATE/DELETE)
SELECT id AS id_film, name AS nom_film, file_size AS duree_film,
       storage_path AS description_film, created_at AS date_sortie_film,
       '' AS cover_link_film
FROM t_files WHERE id = %(value_id_film)s;

-- 12. Ajouter un nouveau fichier
INSERT INTO t_files (id, name, file_size, storage_path)
VALUES (NULL, %(value_nom_film)s, 0, '');

-- 13. Modifier un fichier
UPDATE t_files
SET name = %(value_nom_film)s, file_size = %(value_duree_film)s,
    storage_path = %(value_description_film)s, created_at = %(value_datesortie_film)s
WHERE id = %(value_id_film)s;

-- 14. Modifier le dossier d'un fichier (association)
UPDATE t_files SET folder_id = %(value_fk_genre)s WHERE id = %(value_fk_film)s;

-- 15. Détacher les fichiers d'un dossier (avant suppression du dossier)
UPDATE t_files SET folder_id = NULL WHERE folder_id = %(value_id_genre)s;

-- 16. Supprimer un fichier (supprimer d'abord les partages liés)
DELETE FROM t_shares WHERE file_id = %(value_id_film)s;
DELETE FROM t_files WHERE id = %(value_id_film)s;


------------------------------------------------------------
  TABLE : t_shares (PARTAGES)
------------------------------------------------------------

-- 17. Supprimer les partages d'un fichier
DELETE FROM t_shares WHERE file_id = %(value_id_film)s;


------------------------------------------------------------
  TABLE : t_users_logs (UTILISATEURS)
------------------------------------------------------------

-- 18. Afficher tous les utilisateurs
SELECT id, username, email, storage_quota_gb, created_at
FROM t_users_logs ORDER BY id ASC;

-- 19. Ajouter un utilisateur
INSERT INTO t_users_logs (id, username, email, password_hash, storage_quota_gb, created_at)
VALUES (NULL, %(username)s, %(email)s, %(password_hash)s, %(storage_quota_gb)s, NOW());

-- 20. Modifier le quota de stockage d'un utilisateur
UPDATE t_users_logs SET storage_quota_gb = %(quota)s WHERE id = %(user_id)s;

-- 21. Supprimer un utilisateur
DELETE FROM t_users_logs WHERE id = %(user_id)s;


------------------------------------------------------------
  TABLE : t_users (INFORMATIONS UTILISATEURS)
------------------------------------------------------------

-- 22. Afficher tous les utilisateurs (table info)
SELECT nick_name, email, telephone_number FROM t_users;

-- 23. Ajouter un utilisateur (table info)
INSERT INTO t_users (nick_name, email, telephone_number)
VALUES (%(nick_name)s, %(email)s, %(telephone)s);

-- 24. Supprimer un utilisateur (table info)
DELETE FROM t_users WHERE email = %(email)s;


------------------------------------------------------------
  REQUÊTES DE JOINTURES
------------------------------------------------------------

-- 25. Afficher les fichiers d'un dossier spécifique
SELECT t_files.id AS id_film, t_files.name AS nom_film,
       t_folders.id AS id_genre, t_folders.name AS intitule_genre
FROM t_files
LEFT JOIN t_folders ON t_files.folder_id = t_folders.id
WHERE t_files.folder_id = %(value_id_genre)s;

-- 26. Afficher les dossiers non attribués à un fichier
SELECT id AS id_genre, name AS intitule_genre
FROM t_folders
WHERE id NOT IN (
    SELECT folder_id FROM t_files WHERE id = %(value_id_film_selected)s AND folder_id IS NOT NULL
);

-- 27. Afficher les dossiers attribués à un fichier
SELECT t_files.id AS id_film, t_folders.id AS id_genre, t_folders.name AS intitule_genre
FROM t_files
INNER JOIN t_folders ON t_files.folder_id = t_folders.id
WHERE t_files.id = %(value_id_film_selected)s;


------------------------------------------------------------
  REQUÊTES AVEC HAVING (fichier filtré)
------------------------------------------------------------

-- 28. Afficher un fichier spécifique (avec GROUP BY + HAVING)
SELECT t_files.id AS id_film, t_files.name AS nom_film,
       t_files.file_size AS duree_film, t_files.storage_path AS description_film,
       t_files.created_at AS date_sortie_film, '' AS cover_link_film,
       GROUP_CONCAT(t_folders.name) AS GenresFilms
FROM t_files
LEFT JOIN t_folders ON t_files.folder_id = t_folders.id
GROUP BY t_files.id
HAVING t_files.id = %(value_id_film_selected)s;


------------------------------------------------------------
  CRÉATION DES TABLES (DDL)
------------------------------------------------------------

-- 29. Structure de la table t_files
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

-- 30. Structure de la table t_folders
CREATE TABLE IF NOT EXISTS `t_folders` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 31. Structure de la table t_shares
CREATE TABLE IF NOT EXISTS `t_shares` (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `file_id` int(11) DEFAULT NULL,
  `shared_with_user_id` int(11) DEFAULT NULL,
  `permission_level` varchar(20) DEFAULT 'view',
  `expires_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 32. Structure de la table t_users
CREATE TABLE IF NOT EXISTS `t_users` (
  `nick_name` varchar(30) NOT NULL,
  `email` varchar(40) NOT NULL,
  `telephone_number` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 33. Structure de la table t_users_chat
CREATE TABLE IF NOT EXISTS `t_users_chat` (
  `id_users_chat` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id_users_chat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- 34. Structure de la table t_users_logs
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
