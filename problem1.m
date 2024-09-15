clc 
clear
B = load('images.mat').image_data';
B = mat2gray(B);



for iter = (1:10)
    image = reshape(B(:,iter), [37, 50])'
    subplot(1,10, iter)
    imshow(image)

end

A = B * B';
EV = eig(A);
EV = EV(563:1850,1);
EV = flip(EV);
f2 = figure
loglog(EV)

