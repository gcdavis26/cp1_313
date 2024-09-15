clc 
clear
B = load('images.mat').image_data';
B = mat2gray(B);
firstimage = reshape(B(:,1), [37,50])';
imshow(firstimage)

secondimage = reshape(B(:,2), [37,50])';
thirdimage = reshape(B(:,3), [37,50])';
fourthimage = reshape(B(:,4), [37,50])';
fifthimage = reshape(B(:,5), [37,50])';
sixthimage = reshape(B(:,6), [37,50])';
seventhimage = reshape(B(:,7), [37,50])';
eigthimage = reshape(B(:,8), [37,50])';
ninthimage = reshape(B(:,9), [37,50])';
tenthimage = reshape(B(:,10), [37,50])';

subplot(1,10,1)
imshow(firstimage)
subplot(1,10,2)
imshow(secondimage)
subplot(1,10,3)
imshow(thirdimage)
subplot(1,10,4)
imshow(fourthimage)
subplot(1,10,5)
imshow(fifthimage)
subplot(1,10,6)
imshow(sixthimage)
subplot(1,10,7)
imshow(seventhimage)
subplot(1,10,8)
imshow(eigthimage)
subplot(1,10,9)
imshow(ninthimage)
subplot(1,10,10)
imshow(tenthimage)

A = B * B';
C = eig(A);
C = C

