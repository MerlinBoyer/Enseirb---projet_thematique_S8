clear all;
close all;
clc;
%% 
[im,map] = imread('cpt_eau.jpeg');
figure;image(im);colormap(map);
%% 
% imshow(im);
%p0(11,120)  :  p1(11,180)
%p2(190,8)  :  p3(190,275)

%p0'(1,1) p1'(1,285)
%p2'(202,1) p3'(202,285)

%depart
%recup de 4 points qui seront les 4 coins de l'image finale
% [xd yd] = ginput(4);

%valeurs des 4 coins recupérés "à la main"
% x0=xd(1); y0=yd(1);
% x1=xd(2); y1=yd(2);
% x2=xd(3); y2=yd(3);
% x3=xd(4); y3=yd(4);

%valeurs des 4 coins recupérés "à la main" mode izi
x0=152; y0=254;
x1=306; y1=262;
x2=150; y2=291;
x3=304; y3=300;

hold on
plot(x0,y0,'+')
plot(x1,y1,'+')
plot(x2,y2,'+')
plot(x3,y3,'+')
hold off



%coor finales
largeur_img_finale = size(im,1);
hauteur_img_finale = size(im,2);

x_0=1;   y_0=1;
x_1=largeur_img_finale; y_1=1;
x_2=1;   y_2=hauteur_img_finale;
x_3=largeur_img_finale; y_3=hauteur_img_finale;


A=[x0 y0 1 0 0 0 -x0*x_0 -y0*x_0;
   x1 y1 1 0 0 0 -x1*x_1 -y1*x_1;
   x2 y2 1 0 0 0 -x2*x_2 -y2*x_2;
   x3 y3 1 0 0 0 -x3*x_3 -y3*x_3;
   0 0 0 x0 y0 1 -x0*y_0 -y0*y_0;
   0 0 0 x1 y1 1 -x1*y_1 -y1*y_1;
   0 0 0 x2 y2 1 -x2*y_2 -y2*y_2;
   0 0 0 x3 y3 1 -x3*y_3 -y3*y_3];


B=[x_0;x_1;x_2;x_3;y_0;y_1;y_2;y_3];

X=inv(A)*B;
%X=inv((A')*A)*(A')*B;

H = [X(1) X(2) X(3);
     X(4) X(5) X(6);
     X(7) X(8) 1];

p1 = [x0;y0;1];
p2 = H*p1;
p2(1)/p2(3)
p2(2)/p2(3)

%% 
%creation de la matrice acceuillant l'image finale

 
im2 = uint8(zeros(hauteur_img_finale,largeur_img_finale,3));


for j=1:hauteur_img_finale
    for i=1:largeur_img_finale
        coor1 = [i;j;1];
        coor2 = inv(H)*coor1;
        px = round(coor2(1)/coor2(3));
        py = round(coor2(2)/coor2(3));
        if( px>0 && px<largeur_img_finale && py>0 && py<hauteur_img_finale)
            im2(j,i,:) = im(py,px,:);
        else
            im2(j,i,:) = 3;
        end;
    end;
end;

%utiliser un meshgrid
figure;image(im2);

%% 
%%%%%%%%%%%%%%%%%%%%%%%%%% affichage courbe d'intensite par colonne %%%%%%
sum_col = [1:size(im2,2)];
for i=1:size(im2,2)
    sum_col(i) = sum(im2(:,i))/size(im2,1);
end;

figure;plot([1:size(im2,2)], sum_col);

%% 
%%%%%%%%% detection de points d'interet
% E = uint8(zeros(hauteur_img_finale,largeur_img_finale,3));
% extend_x = 1;
% extend_y = 1;
% 
% 
% for i=extend_x+1:size(im2,1)-extend_x
%     for j=extend_y+1:size(im2,2)-extend_y
%         poid = 0;
%         for u=-extend_x:extend_x
%             for v=-extend_y:extend_y
%                 poid = poid + (im2(i+u,j+v)-im2(i,j))^2;
%             end
%         end
%         E(i,j) = poid;
%     end
% end
% 
% figure;imshow(E);



%% 
% %%%% isolation des chiffres %%%%%%%

% chiffre1=im2(:,1:100);
% chiffre2=im2(:,100:250);
% chiffre2=im2(:,250:400);
% chiffre2=im2(:,400:550);
% chiffre2=im2(:,550;650);
% 
% figure;
% subplot(


%detection coin : harris
%gradient du cours


%% 
%%%% extraction des contours avec gradient du cours
E = double(zeros(hauteur_img_finale,largeur_img_finale,3));
A = double(im2(:,:,1));

[X,Y]=meshgrid(-12:12);
sigma=4;
Hx=-X.*exp(-(X.^2+Y.^2)/(2*sigma^2))/(2*pi*sigma^4);
Hy=-Y.*exp(-(X.^2+Y.^2)/(2*sigma^2))/(2*pi*sigma^4);
Gx=conv2(A,Hx,'same');
Gy=conv2(A,Hy,'same');
G=(Gx.*Gx+Gy.*Gy).^0.5;

figure;
imshow(G, [0 20]);
colormap(flipud(gray(256)));


sum_col = [1:size(G)];
for i=1:size(G)
    sum_col(i) = sum(G(:,i).^2)/size(G,1);
end;

sum_col(1:5) = 0;
figure;plot([1:size(G)], sum_col);

der_sum_col = [2:size(G)-1];
for i=2:size(G)-1
    der_sum_col(i) = (sum_col(i+1)-sum_col(i-1));
end;

% figure;plot([1:size(G)-1], der_sum_col);


% der_der_sum_col = [3:size(G)-2];
% for i=3:size(G)-2
%     der_der_sum_col(i) = (der_sum_col(i+1)-der_sum_col(i-1));
% end;
% 
% figure;plot([1:size(G)-2], der_der_sum_col);



























