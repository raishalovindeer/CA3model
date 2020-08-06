function Irradiance = I(Nv,data)
% Irradiance = I(Nv,data)

v = Nv(4);
kpe = data.k(:,3);
kpc = data.k(:,4);
kchl = data.k(:,5);
kfp = v*kpe+(1-v)*kpc+kchl;
kgp = data.k(:,1);
krp = data.k(:,2); 
kbg = data.k(:,6);

z = data.z;
Irradiance = data.light.*...
    exp(-(kgp*Nv(1)+krp*Nv(2)+kfp*Nv(3)+kbg)*z); %for competition
end