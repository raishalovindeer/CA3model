function x = A(Nv,data)
% x = A(Nv,data)
% Converts N in cells per cm^3 to total light absorption per cm

Ngp = Nv(:,1);
Nrp = Nv(:,2);
Nfp = Nv(:,3);
v = Nv(:,4);
Inl = data.In.green; %<- UPDATE FOR COLOR
zm = data.zm;
kgp = data.k.gp;
krp = data.k.rp;
kpe = data.k.pe;
kpc = data.k.pc;
kchl = data.k.chl;
dlam = 1;
x = zeros(length(Nv),1);

for i = 1:length(Nv)
kfp = v(i)*kpe+(1-v(i))*kpc+kchl;
x(i,1) = log(sum(Inl*dlam)/(dlam*Inl.'*exp(-kgp*Ngp(i)*zm)))/zm;
x(i,2) = log(sum(Inl*dlam)/(dlam*Inl.'*exp(-krp*Nrp(i)*zm)))/zm;
x(i,3) = log(sum(Inl*dlam)/(dlam*Inl.'*exp(-kfp*Nfp(i)*zm)))/zm;
end
end

