
function result = parallel_j(t)
    dx_w = 0.1;
    dx_t = 0.1;
    tbounds = -50:dx_t:50
    j = @(w, t) (((1)./(w.^3 + w)) .* (((exp(-1.*1i.*w.*t)) - 1)./(1 - exp(-1.*w))));
    vec = 1:length(tbounds); % parfor can only iterate through consecutive elements
    sum2 = 0;
    wb = 0.001:1:20
    parfor i=vec % single step index iteration vector for parfor
        t = tbounds(i);
        sum = integrate_omega(wb, t) % i th element of vtbounds is current t
        sum2 = sum2 + (1/(2*pi*hbar))*(exp(sum + 1i.*E.*t/hbar))*dx_t;
    end
    
    result = sum2

function  sub = integrate_omega(wbounds, t)
    sum_ = 0; % scope issue -> subfunction must be sum_
    vec2 = 1:length(wbounds)
    parfor k=vec2
         w = wbounds(k);
         sum_ = sum_ + (j(w, t)*dx_w);
    end
 sub = sum_;