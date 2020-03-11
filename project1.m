close all;
%% Stoch Matlab Project 1 
% Theo Song + Jungang(Leon) Fang
%% Question 1
Number = 10000000;                      % the number of trials should be big
sample = randi([1 6],3,Number);         % we take the samples from [1,6], and a matrix with size of 3*10000000
survived = sum(sample);                 % we take the sum of each coloum, and its will be the result of each trial
number18 = sum(survived == 18);         % we find the number of trials which is eqaul to 18
prob1 = number18/Number                 % calculate the prob
% the probability is around 0.0046 - 0.0047
%% b
sample1 = randi([1 6],3,Number);    % repeat part a for three times
result1 = sum(sample1);             
sample2 = randi([1 6],3,Number);    
result2 = sum(sample2);             
sample3 = randi([1 6],3,Number);    
result3 = sum(sample3);             
finalsample = max([result1;result2;result3]);   % find max
prob2 = sum(finalsample == 18) / Number
% the probability is around 0.0139 - 0.0137
%% c
prob3 = 1;                          % repeart part b for three times
for i=1:6
    sample1 = randi([1 6],3,Number);
    result1 = sum(sample1);
    sample2 = randi([1 6],3,Number);
    result2 = sum(sample2);
    sample3 = randi([1 6],3,Number);
    result3 = sum(sample3);
    finalsample = max([result1;result2;result3]);
    prob2 = sum(finalsample == 18) / Number;
    prob3 = prob3*prob2;
end
prob3
% the probability is around 6.9e-12
%% d
prob4 = 1;                          % repeat part c, but change 18 to 9
for i=1:6
    sample1 = randi([1 6],3,Number);
    result1 = sum(sample1);
    sample2 = randi([1 6],3,Number);
    result2 = sum(sample2);
    sample3 = randi([1 6],3,Number);
    result3 = sum(sample3);
    finalsample = max([result1;result2;result3]);
    prob2 = sum(finalsample == 9) / Number;
    prob4 = prob4*prob2;
end
prob4
% the probability is around 1.95e-9

%% Question 2
Number = 1000000;
hitsample = randi([1 4],1,Number);  % generate the sample for the HP
total = sum(hitsample);             % the total HP trolls can take
avghit = total / Number            % calculate the average
% the average hit is around 2.50
fireball = randi([1 2],2,Number);   % generate the sample for the damage
total = sum(sum(fireball));         % calculate the total damage
avgfireball = total/Number         % calculate the average
% the average of fireball is around 3
prob_bound = sum(sum(fireball) == 4) / Number  % find the total number of trials which are equal to 4, and calculate the prob
% the prob is around 0.25
%% b
figure;
%pmf for the fireball's dmg {2,3,4}
fireballY = [sum(sum(fireball) == 2)/Number sum(sum(fireball) == 3)/Number sum(sum(fireball) == 4)/Number];
fireballX = [2 3 4];
stem(fireballX,fireballY,'filled');
xlim([1 5]);
ylim([0 1]);
ylabel('Probability of damage');
xlabel('Damage of fireball');
title("Stem plot of fireball's pmf");
figure;
%pmf for the troll's hp {1,2,3,4}
trollY = [sum(hitsample == 1)/Number sum(hitsample == 2)/Number sum(hitsample == 3)/Number sum(hitsample == 4)/Number];
trollX = [1 2 3 4];
stem(trollX,trollY,'filled');
xlim([0 5]);
ylim([0 1]);
ylabel('Probability of damage');
xlabel('Damage of troll');
title("Stem plot of troll's pmf");
%adding the probabilities for each pmf gives us around 1, which means
%the probability for other values(that are not in the sample space) must be a zero.
%% c
% HP 1-4
% dmg 2-4
Number = 1000000;
trollHP = randi(4, 6, Number);          %generate 6 trolls
firesmpl = randi(2, 2, Number);         %generate fireball
firedmg = sum(firesmpl);
survived = trollHP > firedmg;           %finding trolls that survived
result = sum((sum(survived) > 0 ) == 0)/Number %finding cases where no trolls survived
% the prob is around 0.342
%% d
index = find(sum(survived) == 1);       % find the survived trolls with only 1 HP 
afteratk = trollHP - firedmg;           % find the remaining HP after attack
result = afteratk(1:end, index);        % find the case where only one troll survived
remainHP = result(find(result>0));      % find the total valid HP
s = size(remainHP);                     % get the size
avg_remain_HP = sum(remainHP)/s(1)     %calculating the average HP of the one troll that survived
%% e
%11/20 -> 2d6 -> 11/20 -> 1d4
Number = 1000000;
dice_20 = randi(20, 2, Number);         % generate the sample space
dice = dice_20 >= 11;                   % find the sample which is bigger than or eqaul to 11
sword = find(dice(1,:)>0);              % take the first row, and find the successful trials(bigger than 1)
sword_temp = size(sword);               % get the size
sword_trial = sword_temp(2);            % the number of trials, which is the size of the column
hammer_trial = sum(dice(2,sword));      % the number of samples that both dice got 1
sword_atk = randi(6, 2, sword_trial);   % generate the sample for the attack
hammer_atk = randi(4, 1, hammer_trial); % generate the sample for the hammer
total_atk = sum(sum(sword_atk)) + sum(hammer_atk);  % calculate the total attack
result = total_atk/Number               % get the average
%% f








