"""
    Fichier : gestion_films_genres_crud.py
    Auteur : OM 2021.05.01
    Gestions des "routes" FLASK et des données pour l'association entre les films et les genres.
"""
from pathlib import Path

from flask import flash
from flask import redirect
from flask import render_template
from flask import request
from flask import session
from flask import url_for

from APP_FILMS_164.database.database_tools import DBconnection
from APP_FILMS_164.erreurs.exceptions import *

"""
    Nom : films_genres_afficher
    Auteur : OM 2021.05.01
    Définition d'une "route" /films_genres_afficher
    
    But : Afficher les films avec les genres associés pour chaque film.
    
    Paramètres : id_genre_sel = 0 >> tous les films.
                 id_genre_sel = "n" affiche le film dont l'id est "n"
                 
"""


@app.route("/films_genres_afficher/<int:id_film_sel>", methods=['GET', 'POST'])
def films_genres_afficher(id_film_sel):
    print(" films_genres_afficher id_film_sel ", id_film_sel)
    if request.method == "GET":
        try:
            with DBconnection() as mc_afficher:
                strsql_genres_films_afficher_data = """SELECT t_files.id AS id_film, t_files.name AS nom_film, 
                                                            t_files.file_size AS duree_film, 
                                                            t_files.storage_path AS description_film, 
                                                            t_files.created_at AS date_sortie_film,
                                                            '' AS cover_link_film,
                                                            GROUP_CONCAT(t_folders.name) AS GenresFilms 
                                                       FROM t_files
                                                       LEFT JOIN t_folders ON t_files.folder_id = t_folders.id
                                                       GROUP BY t_files.id"""
                if id_film_sel == 0:
                    mc_afficher.execute(strsql_genres_films_afficher_data)
                else:
                    valeur_id_film_selected_dictionnaire = {"value_id_film_selected": id_film_sel}
                    strsql_genres_films_afficher_data += """ HAVING t_files.id = %(value_id_film_selected)s"""

                    mc_afficher.execute(strsql_genres_films_afficher_data, valeur_id_film_selected_dictionnaire)

                data_genres_films_afficher = mc_afficher.fetchall()
                print("data_genres ", data_genres_films_afficher, " Type : ", type(data_genres_films_afficher))

                if not data_genres_films_afficher and id_film_sel == 0:
                    flash("""La table "t_files" est vide. !""", "warning")
                elif not data_genres_films_afficher and id_film_sel > 0:
                    flash(f"Le fichier {id_film_sel} demandé n'existe pas !!", "warning")
                else:
                    flash(f"Données fichiers (t_files) et dossiers (t_folders) affichés !!", "success")

        except Exception as Exception_films_genres_afficher:
            raise ExceptionFilmsGenresAfficher(f"fichier : {Path(__file__).name}  ;  {films_genres_afficher.__name__} ;"
                                               f"{Exception_films_genres_afficher}")

    print("films_genres_afficher  ", data_genres_films_afficher)
    return render_template("films_genres/films_genres_afficher.html", data=data_genres_films_afficher)


"""
    nom: edit_genre_film_selected
    On obtient un objet "objet_dumpbd"

    Récupère la liste de tous les genres du film sélectionné par le bouton "MODIFIER" de "films_genres_afficher.html"
    
    Dans une liste déroulante particulière (tags-selector-tagselect), on voit :
    1) Tous les genres contenus dans la "t_genre".
    2) Les genres attribués au film selectionné.
    3) Les genres non-attribués au film sélectionné.

    On signale les erreurs importantes

"""


@app.route("/edit_genre_film_selected", methods=['GET', 'POST'])
def edit_genre_film_selected():
    if request.method == "GET":
        try:
            with DBconnection() as mc_afficher:
                strsql_genres_afficher = """SELECT id AS id_genre, name AS intitule_genre FROM t_folders ORDER BY id ASC"""
                mc_afficher.execute(strsql_genres_afficher)
            data_genres_all = mc_afficher.fetchall()
            print("dans edit_genre_film_selected ---> data_genres_all", data_genres_all)

            id_film_genres_edit = request.values['id_film_genres_edit_html']
            session['session_id_film_genres_edit'] = id_film_genres_edit

            valeur_id_film_selected_dictionnaire = {"value_id_film_selected": id_film_genres_edit}

            data_genre_film_selected, data_genres_films_non_attribues, data_genres_films_attribues = \
                genres_films_afficher_data(valeur_id_film_selected_dictionnaire)

            print(data_genre_film_selected)
            lst_data_film_selected = [item['id_film'] for item in data_genre_film_selected]
            print("lst_data_film_selected  ", lst_data_film_selected,
                  type(lst_data_film_selected))

            lst_data_genres_films_non_attribues = [item['id_genre'] for item in data_genres_films_non_attribues]
            session['session_lst_data_genres_films_non_attribues'] = lst_data_genres_films_non_attribues
            print("lst_data_genres_films_non_attribues  ", lst_data_genres_films_non_attribues,
                  type(lst_data_genres_films_non_attribues))

            lst_data_genres_films_old_attribues = [item['id_genre'] for item in data_genres_films_attribues]
            session['session_lst_data_genres_films_old_attribues'] = lst_data_genres_films_old_attribues
            print("lst_data_genres_films_old_attribues  ", lst_data_genres_films_old_attribues,
                  type(lst_data_genres_films_old_attribues))

            print(" data data_genre_film_selected", data_genre_film_selected, "type ", type(data_genre_film_selected))
            print(" data data_genres_films_non_attribues ", data_genres_films_non_attribues, "type ",
                  type(data_genres_films_non_attribues))
            print(" data_genres_films_attribues ", data_genres_films_attribues, "type ",
                  type(data_genres_films_attribues))

            lst_data_genres_films_non_attribues = [item['intitule_genre'] for item in data_genres_films_non_attribues]
            print("lst_all_genres gf_edit_genre_film_selected ", lst_data_genres_films_non_attribues,
                  type(lst_data_genres_films_non_attribues))

        except Exception as Exception_edit_genre_film_selected:
            raise ExceptionEditGenreFilmSelected(f"fichier : {Path(__file__).name}  ;  "
                                                 f"{edit_genre_film_selected.__name__} ; "
                                                 f"{Exception_edit_genre_film_selected}")

    return render_template("films_genres/films_genres_modifier_tags_dropbox.html",
                           data_genres=data_genres_all,
                           data_film_selected=data_genre_film_selected,
                           data_genres_attribues=data_genres_films_attribues,
                           data_genres_non_attribues=data_genres_films_non_attribues)


"""
    nom: update_genre_film_selected

    Récupère la liste de tous les genres du film sélectionné par le bouton "MODIFIER" de "films_genres_afficher.html"
    
    Dans une liste déroulante particulière (tags-selector-tagselect), on voit :
    1) Tous les genres contenus dans la "t_genre".
    2) Les genres attribués au film selectionné.
    3) Les genres non-attribués au film sélectionné.

    On signale les erreurs importantes
"""


@app.route("/update_genre_film_selected", methods=['GET', 'POST'])
def update_genre_film_selected():
    if request.method == "POST":
        try:
            id_film_selected = session['session_id_film_genres_edit']
            print("session['session_id_film_genres_edit'] ", session['session_id_film_genres_edit'])

            old_lst_data_genres_films_non_attribues = session['session_lst_data_genres_films_non_attribues']
            print("old_lst_data_genres_films_non_attribues ", old_lst_data_genres_films_non_attribues)

            old_lst_data_genres_films_attribues = session['session_lst_data_genres_films_old_attribues']
            print("old_lst_data_genres_films_old_attribues ", old_lst_data_genres_films_attribues)

            session.clear()

            new_lst_str_genres_films = request.form.getlist('name_select_tags')
            print("new_lst_str_genres_films ", new_lst_str_genres_films)

            # Dans la BD réelle, un fichier appartient à UN seul dossier.
            # On prend le premier dossier sélectionné (ou None si aucun).
            if new_lst_str_genres_films:
                new_folder_id = int(new_lst_str_genres_films[0])
            else:
                new_folder_id = None

            strsql_update_folder = """UPDATE t_files SET folder_id = %(value_fk_genre)s WHERE id = %(value_fk_film)s"""
            valeurs_update_dictionnaire = {"value_fk_film": id_film_selected,
                                           "value_fk_genre": new_folder_id}

            with DBconnection() as mconn_bd:
                mconn_bd.execute(strsql_update_folder, valeurs_update_dictionnaire)

        except Exception as Exception_update_genre_film_selected:
            raise ExceptionUpdateGenreFilmSelected(f"fichier : {Path(__file__).name}  ;  "
                                                   f"{update_genre_film_selected.__name__} ; "
                                                   f"{Exception_update_genre_film_selected}")

    return redirect(url_for('films_genres_afficher', id_film_sel=id_film_selected))


"""
    nom: genres_films_afficher_data

    Récupère la liste de tous les genres du film sélectionné par le bouton "MODIFIER" de "films_genres_afficher.html"
    Nécessaire pour afficher tous les "TAGS" des genres, ainsi l'utilisateur voit les genres à disposition

    On signale les erreurs importantes
"""


def genres_films_afficher_data(valeur_id_film_selected_dict):
    print("valeur_id_film_selected_dict...", valeur_id_film_selected_dict)
    try:

        strsql_film_selected = """SELECT t_files.id AS id_film, t_files.name AS nom_film, 
                                        t_files.file_size AS duree_film, 
                                        t_files.storage_path AS description_film, 
                                        t_files.created_at AS date_sortie_film,
                                        '' AS cover_link_film,
                                        GROUP_CONCAT(t_folders.id) as GenresFilms 
                                 FROM t_files
                                 LEFT JOIN t_folders ON t_files.folder_id = t_folders.id
                                 WHERE t_files.id = %(value_id_film_selected)s"""

        strsql_genres_films_non_attribues = """SELECT id AS id_genre, name AS intitule_genre 
                                               FROM t_folders 
                                               WHERE id NOT IN (
                                                   SELECT folder_id FROM t_files WHERE id = %(value_id_film_selected)s AND folder_id IS NOT NULL
                                               )"""

        strsql_genres_films_attribues = """SELECT t_files.id AS id_film, t_folders.id AS id_genre, t_folders.name AS intitule_genre 
                                           FROM t_files
                                           INNER JOIN t_folders ON t_files.folder_id = t_folders.id
                                           WHERE t_files.id = %(value_id_film_selected)s"""

        with DBconnection() as mc_afficher:
            mc_afficher.execute(strsql_genres_films_non_attribues, valeur_id_film_selected_dict)
            data_genres_films_non_attribues = mc_afficher.fetchall()
            print("genres_films_afficher_data ----> data_genres_films_non_attribues ", data_genres_films_non_attribues,
                  " Type : ",
                  type(data_genres_films_non_attribues))

            mc_afficher.execute(strsql_film_selected, valeur_id_film_selected_dict)
            data_film_selected = mc_afficher.fetchall()
            print("data_film_selected  ", data_film_selected, " Type : ", type(data_film_selected))

            mc_afficher.execute(strsql_genres_films_attribues, valeur_id_film_selected_dict)
            data_genres_films_attribues = mc_afficher.fetchall()
            print("data_genres_films_attribues ", data_genres_films_attribues, " Type : ",
                  type(data_genres_films_attribues))

            return data_film_selected, data_genres_films_non_attribues, data_genres_films_attribues

    except Exception as Exception_genres_films_afficher_data:
        raise ExceptionGenresFilmsAfficherData(f"fichier : {Path(__file__).name}  ;  "
                                               f"{genres_films_afficher_data.__name__} ; "
                                               f"{Exception_genres_films_afficher_data}")
