function q = invq(targetV, q0)

N = length(q0);

q = q0;
qNeg = 1e-14 * ones(N,1);

cnt = 0;

while(1)
    V = 2 * q + log(q) - targetV;
    dV = 2 + 1.0 ./ q;
    delta = V ./ dV;
    if ((sum(abs(delta) / q < 1e-9) == N) || (cnt == 500))
        break;
    end
    q -= delta;
    negq = q < 0;
    if(sum(negq))
        q = qNeg .* negq + q .* (1-negq);
        qNeg = qNeg ./ (negq * 9 + 1);
    end
    cnt = cnt + 1;
end

end
