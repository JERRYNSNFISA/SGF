with package_arbre;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with ada.strings; use ada.strings;
with Ada.Text_IO.Unbounded_IO; use Ada.Text_IO.Unbounded_IO;
with Ada.Characters.Handling; use Ada.Characters.Handling;

package p_sgf is
   
   -- Déclaration variables p_sgf
   
   type current is private;
   
   type TAB_parametre is array (1..50) of Unbounded_String;
   
   type droit_acces is array (1..3) of Integer;
   
   type data is record
      type_contenu : Boolean;
      nom : Unbounded_String;
      droits_acces : droit_acces;
      taille : Integer;
      contenu : Unbounded_String;
   end record;
   
   --appel du paquetage package_arbre avec t_data en data
   
   package arbre is new package_arbre(t_data => data);  use arbre; --, image => contenu'Image);
   subtype t_noeud is arbre.p_noeud;
   
   
   --Type : procedure
   --Nom : chemin_menu
   --Sémantique : La procédure décompose une commande en entrée sous forme de chaîne non bornée en un tableau de paramètres en entrée/sortie.
   --Paramètres :
   --commande : in Unbounded_String
   --parametre : in out TAB_parametre
   --Pré-condition : Aucune
   --Post-condition : Le tableau de paramètres en entrée/sortie contient les différents éléments de la chaîne de commande séparés par des espaces.
   --Exception : Trop_de_parametre, levée si le nombre de paramètres dépasse la longueur du tableau.
   procedure chemin_menu (commande : in Unbounded_String; parametre : in out TAB_parametre);
   
   
   --Type : procedure
   --Nom : chemin_sgf
   --Sémantique : Procédure qui analyse et traite la commande pour obtenir les différents paramètres qui la composent.
   --Paramètres :
   --commande : in Unbounded_String (chaîne de caractères représentant la commande)
   --parametre : in out TAB_parametre (tableau contenant les paramètres de la commande)
   --Pré-condition : la commande doit être formattée correctement avec des '/' pour séparer les différents paramètres.
   --Post-condition : le tableau paramètre contiendra les différents paramètres de la commande.
   --Exceptions :
   --chemin_inexistant : levée si la commande ne contient que ou se termine par un '/'
   --erreur_commande : levée si la commande contient plusieurs '/' consécutifs
   --trop_de_parametre : levée si il y a plus de paramètres que la taille du tableau paramètre.
   procedure chemin_sgf (commande : in Unbounded_String; parametre : in out TAB_parametre);
   
   
   --Type : function
   --Nom : existe
   --Sémantique : La fonction vérifie si un nom de noeud donné existe dans une liste de fils d'arbre. Si le nom de noeud existe, la fonction retourne True et le noeud courant est mis à jour pour être égal au noeud correspondant. Sinon, la fonction retourne False.
   --Paramètres :
   --noeud_courant : in out t_noeud
   --Temp : in out arbre.les_fils
   --name_node : in Unbounded_String
   --Valeur retournée : Boolean
   --Pré-condition : Aucune
   --Post-condition : Le noeud courant est mis à jour pour être égal au noeud correspondant si le nom de noeud donné existe dans la liste de fils d'arbre.
   --Exception : Aucune.
   function existe (noeud_courant : in out t_noeud; Temp : in out les_fils; name_node : in Unbounded_String) return boolean;
   
   --Type : procedure
   --Nom : param_chemin
   --Sémantique : La procédure traite le premier paramètre d'un tableau de paramètres entré en entrée, et met à jour un pointeur vers un noeud de l'arbre de fichiers, selon la valeur de ce premier paramètre.
   --Paramètres :
   --temp : in out current
   --parametre : in TAB_parametre
   --index : in out Integer
   --Pré-condition : Aucune
   --Post-condition : Le pointeur vers le noeud de l'arbre de fichiers a été mis à jour, selon la valeur du premier paramètre du tableau de paramètres.
   --Exception : Chemin_inexistant, levée si le chemin n'existe pas dans l'arbre de fichiers.
   procedure param_chemin (temp : in out current; parametre : in TAB_parametre; index : in out Integer);
   
   --Type : procedure
   --Nom : dernier_param
   --Sémantique : La procédure détermine le dernier paramètre valide dans un tableau de paramètres.
   --Paramètres :
   --parametre_tab : in TAB_parametre
   --courant_racine : in out current
   --index : in out Integer
   --Pré-condition : Le tableau de paramètres doit contenir au moins un élément.
   --Post-condition : Le paramètre trouvé est stocké dans "index".
   --Exception : chemin_inexistant, levée si aucun paramètre valide n'a été trouvé.
   --Exception : erreur_element, levée si un élément n'est pas de type répertoire.
   --Exception : element_inexistant, levée si un élément n'existe pas.
   procedure dernier_param (parametre_tab : in TAB_parametre; courant_racine : in out current; index: in out Integer);
   
   --Type : procedure
   --Nom : memoire
   --Sémantique : La procédure met à jour la taille des noeuds dans l'arbre de fichiers en parcourant depuis le noeud courant vers la racine de l'arbre, en ajoutant ou soustractant une valeur donnée en entrée.
   --Paramètres :
   --courant_racine : in t_noeud
   --plus_ou_moins : in Boolean
   --valeur : in Integer
   --Pré-condition : Aucune
   --Post-condition : La taille des noeuds a été mise à jour en ajoutant ou soustractant la valeur donnée.
   --Exception : Aucune.
   procedure memoire (courant_racine : in t_noeud; plus_ou_moins : in Boolean; valeur : in Integer);
   
   --Type : procedure
   --Nom : verif_memoire
   --Sémantique : La procédure vérifie si la capacité de mémoire du système sera atteinte si un certain nombre de données est ajouté.
   --Paramètres :
   --racine : in t_noeud
   --valeur : in Integer
   --Pré-condition : Aucune
   --Post-condition : Aucune
   --Exception : capacite_memoire_atteinte, levée si la capacité de mémoire sera atteinte si la valeur est ajoutée.
   procedure verif_memoire (racine : in t_noeud; valeur : in Integer);
   
   --Type : procedure
   --Nom : creation_racine
   --Sémantique : La procédure crée un noeud racine pour un arbre de fichiers, en y assignant des valeurs par défaut pour ses champs de données (type_contenu, nom, droits_acces, taille, contenu). 
   -- Ensuite, le pointeur vers la racine de l'arbre est mis à jour dans le premier paramètre d'entrée, qui est un objet courant_racine.
   --Paramètres :
   --courant_racine : in out current
   --Pré-condition : Aucune
   --Post-condition : Un noeud racine a été créé dans l'arbre de fichiers, avec des valeurs par défaut pour ses champs de données, et le pointeur vers la racine a été mis à jour dans l'objet courant_racine.
   --Exception : Aucune.
   procedure creation_racine (courant_racine : in out current);
   
   
   --Type : procedure
   --Nom : cd
   --Sémantique : La procédure traite les paramètres d'un tableau de paramètres entré en entrée pour déterminer le chemin du noeud cible, et met à jour le pointeur vers ce noeud dans l'arbre de fichiers.
   --Paramètres :
   --parametre_tab : in TAB_parametre
   --courant_racine : in out current
   --Pré-condition : Le tableau de paramètres doit avoir un format correct, avec deux éléments seulement.
   --Post-condition : Le pointeur vers le noeud cible dans l'arbre de fichiers a été mis à jour.
   --Exception : erreur_commande, levée si le format du tableau de paramètres est incorrect.
   --erreur_element, levée si le noeud cible n'est pas un répertoire.
   --element_inexistant, levée si le noeud cible n'existe pas dans l'arbre de fichiers.
   procedure cd (parametre_tab : in TAB_parametre; courant_racine : in out current);
   
   --Type : procedure
   --Nom : ls
   --Sémantique : La procédure liste les éléments du dossier ou du fichier correspondant au chemin d'accès donné en paramètre. Si le chemin d'accès est vide, elle liste les éléments du dossier courant.élément_inexistant".
   --Paramètres :
   --parametre_tab : in TAB_parametre (tableau contenant les paramètres de la commande)
   --courant_racine : in current (pointeur vers la racine de l'arbre de fichiers)
   --Pré-condition : Le tableau de paramètres doit avoir un format correct, avec deux éléments seulement.
   --Post-condition : Les éléments du dossier ou du fichier correspondant au chemin d'accès ont été listés.
   --Exceptions :
   --element_inexistant : levée si le chemin d'accès donné ne correspond à aucun élément dans l'arbre de fichiers.
   --erreur_element : levée si un élément correspondant au chemin d'accès n'est pas un dossier.
   procedure ls (parametre_tab : in TAB_parametre; courant_racine : in current);
   
   --Type : procedure
   --Nom : ls_r
   --Sémantique : Procédure qui affiche les éléments d'un répertoire ou d'un sous-répertoire de l'arbre de fichiers/dossiers.
   --Paramètres :
   --parametre_tab : in TAB_parametre (tableau contenant les paramètres de la commande)
   --courant_racine : in current (pointeur vers la racine de l'arbre de fichiers)
   --Pré-condition : parametre_tab(4) doit être égal à "".
   --Post-condition : Affiche la liste des éléments dans le répertoire spécifié.
   --Exception : 
   --erreur_commande : levée si le paramètre fourni ne respecte pas la pré-condition. 
   --element_inexistant : levée si le chemin d'accès donné ne correspond à aucun élément dans l'arbre de fichiers.
   --erreur_element : levée si un élément correspondant au chemin d'accès n'est pas un dossier.
   procedure ls_r (parametre_tab : in TAB_parametre; courant_racine : in current);
   
   --Type : procedure
   --Nom : rm_ou_rmr
   --Sémantique : Procédure qui permet de supprimer un élément ou un sous-répertoire dans l'arbre de fichiers/dossiers.
   --Paramètres :
   --parametre_tab : in TAB_parametre (tableau contenant les paramètres de la commande)
   --courant_racine : in current (pointeur vers la racine de l'arbre de fichiers)
   --Bool : in Boolean (indicateur de la commande, soit rm soit rm -r)
   --Pré-condition : parametre_tab(4) doit être égal à "" pour rm -r et parametre_tab(3) doit être égal à "" pour rm.
   --Post-condition : Supprime l'élément ou le sous-répertoire spécifié.
   --Exception :
   --erreur_commande : levée si les paramètres ne respectent pas les pré-conditions.
   --element_inexistant : levée si le chemin d'accès donné ne correspond à aucun élément dans l'arbre de fichiers.
   --erreur_element : levée si l'élément spécifié n'est pas un fichier (rm) ou n'est pas un dossier (rm -r).
   procedure rm_ou_rmr (parametre_tab : in TAB_parametre; courant_racine : in current; Bool : in Boolean);
   
   --Type : procedure
   --Nom : cpr_ou_mv
   --Sémantique : Procédure qui effectue une opération de copie ou de déplacement d'un élément dans l'arbre de fichiers/dossiers.
   --Paramètres :
   --parametre_tab : in TAB_parametre (tableau contenant les paramètres de la commande)
   --courant_racine : in current (pointeur vers la racine de l'arbre de fichiers)
   --Bool : in Boolean (indicateur pour déterminer s'il s'agit d'une opération de copie ou de déplacement)
   --Pré-condition : parametre_tab(5) doit être égal à "" pour l'opération de copie, et parametre_tab(4) doit être égal à "" pour l'opération de déplacement.
   --Post-condition : Effectue une opération de copie ou de déplacement de l'élément spécifié.
   --Exceptions :
   --erreur_commande : levée si les paramètres fournis ne respectent pas la pré-condition.
   --element_inexistant : levée si le chemin d'accès donné ne correspond à aucun élément dans l'arbre de fichiers.
   --erreur_element : levée si un élément correspondant au chemin d'accès n'est pas un répertoire pour l'opération de déplacement.
   procedure cpr_ou_mv (parametre_tab : in TAB_parametre; courant_racine : in current; Bool : in Boolean);
   
   --Type : procedure
   --Nom : tar
   --Sémantique : Procédure qui archive un fichier ou un sous-répertoire de l'arbre de fichiers/dossiers en créant un fichier .tar.
   --Paramètres :
   --parametre_tab : in TAB_parametre (tableau contenant les paramètres de la commande)
   --courant_racine : in current (pointeur vers la racine de l'arbre de fichiers)
   --Pré-condition : parametre_tab(3) doit être égal à "".
   --Post-condition : Crée un fichier .tar correspondant au fichier ou au répertoire spécifié.
   --Exception :
   --erreur_commande : levée si le paramètre fourni ne respecte pas la pré-condition.
   --element_inexistant : levée si le chemin d'accès donné ne correspond à aucun élément dans l'arbre de fichiers.
   --element_present : levée si le fichier .tar correspondant au fichier ou au répertoire spécifié existe déjà.
   --erreur_element : levée si un élément correspondant au chemin d'accès n'est pas un fichier."
   procedure tar (parametre_tab : in TAB_parametre; courant_racine : in current);
   
   --Type : procedure
   --Nom : pwd
   --Sémantique : Procédure qui affiche le chemin du répertoire courant dans l'arbre de fichiers/dossiers.
   --Paramètres :
   --courant_racine : in current (pointeur vers la racine de l'arbre de fichiers)
   --liste : in out arbre.les_fils (tableau pour stocker les répertoires du chemin)
   --Pré-condition : Aucune.
   --Post-condition : Affiche le chemin complet du répertoire courant.
   --Exception : Aucune.
   procedure pwd (courant_racine : in current; liste : in out arbre.les_fils);
   
   --Type : procedure
   --Nom : mkdir_ou_touch
   --Sémantique : Procédure qui crée un dossier ou un fichier dans l'arbre de fichiers/dossiers.
   --Paramètres :
   --parametre_tab : in TAB_parametre (tableau contenant les paramètres de la commande)
   --courant_racine : in current (pointeur vers la racine de l'arbre de fichiers)
   --Bool : in Boolean (indique si l'élément à créer est un dossier ou un fichier)
   --Pré-condition : parametre_tab(3) doit être égal à "".
   --Post-condition : Crée un dossier ou un fichier selon le chemin spécifié.
   --Exception :
   --erreur_commande : levée si le paramètre fourni ne respecte pas la pré-condition.
   --element_present : levée si un élément portant le même nom existe déjà dans le répertoire spécifié.
   --erreur_memoire : levée si la taille de la mémoire n'est pas suffisante pour stocker le nouvel élément.
   procedure mkdir_ou_touch (parametre_tab : in TAB_parametre; courant_racine : in current; Bool : in Boolean);
   
   --Type : procedure
   --Nom : edit
   --Sémantique : Procédure qui modifie le contenu d'un fichier dans l'arbre de fichiers/dossiers.
   --Paramètres :
   --parametre_tab : in TAB_parametre (tableau contenant les paramètres de la commande)
   --courant_racine : in current (pointeur vers la racine de l'arbre de fichiers)
   --Pré-condition : parametre_tab(3) doit être égal à "".
   --Post-condition : Modifie le contenu du fichier spécifié.
   --Exception :
   --erreur_commande : levée si le paramètre fourni ne respecte pas la pré-condition.
   --element_inexistant : levée si le chemin d'accès donné ne correspond à aucun élément dans l'arbre de fichiers.
   --erreur_element : levée si un élément correspondant au chemin d'accès n'est pas un fichier.
   procedure edit (parametre_tab : in TAB_parametre; courant_racine : in current);
   
   --Type : procedure
   --Nom : taille_racine
   --Sémantique : Procédure qui affiche la taille totale de la racine de l'arbre de fichiers/dossiers.
   --Paramètres :
   --parametre_tab : in TAB_parametre (tableau contenant les paramètres de la commande)
   --courant_racine : in current (pointeur vers la racine de l'arbre de fichiers)
   --Pré-condition : parametre_tab(2) doit être égal à "".
   --Post-condition : Affiche la taille totale de la racine de l'arbre de fichiers.
   --Exception :
   --erreur_commande : levée si le paramètre fourni ne respecte pas la pré-condition.
   procedure taille_racine (parametre_tab : in TAB_parametre; courant_racine : in current);
   
   
   --procedure modif_droit_acces (parametre_tab : in TAB_parametre; courant_racine : in current);
   
 
   trop_de_parametre : exception; 
   erreur_element : exception;
   element_inexistant : exception;
   chemin_inexistant : exception;
   element_present : exception;
   erreur_commande : exception;
   capacite_memoire_atteint : exception;
   
   -- Déclaration du type current en privé
private
     
   type current is record
      rep_courant : t_noeud;
      rep_racine : t_noeud;
   end record;
   
end p_sgf;
