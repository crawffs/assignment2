%part 2 is set up similar to part 1 with the addition of boxes that had
%different capacitance values then outside it. Additionally the final plot
%of the voltage will be used to get the gradient and the current density

%sets boundary values
x = 30;
y = 20;
%sets empty matrices
G = sparse(x*y, x*y);
V = zeros(1, x*y);
J = zeros(1, 10);
%sets the two conduction values
conductOut = 1;
conductBox = 1e-2;
%sets matrix for conduction values
conduct = zeros(x,y);
%sets up a bottleneck getting smaller over the increments
for i = 1:10
    Boxy2 = 0.6 - i*(0.01);
    Boxy1 = 0.3 + i*(0.01);
%assigns conduction values for each part of canvas based off box conditions
for i = 1:x
    for j = 1:y
        %sets boundaries of boxes
        if (i > (0.3*x) || i < (0.6*x)) && (j > (Boxy2*y) || j < (Boxy1*y))
            conduct(i,j) = conductBox;
        else
            conduct(i,j) = conductOut;
        end
        
    end
end
%goes through each part of grid and assigns variables for the nodes around
%the index. Then sets the voltages and conductance values based off the 
%x and y coordinates
for i = 1:x
    for j = 1:y
        n = j + (i - 1)*y;
        nx1 = j + ((i-1) - 1)*y;
        nx2 = j + ((i+1) - 1)*y;
        ny1 = (j-1) + (i - 1)*y;
        ny2 = (j+1) + (i - 1)*y;
        
        if i == 1
            V(n) = 1;
            G(n,n) = 1;
        elseif i == x
            V(n) = 0;
            G(n,n) =1;
        elseif j == 1 || j == y
            G(n,n) = -3*conduct(i,j);
            G(n, nx1) = conduct(i,j);
            G(n,nx2) = conduct(i,j);
            G(n, ny2) = conduct(i,j);
        else
            G(n,n) = -4;
            G(n,nx1) = conduct(i,j);
            G(n,nx2) = conduct(i,j);
            G(n,ny1) = conduct(i,j);
            G(n,ny2) = conduct(i,j);
        end
    end
end
%divide each spaces capaitance value by the coresponding voltage
S = G\V;

%set up matrix holding all the results
surface = zeros(x,y);
for i = 1:x
    for j = 1:y
        n = j + (i - 1)*y;
        surface(i,j) = S(n);
    end
end
%plots the surface voltage
figure(1)
surf(surface)

%calculates the x and y values of the gradient
[Ex, Ey] = gradient(-surface);
%finds the total gradient and plots it
E = sqrt(Ex.^2 + Ey.^2);
figure(2)
surf(E)
%finds the current densities using the map of conductance values
Jx = Ex .*conduct;
Jy = Ey .*conduct;
%gets the total current density and indexes it based off bottleneck value
J(i) = sqrt(Jy.^2 + Jx.^2);
end
%plots current density for different bottle neck sizes
figure(1)
plot(1:10,J)

            