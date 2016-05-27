%%


%{
    For each condition in each of the two groups, produces a weighed 
    average of coherences across each relevant pair of electrodes
    (e.g., for graham_exp and roman_exp belonging to same
    condition and group, take weighed average of the coherences 
    across electrode pairs O2-T8, and T8-FC6 - plot these in same
    figure... as such, get 4 figures in total)
    
    NOTE: this .m file contains multiple instances of the same code that
    process all the group conditions in the way described above - this
    is something the author of the code is not proud of (if time allows,
    the code will be made more efficient).
%}


Fs = 128;       % Emotiv sampling freq
wSize = 2048;
cols = 'kbm';

figure

%{
    Musical background condition - experimental (graham_exp, roman_exp)
%}

for ii = 2:3
    [C,F] = mscohere(graham_exp{ii-1},graham_exp{ii},hanning(wSize/4),wSize/8,[],Fs); 
    X{ii-1} = F;
    Y{ii-1} = C;
end

for ii = 2:3
    [C,F] = mscohere(roman_exp{ii-1},roman_exp{ii},hanning(wSize/4),wSize/8,[],Fs); 
    M{ii-1} = F;
    N{ii-1} = C;
end

subplot(2,2,1)

for ii = 1:2
    result{ii} = (length(graham_exp{1})*Y{ii} + length(roman_exp{1})*N{ii})/(length(graham_exp{1})+length(roman_exp{1})); 
    plot(M{ii},10*log10(result{ii}), cols(ii), 'LineWidth', 2);
    hold on
end

xlabel('Frequency (Hz)'); ylabel('Coherence');
set(gca,'XLim',[0 25],'XTick',0:5:25,'FontSize',12); grid on;
legend('O1-T7','T7-FC5');
title('Musical background - musical imagery (N=2)');

%
% NOTE - code below is made of instances of the code above
%

%{
    Musical background condition - control (graham_ctrl, roman_ctrl)
%}

for ii = 2:3
    [C,F] = mscohere(graham_ctrl{ii-1},graham_ctrl{ii},hanning(wSize/4),wSize/8,[],Fs); 
    X{ii-1} = F;
    Y{ii-1} = C;
end

for ii = 2:3
    [C,F] = mscohere(roman_ctrl{ii-1},roman_ctrl{ii},hanning(wSize/4),wSize/8,[],Fs); 
    M{ii-1} = F;
    N{ii-1} = C;
end

subplot(2,2,2)

for ii = 1:2
    result{ii} = (length(graham_ctrl{1})*Y{ii} + length(roman_ctrl{1})*N{ii})/(length(graham_ctrl{1})+length(roman_ctrl{1})); 
    plot(M{ii},10*log10(result{ii}), cols(ii), 'LineWidth', 2);
    hold on
end

xlabel('Frequency (Hz)'); ylabel('Coherence');
set(gca,'XLim',[0 25],'XTick',0:5:25,'FontSize',12); grid on;
legend('O1-T7','T7-FC5');
title('Musical background - visual imagery (N=2)');

%{
    No musical background condition - experimental (savos_exp, angel_exp)
%}

for ii = 2:3
    [C,F] = mscohere(savos_exp{ii-1},savos_exp{ii},hanning(wSize/4),wSize/8,[],Fs); 
    X{ii-1} = F;
    Y{ii-1} = C;
end

for ii = 2:3
    [C,F] = mscohere(angel_exp{ii-1},angel_exp{ii},hanning(wSize/4),wSize/8,[],Fs); 
    M{ii-1} = F;
    N{ii-1} = C;
end

subplot(2,2,3)

for ii = 1:2
    result{ii} = (length(savos_exp{1})*Y{ii} + length(angel_exp{1})*N{ii})/(length(savos_exp{1})+length(angel_exp{1})); 
    plot(M{ii},10*log10(result{ii}), cols(ii), 'LineWidth', 2);
    hold on
end

xlabel('Frequency (Hz)'); ylabel('Coherence');
set(gca,'XLim',[0 25],'XTick',0:5:25,'FontSize',12); grid on;
legend('O1-T7','T7-FC5');
title('No musical background - musical imagery (N=2)');

%{
    No musical background condition - control (savos_ctrl, angel_ctrl)
%}

for ii = 2:3
    [C,F] = mscohere(savos_ctrl{ii-1},savos_ctrl{ii},hanning(wSize/4),wSize/8,[],Fs); 
    X{ii-1} = F;
    Y{ii-1} = C;
end

for ii = 2:3
    [C,F] = mscohere(angel_ctrl{ii-1},angel_ctrl{ii},hanning(wSize/4),wSize/8,[],Fs); 
    M{ii-1} = F;
    N{ii-1} = C;
end

subplot(2,2,4)

for ii = 1:2
    result{ii} = (length(savos_ctrl{1})*Y{ii} + length(angel_ctrl{1})*N{ii})/(length(savos_ctrl{1})+length(angel_ctrl{1})); 
    plot(M{ii},10*log10(result{ii}), cols(ii), 'LineWidth', 2);
    hold on
end

xlabel('Frequency (Hz)'); ylabel('Coherence');
set(gca,'XLim',[0 25],'XTick',0:5:25,'FontSize',12); grid on;
legend('O1-T7','T7-FC5');
title('No musical background - visual imagery (N=2)');