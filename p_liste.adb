with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package body P_Liste is

   --Type : function
   --Nom : Creer_Liste_Vide
   --S�mantique : Cette fonction cr�e une liste vide de pointeurs de noeuds.
   function Creer_Liste_Vide return Liste_Ptr is
   begin
      return null;
   end Creer_Liste_Vide;

   --Type : function
   --Nom : Est_Vide
   --S�mantique : Cette fonction v�rifie si une liste d'arbres est vide.
   function Est_Vide(L: Liste_Ptr) return Boolean is
   begin
      return L = null;
   end Est_Vide;

   --Type : procedure
   --Nom : Inserer_En_Tete
   --S�mantique : Cette proc�dure ins�re un �l�ment en t�te de la liste.
   procedure Inserer_En_Tete(L: in out Liste_Ptr; Nouveau: in Element) is
      Element_Nouveau : Liste_Ptr;
   begin
      Element_Nouveau := new Liste'(Valeur => Nouveau, Suivant => L);
      L := Element_Nouveau;
   end Inserer_En_Tete;

   --Type : procedure
   --Nom : Afficher_Liste
   --S�mantique : Cette proc�dure affiche les �l�ments d'une liste cha�n�e.
   procedure Afficher_Liste(L: Liste_Ptr) is
   begin
      if not Est_Vide(L) then
         --Put(To_String(L.Valeur);
         Afficher_Liste(L.Suivant);
      end if;
   end Afficher_Liste;

   --Type : function
   --Nom : Rechercher
   --S�mantique : Cette fonction recherche un �l�ment sp�cifi� dans la liste et renvoie un pointeur vers l'�l�ment s'il existe ou null s'il n'existe pas.
   function Rechercher(L: Liste_Ptr; E: Element) return Liste_Ptr is
   begin
      if Est_Vide(L) then
         return null;
      elsif L.Valeur = E then
         return L;
      else
         return Rechercher(L.Suivant, E);
      end if;
   end Rechercher;

   --Type : procedure
   --Nom : Inserer_Apres
   --S�mantique : Cette proc�dure permet d'ins�rer un nouvel �l�ment apr�s un �l�ment sp�cifi� dans une liste d'arbres.
   procedure Inserer_Apres(L: in out Liste_Ptr; Nouveau: in Element; Data: in Element) is
      Element_Data : Liste_Ptr;
      Element_Nouveau : Liste_Ptr;
   begin
      Element_Data := Rechercher(L, Data);
      if Element_Data /= null then
         Element_Nouveau := new Liste'(Valeur => Nouveau, Suivant => Element_Data.Suivant);
         Element_Data.Suivant := Element_Nouveau;
      end if;
   end Inserer_Apres;

   --Type : procedure
   --Nom : Inserer_Avant
   --S�mantique : Cette proc�dure ins�re un nouvel �l�ment dans une liste avant un �l�ment sp�cifique.
   procedure Inserer_Avant(L: in out Liste_Ptr; Nouveau: in Element; Data: in Element) is
      Element_Data : Liste_Ptr;
      Element_Nouveau : Liste_Ptr;
      Element_Courant : Liste_Ptr;
   begin
      Element_Data := Rechercher(L, Data);
      if Element_Data /= null then
         Element_Nouveau := new Liste'(Valeur => Nouveau, Suivant => Element_Data);
         Element_Courant := L;
         while Element_Courant.Suivant /= Element_Data loop
            Element_Courant := Element_Courant.Suivant;
         end loop;
         Element_Courant.Suivant := Element_Nouveau;
      end if;
   end Inserer_Avant;

   --Type : procedure
   --Nom : Enlever
   --S�mantique : Cette proc�dure enl�ve un �l�ment d'une liste.
   procedure Enlever(L: in out Liste_Ptr; E: in Element) is
      Element_E : Liste_Ptr;
      Element_Courant : Liste_Ptr;
   begin
      Element_E := Rechercher(L, E);
      if Element_E /= null then
         Element_Courant := L;
         if Element_Courant = Element_E then
            L := Element_Courant.suivant;
         else
            while Element_Courant.Suivant /= Element_E loop
               Element_Courant := Element_Courant.Suivant;
            end loop;
            Element_Courant.Suivant := Element_E.Suivant;
         end if;
      end if;
   end Enlever;

   --Type : procedure
   --Nom : Vider_Liste
   --S�mantique : Cette proc�dure vide une liste d'arbres.
   procedure Vider_Liste(L: in out Liste_Ptr) is
      Element_Courant : Liste_Ptr;
   begin
      while not Est_Vide(L) loop
         Element_Courant := L;
         L := L.Suivant;
      end loop;
   end Vider_Liste;

end P_Liste;
