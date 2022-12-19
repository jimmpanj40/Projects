function[ar]=AR1(a,signal)
    n=poly ([0]);
    d=poly ([a]);
    ar=filter(n,d,signal);
end
