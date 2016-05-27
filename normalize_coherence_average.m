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
wSize = 2048;
cols = 'kbm';

for ii = 2:3
    [C,F] = mscohere(graham_exp{ii-1},graham_exp{ii},hanning(wSize/4),wSize/8,[],Fs); 
    X{ii-1} = F;
    Y{ii-1} = C;
    plot(F,C,cols(ii-1),'LineWidth',2);
end

for ii = 2:3
    [C,F] = mscohere(roman_exp{ii-1},roman_exp{ii},hanning(wSize/4),wSize/8,[],Fs); 
    M{ii-1} = F;
    N{ii-1} = C;
end


for ii = 1:2
    result{ii} = (length(graham_exp{1})*Y{ii} + length(roman_exp{1})*N{ii})/(length(graham_exp{1})+length(roman_exp{1})); 
    plot(M{ii},10*log10(result{ii}), cols(ii), 'LineWidth', 2);
    hold on
end

xlabel('Frequency (Hz)'); ylabel('Coherence');
set(gca,'XLim',[0 25],'XTick',0:5:25,'FontSize',12); grid on;
legend('O1-T7','T7-FC5');
title('Musical background - musical imagery condition (N=2)');
%}