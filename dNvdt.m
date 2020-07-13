function Nvdot = dNvdt(t,Nv,data)
% Nvdot = dNvdt(t,Nv,data)

v = Nv(4);
Irradiance = I(Nv(1),Nv(2),Nv(3),v,data);
[photons_absorbed,Ikfp] = Gam(Irradiance,data);
if Irradiance(130)>=Irradiance(230)
    alpha = data.alpha.green;
else alpha = data.alpha.red;
end
photons_absorbed = [photons_absorbed;v*Ikfp(1,:)+(1-v)*Ikfp(2,:)+Ikfp(3,:)]; 
vdot = trapz(data.z,Ikfp(1,:)-Ikfp(2,:),2)*(data.phi(3)*alpha/data.zm);
if v>=1 
    vdot = 0; 
elseif v<=0
    vdot = 0; 
end
Ndot = trapz(data.z,data.pmax*photons_absorbed./(data.pmax./...
        data.phi+photons_absorbed),2).*...
        Nv(1:3,:)/data.zm-data.L*Nv(1:3,:);
Nvdot = [Ndot;vdot];
% keyboard
end