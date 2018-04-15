% Modify with any audio file (must be on the same file directory as source code)
[x, Fs] = audioread('spring.wav');

Length = length(x);

X = abs(fft(x));

% Low-Pass Filter
for i = 2 : Length   
    if(i < 3)
        y1(i) = .0071*x(i) - .0071*x(i-1);
    else          
        y1(i) = .0071*x(i) - .0071*x(i-1) + .9859*y1(i-1);
    end   
end

% High-Pass Filter
for i = 3 : Length   
    if(i < 4) 
        y2(i) = .7419*x(i) - 1.4838*x(i-1) + .7419*x(i-2);
    else       
        y2(i) = .7419*x(i) - 1.4838*x(i-1) + .7419*x(i-2) + 1.4160*y2(i-1) - .5515*y2(i-2);
    end   
end

%F Band-Pass Filter
for i = 3 : Length   
    if(i < 4)
        y3(i) = .0663*x(i) - .0663*x(i-2);
    else       
        y3(i) = .0663*x(i) - .0663*x(i-2) + 1.8533*y3(i-1) - .8675*y3(i-2);
    end   
end

yFinal = y1+y2+y3;

Y1 = abs(fft(y1));

figure
subplot(2,1,1)      
plot(X)           
title('Original')

subplot(2,1,2)       
plot(Y1)        
title('Low-Pass Filter')

Y2 = abs(fft(y2));

figure
subplot(2,1,1)      
plot(X)           
title('Original')

subplot(2,1,2)       
plot(Y2)        
title('High-Pass Filter')

Y3 = abs(fft(y3));

figure
subplot(2,1,1)      
plot(X)           
title('Original')

subplot(2,1,2)       
plot(Y3)        
title('Band-Pass Filter')