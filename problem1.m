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

EvectorsL = Evectors(:,1)
EvaluesL = Evalues(1,1)

figure(5)
 U1 = A * EvectorsL
 U2 = EvaluesL .* EvectorsL 
image = reshape(U1, [37, 50])'
image = mat2gray(image)
subplot (1,2,1)
imshow(image)

subplot(1,2,2)
image = reshape(U2, [37, 50])'
image = mat2gray(image)
imshow(image)

%bonus

EigVec3 = Evectors(:,1:3)
x = B(:,1)
xbar = (EigVec3 * EigVec3')*x
xreshape = reshape(x(:,1), [37, 50])';
xbarreshape = reshape(xbar(:,1), [37, 50])'; 
figure(6)
xreshape = mat2gray(xreshape)
xbarreshape = mat2gray(xbarreshape)

subplot(1,2,1)
imshow(xbarreshape)
subplot(1,2,2)
imshow(xreshape)