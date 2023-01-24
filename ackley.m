function ObjVal = ackley(vector)

Dim=size(vector,2);
A = 1/Dim;
Omega = 2 * pi;

sum1=A.*sum(vector .* vector);
sum2=A.*sum((cos(Omega * vector)));

ObjVal = -20*exp(-0.2*sqrt(sum1/length(vector)))-exp(sum2/length(vector))+20+exp(1);

end