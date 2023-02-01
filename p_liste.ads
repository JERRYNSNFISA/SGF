-- D�claration de la g�n�ricit�
generic
   type Element is private;
   --with function image(Item: in Element) return String;

package P_Liste is
   
   -- D�claration du pointeur liste
   
   type Liste;
   type Liste_Ptr is access Liste;
      type Liste is record
      Valeur : Element;
      Suivant : Liste_Ptr;
   end record;

   -- D�claration des op�rations de la liste chain�e
   
   --Type : function
   --Nom : Creer_Liste_Vide
   --S�mantique : Cette fonction cr�e une liste vide de pointeurs de noeuds.
   --Param�tres : Aucun
   --Valeur de retour : Liste_Ptr (liste vide de pointeurs de noeuds)
   --Pr�-condition : Aucune
   --Post-condition : Une liste vide de pointeurs de noeuds a �t� cr��e.
   --Exception : Aucune
   function Creer_Liste_Vide return Liste_Ptr;
   
   --Type : function
   --Nom : Est_Vide
   --S�mantique : Cette fonction v�rifie si une liste d'arbres est vide.
   --Param�tres :
   --L : Liste_Ptr (liste � v�rifier)
   --Valeur de retour : Boolean (vrai si la liste est vide, faux sinon)
   --Pr�-condition : Aucune
   --Post-condition : La fonction a v�rifi� si la liste est vide.
   --Exception : Aucune
   function Est_Vide(L: Liste_Ptr) return Boolean;
   
   --Type : procedure
   --Nom : Inserer_En_Tete
   --S�mantique : Cette proc�dure ins�re un �l�ment en t�te de la liste.
   --Param�tres :
   --L : in out Liste_Ptr (liste)
   --Nouveau : in Element (nouvel �l�ment � ins�rer)
   --Pr�-condition : Aucune
   --Post-condition : L'�l�ment "Nouveau" a �t� ins�r� en t�te de la liste "L".
   --Exception : Aucune
   procedure Inserer_En_Tete(L: in out Liste_Ptr; Nouveau: in Element);
   
   --Type : procedure
   --Nom : Afficher_Liste
   --S�mantique : Cette proc�dure affiche les �l�ments d'une liste cha�n�e.
   --Param�tres :
   --L : Liste_Ptr (liste � afficher)
   --Pr�-condition : La liste ne doit pas �tre vide.
   --Post-condition : Les �l�ments de la liste sont affich�s.
   --Exception : Aucune
   procedure Afficher_Liste(L: Liste_Ptr);
   
   --Type : function
   --Nom : Rechercher
   --S�mantique : Cette fonction recherche un �l�ment sp�cifi� dans la liste et renvoie un pointeur vers l'�l�ment s'il existe ou null s'il n'existe pas.
   --Param�tres :
   --L : Liste_Ptr (liste � parcourir)
   --E : Element (�l�ment � rechercher)
   --Valeur de retour : Liste_Ptr (pointeur vers l'�l�ment s'il existe, null sinon)
   --Pr�-condition : La liste ne doit pas �tre vide.
   --Post-condition : Un pointeur vers l'�l�ment a �t� renvoy� si l'�l�ment existe dans la liste, sinon null a �t� renvoy�.
   function Rechercher(L: Liste_Ptr; E: Element) return Liste_Ptr;
   
   --Type : procedure
   --Nom : Inserer_Apres
   --S�mantique : Cette proc�dure permet d'ins�rer un nouvel �l�ment apr�s un �l�ment sp�cifi� dans une liste d'arbres.
   --Param�tres :
   --L : Liste_Ptr (liste dans laquelle ins�rer)
   --Nouveau : Element (nouvel �l�ment � ins�rer)
   --Data : Element (�l�ment sp�cifi� apr�s lequel ins�rer)
   --Pr�-condition : La liste L doit exister.
   --Post-condition : Le nouvel �l�ment a �t� ins�r� dans la liste apr�s l'�l�ment sp�cifi�.
   --Exception : Aucune
   procedure Inserer_Apres(L: in out Liste_Ptr; Nouveau: in Element; Data: in Element);
   
   --Type : procedure
   --Nom : Inserer_Avant
   --S�mantique : Cette proc�dure ins�re un nouvel �l�ment dans une liste avant un �l�ment sp�cifique.
   --Param�tres :
   --L : Liste_Ptr (liste dans laquelle ins�rer)
   --Nouveau : Element (nouvel �l�ment � ins�rer)
   --Data : Element (�l�ment avant lequel ins�rer le nouvel �l�ment)
   --Valeur de retour : Aucune
   --Pr�-condition : L'�l�ment Data doit exister dans la liste.
   --Post-condition : Le nouvel �l�ment a �t� ins�r� dans la liste avant l'�l�ment Data.
   --Exception : Aucune
   procedure Inserer_Avant(L: in out Liste_Ptr; Nouveau: in Element; Data: in Element);
   
   --Type : procedure
   --Nom : Enlever
   --S�mantique : Cette proc�dure enl�ve un �l�ment d'une liste.
   --Param�tres :
   --L : Liste_Ptr (liste de laquelle enlever l'�l�ment)
   --E : Element (�l�ment � enlever)
   --Valeur de retour : Aucune
   --Pr�-condition : L'�l�ment E doit exister dans la liste.
   --Post-condition : L'�l�ment E a �t� enlev� de la liste.
   --Exception : Aucune
   procedure Enlever(L: in out Liste_Ptr; E: in Element);
   
   --Type : procedure
   --Nom : Vider_Liste
   --S�mantique : Cette proc�dure vide une liste d'arbres.
   --Param�tres :
   --L : Liste_Ptr (liste � vider)
   --Pr�-condition : Aucune
   --Post-condition : La liste a �t� vid�e.
   --Exception : Aucune
   procedure Vider_Liste(L: in out Liste_Ptr);

end P_Liste;
