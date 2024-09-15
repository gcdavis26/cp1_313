clc 
clear
B = load('images.mat').image_data';
B = mat2gray(B);



for iter = (1:10)
    image = reshape(B(:,iter), [37, 50])';
    subplot(1,10, iter)
    imshow(image)

end

A = B * B';
[Evectors, Evalues] =  eig(A);
origvect = Evectors;
origval = Evalues;

Evalues = diag(Evalues);
Evalues = Evalues(563:1850,1);
Evectors = Evectors(:,563:1850);
Evalues = flip(Evalues);
Evectors = (flip(Evectors'))';
figure(2)
loglog(Evalues)

%Smallest eigenvalues 
figure(3)

smallest = Evectors(:, [1288-9:1288]);

for iter = (1:10)
    image = reshape(smallest(:,iter), [37,50])'
    image = mat2gray(image)
    subplot(1,10,iter)
    imshow(image)

end

figure(4)
largest = Evectors(:,1:10)
for iter = (1:10)
    image = reshape(largest(:,iter), [37,50])'
    image = mat2gray(image)
    subplot(1,10,iter)
    imshow(image)
end


