%sets boundary values and empty matrices 
x = 30;
y = 20;

G = sparse(x*y, x*y);
V = zeros(x*y, 1);

%goes through each increment of the canvas grid
for i = 1:x
    for j = 1:y
        %assigns variables to each side of the index node 
        n= j + (i - 1)*y;
        nx1 = j + ((i-1) - 1)*y;
        nx2 = j + ((i+1) - 1)*y;
        ny1 = (j-1) + (i - 1)*y;
        ny2 = (j+1) + (i - 1)*y;
        %sets boundary condition for right edge of canvas
        if i == x
            G(n,:) = 0;
            G(n,n) = 1;
          %sets boundary condition for left edge of canvas   
        elseif i == 1
            G(n,:) = 0;
            G(n,n) = 1;
            V(1,n) = 1;
            %sets boundary condition for bottom and top edge of canvas
        elseif j == 1 || j == y;
            G(n,n) = -3;
            G(n,nx1) = 1;
            G(n,nx2) = 1;
            G(n,ny2) = 1;
        else
            %sets condition when not hitting any boundaries
            G(n,n) = -4;
            G(n,nx1) = 1;
            G(n, nx2) = 1;
            G(n, ny1) = 1;
            G(n, ny2) = 1;
        end
    end
end
%sets up surface plot using surface = G\V
S = G\V;
surface = zeros(x,y);

for i = 1:x
    for j = 1:y
        n = j + (i - 1)*y;
        surface(i,j) = S(n);
    end
end
figure(1)
surf(surface);




            