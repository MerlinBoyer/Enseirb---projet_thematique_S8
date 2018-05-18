%% archives des fonctions / scripts :



function [ imH ] = app_homographie(str, img, H, vecteur_x, vecteur_y)


if(strcmp(str,'bilineaire')) %bilineaire lent :
    %initialisation
    largeur_img_depart = size(img,2);
    hauteur_img_depart = size(img,1);

    largeur_img_finale = vecteur_x(2)-vecteur_x(1)+1;
    hauteur_img_finale = vecteur_y(2)-vecteur_y(1)+1;

    imH = uint8(zeros(hauteur_img_finale,largeur_img_finale,3));

    %application de l'homographie H a l'image
    for j=1:hauteur_img_finale
        for i=1:largeur_img_finale
            coor1 = [i;j;1];
            coor2 = H\coor1;
            px = coor2(1)/coor2(3); fx = floor(px);
            %px : coor de x reelle / fx : coor I0,0 = part ent de px.
            py = coor2(2)/coor2(3); fy = floor(py);
            dx = px-fx;
            dy = py-fy;
            if( fx>0 && fx<largeur_img_depart && fy>0 && fy<hauteur_img_depart)
                imH(j,i,:) = img(fy,fx,:)*(1-dx)*(1-dy)+...
                             img(fy+1,fx,:)*dy*(1-dx)+...
                             img(fy,fx+1,:)*(1-dy)*dx+...
                             img(fy+1,fx+1,:)*dy*dx;
            else
                imH(j,i,:) = 3;
            end
        end
    end






%aller chercher dans une image 1 pix : I(x,y) = I(y+(x-1)*h)
%on peut donc prendre plusieurs pix (si c'est en coor inde) : 
%I([8 15 1026..])

%interpolation bilineaire : 
%I = I0,0(1-dx)(1-dy) + I1,0*dx(1-dy) + I0,1*(1-dx)dy + I1,1*dxdy
% avec dx = x-floor(x)


elseif(strcmp(str,'lineaire')) %lineaire lent

    %%old hom;

    %initialisation
    largeur_img_depart = size(img,2);
    hauteur_img_depart = size(img,1);

    largeur_img_finale = vecteur_x(2)-vecteur_x(1)+1;
    hauteur_img_finale = vecteur_y(2)-vecteur_y(1)+1;

    imH = uint8(zeros(hauteur_img_finale,largeur_img_finale,3));

    %application de l'homographie H a l'image
    for j=1:hauteur_img_finale
        for i=1:largeur_img_finale
            coor1 = [i;j;1];
            coor2 = H\coor1;
            px = round(coor2(1)/coor2(3));
            py = round(coor2(2)/coor2(3));
            if( px>0 && px<largeur_img_depart && py>0 && py<hauteur_img_depart)
                imH(j,i,:) = img(py,px,:);
            else
                imH(j,i,:) = 3;
            end
        end
    end
    
else
    
    disp('invalide param lineaire ou bilineaire');
    
end


end
