function [r_out] = restore(sdec_out, q)
r_out = q*sdec_out-1;
end