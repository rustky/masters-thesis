x = linspace(-5,5,11);
y = linspace(-5,5,11);
z = space(x,y);
plot3(x,y,z)


function z = space(x,y)
    z = x.^2 - y.^2;
end