function x = vrestrain(y)
%x = vrestrain(y)

if y >= 1
    x = 1;
elseif y <=0 
    x = 0;
else x = y;
end

% x=0.5+0.5*tanh(y);