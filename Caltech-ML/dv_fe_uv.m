function dv_fe_uv = dv_fe_uv(u, v)
   dv_fe_uv = 2 * e^(-2 * u) * (u * e^(u+v) - 2) * (u * e^(u+v)-2 *v);