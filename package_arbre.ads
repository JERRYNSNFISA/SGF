with p_Liste;
with Ada.Text_IO; use Ada.Text_IO;

-- Déclaration de la généricité
generic
   type t_data is private;
   
package package_arbre is
   
   -- Déclaration du pointeur noeuds
   
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
   
   
   -- Déclaration des opérations de la liste des noeuds
   
   --Type : procedure
   --Nom : creer_noeud
   --Sémantique : Cette procédure crée un nouveau noeud dans l'arbre de fichiers/dossiers.
   --Paramètres :
   --creer : in out p_noeud (noeud à créer)
   --fils : in les_fils (fils du noeud à créer)
   --noeud_parent : in p_noeud (noeud parent)
   --Pré-condition : Aucune
   --Post-condition : Un nouveau noeud a été créé avec les fils et le noeud parent spécifiés.
   --Exception : Aucune
   procedure creer_noeud (creer : in out p_noeud; fils : in les_fils; noeud_parent: in p_noeud);
   
   --Type : procedure
   --Nom : setData
   --Sémantique : Cette procédure définit les données associées à un noeud dans l'arbre de fichiers/dossiers.
   --Paramètres :
   --new_noeud : in out p_noeud (noeud pour lequel les données doivent être définies)
   --data : in t_data (les données à définir pour le noeud)
   --Pré-condition : Aucune
   --Post-condition : Les données pour le noeud spécifié ont été définies avec les valeurs spécifiées.
   --Exception : Aucune
   procedure setData (new_noeud : in out p_noeud; data : in t_data);
   
   --Type : function
   --Nom : Vide
   --Sémantique : Cette fonction renvoie vrai si un noeud est vide (null), faux sinon.
   --Paramètres :
   --N : p_noeud (noeud à tester)
   --Retour : Boolean (résultat de la vérification)
   --Pré-condition : Aucune
   --Post-condition : La fonction renvoie vrai si le noeud est vide (null), faux sinon.
   --Exception : Aucune
   function Vide(N: in p_noeud) return Boolean;
   
end package_arbre;
