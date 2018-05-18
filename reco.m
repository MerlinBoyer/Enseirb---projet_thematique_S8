clear all;
close all;
clc;

%% chargement image

url_img = 'cpt_eau.jpeg';
[im,map] = imread(url_img);
figure;image(im);colormap(map);

%% coor des 4 coins du cadre contenant les chiffres  :
%det a la main :
% figure, imshow(im);
% [xd yd] = ginput(4);

%valeurs théoriques
 xd(1)=152; yd(1)=254;
 xd(2)=306; yd(2)=262;
 xd(3)=150;   yd(3)=291;
 xd(4)=304; yd(4)=300;
 

%% coor des 4 coins du cadre contenant UN chiffre  :
%det a la main :
% figure, imshow(im);
% [xd2 yd2] = ginput(4);

%valeurs théoriques
 xd2(1)=47; yd2(1)=65;
 xd2(2)=126; yd2(2)=53;
 xd2(3)=47; yd2(3)=441;
 xd2(4)=123; yd2(4)=426;


%% creation mat H pour homographie

%H1 :
%creation des points d'arrivee :
x_cible = [1 size(im,1) 1 size(im,1)];
y_cible = [1 1 size(im,2) size(im,2)];
H1 = det_homographie( xd, yd, x_cible, y_cible);


%H2:
%application de la premiere H pour creer l'image intermediaire :
im_int = app_homographie('bilineaire',im, H1, [1 size(im,1)], [1 size(im,2)]);
figure, imshow(im_int);


%creation des coor des point d'arrivee :
x_cible = [1 40 1 40];
y_cible = [1 1 100 100];
H2 = det_homographie( xd2, yd2, x_cible, y_cible);

tic

im_int2 = app_homographie('bilineaire', im_int, H2, [x_cible(1) x_cible(2)], [y_cible(1) y_cible(3)]);
toc
%figure, imshow(im_int2);

%H :
H = H2*H1;

%% application de l'hom


dy = fix((y_cible(3)+1-y_cible(1))/7);
img_finale = app_homographie('bilineaire', im, H, [x_cible(1) x_cible(2)], [y_cible(1)-dy y_cible(3)+dy]);

%figure, imshow(img_finale);



%% calcul des sommes d'intensite par colonne

%sum_col = sum_col(img_finale);
%figure;plot([1:size(img_finale,2)], sum_col);

%% isolation des chiffres

%isoler les chiffres

%chiffre1 = img_finale(:,1:largeurF/5,:);
%figure, imshow(chiffre1);
%[xchiffre, ychiffre] = ginput(1);
%chiffre1 = chiffre1( 25:ychiffre(1), 8:xchiffre(1),:);
%chiffre1 = chiffre1( 25:size(chiffre1,1)-75, 8:size(chiffre1,2)-40,:);
chiffre1 = img_finale;
%figure, imshow(chiffre1);


%size(chiffre1,2)
%% det du 2eme chiffre

% figure, imshow(im_int);
% [xd2 yd2] = ginput(4);

%valeurs théoriques
 xd2(1)=168; yd2(1)=66;
 xd2(2)=243; yd2(2)=52;
 xd2(3)=168; yd2(3)=440;
 xd2(4)=243; yd2(4)=424;
 
 
 %creation des coor des point d'arrivee :

H2 = det_homographie( xd2, yd2, x_cible, y_cible);

tic

im_int2 = app_homographie('bilineaire', im_int, H2, [1 80], [1 400]);
toc
%figure, imshow(im_int2);

%H :
H = H2*H1;

dy = fix((y_cible(3)+1-y_cible(1))/7);
img_finale = app_homographie('bilineaire', im, H, [x_cible(1) x_cible(2)], [y_cible(1)-dy y_cible(3)+dy]);

chiffre2 = img_finale;
%figure, imshow(chiffre2);


%% det du 3eme chiffre

% figure, imshow(im_int);
% [xd2 yd2] = ginput(4);

%valeurs théoriques
 xd2(1)=287; yd2(1)=70;
 xd2(2)=365; yd2(2)=55;
 xd2(3)=287; yd2(3)=445;
 xd2(4)=365; yd2(4)=430;
 
 
 %creation des coor des point d'arrivee :

H2 = det_homographie( xd2, yd2, x_cible, y_cible);

tic

im_int2 = app_homographie('bilineaire', im_int, H2, [1 80], [1 400]);
toc
%figure, imshow(im_int2);

%H :
H = H2*H1;

dy = fix((y_cible(3)+1-y_cible(1))/7);
img_finale = app_homographie('bilineaire', im, H, [x_cible(1) x_cible(2)], [y_cible(1)-dy y_cible(3)+dy]);

chiffre3 = img_finale;
%figure, imshow(chiffre3);


%% det chiffre 4

% figure, imshow(im_int);
% [xd2 yd2] = ginput(4);

%valeurs théoriques
 xd2(1)=407; yd2(1)=74;
 xd2(2)=481; yd2(2)=64;
 xd2(3)=407; yd2(3)=444;
 xd2(4)=481; yd2(4)=434;
 
 
 %creation des coor des point d'arrivee :

H2 = det_homographie( xd2, yd2, x_cible, y_cible);

tic

im_int2 = app_homographie('bilineaire', im_int, H2, [1 80], [1 400]);
toc
%figure, imshow(im_int2);

%H :
H = H2*H1;

dy = fix((y_cible(3)+1-y_cible(1))/7);
img_finale = app_homographie('bilineaire', im, H, [x_cible(1) x_cible(2)], [y_cible(1)-dy y_cible(3)+dy]);

chiffre4 = img_finale;
%figure, imshow(chiffre4);


%% det chiffre 5

% figure, imshow(im_int);
% [xd2 yd2] = ginput(4);

%valeurs théoriques
 xd2(1)= 528; yd2(1)= 47;
 xd2(2)= 606; yd2(2)= 40;
 xd2(3)= 530; yd2(3)= 463;
 xd2(4)= 604; yd2(4)= 456;
 
 
 %creation des coor des point d'arrivee :

H2 = det_homographie( xd2, yd2, x_cible, y_cible);

tic

im_int2 = app_homographie('bilineaire', im_int, H2, [1 80], [1 400]);
toc
%figure, imshow(im_int2);

%H :
H = H2*H1;

dy = fix((y_cible(3)+1-y_cible(1))/7);
img_finale = app_homographie('bilineaire', im, H, [x_cible(1) x_cible(2)], [y_cible(1)-dy y_cible(3)+dy]);

chiffre5 = img_finale;
%figure, imshow(chiffre5);

%% affichage des chiffres :

figure;
subplot(151),imshow(chiffre1);
subplot(152),imshow(chiffre2);
subplot(153),imshow(chiffre3);
subplot(154),imshow(chiffre4);
subplot(155),imshow(chiffre5);


%% decalage du "carre cible"
figure,hold on;
tic
for i=1:2*dy
    
    chiffre = chiffre1(i:size(chiffre1,1)-2*dy+i,:,:);
    subplot(151),imshow(chiffre);
    
    chiffre = chiffre2(i:size(chiffre1,1)-2*dy+i,:,:);
    subplot(152),imshow(chiffre);
    
    chiffre = chiffre3(i:size(chiffre1,1)-2*dy+i,:,:);
    subplot(153),imshow(chiffre);
    
    chiffre = chiffre4(i:size(chiffre1,1)-2*dy+i,:,:);
    subplot(154),imshow(chiffre);
    
    chiffre = chiffre5(i:size(chiffre1,1)-2*dy+i,:,:);
    subplot(155),imshow(chiffre);
    
    drawnow
    

end
toc

hold off;






%%

% chiffre2 = img_finale(:,largeurF/5:2*largeurF/5,:);
% chiffre3 = img_finale(:,2*largeurF/5:3*largeurF/5,:);
% chiffre4 = img_finale(:,3*largeurF/5:4*largeurF/5,:);
% chiffre5 = img_finale(:,4*largeurF/5:largeurF,:);

% figure;
% subplot(231),imshow(chiffre1);
% subplot(232),imshow(chiffre2);
% subplot(233),imshow(chiffre3);
% subplot(234),imshow(chiffre4);
% subplot(235),imshow(chiffre5);



%les decaler poour obtenir plusieurs config
%pdt scal
%decision


%% pour plus tard

% bw = im2bw(im);
% % find both black and white regions
% stats = [regionprops(bw); regionprops(not(bw))]
% % show the image and draw the detected rectangles on it
% figure;
% imshow(bw); 
% hold on;
% for i = 1:numel(stats)
%     rectangle('Position', stats(i).BoundingBox, ...
%     'Linewidth', 3, 'EdgeColor', 'r', 'LineStyle', '--');
% end

% 
% bw = im2bw(img_finale);
% figure,imshow(bw);
% % find both black and white regions
% stats = [regionprops(bw); regionprops(not(bw))]
% % show the image and draw the detected rectangles on it
% figure;
% imshow(bw); 
% hold on;
% for i = 1:numel(stats)
%     rectangle('Position', stats(i).BoundingBox, ...   
%     'Linewidth', 3, 'EdgeColor', 'r', 'LineStyle', '--');
% end












