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
vdot = trapz(z,Ikfp(1,:)-Ikfp(2,:),2)*(phi_fp*alpha/zm);
if v>=1 
    vdot = 0; 
elseif v<=0
    vdot = 0; 
end
Ndot = trapz(z,pmax*photons_absorbed./(pmax./[phi_gp;phi_rp;phi_fp]+photons_absorbed),2).*Nv(1:3,:)/zm-L*Nv(1:3,:);
Nvdot = [Ndot;vdot];
end