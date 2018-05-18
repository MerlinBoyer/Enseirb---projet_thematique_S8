function [ imH ] = app_homographie(str, img, H, vecteur_x, vecteur_y)

%initialisation
    largeur_img_depart = size(img,2);
    hauteur_img_depart = size(img,1);

    largeur_img_finale = vecteur_x(2)-vecteur_x(1)+1;
    hauteur_img_finale = vecteur_y(2)-vecteur_y(1)+1;

    imH = uint8(zeros(hauteur_img_finale,largeur_img_finale,3));
    
    offset = largeur_img_depart*hauteur_img_depart;
    offset2 = largeur_img_finale*hauteur_img_finale;

    [X , Y] = meshgrid(vecteur_x(1):vecteur_x(2),vecteur_y(1):vecteur_y(2));
    X = X(:);
    Y = Y(:);

    coor1 = [X';Y';ones(1,length(X'))];
    coor2 = H\coor1; %= inv(H)*coor1



if(strcmp(str,'bilineaire'))

    
    %application de l'homographie H a l'image

            px = coor2(1,:)./coor2(3,:); fx = floor(px);
            %px : coor de x reelle / fx : coor I0,0 = part ent de px.
            py = coor2(2,:)./coor2(3,:); fy = floor(py);
            dx = px-fx;
            dy = py-fy;
            
            pos2 = find(px>0 & px<largeur_img_depart & py>0 & py<hauteur_img_depart);
            pos = pos2;
            
            %composante R
            imH(pos) = double(img(fy(pos2)+(fx(pos2)-1)*hauteur_img_depart)).*(1-dx(pos2)).*(1-dy(pos2))+...
                         double(img(fy(pos2)+1+(fx(pos2)-1)*hauteur_img_depart)).*dy(pos2).*(1-dx(pos2))+...
                         double(img(fy(pos2)+fx(pos2)*hauteur_img_depart)).*(1-dy(pos2)).*dx(pos2)+...
                         double(img(fy(pos2)+1+fx(pos2)*hauteur_img_depart)).*dy(pos2).*dx(pos2);
            
            pos = pos+offset2;
            
            %Composante G
            imH(pos) = double(img(fy(pos2)+(fx(pos2)-1)*hauteur_img_depart+offset)).*(1-dx(pos2)).*(1-dy(pos2))+...
                         double(img(fy(pos2)+1+(fx(pos2)-1)*hauteur_img_depart+offset)).*dy(pos2).*(1-dx(pos2))+...
                         double(img(fy(pos2)+fx(pos2)*hauteur_img_depart+offset)).*(1-dy(pos2)).*dx(pos2)+...
                         double(img(fy(pos2)+1+fx(pos2)*hauteur_img_depart+offset)).*dy(pos2).*dx(pos2);
            
            pos = pos+offset2;
            
            %Composante B
            imH(pos) = double(img(fy(pos2)+(fx(pos2)-1)*hauteur_img_depart+2*offset)).*(1-dx(pos2)).*(1-dy(pos2))+...
                         double(img(fy(pos2)+1+(fx(pos2)-1)*hauteur_img_depart+2*offset)).*dy(pos2).*(1-dx(pos2))+...
                         double(img(fy(pos2)+fx(pos2)*hauteur_img_depart+2*offset)).*(1-dy(pos2)).*dx(pos2)+...
                         double(img(fy(pos2)+1+fx(pos2)*hauteur_img_depart+2*offset)).*dy(pos2).*dx(pos2);

    



%aller chercher dans une image 1 pix : I(x,y) = I(y+(x-1)*h)
%on peut donc prendre plusieurs pix (si c'est en coor inde) : 
%I([8 15 1026..])

%interpolation bilineaire : 
%I = I0,0(1-dx)(1-dy) + I1,0*dx(1-dy) + I0,1*(1-dx)dy + I1,1*dxdy
% avec dx = x-floor(x)


elseif(strcmp(str,'lineaire'))
 
    %application de l'homographie H a l'image

    px = round(coor2(1,:)./coor2(3,:));
    py = round(coor2(2,:)./coor2(3,:));
    
    pos2 = find(px>0 & px<=largeur_img_depart & py>0 & py<=hauteur_img_depart);
    pos = py(pos2) + (px(pos2)-1)*hauteur_img_depart;
    
    imH(pos2) = img(pos);
    imH(pos2+offset2) = img(pos+offset);
    imH(pos2+2*offset2) = img(pos+2*offset);
    
else
    
    disp('invalide param lineaire ou bilineaire');
    
end


end


%% 
% if(strcmp(str,'bilineaire'))
% 
%     
%     %application de l'homographie H a l'image
%     for j=1:hauteur_img_finale
%         for i=1:largeur_img_finale
%             coor1 = [i;j;1];
%             coor2 = H\coor1;
%             px = coor2(1)/coor2(3); fx = floor(px);
%             %px : coor de x reelle / fx : coor I0,0 = part ent de px.
%             py = coor2(2)/coor2(3); fy = floor(py);
%             dx = px-fx;
%             dy = py-fy;
%             if( fx>0 && fx<largeur_img_depart && fy>0 && fy<hauteur_img_depart)
%                 imH(j,i,:) = img(fy,fx,:)*(1-dx)*(1-dy)+...
%                              img(fy+1,fx,:)*dy*(1-dx)+...
%                              img(fy,fx+1,:)*(1-dy)*dx+...
%                              img(fy+1,fx+1,:)*dy*dx;
%             else
%                 imH(j,i,:) = 3;
%             end
%         end
%     end
