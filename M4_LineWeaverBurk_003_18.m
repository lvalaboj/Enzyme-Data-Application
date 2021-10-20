function [Vmax, Km] = M4_LineWeaverBurk_003_18(velocity, concentration)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% This program inputs and interprets solar panel power output data,
% calculates an LSRL, and displays relevant figures and calculations to the
% user.
%
% Function Call
% 
%
% Input Arguments
% 
%
% Output Arguments
% 
%
% Assignment Information
%   Assignment:     
%   Author:         Cameron McCutcheon, mccutchc@purdue.edu
%   Team ID:        003-18
%   Academic Integrity:
%     [] We worked with one or more peers but our collaboration
%        maintained academic integrity.
%    Peers I worked with: Ernani Costa Neto, ecostane@purdue.edu
%    Peers I worked with: Lakshmi Valaboju, lvalaboj@purdue.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ____________________
%% INITIALIZATION



%% ____________________
%% CALCULATIONS

%Polynomial Function Calculations

coeffs = polyfit(velocity ./ concentration, velocity, 1);
M_lin = coeffs(1);
B_lin = coeffs(2);

%Vmax Calculations
Vmax = B_lin;

%Km Calculations
Km = -1 * M_lin;

%% ____________________
%% FORMATTED TEXT/FIGURE DISPLAYS


%% ____________________
%% RESULTS


%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.

