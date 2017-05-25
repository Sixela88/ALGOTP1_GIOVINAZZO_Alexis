{ALGORITHME : TP_Fichiers_Verbes
BUT : Créez un fichier (en programmation) contenant des verbes
Créer une fonctionnalité afficher_fichier qui comme son nom l’indique affichera vos fichiers.
Créer une fonctionnalité groupe_verbe qui permet de reconnaître le groupe de chaque verbe.
Créer une fonctionnalité qui permet de conjuguer votre verbe au présent de l’indicatif.
Les verbes conjugués seront stockés proprement (attention à la présentation svp) dans un fichier conjugaison.
ENTREES : Verbes
SORTIES : Fichiers de verbes, groupe des verbes, conjugaison des verbes.}

Program TP_fichiers_verbes;

uses crt,sysutils;

PROCEDURE CreationFichier(VAR f:textfile); //Créer le fichier de base avec les verbes voulus

BEGIN

	IF NOT FileExists (ParamStr(0)) THEN //Fonction vérifiant si le fichier f n'existe pas
		BEGIN
			Rewrite(f);
			writeln(f,'rire');
			writeln(f,'recevoir');
			writeln(f,'aller');
			writeln(f,'bouillir');
			writeln(f,'envoyer');
			writeln(f,'peindre');
			writeln(f,'habite');
			writeln(f,'payer');
			writeln(f,'mourir');
			writeln(f,'hair');
			writeln(f,'vouloir');
			writeln(f,'finir');
			writeln(f,'s''amuser');
			close(f);
		END;
END;

PROCEDURE Afficher_Fichier(VAR f:textfile); //Affiche le fichier voulu

VAR ChaineFichier:string;

BEGIN

	Reset(f);

	WHILE NOT Eof(f) DO
		BEGIN {Tant que le pointeur n'est pas à la fin du fichier, on lit les lignes du fichier 'f' 
		que l'on affecte à  la variable 'ChaineFichier'}
			read(f,ChaineFichier);
			writeln(ChaineFichier);
		END;

	close(f);
	
END;

PROCEDURE Groupe_Verbe(VAR f:Textfile;VAR g:Textfile); {Procedure permettant de dire de quel groupe fait 
partie les verbes dans le fichier.}

VAR 
	grp1,grp2,grp3:boolean;
	TestVerbe:string;
	Verbe:string;
	Verbe2:string;
	Long:integer;

BEGIN

	Reset(f);
	Reset(g);

	WHILE NOT Eof(f) DO
		BEGIN
			grp1:=FALSE;
			grp2:=FALSE;
			grp3:=FALSE;
			read(f,Verbe);
			writeln(Verbe);
			Long:=length(Verbe);
			TestVerbe:=copy(Verbe,Long-1,2);

			IF ((TestVerbe='er') AND (Verbe<>'aller')) THEN //Vérification si verbe du 1er groupe
				BEGIN
					grp1:=TRUE;
					write('1er Groupe');
				END;
		
			WHILE NOT Eof(g) DO
				BEGIN
					read(g,Verbe2);
					IF ((TestVerbe='ir') AND (Verbe=Verbe2)) THEN //Vérification si verbe du 2eme groupe
						BEGIN	
							grp2:=TRUE;
							writeln('2ème Groupe');
						END;
				END;
					
			IF ((grp1=FALSE) AND (2eme=FALSE)) THEN
				BEGIN
					grp3:=TRUE;
					writeln('3ème Groupe');		
				END;
		END;

END;

PROCEDURE Conjugaison(VAR f2:Textfile;Verbe:string;VAR g:Textfile);

VAR
	TestVerbe, Je, Tu, Il, Nous, Vous, Ils,Voy,car2:string;
	cer, ger, Voyelle,apos: boolean;

BEGIN
		1er:=FALSE;
		2eme:=FALSE;
		3eme:=FALSE;

		IF NOT FileExists (f2) THEN
				Rewrite(f2)
			ELSE
				BEGIN
					Rewrite(f2);
					Append(f2);
				END;

		Long:=length(Verbe);
		TestVerbe:=copy(Verbe,Long-1,2);

		IF ((TestVerbe='er') AND (Verbe<>'aller')) THEN
			BEGIN
				1er:=TRUE;
				car2:=copy(Verbe,1,2);
				Voy:=copy(Verbe,1,1);
				apos:=(car2=(''''));
				Voyelle:=(Voy='a') OR (Voy='e') OR (Voy='i') OR (Voy='o') OR (Voy='u');
				ger:=copy(Verbe,Long-2,3)='ger';
				cer:=copy(Verbe,Long-2,3)='cer';
				Je:='Je ' + copy(Verbe,1,Long-1);
				Tu:='Tu ' + copy(Verbe,1,Long-1) + 's';
				Il:='Il ' + copy(Verbe,1,Long-1);
				Nous:='Nous ' + copy(Verbe,1,Long-2) + 'ons';
				Vous:='Vous ' + copy(Verbe,1,Long-1) + 'z';
				Ils:='Ils ' + copy(Verbe,1,Long-1) + 'nt';

				IF Voyelle THEN
					Je:='J''' + copy(Verbe,1,Long-1);

				//SI Voyelle ET apos ALORS //Condition à finir

				IF ger THEN
					Nous:='Nous ' + copy(Verbe,1,Long-1) + 'ons';

				IF cer THEN
					Nous:='Nous ' + copy(Verbe,1,Long-3) + 'çons';
					
				IF Verbe='aller' THEN
					BEGIN
						Je:='Je vais';
						Tu:='Tu vas';
						Il:='Il va';
						Nous:='Nous allons';
						Vous:='Vous allez';
						Ils:='Ils vont';
					END;

				writeln(f2,Je);
				writeln(f2,Tu);
				writeln(f2,Il);
				writeln(f2,Nous);
				writeln(f2,Vous);
				writeln(f2,Ils);
		END;

		WHILE NOT Eof(g) DO
			BEGIN
				read(g,Verbe2);
				IF (TestVerbe='ir') AND (Verbe=Verbe2) THEN 
					BEGIN//Vérification si verbe du 2eme groupe
						2eme:=TRUE;
						Je:='Je ' + copy(Verbe,1,Long-2) + 'is';
						Tu:='Tu ' + copy(Verbe,1,Long-2) + 'is';
						Il:='Il ' + copy(Verbe,1,Long-2) + 'it';
						Nous:='Nous ' + copy(Verbe,1,Long-2) + 'issons';
						Vous:='Vous ' + copy(Verbe,1,Long-2) + 'issez';
						Ils:='Ils ' + copy(Verbe,1,Long-2) + 'issent';

						writeln(f2,Je);
						writeln(f2,Tu);
						writeln(f2,Il);
						writeln(f2,Nous);
						writeln(f2,Vous);
						writeln(f2,Ils);

					END;
			END;
	

		IF (1er=FALSE) AND (2eme=FALSE) THEN
			BEGIN
				3eme:=TRUE;
				IF Verbe='recevoir' THEN
					BEGIN
		                Je:='Je reçois';
		                Tu:='Tu reçois';
		                Il:='Il reçoit';
		                Nous:='Nous recevons';
		                Vous:='Vous recevez';
		                Ils:='Ils reçoivent';

		                writeln(f2,Je);
						writeln(f2,Tu);
						writeln(f2,Il);
						writeln(f2,Nous);
						writeln(f2,Vous);
						writeln(f2,Ils);
					END      
	        	ELSE
	        		BEGIN
	        	 		IF Verbe='bouillir' THEN
	        	 			BEGIN
				                Je:='Je bous';
				                Tu:='Tu bous';
				                Il:='Il bout';
				                Nous:='Nous bouillons';
				                Vous:='Vous bouillez';
				                Ils:='Ils bouillent';

				                writeln(f2,Je);
								writeln(f2,Tu);
								writeln(f2,Il);
								writeln(f2,Nous);
								writeln(f2,Vous);
								writeln(f2,Ils);
							END;
					END;
			END;

			//Je devais mettre ici les autres exceptions  

		close(f2);
		close(g);
END;

//Programme principal

VAR f:Textfile; //Fichier contenant les verbes voulus
	f2:Textfile; //Fichier contenant les conjugaisons au présent de l'indicatif des verbes voulus
	g:Textfile; //Fichier des verbes du 2eme groupe
	Verbe:string;
	Groupe:string;

BEGIN
	ASSIGN(g,'fichier_verbes2emegroupe.txt');
	ASSIGN(f,'fichier_verbes.txt');
	ASSIGN(f2,'fichier_verbes_conj.txt');
	CreationFichier(f);
	Afficher_Fichier(f);
	Groupe_Verbe(f,g);
	writeln('Veuillez saisir le verbe voulu dans la liste ci-dessus pour le conjuguer au présent de l''indicatif');
	readln(Verbe);
	Conjugaison(f2,Verbe,g);
END.
