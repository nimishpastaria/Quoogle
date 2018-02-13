% Grover Search Algorithm Using Quantum Computing 

close all; clear all; clc 

n=6;

% Search vector 

f = 'searchvector';


V_f = zeros(2^n);

for i=0:2^n-1
    V_f(i+1,i+1)=(-1)^(feval(f,i));
end

% Unitary matrix with hadamard transform , Kronecker products as a basis 

if n==1
    H = [ 1 1; 1 -1]/sqrt(2);
else
    H1 = hadamard(1);
    H=1;
    for i=1:n
        H=kron(H,H1);
    end
end

% Invert Unitary Matrices 

IA =2*ones(2^n)/(2^n);

IA =IA-eye(2^n);


phi = bin2vec('111111');

phi = H*phi;

maxiter = (pi/4)*sqrt(2^n);

phihist=[];

% Quantum Measurement s 
for i=1:10

    phi=V_f*phi;
    phi=IA*phi;
    
    phihist=[phihist, phi];
    
end

psi = phi; 

p = (abs(psi)).^2;

cf_assert(cf_approx(sum(p)-1, 0), 'Phi not normalised');

[sp,ip]=sort(p);
sp=cumsum(sp);

r = rand;

i=1;
while r>sp(i)
    i=i+1;
end

obs=ip(i);  

phi=zeros(size(psi));
    phi(obs)=1;

ribbon(phihist');


