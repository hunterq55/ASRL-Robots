thetad=cell(length(T),1);
for i=1:length(z)
    for j=1:6
        if i == 1
            thetad{i}(j,1) = 0;
        elseif i == 2
            %forward finite difference first step
            thetad{i}(j,1) = (J{i+1}(j)-(J{i}(j)))/ts;
        elseif i < 3000
            %central finite
            thetad{i}(j,1) = (J{i+1}(j)-(J{i-1}(j)))/(2*ts);
        elseif i == length(z)
            thetad{i}(j,1) = 0;
        end
    end
end
%factor at which you want to refine frequency of thetas reported
%hz
sizef=1;

theta=J;
timestep=t/length(theta);
%thetad=downsample(thetad,chi/(t*2));
%thetad unit - rad/s

for i=1:t/timestep
    V=thetad{i,1}';
    F{i}=V;
    F{i}=F{i}';
end

theta=cell2mat(theta);
thetad=cell2mat(F);

thetad=thetad';

tv=zeros(t/timestep,1);

for i=1:t/timestep
    tv(i)=timestep*i;
end

path=[tv theta thetad];