function e_uv = fe_uv(u, v)
    e_uv = (u * exp(v) - 2 * v * exp(-u))^2;
    
   

