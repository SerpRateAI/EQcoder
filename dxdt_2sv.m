function dxdt = dxdt_2sv(t,x,par)
expx=exp(x(1));
yd=(1-expx)*par.k;
zd=-expx*par.r*(par.b2*x(1)+x(3));
xd=expx*((par.b1-1)*x(1)+x(2)-x(3))+yd-zd;
dxdt = [ xd yd zd]';

