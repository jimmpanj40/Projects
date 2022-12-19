%% Question 1 Constellation M-QAM

% new figure
figure()
hold on
% Plot constellation's points
scatter(x,y,50,'b*');          
axis([-sqrt(M) sqrt(M) -sqrt(M) sqrt(M)]);

% parametres figure
title('Gray coding of M-QAM');
xlabel('I');
ylabel('Q');
grid on

% Initialisation of the scale
x = real(mComplex(:));
y = imag(mComplex(:));
z = mGray(:);

% adding Gray code
for k = 1 : M
    text(x(k)-0.6,y(k)+0.3,...
        dec2base(z(k),2,log2(M)),'Color',[1 0 0]);
end

%% Question 2 Communication chain

% dessiner les points de la constellation
figure()
scatter(x_rn,y_rn,50,'b*');          
axis([-sqrt(M) sqrt(M) -sqrt(M) sqrt(M)]);

title('Representation of rn sequence');
xlabel('I');
ylabel('Q');
grid on


figure()
hold on;

scatter(x_an,y_an,50,'m*');          
axis([-sqrt(M) sqrt(M) -sqrt(M) sqrt(M)]);

scatter(x_an2,y_an2,50,'r');          
axis([-sqrt(M) sqrt(M) -sqrt(M) sqrt(M)]);

scatter(x_rn,y_rn,50,'b*');          
axis([-sqrt(M) sqrt(M) -sqrt(M) sqrt(M)]);

% figure parameters
title('Representation of an, rn and ân sequences');
xlabel('I');
ylabel('Q');
legend('an','ân','rn')
grid on

%% Question 3 Experimental binary and symbol error rates

figure()
semilogy(normalisedNoiseDB,binErrorRateExp)
hold on
semilogy(normalisedNoiseDB,symbErrorRateExp)
title("Experimental error rate curve ")
xlabel("Normalised SNR in dB")
ylabel("Bit error rate")
ylim([0.0001 1])
legend("Bit error rate","Symbol error rate")

%% Question 4 Theoretical curve of error probability
figure()
semilogy(normalisedNoiseDB,binErrorRateTh)
hold on
semilogy(normalisedNoiseDB,symbErrorRateTh)
title("Theoretical error rate curve ")
xlabel("Normalised SNR in dB")
ylabel("Bit error rate")
%ylim([0 1.6])
legend("Bit error rate","Symbol error rate")
