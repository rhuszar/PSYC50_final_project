%%

%{
roman_exp{1}   roman_exp{ii}    roman_exp_thresh
roman_ctrl{1}  roman_ctrl{ii}   roman_ctrl_thresh

graham_exp{1}   graham_exp{ii}    graham_exp_thresh
graham_ctrl{1}  graham_ctrl{ii}   graham_ctrl_thresh

savos_exp{1}   savos_exp{ii}    savos_exp_thresh
savos_ctrl{1}  savos_ctrl{ii}   savos_ctrl_thresh

angel_exp{1}   angel_exp{ii}    angel_exp_thresh
angel_ctrl{1}  angel_ctrl{ii}   angel_ctrl_thresh
%}

Fs = 128;

toss_idx = [];
curr_toss_idx = [];

myLength = length(roman_exp{1});        % number of data points for given condition

for ii = 1:3
    curr_toss_idx = find(roman_exp{ii} > (roman_exp_thresh) | roman_exp{ii} < (-roman_exp_thresh));
    toss_idx = cat(2,toss_idx,curr_toss_idx);
end

toss_idx = sort(toss_idx);
toss_idx = unique(toss_idx);

% note: an index interval in toss_idx is a sequence of indices, such that
% for any adjacent pair a and b s.t. a+1==b, toss_idx(a)+1==toss_idx(b)

temp_toss_idx = [];         % temporary index placeholder for at most 64 data points (0.5 seconds)
curr_toss_idx = [];         % hold indices of the 64-data-point blocks on either side of all index intervals in toss_idx


for ii = 1:length(toss_idx)
    if (toss_idx(ii)-1 >= 1) && (ii == 1) || (ii-1 >= 1 && (toss_idx(ii) > toss_idx(ii-1)+1))  % either ii==1 or new index interval
        jj = toss_idx(ii) - 1;              % know this is at least 1
        temp_toss_idx = [temp_toss_idx jj];    
        counter = 1;                        % keep track till 64 points
        jj = jj - 1;
        while(jj ~= 1 && any(jj==toss_idx)==0 && counter ~= Fs/2)
            temp_toss_idx = [temp_toss_idx jj];
            counter = counter+1;            
            jj = jj - 1;
        end
        curr_toss_idx=[curr_toss_idx temp_toss_idx];
        temp_toss_idx = [];
    elseif (toss_idx(ii)+1 <= myLength) && (ii == length(toss_idx)) || (ii+1 <= length(toss_idx) && (toss_idx(ii) < toss_idx(ii+1)-1))
        jj = toss_idx(ii) + 1;   
        temp_toss_idx = [temp_toss_idx jj];    
        counter = 1;                        % keep track till 64 points
        jj = jj + 1;
        while(jj ~= myLength && any(jj==toss_idx)==0 && counter ~= Fs/2)
            temp_toss_idx = [temp_toss_idx jj];
            counter = counter+1;            
            jj = jj + 1;
        end
        curr_toss_idx=[curr_toss_idx temp_toss_idx];
        temp_toss_idx = [];
    end
end

curr_toss_idx = sort(curr_toss_idx); curr_toss_idx = unique(curr_toss_idx);

toss_idx = [toss_idx curr_toss_idx];

for ii = 1:3
    roman_exp{ii}(toss_idx) = [];
end


                                                    
%toss_tvec = tvec; toss_tvec(toss_idx) = [];
%plot(toss_tvec,data_cell{iCh}')

%%