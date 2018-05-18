function [ H ] = det_homographie( xd, yd, xd2, yd2 )


%valeurs des 4 coins a traiter dans l'image de départ
x0=xd(1); y0=yd(1);
x1=xd(2); y1=yd(2);
x2=xd(3); y2=yd(3);
x3=xd(4); y3=yd(4);



%creation de la mat H
x_0=xd2(1);   y_0=yd2(1);
x_1=xd2(2);   y_1=yd2(2);
x_2=xd2(3);   y_2=yd2(3);
x_3=xd2(4);   y_3=yd2(4);


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


H = [X(1) X(2) X(3);
     X(4) X(5) X(6);
     X(7) X(8) 1];


end

