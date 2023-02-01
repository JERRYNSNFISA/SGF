with p_sgf; use p_sgf;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with ada.strings; use ada.strings;
with Ada.Text_IO.Unbounded_IO; use Ada.Text_IO.Unbounded_IO;


procedure test is
   
   --Type : procedure
   --Nom : init_test
   --Sémantique : Cette procédure permet de tester une fonctionnalité spécifique du programme.
   --Paramètres : Aucun
   --Valeur de retour : Aucune
   --Pré-condition : Les conditions nécessaires à la bonne exécution de la procédure doivent être remplies.
   --Post-condition : La fonctionnalité a été testée avec succès.
   --Exception : Il peut y avoir des erreurs ou des anomalies lors de l'exécution de la procédure, auquel cas un message d'erreur sera affiché.
   procedure init_test(init_test_tab : in out TAB_parametre) is
   begin
      init_test_tab := (others => To_Unbounded_String(""));
      
      -- scénario test
      
      init_test_tab(1) := To_Unbounded_String("pwd");
      init_test_tab(2) := To_Unbounded_String("mkdir repertoire1");
      init_test_tab(3) := To_Unbounded_String("mkdir repertoire_supp");
      init_test_tab(4) := To_Unbounded_String("ls");
      init_test_tab(5) := To_Unbounded_String("cd repertoire1");
      init_test_tab(6) := To_Unbounded_String("pwd");
      init_test_tab(7) := To_Unbounded_String("mkdir repertoire1.1");
      init_test_tab(8) := To_Unbounded_String("touch fichier_test");
      init_test_tab(9) := To_Unbounded_String("ls");
      init_test_tab(10) := To_Unbounded_String("edit fichier_test");
      init_test_tab(11) := To_Unbounded_String("ls");
      init_test_tab(12) := To_Unbounded_String("ls -r");
      init_test_tab(13) := To_Unbounded_String("ls -r /Root ");
      init_test_tab(14) := To_Unbounded_String("cp -r fichier_test ../fichier_supp");
      init_test_tab(15) := To_Unbounded_String("tar /Root/repertoire1");
      init_test_tab(16) := To_Unbounded_String("cd ..");
      init_test_tab(17) := To_Unbounded_String("pwd");
      init_test_tab(18) := To_Unbounded_String("ls -r");
      init_test_tab(19) := To_Unbounded_String("rm fichier_supp");
      init_test_tab(20) := To_Unbounded_String("rm -r /Root/repertoire_supp");
      init_test_tab(21) := To_Unbounded_String("ls");
      init_test_tab(22) := To_Unbounded_String("ls -r");
      init_test_tab(23) := To_Unbounded_String("mv repertoire1.tar fichier_à_copier");
      init_test_tab(24) := To_Unbounded_String("ls");
      init_test_tab(25) := To_Unbounded_String("mv fichier_à_copier repertoire1/repertoire1.1/fichier_coller");
      init_test_tab(26) := To_Unbounded_String("cd /Root/repertoire1/repertoire1.1");
      init_test_tab(27) := To_Unbounded_String("pwd");
      init_test_tab(28) := To_Unbounded_String("ls");
      init_test_tab(29) := To_Unbounded_String("ls -r ../..");
      init_test_tab(30) := To_Unbounded_String("racine");
      
      -- avec erreur et exception (l'exception trop_de_paramètre ne sera pratiquement jamais activé) :
      
      -- en général
      
      init_test_tab(31) := To_Unbounded_String("ls /////");  --erreur_commande
      init_test_tab(32) := To_Unbounded_String("mkdir /root/new_rep"); -- chemin_inexistant
      init_test_tab(33) := To_Unbounded_String("tar fichier_coller"); -- erreur_element
      init_test_tab(34) := To_Unbounded_String("edit fichier_inexistant"); -- element inexistant
      
      -- vérification présence d'élément
      
      init_test_tab(35) := To_Unbounded_String("touch /Root/toto"); 
      init_test_tab(36) := To_Unbounded_String("cp -r /Root/toto fichier_coller"); -- element présent
      
      -- vérification de la taille 
      
      init_test_tab(37) := To_Unbounded_String("cd /Root");
      init_test_tab(38) := To_Unbounded_String("cp -r repertoire1 repertoire1/0");
      init_test_tab(39) := To_Unbounded_String("cp -r repertoire1 repertoire1/repertoire1.1/test");
      init_test_tab(40) := To_Unbounded_String("cp -r repertoire1 repertoire1/repertoire1.2");
      init_test_tab(41) := To_Unbounded_String("cp -r repertoire1 repertoire1/test");
      init_test_tab(42) := To_Unbounded_String("cp -r repertoire1 repertoire1/memoire");
      init_test_tab(43) := To_Unbounded_String("cp -r repertoire1 repertoire1/repertoire1.2/yes");
      init_test_tab(44) := To_Unbounded_String("cp -r repertoire1 repertoire1/repertoire1.2/1");
      init_test_tab(45) := To_Unbounded_String("cp -r repertoire1 repertoire1/repertoire1.2/2");
      init_test_tab(46) := To_Unbounded_String("cp -r repertoire1 repertoire1/repertoire1.2/3");
      init_test_tab(47) := To_Unbounded_String("cp -r repertoire1 repertoire1/repertoire1.2/4");
      init_test_tab(48) := To_Unbounded_String("cp -r repertoire1 repertoire1/repertoire1.2/5"); -- capacite_memoire_atteint
      init_test_tab(49) := To_Unbounded_String("racine"); 
      
   end init_test;


   procedure select_operations(courant : in out current) is
      parametre : TAB_parametre;
      stop : boolean := false;
      bool : Boolean;
      liste_pwd : arbre.les_fils;
      tab_test : TAB_parametre;
      indice_test : Integer;
   begin
      init_test(tab_test);
      indice_test := 1;
      while tab_test(indice_test) /= "" loop
         
         chemin_menu(tab_test(indice_test), parametre);

         if parametre(1) = "shutdown" then
            stop:= true;
         elsif parametre(1) = "pwd" then
            if parametre(2) = "" then
               pwd(courant, liste_pwd);
               Put("    ");
               while not arbre.liste_arbre.Est_Vide(liste_pwd) loop
                  put ("/");
                  put (To_String(liste_pwd.valeur.all.donnees.nom));
                  liste_pwd := liste_pwd.suivant;
               end loop;
            else
               Put("    erreur_commande");
            end if;
         elsif parametre(1) = "touch" then
            bool := false;
            begin
               mkdir_ou_touch(parametre, courant, bool) ;
            exception
               when element_present =>
                  Put("    erreur, élément déjà présent");
               when element_inexistant =>
                  Put("    erreur, élément inexistant");
               when erreur_element =>
                  Put("    erreur, élément non compatible avec la commande effectué");
               when trop_de_parametre =>
                  Put("    erreur, trop de paramètre à prendre en compte");
               when chemin_inexistant =>
                  Put("    erreur, chemin inexistant");
               when erreur_commande =>
                  Put("    erreur_commande");
               when capacite_memoire_atteint =>
                  Put("    erreur, la capacité mémoire est insuffisante pour cette action");
            end;
         elsif parametre(1) = "edit" then
            begin
               edit(parametre, courant);
            exception
               when element_inexistant =>
                  Put("    erreur, élément inexistant");
               when erreur_element =>
                  Put("    erreur, élément non compatible avec la commande effectué");
               when trop_de_parametre =>
                  Put("    erreur, trop de paramètre à prendre en compte");
               when chemin_inexistant =>
                  Put("    erreur, chemin inexistant");
               when erreur_commande =>
                  Put("    erreur_commande");
               when capacite_memoire_atteint =>
                  Put("    erreur, la capacité mémoire est insuffisante pour cette action");
            end;
         elsif parametre(1) = "mkdir" then
            bool := True;
            begin
               mkdir_ou_touch(parametre, courant, bool) ;
            exception
               when element_present =>
                  Put("    erreur, élément déjà présent");
               when element_inexistant =>
                  Put("    erreur, élément inexistant");
               when erreur_element =>
                  Put("    erreur, élément non compatible avec la commande effectué");
               when trop_de_parametre =>
                  Put("    erreur, trop de paramètre à prendre en compte");
               when chemin_inexistant =>
                  Put("    erreur, chemin inexistant");
               when erreur_commande =>
                  Put("    erreur_commande");
               when capacite_memoire_atteint =>
                  Put("    erreur, la capacité mémoire est insuffisante pour cette action");
            end;
         elsif parametre(1) = "cd" then
            begin
               cd(parametre, courant);
            exception
               when element_inexistant =>
                  Put("    erreur, élément inexistant");
               when erreur_element =>
                  Put("    erreur, élément non compatible avec la commande effectué");
               when trop_de_parametre =>
                  Put("    erreur, trop de paramètre à prendre en compte");
               when erreur_commande =>
                  Put("    erreur_commande");
               when chemin_inexistant =>
                  Put("    erreur, chemin inexistant");
            end;
         elsif parametre(1) = "ls" then
            if parametre(2) = "-r" then
               begin
                  ls_r(parametre, courant) ;
               exception
                  when element_inexistant =>
                     Put("    erreur, élément inexistant");
                  when erreur_element =>
                     Put("    erreur, élément non compatible avec la commande effectué");
                  when trop_de_parametre =>
                     Put("    erreur, trop de paramètre à prendre en compte");
                  when chemin_inexistant =>
                     Put("    erreur, chemin inexistant");
                  when erreur_commande =>
                     Put("    erreur_commande");
               end;
            else
               begin
                  ls(parametre, courant);
               exception
                  when element_inexistant =>
                     Put("    erreur, élément inexistant");
                  when erreur_element =>
                     Put("    erreur, élément non compatible avec la commande effectué");
                  when trop_de_parametre =>
                     Put("    erreur, trop de paramètre à prendre en compte");
                  when chemin_inexistant =>
                     Put("    erreur, chemin inexistant");
                  when erreur_commande =>
                     Put("    erreur_commande");
               end;
            end if;
         elsif parametre(1) = "rm" then
            if parametre(2) = "-r" then
               bool := False;
            else
               bool := True;
            end if;
            begin
               rm_ou_rmr(parametre, courant, bool);
            exception
               when element_inexistant =>
                  Put("    erreur, élément inexistant");
               when erreur_element =>
                  Put("    erreur, élément non compatible avec la commande effectué");
               when trop_de_parametre =>
                  Put("    erreur, trop de paramètre à prendre en compte");
               when chemin_inexistant =>
                  Put("    erreur, chemin inexistant");
               when erreur_commande =>
                  Put("    erreur_commande");
            end;
         elsif parametre(1) = "mv" then
            bool := False;
            begin
               cpr_ou_mv(parametre, courant, bool);
            exception
               when element_present =>
                  Put("    erreur, élément déjà présent");
               when element_inexistant =>
                  Put("    erreur, élément inexistant");
               when erreur_element =>
                  Put("    erreur, élément non compatible avec la commande effectué");
               when trop_de_parametre =>
                  Put("    erreur, trop de paramètre à prendre en compte");
               when chemin_inexistant =>
                  Put("    erreur, chemin inexistant");
               when erreur_commande =>
                  Put("    erreur_commande");
            end;
         elsif (parametre(1) = "cp") and (parametre(2)= "-r") then
            bool := True;
            begin
               cpr_ou_mv(parametre, courant, bool);
            exception
               when element_present =>
                  Put("    erreur, élément déjà présent");
               when element_inexistant =>
                  Put("    erreur, élément inexistant");
               when erreur_element =>
                  Put("    erreur, élément non compatible avec la commande effectué");
               when trop_de_parametre =>
                  Put("    erreur, trop de paramètre à prendre en compte");
               when chemin_inexistant =>
                  Put("    erreur, chemin inexistant");
               when erreur_commande =>
                  Put("    erreur_commande");
               when capacite_memoire_atteint =>
                  Put("    erreur, la capacité mémoire est insuffisante pour cette action");
            end;
         elsif (parametre(1) = "tar") then
            begin
               tar(parametre, courant);
            exception
               when element_present =>
                  Put("    erreur, élément déjà présent");
               when element_inexistant =>
                  Put("    erreur, élément inexistant");
               when erreur_element =>
                  Put("    erreur, élément non compatible avec la commande effectué");
               when trop_de_parametre =>
                  Put("    erreur, trop de paramètre à prendre en compte");
               when chemin_inexistant =>
                  Put("    erreur, chemin inexistant");
               when erreur_commande =>
                  Put("    erreur_commande");
               when capacite_memoire_atteint =>
                  Put("    erreur, la capacité mémoire est insuffisante pour cette action");
            end;
         elsif (parametre(1) = "racine") then
            begin
               taille_racine(parametre, courant);
            exception
               when erreur_commande =>
                  Put("    erreur_commande");
            end;  
         else   
            if parametre(1) /= "" then
               Put("    erreur_commande");
            end if;
         end if;
         
         if parametre(1) = "ls" or parametre(1) = "edit" or parametre(1) = "pwd" then
            New_Line; New_Line;
         end if;
                     
         indice_test := indice_test + 1;

         exit when stop;
      end loop;
      Put("CLI EXIT");
      New_Line;
   end select_operations;
     

    -- main's variable
   noeud_courant : current;

begin
   creation_racine(noeud_courant);
   select_operations(noeud_courant);
end test;
