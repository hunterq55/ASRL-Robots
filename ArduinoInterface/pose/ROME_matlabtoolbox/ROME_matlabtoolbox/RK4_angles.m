function [t,x]=RK4_angles(AR2KinDE,x0)
%stepsize 
h=0.0155;
%length that you will be solving to
tspan=10;
t = 0:h:tspan;

x = zeros(length(t),12);

%IC
x(1,:) = x0;

% calculation loop
for i=1:(length(t)-1)
    k_1 = AR2KinDE(t(i),x(i,:)');
    k_2 = AR2KinDE(t(i)+0.5*h,x(i,:)'+0.5*h*k_1);
    k_3 = AR2KinDE((t(i)+0.5*h),(x(i,:)'+0.5*h*k_2));
    k_4 = AR2KinDE((t(i)+h),(x(i,:)'+k_3*h));
    x(i+1,:) = x(i,:) + ((1/6)*(k_1+2*k_2+2*k_3+k_4)*h)'; 
end

