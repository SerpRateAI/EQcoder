%clear all
%
%
% solve the two state variable RS equations following Becker (2000)
%
par.b1=1;
par.b2=0.84;
par.r=0.048;


kcr1=par.b1-1;
kcr2=(kcr1+par.r*(2*par.b1+(par.b2-1)*(2+par.r))+ ... 
    (4*par.r^2*(kcr1+par.b2)+(kcr1+par.r^2*(par.b2-1))^2)^0.5)/(2+2*par.r);

for knd = [0.9 0.86 0.856 0.8552 0.8525]
    knd

%par.k = 0.9 * kcr2; % 2 orbit
%par.k = 0.86 * kcr2; % 4 
%par.k = 0.856 * kcr2; % 8 
%par.k = 0.8552 * kcr2; % 16
%par.k = 0.8525 * kcr2; % attractor
par.k = knd *kcr2;

% initial conditions
x0(1) = .1; x0(2) = 0.1;x0(3) = 0.1;
% time range
tmax=1e5;
tshow = tmax - 2e3; % range of sol to show 

trange = [0 tmax];
%
% solve ODE
%
options=odeset('AbsTol',1e-13,'RelTol',1e-7);
[t,x] = ode45(@dxdt_2sv,trange,x0,options,par);
%
% plot
%

ind=find(t>tshow);

figure(1);clf
subplot(2,1,1);
% y vs. time
plot(t(ind),x(ind,2));
xlabel('time');ylabel('y')

noise = randn(length(ind),3)*0.01;
% phase space
subplot(2,1,2);
oname=sprintf("p.%g.dat",knd)
out = [ t(ind) x(ind,:) x(ind,:)+noise ];
save(oname,"out","-ascii");
plot3(x(ind,1)+noise(:,1),x(ind,2)+noise(:,2),x(ind,3)+noise(:,3));
xlabel('x');ylabel('y');zlabel('z');
end

