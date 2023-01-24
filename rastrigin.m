
function ObjVal = rastrigin(vector)

d = length(vector);
sum = 0;
for i = 1:d
	x = vector(i);
	sum = sum + (x^2 - 10*cos(2*pi*x));
end

ObjVal = 10*d + sum;

end
