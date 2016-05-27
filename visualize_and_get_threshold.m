
%%

%{
    Visualize musical subjects (roman, graham), and non musical subjects
    (savos, angel). Uncomment whomever you wish to visualize for whichever 
    condition (experimental - musical imagery; control - visual imagery).
%}

% visualize roman_exp

%{
plot(roman_exp{1}');
hold on
plot(roman_exp{2}', 'r');
plot(roman_exp{3}', 'k');
%}


roman_exp_thresh = 200;


% visualize roman_ctrl

%{
plot(roman_ctrl{1}');
hold on
plot(roman_ctrl{2}', 'r');
plot(roman_ctrl{3}', 'k');
%}

roman_ctrl_thresh = 75;

% visualize graham_exp

%{
plot(graham_exp{1}');
hold on
plot(graham_exp{2}', 'r');
plot(graham_exp{3}', 'k');
%}

graham_exp_thresh = 55;

% visualize graham_ctrl

%{
plot(graham_ctrl{1}');
hold on
plot(graham_ctrl{2}', 'r');
plot(graham_ctrl{3}', 'k');
%}

graham_ctrl_thresh = 55;

% visualize savos_exp

%{
plot(savos_exp{1}');
hold on
plot(savos_exp{2}', 'r');
plot(savos_exp{3}', 'k');
%}

savos_exp_thresh = 600;

% visualize savos_ctrl

%{
plot(savos_ctrl{1}');
hold on
plot(savos_ctrl{2}', 'r');
plot(savos_ctrl{3}', 'k');
%}

savos_ctrl_thresh = 150;

% visualize angel_exp

%{
plot(angel_exp{1}');
hold on
plot(angel_exp{2}', 'r');
plot(angel_exp{3}', 'k');
%}

angel_exp_thresh = 150;

% visualize savos_ctrl

%{
plot(angel_ctrl{1}');
hold on
plot(angel_ctrl{2}', 'r');
plot(angel_ctrl{3}', 'k');
%}

angel_ctrl_thresh = 75;



%%