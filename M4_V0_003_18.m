function [v] = M4_V0_003_18(times, Smooth_Conc, s, v)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Function Description 
% This function would determine the VO.
%
% Function Call
% [v] = V0_UDF(times, Concentration)
%
% Input Arguments
% 1. Times
% 2. Concentration
%
% Output Arguments
% 1. V - Velocity 
%
% Assignment Information
%   Assignment:     M4
%   Team member:    Ernani Costa Neto, ecostane@purdue.eduj
%                   Cam McCutcheon, mccutchc@purdue.edu
%                   Lakshmi Valaboju, lvalabo@purdue.edu
%   Team ID:        003-18
%   Academic Integrity:
%     [] We worked with one or more peers but our collaboration
%        maintained academic integrity.
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ____________________
%% INITIALIZATION
%Removes All NAN values from called concentration array
Smooth_Conc = Smooth_Conc';
Smooth_Conc = Smooth_Conc(~isnan(Smooth_Conc))';

%% ____________________
%% CALCULATIONS


times = times(1:length(Smooth_Conc));

Val = floor(length(Smooth_Conc) * v); %Point is 3% of the way through the data to give accurate linear representation of data

v = (Smooth_Conc(Val)- Smooth_Conc(1)) / (times(Val)- times(1));

%% ____________________
%% FORMATTED TEXT/FIGURE DISPLAYS

%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% I have not used source code obtained from any other unauthorized
% source, either modified or unmodified.  Neither have I provided
% access to my code to another. The function I am submitting
% is my own original work.
