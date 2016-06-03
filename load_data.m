
%%

ch1 = 3;    % O2 occipital
ch2 = 7;    % T8 temporal
ch3 = 13;   % FC6 frontocentral... Rolandic???
myCh = [ch1 ch2 ch3];


%{
      Load subjects with musical background (roman, graham)
%}

%load roman

fn = 'roman_exp.edf';
[hdr,data] = edfread(fn);
for ii = 1:3
    roman_exp{ii} = data(myCh(ii),:) - mean(data(myCh(ii),:));
end

fn = 'roman_ctrl.edf';
[hdr,data] = edfread(fn);
for ii = 1:3
    roman_ctrl{ii} = data(myCh(ii),:) - mean(data(myCh(ii),:));
end

%load graham

fn = 'graham_exp.edf';
[hdr,data] = edfread(fn);
for ii = 1:3
    graham_exp{ii} = data(myCh(ii),:) - mean(data(myCh(ii),:));
end

fn = 'graham_ctrl.edf';
[hdr,data] = edfread(fn);
for ii = 1:3
    graham_ctrl{ii} = data(myCh(ii),:) - mean(data(myCh(ii),:));
end

%{
      Load subjects with zero musical background (savos, angel)
%}

%load savos
fn = 'savos_exp.edf';
[hdr,data] = edfread(fn);
for ii = 1:3
    savos_exp{ii} = data(myCh(ii),:) - mean(data(myCh(ii),:));
end

fn = 'savos_ctrl.edf';
[hdr,data] = edfread(fn);
for ii = 1:3
    savos_ctrl{ii} = data(myCh(ii),:) - mean(data(myCh(ii),:));
end

%load angel

fn = 'angel_exp.edf';
[hdr,data] = edfread(fn);
for ii = 1:3
    angel_exp{ii} = data(myCh(ii),:) - mean(data(myCh(ii),:));
end

fn = 'angel_ctrl.edf';
[hdr,data] = edfread(fn);
for ii = 1:3
    angel_ctrl{ii} = data(myCh(ii),:) - mean(data(myCh(ii),:));
end


%%