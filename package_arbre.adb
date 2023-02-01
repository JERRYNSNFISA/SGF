

package body package_arbre is

   --Type : procedure
   --Nom : creer_noeud
   --Sémantique : Cette procédure crée un nouveau noeud dans l'arbre de fichiers/dossiers.
   procedure creer_noeud (creer : in out p_noeud; fils : in les_fils; noeud_parent: in p_noeud) is
   begin
      creer := new noeud;
      if fils = null then
         creer.all.fils := liste_arbre.Creer_Liste_Vide;
      else
         creer.all.fils := fils;
      end if;
      creer.all.parent := noeud_parent;
   end creer_noeud;
    
   --Type : procedure
   --Nom : setData
   --Sémantique : Cette procédure définit les données associées à un noeud dans l'arbre de fichiers/dossiers.
   procedure setData (new_noeud : in out p_noeud; data : in t_data) is
   begin
      new_noeud.all.donnees := data;
   end setData;
   
   --Type : function
   --Nom : Vide
   --Sémantique : Cette fonction renvoie vrai si un noeud est vide (null), faux sinon.
   function Vide(N: p_noeud) return Boolean is
   begin
      return N = null;
   end Vide;
   
end package_arbre;
