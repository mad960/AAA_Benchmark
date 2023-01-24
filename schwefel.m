function ObjVal = schwefel(Chrom)
ObjVal = sum((-Chrom .* sin(sqrt(abs(Chrom)))));
end