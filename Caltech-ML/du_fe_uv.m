function du_fe_uv = du_fe_uv (u, v)
   du_fe_uv = 2 * (exp(v) + 2 * v * exp(-u)) * (u * exp(v) - 2 * v * exp(-u));