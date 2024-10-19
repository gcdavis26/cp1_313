%Part 1.1

clc %WClears command window
clear %Clears variables


B = load('images.mat').image_data'; %Loads in data
B = mat2gray(B); %Applying grayscale 


for iter = (1:10) %Itering 10 times
    figure(1) %Using figure
    image = reshape(B(:,iter), [37, 50])'; %Grabbing each column, 
    % reshaping it into a 37 by 50 matrix
    subplot(1,10, iter) %Plotting each graph on the same figure
    imshow(image) %Showing the image

end %Exit for loop

%%%%%%%%%%%%%%
% Part 1.2

A = B * B'; %Matrix math
[Evectors, Evalues] =  eig(A); %Finding eigenvalues and eigenvectors
%origvect = Evectors;  These were used for testing purposes 
%origval = Evalues;  Used for testing purposes

Evalues = diag(Evalues); %The eigenvalues are stored on the diagonal. This 
% makes a column vector of the values
Evalues = Evalues(563:1850,1); %First 562 are junk
Evectors = Evectors(:,563:1850); %Since we removed eigenvalues, we need to 
% remove their corresponding vectors too
Evalues = flip(Evalues); %Flipping the order of the eigenvalues
Evectors = (flip(Evectors'))'; %Since each eigenvector is a column, in 
% order to rearrange the columns, we need to first turn the columns into 
% rows, flip the rows (rearranging the columns), and then make the rows 
% back into columns.
figure(2) %We need a separate figure for the graphs
loglog(Evalues) %Plotting on a log log scale

%%%%%%%%%%%%%%
% Part 1.3

%Smallest eigenvalues 

figure(3) %New figure
smallest = Evectors(:, 1288-9:1288); %The smallest vectors are at the 
% end

for iter = (1:10) %Itering through all ten eigenvectors
    image = reshape(smallest(:,iter), [37,50])'; %Reshaping the columns 
    %into picture format
    image = mat2gray(image); %Grayscaling to make it visible
    subplot(1,10,iter) %Plotting them all
    imshow(image) %Showing the image

end

%Largest eigenvalues 

figure(4) %New figure
largest = Evectors(:,1:10); %The largest vectors are at the beginning
for iter = (1:10) %Itering through all ten eigenvectors
    image = reshape(largest(:,iter), [37,50])'; %Reshaping the columns 
    %into picture format
    image = mat2gray(image); %Grayscaling to make it visible
    subplot(1,10,iter) %Plotting them all
    imshow(image) %Showing the image
end


%%%%%%%%%%%%%%
% Part 1.4
EvectorsL = Evectors(:,1); %Largest eigenvector
EvaluesL = Evalues(1,1); %Largest eigenvalue

figure(5) %New figure 
% A * x = x * lambda
 U1 = A * EvectorsL; %A * x part of the equation 
 U2 = EvaluesL * EvectorsL;  % x * lambda part of the equation 
image = reshape(U1, [37, 50])'; %reshaping U1 to an image
image = mat2gray(image); %Grayscale
subplot (1,2,1) %Plotting the image
imshow(image) %Showing the image
title("A * Eigenvector") %Adding title

image = reshape(U2, [37, 50])'; %Reshaped to an image
image = mat2gray(image); % Grayscale
subplot(1,2,2) %Plotting U2
imshow(image)%Showing U2
title("Eigenvector * Eigenvalue") %Adding title

%%%%%%%%%%%%%%
% Part 1.5

EigVec3 = Evectors(:,1:3); %The first 3 eigenvectors
x = B(:,1); %First image
UUT = (EigVec3 * EigVec3'); % U by U transpose
xbar = UUT *x; %Finding xbar
xreshape = reshape(x(:,1), [37, 50])'; %Reshaping x into an image
xbarreshape = reshape(xbar(:,1), [37, 50])'; %Reshaping xbar into an image
figure(6) %New figure
xreshape = mat2gray(xreshape); %Grayscale
xbarreshape = mat2gray(xbarreshape); %Grayscale

subplot(1,2,1) %Plotting xbar
imshow(xbarreshape) %Showing xbar
title("XBar Image") %Adding plot title
subplot(1,2,2) %Plotting x
imshow(xreshape) %Showing x
title("X Image") %Adding plot title
