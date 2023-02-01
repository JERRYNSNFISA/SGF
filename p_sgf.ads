with package_arbre;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with ada.strings; use ada.strings;
with Ada.Text_IO.Unbounded_IO; use Ada.Text_IO.Unbounded_IO;
with Ada.Characters.Handling; use Ada.Characters.Handling;

package p_sgf is
   
   -- D�claration variables p_sgf
   
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
   --S�mantique : La proc�dure d�compose une commande en entr�e sous forme de cha�ne non born�e en un tableau de param�tres en entr�e/sortie.
   --Param�tres :
   --commande : in Unbounded_String
   --parametre : in out TAB_parametre
   --Pr�-condition : Aucune
   --Post-condition : Le tableau de param�tres en entr�e/sortie contient les diff�rents �l�ments de la cha�ne de commande s�par�s par des espaces.
   --Exception : Trop_de_parametre, lev�e si le nombre de param�tres d�passe la longueur du tableau.
   procedure chemin_menu (commande : in Unbounded_String; parametre : in out TAB_parametre);
   
   
   --Type : procedure
   --Nom : chemin_sgf
   --S�mantique : Proc�dure qui analyse et traite la commande pour obtenir les diff�rents param�tres qui la composent.
   --Param�tres :
   --commande : in Unbounded_String (cha�ne de caract�res repr�sentant la commande)
   --parametre : in out TAB_parametre (tableau contenant les param�tres de la commande)
   --Pr�-condition : la commande doit �tre formatt�e correctement avec des '/' pour s�parer les diff�rents param�tres.
   --Post-condition : le tableau param�tre contiendra les diff�rents param�tres de la commande.
   --Exceptions :
   --chemin_inexistant : lev�e si la commande ne contient que ou se termine par un '/'
   --erreur_commande : lev�e si la commande contient plusieurs '/' cons�cutifs
   --trop_de_parametre : lev�e si il y a plus de param�tres que la taille du tableau param�tre.
   procedure chemin_sgf (commande : in Unbounded_String; parametre : in out TAB_parametre);
   
   
   --Type : function
   --Nom : existe
   --S�mantique : La fonction v�rifie si un nom de noeud donn� existe dans une liste de fils d'arbre. Si le nom de noeud existe, la fonction retourne True et le noeud courant est mis � jour pour �tre �gal au noeud correspondant. Sinon, la fonction retourne False.
   --Param�tres :
   --noeud_courant : in out t_noeud
   --Temp : in out arbre.les_fils
   --name_node : in Unbounded_String
   --Valeur retourn�e : Boolean
   --Pr�-condition : Aucune
   --Post-condition : Le noeud courant est mis � jour pour �tre �gal au noeud correspondant si le nom de noeud donn� existe dans la liste de fils d'arbre.
   --Exception : Aucune.
   function existe (noeud_courant : in out t_noeud; Temp : in out les_fils; name_node : in Unbounded_String) return boolean;
   
   --Type : procedure
   --Nom : param_chemin
   --S�mantique : La proc�dure traite le premier param�tre d'un tableau de param�tres entr� en entr�e, et met � jour un pointeur vers un noeud de l'arbre de fichiers, selon la valeur de ce premier param�tre.
   --Param�tres :
   --temp : in out current
   --parametre : in TAB_parametre
   --index : in out Integer
   --Pr�-condition : Aucune
   --Post-condition : Le pointeur vers le noeud de l'arbre de fichiers a �t� mis � jour, selon la valeur du premier param�tre du tableau de param�tres.
   --Exception : Chemin_inexistant, lev�e si le chemin n'existe pas dans l'arbre de fichiers.
   procedure param_chemin (temp : in out current; parametre : in TAB_parametre; index : in out Integer);
   
   --Type : procedure
   --Nom : dernier_param
   --S�mantique : La proc�dure d�termine le dernier param�tre valide dans un tableau de param�tres.
   --Param�tres :
   --parametre_tab : in TAB_parametre
   --courant_racine : in out current
   --index : in out Integer
   --Pr�-condition : Le tableau de param�tres doit contenir au moins un �l�ment.
   --Post-condition : Le param�tre trouv� est stock� dans "index".
   --Exception : chemin_inexistant, lev�e si aucun param�tre valide n'a �t� trouv�.
   --Exception : erreur_element, lev�e si un �l�ment n'est pas de type r�pertoire.
   --Exception : element_inexistant, lev�e si un �l�ment n'existe pas.
   procedure dernier_param (parametre_tab : in TAB_parametre; courant_racine : in out current; index: in out Integer);
   
   --Type : procedure
   --Nom : memoire
   --S�mantique : La proc�dure met � jour la taille des noeuds dans l'arbre de fichiers en parcourant depuis le noeud courant vers la racine de l'arbre, en ajoutant ou soustractant une valeur donn�e en entr�e.
   --Param�tres :
   --courant_racine : in t_noeud
   --plus_ou_moins : in Boolean
   --valeur : in Integer
   --Pr�-condition : Aucune
   --Post-condition : La taille des noeuds a �t� mise � jour en ajoutant ou soustractant la valeur donn�e.
   --Exception : Aucune.
   procedure memoire (courant_racine : in t_noeud; plus_ou_moins : in Boolean; valeur : in Integer);
   
   --Type : procedure
   --Nom : verif_memoire
   --S�mantique : La proc�dure v�rifie si la capacit� de m�moire du syst�me sera atteinte si un certain nombre de donn�es est ajout�.
   --Param�tres :
   --racine : in t_noeud
   --valeur : in Integer
   --Pr�-condition : Aucune
   --Post-condition : Aucune
   --Exception : capacite_memoire_atteinte, lev�e si la capacit� de m�moire sera atteinte si la valeur est ajout�e.
   procedure verif_memoire (racine : in t_noeud; valeur : in Integer);
   
   --Type : procedure
   --Nom : creation_racine
   --S�mantique : La proc�dure cr�e un noeud racine pour un arbre de fichiers, en y assignant des valeurs par d�faut pour ses champs de donn�es (type_contenu, nom, droits_acces, taille, contenu). 
   -- Ensuite, le pointeur vers la racine de l'arbre est mis � jour dans le premier param�tre d'entr�e, qui est un objet courant_racine.
   --Param�tres :
   --courant_racine : in out current
   --Pr�-condition : Aucune
   --Post-condition : Un noeud racine a �t� cr�� dans l'arbre de fichiers, avec des valeurs par d�faut pour ses champs de donn�es, et le pointeur vers la racine a �t� mis � jour dans l'objet courant_racine.
   --Exception : Aucune.
   procedure creation_racine (courant_racine : in out current);
   
   
   --Type : procedure
   --Nom : cd
   --S�mantique : La proc�dure traite les param�tres d'un tableau de param�tres entr� en entr�e pour d�terminer le chemin du noeud cible, et met � jour le pointeur vers ce noeud dans l'arbre de fichiers.
   --Param�tres :
   --parametre_tab : in TAB_parametre
   --courant_racine : in out current
   --Pr�-condition : Le tableau de param�tres doit avoir un format correct, avec deux �l�ments seulement.
   --Post-condition : Le pointeur vers le noeud cible dans l'arbre de fichiers a �t� mis � jour.
   --Exception : erreur_commande, lev�e si le format du tableau de param�tres est incorrect.
   --erreur_element, lev�e si le noeud cible n'est pas un r�pertoire.
   --element_inexistant, lev�e si le noeud cible n'existe pas dans l'arbre de fichiers.
   procedure cd (parametre_tab : in TAB_parametre; courant_racine : in out current);
   
   --Type : procedure
   --Nom : ls
   --S�mantique : La proc�dure liste les �l�ments du dossier ou du fichier correspondant au chemin d'acc�s donn� en param�tre. Si le chemin d'acc�s est vide, elle liste les �l�ments du dossier courant.�l�ment_inexistant".
   --Param�tres :
   --parametre_tab : in TAB_parametre (tableau contenant les param�tres de la commande)
   --courant_racine : in current (pointeur vers la racine de l'arbre de fichiers)
   --Pr�-condition : Le tableau de param�tres doit avoir un format correct, avec deux �l�ments seulement.
   --Post-condition : Les �l�ments du dossier ou du fichier correspondant au chemin d'acc�s ont �t� list�s.
   --Exceptions :
   --element_inexistant : lev�e si le chemin d'acc�s donn� ne correspond � aucun �l�ment dans l'arbre de fichiers.
   --erreur_element : lev�e si un �l�ment correspondant au chemin d'acc�s n'est pas un dossier.
   procedure ls (parametre_tab : in TAB_parametre; courant_racine : in current);
   
   --Type : procedure
   --Nom : ls_r
   --S�mantique : Proc�dure qui affiche les �l�ments d'un r�pertoire ou d'un sous-r�pertoire de l'arbre de fichiers/dossiers.
   --Param�tres :
   --parametre_tab : in TAB_parametre (tableau contenant les param�tres de la commande)
   --courant_racine : in current (pointeur vers la racine de l'arbre de fichiers)
   --Pr�-condition : parametre_tab(4) doit �tre �gal � "".
   --Post-condition : Affiche la liste des �l�ments dans le r�pertoire sp�cifi�.
   --Exception : 
   --erreur_commande : lev�e si le param�tre fourni ne respecte pas la pr�-condition. 
   --element_inexistant : lev�e si le chemin d'acc�s donn� ne correspond � aucun �l�ment dans l'arbre de fichiers.
   --erreur_element : lev�e si un �l�ment correspondant au chemin d'acc�s n'est pas un dossier.
   procedure ls_r (parametre_tab : in TAB_parametre; courant_racine : in current);
   
   --Type : procedure
   --Nom : rm_ou_rmr
   --S�mantique : Proc�dure qui permet de supprimer un �l�ment ou un sous-r�pertoire dans l'arbre de fichiers/dossiers.
   --Param�tres :
   --parametre_tab : in TAB_parametre (tableau contenant les param�tres de la commande)
   --courant_racine : in current (pointeur vers la racine de l'arbre de fichiers)
   --Bool : in Boolean (indicateur de la commande, soit rm soit rm -r)
   --Pr�-condition : parametre_tab(4) doit �tre �gal � "" pour rm -r et parametre_tab(3) doit �tre �gal � "" pour rm.
   --Post-condition : Supprime l'�l�ment ou le sous-r�pertoire sp�cifi�.
   --Exception :
   --erreur_commande : lev�e si les param�tres ne respectent pas les pr�-conditions.
   --element_inexistant : lev�e si le chemin d'acc�s donn� ne correspond � aucun �l�ment dans l'arbre de fichiers.
   --erreur_element : lev�e si l'�l�ment sp�cifi� n'est pas un fichier (rm) ou n'est pas un dossier (rm -r).
   procedure rm_ou_rmr (parametre_tab : in TAB_parametre; courant_racine : in current; Bool : in Boolean);
   
   --Type : procedure
   --Nom : cpr_ou_mv
   --S�mantique : Proc�dure qui effectue une op�ration de copie ou de d�placement d'un �l�ment dans l'arbre de fichiers/dossiers.
   --Param�tres :
   --parametre_tab : in TAB_parametre (tableau contenant les param�tres de la commande)
   --courant_racine : in current (pointeur vers la racine de l'arbre de fichiers)
   --Bool : in Boolean (indicateur pour d�terminer s'il s'agit d'une op�ration de copie ou de d�placement)
   --Pr�-condition : parametre_tab(5) doit �tre �gal � "" pour l'op�ration de copie, et parametre_tab(4) doit �tre �gal � "" pour l'op�ration de d�placement.
   --Post-condition : Effectue une op�ration de copie ou de d�placement de l'�l�ment sp�cifi�.
   --Exceptions :
   --erreur_commande : lev�e si les param�tres fournis ne respectent pas la pr�-condition.
   --element_inexistant : lev�e si le chemin d'acc�s donn� ne correspond � aucun �l�ment dans l'arbre de fichiers.
   --erreur_element : lev�e si un �l�ment correspondant au chemin d'acc�s n'est pas un r�pertoire pour l'op�ration de d�placement.
   procedure cpr_ou_mv (parametre_tab : in TAB_parametre; courant_racine : in current; Bool : in Boolean);
   
   --Type : procedure
   --Nom : tar
   --S�mantique : Proc�dure qui archive un fichier ou un sous-r�pertoire de l'arbre de fichiers/dossiers en cr�ant un fichier .tar.
   --Param�tres :
   --parametre_tab : in TAB_parametre (tableau contenant les param�tres de la commande)
   --courant_racine : in current (pointeur vers la racine de l'arbre de fichiers)
   --Pr�-condition : parametre_tab(3) doit �tre �gal � "".
   --Post-condition : Cr�e un fichier .tar correspondant au fichier ou au r�pertoire sp�cifi�.
   --Exception :
   --erreur_commande : lev�e si le param�tre fourni ne respecte pas la pr�-condition.
   --element_inexistant : lev�e si le chemin d'acc�s donn� ne correspond � aucun �l�ment dans l'arbre de fichiers.
   --element_present : lev�e si le fichier .tar correspondant au fichier ou au r�pertoire sp�cifi� existe d�j�.
   --erreur_element : lev�e si un �l�ment correspondant au chemin d'acc�s n'est pas un fichier."
   procedure tar (parametre_tab : in TAB_parametre; courant_racine : in current);
   
   --Type : procedure
   --Nom : pwd
   --S�mantique : Proc�dure qui affiche le chemin du r�pertoire courant dans l'arbre de fichiers/dossiers.
   --Param�tres :
   --courant_racine : in current (pointeur vers la racine de l'arbre de fichiers)
   --liste : in out arbre.les_fils (tableau pour stocker les r�pertoires du chemin)
   --Pr�-condition : Aucune.
   --Post-condition : Affiche le chemin complet du r�pertoire courant.
   --Exception : Aucune.
   procedure pwd (courant_racine : in current; liste : in out arbre.les_fils);
   
   --Type : procedure
   --Nom : mkdir_ou_touch
   --S�mantique : Proc�dure qui cr�e un dossier ou un fichier dans l'arbre de fichiers/dossiers.
   --Param�tres :
   --parametre_tab : in TAB_parametre (tableau contenant les param�tres de la commande)
   --courant_racine : in current (pointeur vers la racine de l'arbre de fichiers)
   --Bool : in Boolean (indique si l'�l�ment � cr�er est un dossier ou un fichier)
   --Pr�-condition : parametre_tab(3) doit �tre �gal � "".
   --Post-condition : Cr�e un dossier ou un fichier selon le chemin sp�cifi�.
   --Exception :
   --erreur_commande : lev�e si le param�tre fourni ne respecte pas la pr�-condition.
   --element_present : lev�e si un �l�ment portant le m�me nom existe d�j� dans le r�pertoire sp�cifi�.
   --erreur_memoire : lev�e si la taille de la m�moire n'est pas suffisante pour stocker le nouvel �l�ment.
   procedure mkdir_ou_touch (parametre_tab : in TAB_parametre; courant_racine : in current; Bool : in Boolean);
   
   --Type : procedure
   --Nom : edit
   --S�mantique : Proc�dure qui modifie le contenu d'un fichier dans l'arbre de fichiers/dossiers.
   --Param�tres :
   --parametre_tab : in TAB_parametre (tableau contenant les param�tres de la commande)
   --courant_racine : in current (pointeur vers la racine de l'arbre de fichiers)
   --Pr�-condition : parametre_tab(3) doit �tre �gal � "".
   --Post-condition : Modifie le contenu du fichier sp�cifi�.
   --Exception :
   --erreur_commande : lev�e si le param�tre fourni ne respecte pas la pr�-condition.
   --element_inexistant : lev�e si le chemin d'acc�s donn� ne correspond � aucun �l�ment dans l'arbre de fichiers.
   --erreur_element : lev�e si un �l�ment correspondant au chemin d'acc�s n'est pas un fichier.
   procedure edit (parametre_tab : in TAB_parametre; courant_racine : in current);
   
   --Type : procedure
   --Nom : taille_racine
   --S�mantique : Proc�dure qui affiche la taille totale de la racine de l'arbre de fichiers/dossiers.
   --Param�tres :
   --parametre_tab : in TAB_parametre (tableau contenant les param�tres de la commande)
   --courant_racine : in current (pointeur vers la racine de l'arbre de fichiers)
   --Pr�-condition : parametre_tab(2) doit �tre �gal � "".
   --Post-condition : Affiche la taille totale de la racine de l'arbre de fichiers.
   --Exception :
   --erreur_commande : lev�e si le param�tre fourni ne respecte pas la pr�-condition.
   procedure taille_racine (parametre_tab : in TAB_parametre; courant_racine : in current);
   
   
   --procedure modif_droit_acces (parametre_tab : in TAB_parametre; courant_racine : in current);
   
 
   trop_de_parametre : exception; 
   erreur_element : exception;
   element_inexistant : exception;
   chemin_inexistant : exception;
   element_present : exception;
   erreur_commande : exception;
   capacite_memoire_atteint : exception;
   
   -- D�claration du type current en priv�
private
     
   type current is record
      rep_courant : t_noeud;
      rep_racine : t_noeud;
   end record;
   
end p_sgf;
