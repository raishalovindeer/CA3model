function Nvdot = dNvdt(t,Nv,data)
% Nvdot = dNvdt(t,Nv,data)

v = Nv(4);
phi_fp = data.phi_fp;
phi_gp = data.phi_gp;
phi_rp = data.phi_rp;

Irradiance = I(Nv(1),Nv(2),Nv(3),v,data);
[photons_absorbed,Ikfp] = Gam(Irradiance,data);
if Irradiance(130)>=Irradiance(230)
    alpha = data.alpha_green;
else alpha = data.alpha_red;
end
photons_absorbed = [photons_absorbed;v*Ikfp(1,:)+(1-v)*Ikfp(2,:)+Ikfp(3,:)]; 
vdot = simpsons(Ikfp(1,:)-Ikfp(2,:),data.z(1),data.zm,data.nz-1)*(phi_fp*alpha/data.zm);
% vdot = trapz(data.z,Ikfp(1,:)-Ikfp(2,:),2)*(phi_fp*alpha/data.zm);
if v>=1 
    vdot = 0; 
elseif v<=0
    vdot = 0; 
end
Ndot = simpsons(data.pmax*photons_absorbed./(data.pmax./[phi_gp;phi_rp;phi_fp]+photons_absorbed),data.z(1),data.zm,data.nz-1)*Nv(1:3,:)/data.zm-data.L*Nv(1:3,:);
% Ndot = trapz(data.z,data.pmax*photons_absorbed./(data.pmax./[phi_gp;phi_rp;phi_fp]+photons_absorbed),2).*Nv(1:3,:)/data.zm-data.L*Nv(1:3,:);
Nvdot = [Ndot;vdot];
keyboard
end