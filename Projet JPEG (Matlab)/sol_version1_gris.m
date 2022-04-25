clear all;
close all;
clc
dim_bloc = 8;
I = imread('end.png');
image1 = rgb2gray(I);
%imshow(image1);
image2 = double(image1);
image(image2),
[n1,m1] = size(image2);


%% Padding %% if the dimension are not multiple of 8

%si le nombre de colonnes est différent d'un multiple 8, on ajoute la dernière colonne jusqu'à satisfaire cette condition
if rem(m1,dim_bloc)~=0 
    i=dim_bloc-rem(m1,dim_bloc);
    while i~=0
    image2=[image2 image2(:,m1:m1)];
    i=i-1;
    end
end
%si le nombre de lignes est différent d'un multiple 8, on ajoute la dernière ligne jusqu'à satisfaire cette condition
if rem(n1,dim_bloc)~=0
    i=dim_bloc-rem(n1,dim_bloc);
    while i~=0
    image2=[image2;image2(n1:n1,:)];
    i=i-1;
    end
end
%L'image que nous avons est de dimension 8k x 8l avec k et l entiers.
[n,m] = size(image2); %Nouvelle valeur de m et n
dim_img = m*n; %%Nombre total d'élement dans la matrice complète 

%% le centrage
DCT = dctmtx(dim_bloc);
quantizer=[16 11 10 16  24  40  51  61;
   12 12 14 19  26  58  60  55;
   14 13 16 24  40  57  69  56;
   14 17 22 29  51  87  80  62;
   18 22 37 56  68 109 103  77;
   24 35 55 64  81 104 113  92;
   49 64 78 87 103 121 120 101;
   72 92 95 98 112 100 103 99];

%% codage
Vrlc=[];
for i = 1:dim_bloc:n
   for j = 1:dim_bloc:m
        bloc =image2( i:i+7,j:j+7 ); % extraire une région de 8x8
        %centrage
        bloc=bloc-128; %centré en 0
        %DCT
        dct=DCT*bloc*DCT';
        %quantification
        % On prend la partie entière de la dct divisée terme à terme par la
        % matrice de quantification
        F=round(dct./quantizer); %On effectue la division de dct par la matrice de quantification
        %On arrondit les éléments de cette matrice de sorte à ce que les
        %élements proche de 0 soit considérés étant 0. C'est l'étape qui va nous faire perdre des informations
       
       % zigzag of the block
        zig=zigzagcode(F); %On obtient une matrice ligne après avoir appliqué la méthode du zigzag
        % concatenate all zigzag vectors (Vrlc)
        vrlc=RunLength(zig); %Compression des blocs. On réduit le nombre de termes et on gagne de l'espace 
        Vrlc=[Vrlc vrlc]; %On concatène le tout sous un seul grand vecteur
    end
end
%code de Huffman
symboles= unique(Vrlc); %Liste de tous les différents symboles 
iteration=zeros(1,length(symboles)); %Compteur pour chaque symbole

T=dim_img/length(Vrlc);%taux de compression

for i=1:length(Vrlc)
    k=Vrlc(i);%On parcourt le vecteur Vrlc
    enable=1; %enable nous permet d'entrer et de rester dans la boucle while
    r=1; % r est une variable qui va parcourir la liste des iterations, il récupère le rang du symbole
    while enable==1 
        if symboles(r)==k %lorsque l'on atteint le rang du symbole
            enable=0; %on sort de la boucle while
            iteration(r)=iteration(r)+1;%on incrémente de 1 la colonne de iteration qui correspond au symbole
        else
            r=r+1;%Si le symbole n'est pas identifié, on continue de la parcourir la liste des symboles jusqu'à le trouver 
        end
    end 
        
end

prob=iteration/length(Vrlc); %la probabilité= récurrence / nombre d'échantillons total
dico=huffmandict(symboles,prob); %On détermine le dictionnaire

%% Encodage

encode=huffmanenco(Vrlc,dico); %On encode

decode=huffmandeco(encode,dico); %On décode


%% Decodage

sous_bloc=[]; %On ititialise la variable qui va récupérer les sous blocs à traiter
zigInverse=InverseRunLength(decode,n,m); %On applique la méthode inverse de Runlength: on supprime les symboles 257 et on les remplace par un nombre de 0 correspondant à la valeur du symbole suivant (symbole qui doit être supprimé). Il faudra ensuite appliquer la méthode inverse du zigzag
Finter = []; %Finter correspond à la concatenation sur 8 lignes de nos sous-bloc après traitement
imagefinal=zeros(n); %imagefinal correspond la matrice de l'image finale après traitement. il faut la comparer à image2

for i = 1:64:m*n
    sous_ziginverse=Inversezigzagcode(zigInverse(i:i+63)) ; %on applique la méthode inverse du zigzag
    dctinverse=quantizer.*sous_ziginverse;%On perd ici notre information car nous avons utilisé round précedemment pour arrondir les nombres proches de 0
    sous_blocinverse=DCT\dctinverse/DCT+128; %On décentre de 0 nos blocs pour avoir des valeurs entre 0 et 128
    Finter=[Finter sous_blocinverse]; %Concatenation des Finter, 8 lignes et n*m/8 colonnes
end           


%La boucle suivante permet de passer de Finter (matrice 8x(n*m/8)) 
%à imagefinal (matrice n*m)

for k=1:dim_bloc:n
    for j=1:dim_bloc:m
        imagefinal(k:k+7,j:j+7)=Finter(1:8,(k-1)*n/dim_bloc+j:(k-1)*n/dim_bloc+j+7); %Moi
        
    end
end

%%
err=abs(imagefinal-image2); %On peut déterminer l'erreur sur chaque terme

errmoyen=sum(sum(err))/n/n;%On peut déterminer l'erreur moyenne sur l'ensemble de la matrice

figure()
image(image2) %Avant traitement
title("Image avant traitement");
figure()
image(imagefinal)%Après traitement
title("Image après traitement");

%% END