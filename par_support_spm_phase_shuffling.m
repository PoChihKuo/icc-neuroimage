function Y = par_support_spm_phase_shuffling(X)
%  Y = par_support_spm_phase_shuffling(X)
%  parallel phase shuffling
%  X is a matrix. Shuffling is applied to each column vector in X.
%
%

if  size(X,1)==1
    X=X';
end

debug_mode = false;

N = size(X,1);

idx = 2:ceil(N/2);
if debug_mode,
    R = ones(length(idx),size(X,2))*2*pi - pi;
else
    R = rand(length(idx),size(X,2))*2*pi - pi;
end

P = zeros(size(X));
P([idx N-idx+2],:) = [R; -R];


S = fft(X);
S = abs(S).*exp(1i*P);
Y = real(ifft(S));

%Y = fft(X);
%Y = abs(Y).*exp(1i*P);
%Y = real(ifft(Y));

%%%%%%%% SPM (input x must be a column vector)
%{
n              = size(x,1);
s              = fft(x);
i              = 2:ceil(n/2);
r              = rand(length(i),size(x,2))*2*pi - pi;
p              = zeros(n,size(x,2));
p(i,:)         =  r;
p(n - i + 2,:) = -r;
s              = abs(s).*exp(1i*p);
y              = real(ifft(s));
%y=(y-mean(y))/std(y);
%}

end 