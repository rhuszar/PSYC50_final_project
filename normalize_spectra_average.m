%%


%{
roman_exp{1}   roman_exp{ii}   
roman_ctrl{1}  roman_ctrl{ii}

graham_exp{1}   graham_exp{ii} 
graham_ctrl{1}  graham_ctrl{ii}

savos_exp{1}   savos_exp{ii}   
savos_ctrl{1}  savos_ctrl{ii} 

angel_exp{1}   angel_exp{ii}  
angel_ctrl{1}  angel_ctrl{ii} 
%}


Fs = 128;   % Emotiv sampling freq
wSize = 1024;
cols = 'kbm';


%subplot(121)
for ii = 1:3
    [Pxx,F] = pwelch(graham_exp{ii},hanning(wSize/4),wSize/8,[],Fs);
    Y{ii} = Pxx;
    X{ii} = F;
    mySum1{ii} = sum(Y{ii});
    Y{ii} = Y{ii}/mySum1{ii};
    %plot(X{ii},10*log10(Y{ii}), cols(ii), 'LineWidth', 2);
    %hold on
end

for ii = 1:3
    [Pxx,F] = pwelch(roman_exp{ii},hanning(wSize/4),wSize/8,[],Fs);
    M{ii} = F;
    N{ii} = Pxx;
    mySum2{ii} = sum(N{ii});
    N{ii} = N{ii}/mySum2{ii};
end


for ii = 1:3
    result{ii} = (length(graham_exp{1})*Y{ii} + length(roman_exp{1})*N{ii})/(length(graham_exp{1})+length(roman_exp{1})); 
    plot(M{ii},10*log10(result{ii}), cols(ii), 'LineWidth', 2);
    hold on
end

xlabel('Frequency (Hz)'); ylabel('Power (dB)');
set(gca,'XLim',[0 50],'XTick',0:10:50,'FontSize',12); grid on;
legend('O1','T7', 'FC5');
title('Musical background - musical imagery condition (N=2)');




%%