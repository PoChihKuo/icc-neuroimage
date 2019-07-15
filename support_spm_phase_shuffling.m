function y = support_spm_phase_shuffling(x)

%%%%%%%% SPM (input x must be a column vector)
if  size(x,1)==1
    x=x';
end

n              = size(x,1);

s              = fft(x);
i              = 2:ceil(n/2);

debug_mode = false;

if debug_mode,
    r              = ones(length(i),size(x,2))*2*pi - pi;
else
    r              = rand(length(i),size(x,2))*2*pi - pi;
end


p              = zeros(n,size(x,2));
p(i,:)         =  r;
p(n - i + 2,:) = -r;
s              = abs(s).*exp(1i*p);
y              = real(ifft(s));
%y=(y-mean(y))/std(y);
end % end