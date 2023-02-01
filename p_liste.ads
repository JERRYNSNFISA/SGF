-- Déclaration de la généricité
generic
   type Element is private;
   --with function image(Item: in Element) return String;

package P_Liste is
   
   -- Déclaration du pointeur liste
   
   type Liste;
   type Liste_Ptr is access Liste;
      type Liste is record
      Valeur : Element;
      Suivant : Liste_Ptr;
   end record;

   -- Déclaration des opérations de la liste chainée
   
   --Type : function
   --Nom : Creer_Liste_Vide
   --Sémantique : Cette fonction crée une liste vide de pointeurs de noeuds.
   --Paramètres : Aucun
   --Valeur de retour : Liste_Ptr (liste vide de pointeurs de noeuds)
   --Pré-condition : Aucune
   --Post-condition : Une liste vide de pointeurs de noeuds a été créée.
   --Exception : Aucune
   function Creer_Liste_Vide return Liste_Ptr;
   
   --Type : function
   --Nom : Est_Vide
   --Sémantique : Cette fonction vérifie si une liste d'arbres est vide.
   --Paramètres :
   --L : Liste_Ptr (liste à vérifier)
   --Valeur de retour : Boolean (vrai si la liste est vide, faux sinon)
   --Pré-condition : Aucune
   --Post-condition : La fonction a vérifié si la liste est vide.
   --Exception : Aucune
   function Est_Vide(L: Liste_Ptr) return Boolean;
   
   --Type : procedure
   --Nom : Inserer_En_Tete
   --Sémantique : Cette procédure insère un élément en tête de la liste.
   --Paramètres :
   --L : in out Liste_Ptr (liste)
   --Nouveau : in Element (nouvel élément à insérer)
   --Pré-condition : Aucune
   --Post-condition : L'élément "Nouveau" a été inséré en tête de la liste "L".
   --Exception : Aucune
   procedure Inserer_En_Tete(L: in out Liste_Ptr; Nouveau: in Element);
   
   --Type : procedure
   --Nom : Afficher_Liste
   --Sémantique : Cette procédure affiche les éléments d'une liste chaînée.
   --Paramètres :
   --L : Liste_Ptr (liste à afficher)
   --Pré-condition : La liste ne doit pas être vide.
   --Post-condition : Les éléments de la liste sont affichés.
   --Exception : Aucune
   procedure Afficher_Liste(L: Liste_Ptr);
   
   --Type : function
   --Nom : Rechercher
   --Sémantique : Cette fonction recherche un élément spécifié dans la liste et renvoie un pointeur vers l'élément s'il existe ou null s'il n'existe pas.
   --Paramètres :
   --L : Liste_Ptr (liste à parcourir)
   --E : Element (élément à rechercher)
   --Valeur de retour : Liste_Ptr (pointeur vers l'élément s'il existe, null sinon)
   --Pré-condition : La liste ne doit pas être vide.
   --Post-condition : Un pointeur vers l'élément a été renvoyé si l'élément existe dans la liste, sinon null a été renvoyé.
   function Rechercher(L: Liste_Ptr; E: Element) return Liste_Ptr;
   
   --Type : procedure
   --Nom : Inserer_Apres
   --Sémantique : Cette procédure permet d'insérer un nouvel élément après un élément spécifié dans une liste d'arbres.
   --Paramètres :
   --L : Liste_Ptr (liste dans laquelle insérer)
   --Nouveau : Element (nouvel élément à insérer)
   --Data : Element (élément spécifié après lequel insérer)
   --Pré-condition : La liste L doit exister.
   --Post-condition : Le nouvel élément a été inséré dans la liste après l'élément spécifié.
   --Exception : Aucune
   procedure Inserer_Apres(L: in out Liste_Ptr; Nouveau: in Element; Data: in Element);
   
   --Type : procedure
   --Nom : Inserer_Avant
   --Sémantique : Cette procédure insère un nouvel élément dans une liste avant un élément spécifique.
   --Paramètres :
   --L : Liste_Ptr (liste dans laquelle insérer)
   --Nouveau : Element (nouvel élément à insérer)
   --Data : Element (élément avant lequel insérer le nouvel élément)
   --Valeur de retour : Aucune
   --Pré-condition : L'élément Data doit exister dans la liste.
   --Post-condition : Le nouvel élément a été inséré dans la liste avant l'élément Data.
   --Exception : Aucune
   procedure Inserer_Avant(L: in out Liste_Ptr; Nouveau: in Element; Data: in Element);
   
   --Type : procedure
   --Nom : Enlever
   --Sémantique : Cette procédure enlève un élément d'une liste.
   --Paramètres :
   --L : Liste_Ptr (liste de laquelle enlever l'élément)
   --E : Element (élément à enlever)
   --Valeur de retour : Aucune
   --Pré-condition : L'élément E doit exister dans la liste.
   --Post-condition : L'élément E a été enlevé de la liste.
   --Exception : Aucune
   procedure Enlever(L: in out Liste_Ptr; E: in Element);
   
   --Type : procedure
   --Nom : Vider_Liste
   --Sémantique : Cette procédure vide une liste d'arbres.
   --Paramètres :
   --L : Liste_Ptr (liste à vider)
   --Pré-condition : Aucune
   --Post-condition : La liste a été vidée.
   --Exception : Aucune
   procedure Vider_Liste(L: in out Liste_Ptr);

end P_Liste;
