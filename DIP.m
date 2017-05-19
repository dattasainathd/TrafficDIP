%%%%%%%%%%Code preapared for project work%%%%%%%%%%
%%%%%%%%%%Author: Datta Sainath D%%%%%%%%%%
clc;
close all;
clear all;

%%%%%%%%%%Reference Image%%%%%%%%%%
RGB1 = imread('No Traffic.jpg');
figure; imshow(RGB1); title('Reference Image');

%RGB to Gray Conversion
I1 = rgb2gray(RGB1);
ID1=im2double(I1);
figure; imshow(ID1); title('Reference Image: Gray Image');

%Image Resizing
IR1 = imresize(ID1, [512 512]);
figure; imshow(IR1); title('Resized Reference Image');

%Image Enhancement Power Law Transformation
c = 2;
g =0.9;
for p = 1 : 512
    for q = 1 : 512
        IG1(p, q) = c * IR1(p, q).^ 0.9;  
    end
end
figure; imshow(IG1); title('Enhanced Reference Image');

%Edge Detection
% The algorithm parameters:
% 1. Parameters of edge detecting filters:
%    X-axis direction filter:
     Nx1=10;Sigmax1=1;Nx2=10;Sigmax2=1;Theta1=pi/2;
%    Y-axis direction filter:
     Ny1=10;Sigmay1=1;Ny2=10;Sigmay2=1;Theta2=0;
% 2. The thresholding parameter alfa:
     alfa=0.1;
% Get the initial Reference Image
figure;
subplot(3,2,1);
imagesc(IG1);
title('Image: Reference Image');
% X-axis direction edge detection
subplot(3,2,2);
filterx=d2dgauss(Nx1,Sigmax1,Nx2,Sigmax2,Theta1);
Ix= conv2(IG1,filterx,'same');
imagesc(Ix);
title('Ix');
% Y-axis direction edge detection
subplot(3,2,3)
filtery=d2dgauss(Ny1,Sigmay1,Ny2,Sigmay2,Theta2);
Iy=conv2(IG1,filtery,'same'); 
imagesc(Iy);
title('Iy');
% Norm of the gradient (Combining the X and Y directional derivatives)
subplot(3,2,4);
NVI1=sqrt(Ix.*Ix+Iy.*Iy);
imagesc(NVI1);
title('Norm of Gradient');
% Thresholding
I_max=max(max(NVI1));
I_min=min(min(NVI1));
level=alfa*(I_max-I_min)+I_min;
subplot(3,2,5);
Ibw=max(NVI1,level.*ones(size(NVI1)));
imagesc(Ibw);
title('After Thresholding');
% Thinning (Using interpolation to find the pixels where the norms of 
% gradient are local maximum.)
subplot(3,2,6);
[n,m]=size(Ibw);
for i=2:n-1,
for j=2:m-1,
	if Ibw(i,j) > level,
	X=[-1,0,+1;-1,0,+1;-1,0,+1];
	Y=[-1,-1,-1;0,0,0;+1,+1,+1];
	Z=[Ibw(i-1,j-1),Ibw(i-1,j),Ibw(i-1,j+1);
	   Ibw(i,j-1),Ibw(i,j),Ibw(i,j+1);
	   Ibw(i+1,j-1),Ibw(i+1,j),Ibw(i+1,j+1)];
	XI=[Ix(i,j)/NVI1(i,j), -Ix(i,j)/NVI1(i,j)];
	YI=[Iy(i,j)/NVI1(i,j), -Iy(i,j)/NVI1(i,j)];
	ZI=interp2(X,Y,Z,XI,YI);
		if Ibw(i,j) >= ZI(1) & Ibw(i,j) >= ZI(2)
		I_temp(i,j)=I_max;
		else
		I_temp(i,j)=I_min;
		end
	else
	I_temp(i,j)=I_min;
	end
end
end
imagesc(I_temp);
title('After Thinning');
colormap(gray);
I_temp1 = I_temp;
figure; imshow(I_temp); title('Edge Detection Image');

%%%%%%%%%%Captured Image%%%%%%%%%%
RGB2 = imread('Lots of Traffic.jpg');
figure; imshow(RGB2); title('Captured Image');

%RGB to Gray Conversion: Captured Image
I2 = rgb2gray(RGB2);
ID2=im2double(I2);
figure; imshow(ID2); title('Captured Image:Gray Image');

%Image Resizing: Captured Image
IR2 = imresize(ID2, [512 512]);
figure; imshow(IR2); title('Resized Captured Image');

%Image Enhancement Power Law Transformation: Captured Image
for p = 1 : 512
    for q = 1 : 512
        IG2(p, q) = abs(c * IR2(p, q).^ 0.9);  
    end
end
figure; imshow(IG2); title('Enhanced Captured Image');

%Edge Detection
% Get the initial Captured Image     
figure;
subplot(3,2,1);
imagesc(IG2);
title('Image: Captured Image');
% X-axis direction edge detection
subplot(3,2,2);
filterx=d2dgauss(Nx1,Sigmax1,Nx2,Sigmax2,Theta1);
Ix= conv2(IG2,filterx,'same');
imagesc(Ix);
title('Ix');
% Y-axis direction edge detection
subplot(3,2,3)
filtery=d2dgauss(Ny1,Sigmay1,Ny2,Sigmay2,Theta2);
Iy=conv2(IG2,filtery,'same'); 
imagesc(Iy);
title('Iy');
% Norm of the gradient (Combining the X and Y directional derivatives)
subplot(3,2,4);
NVI2=sqrt(Ix.*Ix+Iy.*Iy);
imagesc(NVI2);
title('Norm of Gradient');
% Thresholding
I_max=max(max(NVI2));
I_min=min(min(NVI2));
level=alfa*(I_max-I_min)+I_min;
subplot(3,2,5);
Ibw=max(NVI2,level.*ones(size(NVI2)));
imagesc(Ibw);
title('After Thresholding');
% Thinning (Using interpolation to find the pixels where the norms of 
% gradient are local maximum.)
subplot(3,2,6);
[n,m]=size(Ibw);
for i=2:n-1,
for j=2:m-1,
	if Ibw(i,j) > level,
	X=[-1,0,+1;-1,0,+1;-1,0,+1];
	Y=[-1,-1,-1;0,0,0;+1,+1,+1];
	Z=[Ibw(i-1,j-1),Ibw(i-1,j),Ibw(i-1,j+1);
	   Ibw(i,j-1),Ibw(i,j),Ibw(i,j+1);
	   Ibw(i+1,j-1),Ibw(i+1,j),Ibw(i+1,j+1)];
	XI=[Ix(i,j)/NVI2(i,j), -Ix(i,j)/NVI2(i,j)];
	YI=[Iy(i,j)/NVI2(i,j), -Iy(i,j)/NVI2(i,j)];
	ZI=interp2(X,Y,Z,XI,YI);
		if Ibw(i,j) >= ZI(1) & Ibw(i,j) >= ZI(2)
		I_temp(i,j)=I_max;
		else
		I_temp(i,j)=I_min;
		end
	else
	I_temp(i,j)=I_min;
	end
end
end
imagesc(I_temp);
title('After Thinning');
colormap(gray);
I_temp2 = I_temp;
figure; imshow(I_temp); title('Edge Detection Image');

%%%%%%%%%%Image Matching%%%%%%%%%%

match = 0;
BW1 = im2bw(NVI1);
BW2 = im2bw(NVI2);
for p = 1 : 511
    for q = 1 : 511
        if (BW1(p, q) == BW2(p,q))
            match = match +1;
        end
    end
end

match;

%%%%%%%%%%Output Display%%%%%%%%%%

if(match>233000)
    disp('Green signal will be displayed for 10 second');
    disp('Red signal will be displayed for 50 seconds');
elseif(match>232000 && match <233000)
    disp('Green signal will be displayed for 20 second');
    disp('Red signal will be displayed for 40 seconds');
else
    disp('Green signal will be displayed for 30 second');
    disp('Red signal will be displayed for 30 seconds');
end