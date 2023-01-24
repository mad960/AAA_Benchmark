clc; 
clearvars;

fonkName = 'ackley';
%fonkName = 'griewank';
%fonkName = 'rastrigin';
%fonkName = 'sphere';
%fonkName = 'rosenbrock';
%fonkName = 'schwefel';

LB = -20; 
UB = 20; 
D = 3; 
N = 100; 
maxHesaplama = 100;
Delta = 1.5;
Ap = 0.5;
e = 0.3;

AAA(fonkName, maxHesaplama, LB, UB, N,D,Delta,Ap,e);
