B= load('images.mat').image_data';
B = mat2gray( B );
firstimage = reshape(B(:,1),[37,50])';
imshow(firstimage);