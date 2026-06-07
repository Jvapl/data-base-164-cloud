# Module 164 - Application de Gestion de Fichiers

## Description

Application web Flask pour la gestion de fichiers et dossiers.
Développée dans le cadre du module 164 à l'EPSIC.

## Base de données

L'application utilise une base de données MySQL/MariaDB avec les tables suivantes :

- `t_folders` — Dossiers (id, name, parent_id, user_id, created_at)
- `t_files` — Fichiers (id, name, file_size, mime_type, storage_path, folder_id, user_id, created_at, updated_at)
- `t_shares` — Partages (id, file_id, shared_with_user_id, permission_level, expires_at)
- `t_users` — Utilisateurs (nick_name, email, telephone_number)
- `t_users_chat` — Chat (id_users_chat)
- `t_users_logs` — Connexions (id, username, email, password_hash, storage_quota_gb, created_at)

## Installation

1. Importer le dump SQL dans MySQL :
   ```
   mysql -u root < APP_FILMS_164/database/joao_aebi_deva1a_app.SQL
   ```

2. Configurer le fichier `.env` avec vos paramètres de connexion MySQL.

3. Installer les dépendances :
   ```
   pip install -r requirements.txt
   ```

4. Lancer l'application :
   ```
   python run_mon_app.py
   ```

## Structure du projet

```
APP_FILMS_164/
├── database/          # Scripts et dump SQL
├── genres/            # Gestion des dossiers (CRUD)
├── films/             # Gestion des fichiers (CRUD)
├── films_genres/      # Association fichiers-dossiers
├── erreurs/           # Gestion des exceptions
├── demos_om_164/      # Routes de démonstration
├── essais_wtf_forms/  # Exemples de formulaires
├── templates/         # Templates Jinja2
└── static/            # Fichiers statiques (CSS, JS, images)
```

## Auteur

João Aebi — EPSIC 2026
