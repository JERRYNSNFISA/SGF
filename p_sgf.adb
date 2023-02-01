
package body p_sgf is
   
   --Type : procedure
   --Nom : chemin_menu
   --Sémantique : La procédure décompose une commande en entrée sous forme de chaîne non bornée en un tableau de paramètres en entrée/sortie.
   procedure chemin_menu (commande : in Unbounded_String; parametre : in out TAB_parametre) is
      index_char : Integer;
      nbr_parametre : Integer;
      longueur_param : Integer;
      
   begin
      nbr_parametre := 1;
      index_char:= 1;
      
      for i in parametre'Range loop
         parametre(i) := To_Unbounded_String("");
         longueur_param := i;
      end loop;
      
      while (index_char <= Length(commande)) loop
         if (Element(commande, index_char) = ' ') then
            if nbr_parametre < longueur_param then 
               nbr_parametre := nbr_parametre + 1;
            else
               raise trop_de_parametre; 
            end if;
         else
            parametre(nbr_parametre) := parametre(nbr_parametre) & Element(commande, index_char);
         end if;
         index_char := index_char + 1;        
      end loop;
 
   end chemin_menu;
   
   --Type : procedure
   --Nom : chemin_sgf
   --Sémantique : Procédure qui analyse et traite la commande pour obtenir les différents paramètres qui la composent.
   procedure chemin_sgf (commande : in Unbounded_String; parametre : in out TAB_parametre) is
      index_char : Integer;
      nbr_parametre : Integer;
      longueur_param : Integer;
      
   begin
      --vérif avant parsing
      if commande = "/" then
         raise chemin_inexistant;
      end if;
      
      index_char := 1;
      if commande /= "" then
         if Element(commande, index_char) = '/' then
            index_char := 2;
            if Element (commande, index_char) = '/' then
               raise erreur_commande;
            end if;
         end if;
      end if;
      
      index_char:= 1;
      if commande /= "" then
         while (index_char < Length(commande)) loop
            index_char := index_char + 1;
         end loop;
  
         if Element(commande, index_char) = ('/') then
            raise chemin_inexistant;
         end if;
      end if;
      
      
      -- parsing des '/'
      
      index_char:= 1;
      nbr_parametre := 1;
      
      for i in parametre'Range loop
         parametre(i) := To_Unbounded_String("");
         longueur_param := i;
      end loop;
      
      
      while (index_char <= Length(commande)) loop
         if (Element(commande, index_char) = '/') then
            if nbr_parametre < longueur_param then 
               nbr_parametre := nbr_parametre + 1;
            else
               raise trop_de_parametre;
            end if;
         else
            parametre(nbr_parametre) := parametre(nbr_parametre) & Element(commande, index_char);
         end if;
         index_char := index_char + 1;        
      end loop;
 
   end chemin_sgf; 
   
   --Type : function
   --Nom : existe
   --Sémantique : La fonction vérifie si un nom de noeud donné existe dans une liste de fils d'arbre. Si le nom de noeud existe, la fonction retourne True et le noeud courant est mis à jour pour être égal au noeud correspondant. 
   -- Sinon, la fonction retourne False.
   function existe (noeud_courant : in out t_noeud; Temp: in out arbre.les_fils; name_node : in Unbounded_String) return Boolean is
   begin
      while not arbre.liste_arbre.Est_Vide(Temp) loop
         if (Temp.all.Valeur.all.donnees.nom = name_node) then 
            noeud_courant := Temp.all.Valeur; 
            return Temp.all.Valeur.all.donnees.nom = name_node;
         else
            Temp := Temp.all.Suivant;
         end if;
      end loop;
      return False;
   end existe;
   
   --Type : procedure
   --Nom : param_chemin
   --Sémantique : La procédure traite le premier paramètre d'un tableau de paramètres entré en entrée, et met à jour un pointeur vers un noeud de l'arbre de fichiers, selon la valeur de ce premier paramètre.
   procedure param_chemin (temp : in out current; parametre : in TAB_parametre; index : in out Integer) is 
   begin
      
      if parametre(1) /= "" then
         index := 1;
      end if;
      
      if parametre(1) = "" then
         if parametre(2) = "Root" then
            temp.rep_courant := temp.rep_racine;
            index := 3;
         else
            if parametre(2) = "" then
               index := 1;
            else
               raise chemin_inexistant;
            end if;
         end if;
      end if;
       
      if parametre(index) = ".." then
         while parametre(index) = ".." loop 
            if not arbre.Vide(temp.rep_courant.all.parent) then
               temp.rep_courant := temp.rep_courant.all.parent;
               index := index + 1;
            else
               raise chemin_inexistant;
            end if ;
         end loop;
      end if;
      
   end param_chemin;
   
   --Type : procedure
   --Nom : dernier_param
   --Sémantique : La procédure détermine le dernier paramètre valide dans un tableau de paramètres.
   procedure dernier_param (parametre_tab : in TAB_parametre; courant_racine : in out current; index: in out Integer) is 
      indice : Integer;
      last_indice : Integer;
      Temp_fils : arbre.les_fils;
   begin
      indice := index;
      param_chemin(courant_racine, parametre_tab, indice);
      last_indice := indice;
      
      while (parametre_tab(last_indice) /= "") and (last_indice <= 49)  loop  
         last_indice := last_indice + 1;
      end loop;
      
      if parametre_tab(last_indice) = "" then -- si à 50 ya rien, on fait -1 mais sinon ce sera -1 en général 
         last_indice := last_indice - 1;
      end if;
      
      if last_indice = 0 or (parametre_tab(1) = "" and parametre_tab(2) = "Root" and parametre_tab(3) = "") then
         raise chemin_inexistant;
      end if;
      
      while (parametre_tab(indice) /= "") and (indice < last_indice)  loop
         Temp_fils := courant_racine.rep_courant.all.fils;
         if existe(courant_racine.rep_courant, Temp_fils, parametre_tab(indice)) then
            if Temp_fils.all.Valeur.all.donnees.type_contenu = True then
               indice := indice + 1;
            else
               raise erreur_element;
            end if;  
         else            
            raise element_inexistant;           
         end if;
      end loop;
      index := last_indice;
   end dernier_param; 
   
   --Type : procedure
   --Nom : memoire
   --Sémantique : La procédure met à jour la taille des noeuds dans l'arbre de fichiers en parcourant depuis le noeud courant vers la racine de l'arbre, en ajoutant ou soustractant une valeur donnée en entrée.
   procedure memoire (courant_racine : in t_noeud; plus_ou_moins : in Boolean; valeur : in Integer) is
      Temp : t_noeud;
      c : data;
   begin
      Temp := courant_racine;
      if plus_ou_moins = true then
         while not arbre.Vide(Temp) loop
            c := Temp.all.donnees;
            c.taille := c.taille + valeur; 
            arbre.setData(Temp, c);
            Temp := Temp.all.parent;
         end loop;
      else
         while not arbre.Vide(Temp) loop
            c := Temp.all.donnees;
            c.taille := c.taille - valeur; 
            arbre.setData(Temp, c);
            Temp := Temp.all.parent;
         end loop;
      end if;
   end memoire;
   
   --Type : procedure
   --Nom : verif_memoire
   --Sémantique : La procédure vérifie si la capacité de mémoire du système sera atteinte si un certain nombre de données est ajouté.
   procedure verif_memoire (racine : in t_noeud; valeur : in Integer) is
   begin
      if 1e8 < racine.all.donnees.taille + valeur then -- 1 tera = 1e12 mais ce n'est pas possible donc on fait 100 Mega-Octets = 1e8
         raise capacite_memoire_atteint;
      end if;
   end verif_memoire;
   
   --Type : procedure
   --Nom : creation_racine
   --Sémantique : La procédure crée un noeud racine pour un arbre de fichiers, en y assignant des valeurs par défaut pour ses champs de données (type_contenu, nom, droits_acces, taille, contenu).
   -- Ensuite, le pointeur vers la racine de l'arbre est mis à jour dans le premier paramètre d'entrée, qui est un objet courant_racine.
   procedure creation_racine (courant_racine : in out current) is
      racine : t_noeud;
      c : data;
   begin
      c.type_contenu := True;
      c.nom := To_Unbounded_String("Root");
      c.droits_acces(1) := 7;
      c.droits_acces(2) := 0;
      c.droits_acces(3) := 0;
      c.taille := 10000;
      c.contenu := To_Unbounded_String("");
     
      arbre.creer_noeud(racine, null, null);
      arbre.setData(racine, c);
      courant_racine.rep_racine := racine;
      courant_racine.rep_courant := courant_racine.rep_racine;
   end creation_racine;
   
   --Type : procedure
   --Nom : cd
   --Sémantique : La procédure traite les paramètres d'un tableau de paramètres entré en entrée pour déterminer le chemin du noeud cible, et met à jour le pointeur vers ce noeud dans l'arbre de fichiers.
   procedure cd (parametre_tab : in TAB_parametre; courant_racine : in out current) is
      indice : Integer ;
      record_temp : current;
      Temp_fils : arbre.les_fils;
      tab_param : TAB_parametre;
   begin
      if not (parametre_tab(2) /= "" and parametre_tab(3) = "") then
         raise erreur_commande;  
      end if;
      
      indice := 1 ;
      record_temp := courant_racine;

      chemin_sgf(parametre_tab(2), tab_param);
      
      param_chemin(record_temp, tab_param, indice);

      while (tab_param(indice) /= "") and (indice <= 50)  loop 
         Temp_fils := record_temp.rep_courant.all.fils;
         if existe(record_temp.rep_courant, Temp_fils, tab_param(indice)) then
            if Temp_fils.all.Valeur.all.donnees.type_contenu = True then
               indice := indice + 1;
            else
               raise erreur_element;
            end if;  
         else            
            raise element_inexistant;            
         end if;           
      end loop;
      courant_racine := record_temp;
   end cd;   
    
   --Type : procedure
   --Nom : ls
   --Sémantique : La procédure liste les éléments du dossier ou du fichier correspondant au chemin d'accès donné en paramètre. Si le chemin d'accès est vide, elle liste les éléments du dossier courant.élément_inexistant".
   procedure ls (parametre_tab : in TAB_parametre; courant_racine : in current) is
      indice : Integer;
      record_temp : current;
      Temp_fils : arbre.les_fils;
      tab_param : TAB_parametre;
      
   begin
      
      if parametre_tab(3) /= "" then
         raise erreur_commande;
      end if;
      
      indice := 1 ;
      chemin_sgf(parametre_tab(2), tab_param);
      record_temp := courant_racine;
      param_chemin(record_temp, tab_param, indice);
      if tab_param(indice) = "" then 
         Temp_fils := record_temp.rep_courant.all.fils;
      else
         while (tab_param(indice) /= "") and (indice <= 50)  loop 
            Temp_fils := record_temp.rep_courant.all.fils;
            if existe(record_temp.rep_courant, Temp_fils, tab_param(indice)) then
               if Temp_fils.all.Valeur.all.donnees.type_contenu = True then
                  indice := indice + 1;
               else
                  raise erreur_element;
               end if;  
            else            
               raise element_inexistant;            
            end if;          
         end loop;
         Temp_fils := record_temp.rep_courant.all.fils;
      end if;
       
      while not arbre.liste_arbre.Est_Vide(Temp_fils) loop
         
         put("    ");
         
         if Temp_fils.all.Valeur.all.donnees.type_contenu = True then
            Put('d');
         elsif Temp_fils.all.Valeur.all.donnees.type_contenu = False then
            Put('-');
         end if;
         
         for i in 1..3 loop
            if Temp_fils.all.Valeur.all.donnees.droits_acces(i) = 0 then
               Put("---");
            elsif Temp_fils.all.Valeur.all.donnees.droits_acces(i) = 1 then
               Put("r--");
            elsif Temp_fils.all.Valeur.all.donnees.droits_acces(i) = 2 then
               Put("-w-");
            elsif Temp_fils.all.Valeur.all.donnees.droits_acces(i) = 3 then
               Put("rw-");
            elsif Temp_fils.all.Valeur.all.donnees.droits_acces(i) = 4 then
               Put("--x");
            elsif Temp_fils.all.Valeur.all.donnees.droits_acces(i) = 5 then
               Put("r-x");
            elsif Temp_fils.all.Valeur.all.donnees.droits_acces(i) = 6 then
               Put("-wx");
            elsif Temp_fils.all.Valeur.all.donnees.droits_acces(i) = 7 then
               Put("rwx");
            end if;
         end loop;
         Put("   ");
         put (To_String(Temp_fils.all.Valeur.all.donnees.nom));
         Put("   ");
         Put(Integer'Image(Temp_fils.all.Valeur.all.donnees.taille));
         Temp_fils := Temp_fils.all.Suivant;
         
         if not arbre.liste_arbre.Est_Vide(Temp_fils) then
            New_Line;
         end if;
         
      end loop;
   end ls;
   
   
   --Type : procedure
   --Nom : ls_r
   --Sémantique : Procédure qui affiche les éléments d'un répertoire ou d'un sous-répertoire de l'arbre de fichiers/dossiers.
   procedure ls_r (parametre_tab : in TAB_parametre; courant_racine : in current) is
      indice : Integer;
      record_temp : current;
      Temp_fils : arbre.les_fils;
      tab_param : TAB_parametre;
      espace_tab : Integer;
      Temp_bis : arbre.les_fils;
   begin
      if parametre_tab(4) /= "" then
         raise erreur_commande;
      end if;
      
      indice := 1 ;
      chemin_sgf(parametre_tab(3), tab_param);
      record_temp := courant_racine;
      param_chemin(record_temp, tab_param, indice);
      Temp_fils := record_temp.rep_courant.all.fils;
      while (tab_param(indice) /= "") and (indice <= 50)  loop        
         if existe(record_temp.rep_courant, Temp_fils, tab_param(indice)) then
            if Temp_fils.all.Valeur.all.donnees.type_contenu = True then
               indice := indice + 1;
               Temp_fils := record_temp.rep_courant.all.fils;
            else
               raise erreur_element;
            end if;  
         else            
           raise element_inexistant;            
         end if;          
      end loop;
      
      Temp_bis := arbre.liste_arbre.Creer_Liste_Vide;
      arbre.liste_arbre.Inserer_En_Tete(temp_bis, record_temp.rep_courant);
      espace_tab := 1;
       
      put("    "); put("|");
      put("\- "); put (To_String(record_temp.rep_courant.all.donnees.nom));

      while not arbre.liste_arbre.Est_Vide(Temp_bis) loop 

         if not arbre.liste_arbre.Est_Vide(Temp_fils) then 
            while Temp_fils.all.Valeur.all.donnees.type_contenu = false loop
               New_Line; put("    "); put("|");
               for i in 1..espace_tab loop
                  put("    ");
               end loop;
               put("|"); put(To_String(Temp_fils.all.Valeur.all.donnees.nom));
               Temp_fils := Temp_fils.all.Suivant;
               if arbre.liste_arbre.Est_Vide(Temp_fils) then
                  exit;
               end if;
            end loop;
         end if;

         if not arbre.liste_arbre.Est_Vide(Temp_fils) then
            if Temp_fils.all.Valeur.all.donnees.type_contenu = true then
               New_Line; put("    "); put("|");
               for i in 1..espace_tab loop
                  put("    ");
               end loop;
               put("\- "); put (To_String(Temp_fils.all.Valeur.all.donnees.nom));
               espace_tab := espace_tab + 1;
               arbre.liste_arbre.Inserer_En_Tete(Temp_bis, Temp_fils.all.valeur);
               Temp_fils := Temp_fils.all.Valeur.all.fils;
            end if;
         end if;

         if arbre.liste_arbre.Est_Vide(Temp_fils) then
            espace_tab := espace_tab - 1;
            if not arbre.Vide(Temp_bis.all.Valeur.all.parent) then
               Temp_fils := Temp_bis.all.Valeur.all.parent.all.fils;
               while not arbre.liste_arbre.Est_Vide(Temp_fils.all.Valeur.all.parent.all.fils) loop
                  if (Temp_bis.all.Valeur.all.donnees.nom = Temp_fils.all.valeur.all.donnees.nom) then 
                     Temp_fils := Temp_fils.all.suivant;
                     exit;
                  else
                     Temp_fils := Temp_fils.all.suivant;
                  end if;
               end loop;
            end if;
            Temp_bis:= Temp_bis.all.suivant;
         end if;
      end loop;
   end ls_r;
    
   --Type : procedure
   --Nom : rm_ou_rmr
   --Sémantique : Procédure qui permet de supprimer un élément ou un sous-répertoire dans l'arbre de fichiers/dossiers.
   procedure rm_ou_rmr (parametre_tab : in TAB_parametre; courant_racine : in current; Bool : in Boolean) is
      record_temp : current;
      Temp_fils : arbre.les_fils;
      tab_param : TAB_parametre;
      last_indice : Integer;
      memoire_bool : Boolean;
      valeur : Integer;
   begin
      last_indice := 1 ;
      if Bool = False then
         if parametre_tab(4) /= "" then
            raise erreur_commande;
         else
            chemin_sgf (parametre_tab(3), tab_param); --rm_r
         end if;
      else
         if parametre_tab(3) /= "" then
            raise erreur_commande;
         else
            chemin_sgf (parametre_tab(2), tab_param); --rm
         end if;
      end if;
      
      record_temp := courant_racine;
      dernier_param(tab_param, record_temp, last_indice);
      
      Temp_fils := record_temp.rep_courant.all.fils;
      if existe(record_temp.rep_courant, Temp_fils, tab_param(last_indice)) then
         if Bool = false then
            if record_temp.rep_courant.all.donnees.type_contenu = true then 
               valeur := record_temp.rep_courant.all.donnees.taille;
               arbre.liste_arbre.Enlever(record_temp.rep_courant.all.parent.all.fils, record_temp.rep_courant);
            else
               raise erreur_element;
            end if;
         else
            if Temp_fils.all.Valeur.donnees.type_contenu = False then 
               valeur := record_temp.rep_courant.all.donnees.taille;
               arbre.liste_arbre.Enlever(record_temp.rep_courant.all.parent.all.fils, record_temp.rep_courant);
            else
               raise erreur_element;
            end if;
         end if;
      else
         raise element_inexistant;
      end if;
      memoire_bool := False;
      memoire(record_temp.rep_courant, memoire_bool, valeur);
   end rm_ou_rmr;
   
   --Type : procedure
   --Nom : cpr_ou_mv
   --Sémantique : Procédure qui effectue une opération de copie ou de déplacement d'un élément dans l'arbre de fichiers/dossiers.
   procedure cpr_ou_mv (parametre_tab : in TAB_parametre; courant_racine : in current; Bool : in Boolean) is
      last_indice : Integer;
      record_temp : current;
      record_temp_2 : current;
      Temp_fils : arbre.les_fils;
      c : data;
      new_noeud : t_noeud;
      tab_param : TAB_parametre;
      memoire_bool : Boolean;
   begin
      --indice := 2;
         
      
      last_indice := 1;
      if Bool = False then
         if parametre_tab(4) /= "" then
            raise erreur_commande;
         else
            chemin_sgf (parametre_tab(2), tab_param); --mv
         end if;
      else
         if parametre_tab(5) /= "" then
            raise erreur_commande;
         else
            chemin_sgf (parametre_tab(3), tab_param); --cp_r
         end if;
      end if;
      --put(To_String(parametre_tab(3)));
      record_temp := courant_racine;
      dernier_param (tab_param, record_temp, last_indice);
      
      while (tab_param(last_indice) /= "") and (last_indice <= 50)  loop
         Temp_fils := record_temp.rep_courant.all.fils;
         if Bool = false then
            if existe(record_temp.rep_courant, Temp_fils, tab_param(last_indice)) then
               if Temp_fils.all.Valeur.donnees.type_contenu = False then
                  last_indice := last_indice + 1; 
               else            
                  raise erreur_element;                       
               end if; 
            else            
               raise element_inexistant; 
            end if; 
         else
            if existe(record_temp.rep_courant, Temp_fils, tab_param(last_indice)) then
               last_indice := last_indice + 1;
            else            
               raise element_inexistant;            
            end if;
         end if;
      end loop;
         
      record_temp_2 := courant_racine;
      last_indice := 1;
      if Bool = False then
         chemin_sgf (parametre_tab(3), tab_param); --mv
      else 
         chemin_sgf (parametre_tab(4), tab_param); --cp_r
      end if;
      dernier_param(tab_param, record_temp_2, last_indice);
      
      while (tab_param(last_indice) /= "") and (last_indice <= 50)  loop
         Temp_fils := record_temp_2.rep_courant.all.fils;
         if existe(record_temp_2.rep_courant, Temp_fils, tab_param(last_indice)) then 
            raise element_present;
         else
            if not arbre.Vide(record_temp.rep_courant) then
               c.type_contenu := record_temp.rep_courant.all.donnees.type_contenu; 
               c.nom := tab_param(last_indice);         
               c.droits_acces := record_temp.rep_courant.all.donnees.droits_acces;         
               c.taille := record_temp.rep_courant.all.donnees.taille;
               if Bool = True then
                  verif_memoire(record_temp.rep_racine, c.taille);
               end if;
               c.contenu := record_temp.rep_courant.all.donnees.contenu;
               arbre.creer_noeud(new_noeud, record_temp.rep_courant.all.fils, record_temp_2.rep_courant);
               arbre.setData(new_noeud, c); 
               arbre.liste_arbre.Inserer_En_Tete(record_temp_2.rep_courant.all.fils, new_noeud);
               if Bool = False then
                  arbre.liste_arbre.Enlever(record_temp.rep_courant.all.parent.all.fils, record_temp.rep_courant);
               end if;
            end if;
            last_indice := last_indice + 1;
         end if;
      end loop;
      
      if Bool = false then
         memoire_bool := False;
         memoire(record_temp.rep_courant, memoire_bool, c.taille);
      end if;
      
      memoire_bool := True;
      memoire(record_temp_2.rep_courant, memoire_bool, c.taille);

   end cpr_ou_mv;
   
   --Type : procedure
   --Nom : tar
   --Sémantique : Procédure qui archive un fichier ou un sous-répertoire de l'arbre de fichiers/dossiers en créant un fichier .tar.
   procedure tar (parametre_tab : in TAB_parametre; courant_racine : in current) is
      last_indice : Integer;
      record_temp : current;
      courant_temp : t_noeud;  
      Temp_fils : arbre.les_fils;
      c : data;
      new_noeud : t_noeud;
      tab_param : TAB_parametre;
      memoire_bool : Boolean;
      verif_tar : Unbounded_String;
   begin
      last_indice := 1;
      if parametre_tab(3) /= "" then
         raise erreur_commande;
      else
         chemin_sgf (parametre_tab(2), tab_param); --mv
      end if;
      record_temp := courant_racine;
      dernier_param (tab_param, record_temp, last_indice);
      
      while (tab_param(last_indice) /= "") and (last_indice <= 50)  loop
         Temp_fils := record_temp.rep_courant.all.fils;
         if existe(record_temp.rep_courant, Temp_fils, tab_param(last_indice)) then
            if Temp_fils.all.Valeur.donnees.type_contenu = true then
               courant_temp := record_temp.rep_courant.all.parent;
               Temp_fils := courant_temp.all.fils;
               verif_tar := tab_param(last_indice) & ".tar";
               if not existe(courant_temp, Temp_fils, verif_tar) then
                  if not arbre.Vide(record_temp.rep_courant) then
                     c.type_contenu := False; 
                     c.nom := tab_param(last_indice) & ".tar";         
                     c.droits_acces := record_temp.rep_courant.all.donnees.droits_acces;         
                     c.taille := record_temp.rep_courant.all.donnees.taille;
                     verif_memoire(record_temp.rep_racine, c.taille);
                     c.contenu := record_temp.rep_courant.all.donnees.contenu;
                     arbre.creer_noeud(new_noeud, record_temp.rep_courant.all.fils, record_temp.rep_courant.all.parent);
                     arbre.setData(new_noeud, c); 
                     arbre.liste_arbre.Inserer_En_Tete(record_temp.rep_courant.all.parent.all.fils, new_noeud);
                  end if;
               else 
                  raise element_present;
               end if;
            else            
               raise erreur_element;                       
            end if; 
         else            
            raise element_inexistant; 
         end if; 
         last_indice := last_indice + 1;
      end loop;
      memoire_bool := True;
      memoire(record_temp.rep_courant.all.parent, memoire_bool, c.taille);
   end tar;
      
   --Type : procedure
   --Nom : pwd
   --Sémantique : Procédure qui affiche le chemin du répertoire courant dans l'arbre de fichiers/dossiers.
   procedure pwd (courant_racine : in current; liste : in out arbre.les_fils) is
      repertoire_temp : t_noeud;   
   begin
      repertoire_temp := courant_racine.rep_courant;
        
      liste := arbre.liste_arbre.Creer_Liste_Vide;

      while not arbre.Vide(repertoire_temp.all.parent) loop
         arbre.liste_arbre.Inserer_En_Tete(liste, repertoire_temp);
         repertoire_temp := repertoire_temp.all.parent;
      end loop;
      arbre.liste_arbre.Inserer_En_Tete(liste, repertoire_temp);
   end pwd;
   
   --Type : procedure
   --Nom : mkdir_ou_touch
   --Sémantique : Procédure qui crée un dossier ou un fichier dans l'arbre de fichiers/dossiers.
   procedure mkdir_ou_touch (parametre_tab : in TAB_parametre; courant_racine : in current; Bool : in Boolean) is
      c : data;
      new_noeud : t_noeud;
      record_temp : current;
      Temp_fils : arbre.les_fils;
      tab_param : TAB_parametre;
      last_indice : Integer;
      memoire_bool : Boolean;
   begin
      if parametre_tab(3) /= "" then
         raise erreur_commande;
      end if;
      
      last_indice := 1 ;
      chemin_sgf(parametre_tab(2), tab_param);
      record_temp := courant_racine;
      dernier_param(tab_param, record_temp, last_indice);
      
      Temp_fils := record_temp.rep_courant.all.fils;

      if existe(record_temp.rep_courant, Temp_fils, tab_param(last_indice)) then 
         raise element_present;
      else
         if Bool = false then
            c.type_contenu := False;
            c.taille := 5000;         
         else
            c.type_contenu := True;        
            c.taille := 10000;         
         end if;
         verif_memoire(record_temp.rep_racine, c.taille);
         c.nom := tab_param(last_indice);         
         c.droits_acces(1) := 7;
         c.droits_acces(2) := 0;
         c.droits_acces(3) := 0;
         c.contenu := To_Unbounded_String("");
         arbre.creer_noeud(new_noeud, null, record_temp.rep_courant);
         arbre.setData(new_noeud, c); 
         arbre.liste_arbre.Inserer_En_Tete(record_temp.rep_courant.all.fils, new_noeud);
      end if;
      memoire_bool := True;
      memoire(record_temp.rep_courant, memoire_bool, c.taille);
   end mkdir_ou_touch;
   
   --Type : procedure
   --Nom : edit
   --Sémantique : Procédure qui modifie le contenu d'un fichier dans l'arbre de fichiers/dossiers.
   procedure edit (parametre_tab : in TAB_parametre; courant_racine : in current) is 
      record_temp : current;
      Temp_fils : arbre.les_fils;
      tab_param : TAB_parametre;
      last_indice : Integer;
      memoire_bool : Boolean;
      c : data;
   begin
      if parametre_tab(3) /= "" then
         raise erreur_commande;
      end if;
      
      last_indice := 1 ;
      chemin_sgf(parametre_tab(2), tab_param);
      record_temp := courant_racine;
      dernier_param(tab_param, record_temp, last_indice);
      
      Temp_fils := record_temp.rep_courant.all.fils;
      if existe(record_temp.rep_courant, Temp_fils, tab_param(last_indice)) then 
         if Temp_fils.all.Valeur.donnees.type_contenu = False then 
            memoire_bool := False;
            memoire(record_temp.rep_courant, memoire_bool, Length(record_temp.rep_courant.all.donnees.contenu));
            Put("    Avant écrasement :"); New_Line;
            Put(To_String(record_temp.rep_courant.all.donnees.contenu)); New_Line;
            Put("    Nouveau : "); New_Line;
            c := record_temp.rep_courant.all.donnees;
            Get_Line(c.contenu);
            setData(record_temp.rep_courant, c);
            memoire_bool := True;
            memoire(record_temp.rep_courant, memoire_bool, Length(record_temp.rep_courant.all.donnees.contenu));
         else
            raise erreur_element;
         end if;
      else
         raise element_inexistant;
      end if;
   end edit;
   
   --Type : procedure
   --Nom : taille_racine
   --Sémantique : Procédure qui affiche la taille totale de la racine de l'arbre de fichiers/dossiers.
   procedure taille_racine (parametre_tab : in TAB_parametre; courant_racine : in current) is
   begin
      if parametre_tab(2) /= "" then
         raise erreur_commande;
      end if;
      Put("    Taille de la racine (/Root) : ");  Put(Integer'Image(courant_racine.rep_racine.all.donnees.taille)); Put("/"); Put(Integer'Image(1e8));
      New_Line;
   end taille_racine;
      
end p_sgf;
