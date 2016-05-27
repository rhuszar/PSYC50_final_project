%%

%{
    This .m processes signals for each subject, and cuts to reduce the
    number of artifacts according to the following rule (design spec): 
        
        For each subject condition (e.g. roman_exp), take the threshold
        determined by inspecting the signals across electrodes, and
        construct a toss index vector containing indices of data points in
        this subject condition's signals that exceed this threshold in
        either positive or negative direction.
        Step through the created toss index vector, and whenever a sequence of
        adjacent data points is identified, save 0.5 seconds of data points
        on either side of this sequence (corresponds to 64 data points on
        either end since Fs=128) - add these to the toss index vector.
        Lastly, remove the data points specified in toss index vector from
        all signals for given subject condition.

    NOTE: this .m file contains multiple instances of the same code that
    process all the subject conditions in the way described above - this
    is something the author of the code is not proud of (if time allows,
    the code will be made more efficient.
%} 

Fs = 128;

%{
    Eliminate noise in roman_exp
%}

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
% for any adjacent pair a and b, where a precedes b, and a+1==b, 
% toss_idx(a)+1==toss_idx(b) holds...

temp_toss_idx = [];         % temporary index placeholder for at most 64 data points (0.5 seconds)
curr_toss_idx = [];         % hold indices of the 64-data-point blocks on either side of all index intervals in toss_idx

% identify 0.5 seconds worth of data points on either end of
% each index interval, and keep track of their indices in curr_toss_idx
% NOTE: the algorithm below doesn't account for overlaps in the 0.5 second
%       intervals, though this only changes runtime by a constant amount
%       (worst case run time is O(num data points for given condition), 
%       which is linear)
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

% update  toss_idx with curr_toss_idx
toss_idx = [toss_idx curr_toss_idx];

for ii = 1:3
    roman_exp{ii}(toss_idx) = [];
end

%
%   NOTE - code below is made of instances of the code above
%

%{
    Eliminate noise in roman_ctrl
%}

toss_idx = [];
curr_toss_idx = [];

myLength = length(roman_ctrl{1});  

for ii = 1:3
    curr_toss_idx = find(roman_ctrl{ii} > (roman_ctrl_thresh) | roman_ctrl{ii} < (-roman_ctrl_thresh));
    toss_idx = cat(2,toss_idx,curr_toss_idx);
end

toss_idx = sort(toss_idx);
toss_idx = unique(toss_idx);

temp_toss_idx = []; 
curr_toss_idx = [];   


for ii = 1:length(toss_idx)
    if (toss_idx(ii)-1 >= 1) && (ii == 1) || (ii-1 >= 1 && (toss_idx(ii) > toss_idx(ii-1)+1))
        jj = toss_idx(ii) - 1;             
        temp_toss_idx = [temp_toss_idx jj];    
        counter = 1;                      
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
        counter = 1;                     
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
    roman_ctrl{ii}(toss_idx) = [];
end

%{
    Eliminate noise in graham_exp
%}

toss_idx = [];
curr_toss_idx = [];

myLength = length(graham_exp{1});  

for ii = 1:3
    curr_toss_idx = find(graham_exp{ii} > (graham_exp_thresh) | graham_exp{ii} < (-graham_exp_thresh));
    toss_idx = cat(2,toss_idx,curr_toss_idx);
end

toss_idx = sort(toss_idx);
toss_idx = unique(toss_idx);

temp_toss_idx = []; 
curr_toss_idx = [];   


for ii = 1:length(toss_idx)
    if (toss_idx(ii)-1 >= 1) && (ii == 1) || (ii-1 >= 1 && (toss_idx(ii) > toss_idx(ii-1)+1))
        jj = toss_idx(ii) - 1;             
        temp_toss_idx = [temp_toss_idx jj];    
        counter = 1;                      
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
        counter = 1;                     
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
    graham_exp{ii}(toss_idx) = [];
end

%{
    Eliminate noise in graham_ctrl
%}

toss_idx = [];
curr_toss_idx = [];

myLength = length(graham_ctrl{1});  

for ii = 1:3
    curr_toss_idx = find(graham_ctrl{ii} > (graham_ctrl_thresh) | graham_ctrl{ii} < (-graham_ctrl_thresh));
    toss_idx = cat(2,toss_idx,curr_toss_idx);
end

toss_idx = sort(toss_idx);
toss_idx = unique(toss_idx);

temp_toss_idx = []; 
curr_toss_idx = [];   


for ii = 1:length(toss_idx)
    if (toss_idx(ii)-1 >= 1) && (ii == 1) || (ii-1 >= 1 && (toss_idx(ii) > toss_idx(ii-1)+1))
        jj = toss_idx(ii) - 1;             
        temp_toss_idx = [temp_toss_idx jj];    
        counter = 1;                      
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
        counter = 1;                     
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
    graham_ctrl{ii}(toss_idx) = [];
end

%{
    Eliminate noise in savos_exp
%}

toss_idx = [];
curr_toss_idx = [];

myLength = length(savos_exp{1});  

for ii = 1:3
    curr_toss_idx = find(savos_exp{ii} > (savos_exp_thresh) | savos_exp{ii} < (-savos_exp_thresh));
    toss_idx = cat(2,toss_idx,curr_toss_idx);
end

toss_idx = sort(toss_idx);
toss_idx = unique(toss_idx);

temp_toss_idx = []; 
curr_toss_idx = [];   


for ii = 1:length(toss_idx)
    if (toss_idx(ii)-1 >= 1) && (ii == 1) || (ii-1 >= 1 && (toss_idx(ii) > toss_idx(ii-1)+1))
        jj = toss_idx(ii) - 1;             
        temp_toss_idx = [temp_toss_idx jj];    
        counter = 1;                      
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
        counter = 1;                     
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
    savos_exp{ii}(toss_idx) = [];
end

%{
    Eliminate noise in savos_ctrl
%}

toss_idx = [];
curr_toss_idx = [];

myLength = length(savos_ctrl{1});  

for ii = 1:3
    curr_toss_idx = find(savos_ctrl{ii} > (savos_ctrl_thresh) | savos_ctrl{ii} < (-savos_ctrl_thresh));
    toss_idx = cat(2,toss_idx,curr_toss_idx);
end

toss_idx = sort(toss_idx);
toss_idx = unique(toss_idx);

temp_toss_idx = []; 
curr_toss_idx = [];   


for ii = 1:length(toss_idx)
    if (toss_idx(ii)-1 >= 1) && (ii == 1) || (ii-1 >= 1 && (toss_idx(ii) > toss_idx(ii-1)+1))
        jj = toss_idx(ii) - 1;             
        temp_toss_idx = [temp_toss_idx jj];    
        counter = 1;                      
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
        counter = 1;                     
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
    savos_ctrl{ii}(toss_idx) = [];
end
     
%{
    Eliminate noise in angel_exp
%}

toss_idx = [];
curr_toss_idx = [];

myLength = length(angel_exp{1});  

for ii = 1:3
    curr_toss_idx = find(angel_exp{ii} > (angel_exp_thresh) | angel_exp{ii} < (-angel_exp_thresh));
    toss_idx = cat(2,toss_idx,curr_toss_idx);
end

toss_idx = sort(toss_idx);
toss_idx = unique(toss_idx);

temp_toss_idx = []; 
curr_toss_idx = [];   


for ii = 1:length(toss_idx)
    if (toss_idx(ii)-1 >= 1) && (ii == 1) || (ii-1 >= 1 && (toss_idx(ii) > toss_idx(ii-1)+1))
        jj = toss_idx(ii) - 1;             
        temp_toss_idx = [temp_toss_idx jj];    
        counter = 1;                      
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
        counter = 1;                     
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
    angel_exp{ii}(toss_idx) = [];
end

%{
    Eliminate noise in angel_ctrl
%}

toss_idx = [];
curr_toss_idx = [];

myLength = length(angel_ctrl{1});  

for ii = 1:3
    curr_toss_idx = find(angel_ctrl{ii} > (angel_ctrl_thresh) | angel_ctrl{ii} < (-angel_ctrl_thresh));
    toss_idx = cat(2,toss_idx,curr_toss_idx);
end

toss_idx = sort(toss_idx);
toss_idx = unique(toss_idx);

temp_toss_idx = []; 
curr_toss_idx = [];   


for ii = 1:length(toss_idx)
    if (toss_idx(ii)-1 >= 1) && (ii == 1) || (ii-1 >= 1 && (toss_idx(ii) > toss_idx(ii-1)+1))
        jj = toss_idx(ii) - 1;             
        temp_toss_idx = [temp_toss_idx jj];    
        counter = 1;                      
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
        counter = 1;                     
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
    angel_ctrl{ii}(toss_idx) = [];
end

%%