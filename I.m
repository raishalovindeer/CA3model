function Irradiance = I(Ngp,Nrp,Nfp,v,data)
% Irradiance = I(Ngp,Nrp,Nfp,v,data)

kpe = data.k.pe;
kpc = data.k.pc;
kchl = data.k.chl;
kfp = v*kpe+(1-v)*kpc+kchl;
kgp = data.k.gp;
krp = data.k.rp; 
kbg = data.kbg;
Incoming_light = data.In.white; %<- UPDATE FOR COLOR
z = data.z;
Irradiance = Incoming_light.*exp(-(kgp*Ngp+krp*Nrp+kfp*Nfp+kbg)*z); %for competition
%Irradiance = Incoming_light.*exp(-(kfp*Nfp+kbg)*z);                % for monoculture
end