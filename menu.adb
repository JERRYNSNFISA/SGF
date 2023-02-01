with p_sgf; use p_sgf;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with ada.strings; use ada.strings;
with Ada.Text_IO.Unbounded_IO; use Ada.Text_IO.Unbounded_IO;


procedure menu is

   --Type : procedure
   --Nom : display_prompt
   --Sémantique : Cette procédure affiche un prompt pour la saisie d'une commande dans une application.
   --Paramètres :
   --curr : current (position actuelle dans l'application)
   --liste : arbre.les_fils (liste des répertoires fils de la position actuelle)
   --Valeur de retour : Aucune
   --Pré-condition : curr doit être une position valide dans l'application.
   --Post-condition : Le prompt a été affiché, indiquant la position actuelle dans l'application et la liste des répertoires fils.
   --Exception : Aucune
   procedure display_prompt(curr : in current) is
      liste : arbre.les_fils;
   begin
      pwd(curr, liste);
      New_Line; put("[");
      while not arbre.liste_arbre.Est_Vide(liste) loop
         put ("/");
         put (To_String(liste.valeur.all.donnees.nom));
         liste := liste.suivant;
      end loop;
      put("]# ");
   end display_prompt;

   --Type : procedure
   --Nom : display_operations
   --Sémantique : Cette procédure affiche les 14 opérations disponibles avec une description courte de chacune d'entre elles.
   --Paramètres : Aucun
   --Valeur de retour : Aucune
   --Pré-condition : Aucune
   --Post-condition : Les 14 opérations ainsi que leur description ont été affichées à l'écran.
   --Exception : Aucune
   procedure display_operations is
   begin
      Put_Line("Voici les 14 opérations disponibles:");
      Put_Line("""pwd"": Affiche le répertoire courant.");
      Put_Line("""touch"": Crée un fichier.");
      Put_Line("""edit"": Change la taille d'un fichier (simulation d'édition).");
      Put_Line("""mkdir"": Crée un répertoire vide.");
      Put_Line("""cd"": Change le répertoire courant.");
      Put_Line("""ls"": Affiche le contenu d'un répertoire.");
      Put_Line("""ls -r"": Affiche récursif le contenu d'un répertoire.");
      Put_Line("""rm"": Supprime un fichier.");
      Put_Line("""rm -r"": Supprime un répertoire et son contenu.");
      Put_Line("""mv"": Déplace un fichier et/ou le renome éventuellement.");
      Put_Line("""cp -r"": Copie un fichier ou un répertoire et le renome éventuellement.");
      Put_Line("""tar"": Crée une archive d'un répertoire, dont la taille est égale aux contenu du répertoire.");
      Put_Line("""racine"": Affiche la taille de la racine (/Root).");
      Put_Line("""shutdown"": Eteins l'ordinateur.(ferme le menu)");
   end display_operations;

   --Type : procedure
   --Nom : select_operations
   --Sémantique : Cette procédure permet à l'utilisateur de sélectionner une des 14 opérations disponibles et de l'exécuter.
   --Paramètres : Aucun
   --Valeur de retour : Aucune
   --Pré-condition : Les 14 opérations doivent être définies et disponibles pour être sélectionnées par l'utilisateur.
   --Post-condition : L'opération sélectionnée par l'utilisateur a été exécutée.
   --Exception : L'utilisateur peut saisir un nombre incorrect, auquel cas un message d'erreur sera affiché et l'utilisateur devra sélectionner à nouveau une opération valide.
   procedure select_operations(courant : in out current) is
      parametre : TAB_parametre;
      stop : boolean := false;
      bool : Boolean;
      liste_pwd : arbre.les_fils;
      commande : Unbounded_String := To_Unbounded_String("");
   begin
      display_operations;
      loop
         display_prompt(courant);
         Get_Line(commande);
         Ada.Strings.Unbounded.Trim(commande, Both);
         chemin_menu(commande, parametre);

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
end menu;


