%%


%{
    For each condition in each of the two groups, produces a weighed 
    average of the normalized power spectra across each set of
    electrodes (e.g., for graham_exp and roman_exp belonging to same
    condition and group, take weighed average of the normalized power
    spectra across electrodes O2, T8, and FC6 - plot these in same
    figure... as such, get 4 figures in total)
    
    NOTE: this .m file contains multiple instances of the same code that
    process all the group conditions in the way described above - this
    is something the author of the code is not proud of (if time allows,
    the code will be made more efficient.
%}


Fs = 128;   % Emotiv sampling freq
wSize = 1024;
cols = 'kbm';

figure

%{
    Musical background condition - experimental (graham_exp, roman_exp)
%}

for ii = 1:3
    [Pxx,F] = pwelch(graham_exp{ii},hanning(wSize/4),wSize/8,[],Fs);
    Y{ii} = Pxx;
    X{ii} = F;
    mySum1{ii} = sum(Y{ii});
    Y{ii} = Y{ii}/mySum1{ii};
end

for ii = 1:3
    [Pxx,F] = pwelch(roman_exp{ii},hanning(wSize/4),wSize/8,[],Fs);
    M{ii} = F;
    N{ii} = Pxx;
    mySum2{ii} = sum(N{ii});
    N{ii} = N{ii}/mySum2{ii};
end

subplot(2,2,1)

for ii = 1:3
    result{ii} = (length(graham_exp{1})*Y{ii} + length(roman_exp{1})*N{ii})/(length(graham_exp{1})+length(roman_exp{1})); 
    plot(M{ii},10*log10(result{ii}), cols(ii), 'LineWidth', 2);
    hold on
end

xlabel('Frequency (Hz)'); ylabel('Power (dB)');
set(gca,'XLim',[0 50],'XTick',0:10:50,'YLim',[-50 0],'YTick',-50:10:0,'FontSize',12); grid on;
legend('O1','T7', 'FC5');
title('Musical background - musical imagery condition (N=2)');

%
% NOTE - code below is made of instances of the code above
%

%{
    Musical background condition - control (graham_ctrl, roman_ctrl)
%}

for ii = 1:3
    [Pxx,F] = pwelch(graham_ctrl{ii},hanning(wSize/4),wSize/8,[],Fs);
    Y{ii} = Pxx;
    X{ii} = F;
    mySum1{ii} = sum(Y{ii});
    Y{ii} = Y{ii}/mySum1{ii};
end

for ii = 1:3
    [Pxx,F] = pwelch(roman_ctrl{ii},hanning(wSize/4),wSize/8,[],Fs);
    M{ii} = F;
    N{ii} = Pxx;
    mySum2{ii} = sum(N{ii});
    N{ii} = N{ii}/mySum2{ii};
end

subplot(2,2,2)

for ii = 1:3
    result{ii} = (length(graham_ctrl{1})*Y{ii} + length(roman_ctrl{1})*N{ii})/(length(graham_ctrl{1})+length(roman_ctrl{1})); 
    plot(M{ii},10*log10(result{ii}), cols(ii), 'LineWidth', 2);
    hold on
end

xlabel('Frequency (Hz)'); ylabel('Power (dB)');
set(gca,'XLim',[0 50],'XTick',0:10:50,'YLim',[-50 0],'YTick',-50:10:0,'FontSize',12); grid on;
legend('O1','T7','FC5');
title('Musical background - visual imagery condition (N=2)');

%{
    No musical background condition - experimental (savos_exp, angel_exp)
%}

for ii = 1:3
    [Pxx,F] = pwelch(savos_exp{ii},hanning(wSize/4),wSize/8,[],Fs);
    Y{ii} = Pxx;
    X{ii} = F;
    mySum1{ii} = sum(Y{ii});
    Y{ii} = Y{ii}/mySum1{ii};
end

for ii = 1:3
    [Pxx,F] = pwelch(angel_exp{ii},hanning(wSize/4),wSize/8,[],Fs);
    M{ii} = F;
    N{ii} = Pxx;
    mySum2{ii} = sum(N{ii});
    N{ii} = N{ii}/mySum2{ii};
end

subplot(2,2,3)

for ii = 1:3
    result{ii} = (length(savos_exp{1})*Y{ii} + length(angel_exp{1})*N{ii})/(length(savos_exp{1})+length(angel_exp{1})); 
    plot(M{ii},10*log10(result{ii}), cols(ii), 'LineWidth', 2);
    hold on
end

xlabel('Frequency (Hz)'); ylabel('Power (dB)');
set(gca,'XLim',[0 50],'XTick',0:10:50,'YLim',[-50 0],'YTick',-50:10:0,'FontSize',12); grid on;
legend('O1','T7', 'FC5');
title('No Musical background - musical imagery condition (N=2)');

%{
    No musical background condition - control (savos_ctrl, angel_ctrl)
%}

for ii = 1:3
    [Pxx,F] = pwelch(savos_ctrl{ii},hanning(wSize/4),wSize/8,[],Fs);
    Y{ii} = Pxx;
    X{ii} = F;
    mySum1{ii} = sum(Y{ii});
    Y{ii} = Y{ii}/mySum1{ii};
end

for ii = 1:3
    [Pxx,F] = pwelch(angel_ctrl{ii},hanning(wSize/4),wSize/8,[],Fs);
    M{ii} = F;
    N{ii} = Pxx;
    mySum2{ii} = sum(N{ii});
    N{ii} = N{ii}/mySum2{ii};
end

subplot(2,2,4)

for ii = 1:3
    result{ii} = (length(savos_ctrl{1})*Y{ii} + length(angel_ctrl{1})*N{ii})/(length(savos_ctrl{1})+length(angel_ctrl{1})); 
    plot(M{ii},10*log10(result{ii}), cols(ii), 'LineWidth', 2);
    hold on
end

xlabel('Frequency (Hz)'); ylabel('Power (dB)');
set(gca,'XLim',[0 50],'XTick',0:10:50,'YLim',[-50 0],'YTick',-50:10:0,'FontSize',12); grid on;
legend('O1','T7', 'FC5');
title('No Musical background - visual imagery condition (N=2)');



%%