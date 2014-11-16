iter = 0;
step = 0.1;
u = 1;
v = 1;
error = fe_uv(u, v);
while iter < 15
   du = du_fe_uv(u, v);
   u = u - du * step;
   
   dv = dv_fe_uv(u, v);
   v = v - dv * step;
   
   iter++;
   error = fe_uv(u, v)
end

iter
u
v