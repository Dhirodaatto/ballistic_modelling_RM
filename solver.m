syms x(t) y(t)

m = 2;
c = 0.01;
g = 9.81;

x_dot = diff(x,t );
x_ddot = diff(x,t,2);

y_dot = diff(y,t);
y_ddot = diff(y,t,2);

V = sqrt(x_dot^2+y_dot^2);

eqns = [m * x_ddot + c * x_dot * V == 0, m * y_ddot + c * y_dot * V + m * g == 0];

dsolve(eqns)