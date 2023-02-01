with p_Liste;
with Ada.Text_IO; use Ada.Text_IO;

-- D�claration de la g�n�ricit�
generic
   type t_data is private;
   
package package_arbre is
   
   -- D�claration du pointeur noeuds
   
   type noeud;
   type p_noeud is access noeud;
   
   --appel du paquetage p_liste avec Element en p_noeud
   
   package liste_arbre is new p_Liste(Element => p_noeud); use liste_arbre;
   subtype les_fils is liste_arbre.Liste_Ptr;
   
   type noeud is record
      donnees : t_data;
      parent : p_noeud;
      fils: les_fils; 
   end record;
   
   
   -- D�claration des op�rations de la liste des noeuds
   
   --Type : procedure
   --Nom : creer_noeud
   --S�mantique : Cette proc�dure cr�e un nouveau noeud dans l'arbre de fichiers/dossiers.
   --Param�tres :
   --creer : in out p_noeud (noeud � cr�er)
   --fils : in les_fils (fils du noeud � cr�er)
   --noeud_parent : in p_noeud (noeud parent)
   --Pr�-condition : Aucune
   --Post-condition : Un nouveau noeud a �t� cr�� avec les fils et le noeud parent sp�cifi�s.
   --Exception : Aucune
   procedure creer_noeud (creer : in out p_noeud; fils : in les_fils; noeud_parent: in p_noeud);
   
   --Type : procedure
   --Nom : setData
   --S�mantique : Cette proc�dure d�finit les donn�es associ�es � un noeud dans l'arbre de fichiers/dossiers.
   --Param�tres :
   --new_noeud : in out p_noeud (noeud pour lequel les donn�es doivent �tre d�finies)
   --data : in t_data (les donn�es � d�finir pour le noeud)
   --Pr�-condition : Aucune
   --Post-condition : Les donn�es pour le noeud sp�cifi� ont �t� d�finies avec les valeurs sp�cifi�es.
   --Exception : Aucune
   procedure setData (new_noeud : in out p_noeud; data : in t_data);
   
   --Type : function
   --Nom : Vide
   --S�mantique : Cette fonction renvoie vrai si un noeud est vide (null), faux sinon.
   --Param�tres :
   --N : p_noeud (noeud � tester)
   --Retour : Boolean (r�sultat de la v�rification)
   --Pr�-condition : Aucune
   --Post-condition : La fonction renvoie vrai si le noeud est vide (null), faux sinon.
   --Exception : Aucune
   function Vide(N: in p_noeud) return Boolean;
   
end package_arbre;
