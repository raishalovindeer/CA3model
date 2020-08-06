function Nvdot = dNvdt(t,Nv,data)
% Nvdot = dNvdt(t,Nv,data)

v = Nv(4);
Irradiance = I(Nv,data);
[photons_absorbed,Ikfp] = Gam(Irradiance,data);
if Irradiance(130)>=Irradiance(230)
    alpha = data.alpha.green;
else alpha = data.alpha.red;
end
photons_absorbed = [photons_absorbed;v*Ikfp(1,:)+(1-v)*Ikfp(2,:)+Ikfp(3,:)]; 
vintegral = trapz(data.z,Ikfp(1,:)-Ikfp(2,:),2);
vdot = vintegral*(data.phi(3)*alpha/data.zm);
if v > 0.99999999999 
    vdot = 0; 
elseif v < 0.00000000000001
    vdot = 0; 
end
Nintegral = trapz(data.z,data.pmax*photons_absorbed./(data.pmax./...
        data.phi'+photons_absorbed),2);
Ndot = Nintegral.*Nv(1:3,:)/data.zm-data.L*Nv(1:3,:);
Nvdot = [Ndot;vdot];
end