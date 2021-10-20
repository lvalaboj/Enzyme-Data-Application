function [Vmax, Km] = M4_HanesWoolf_003_18(velocity, concentration)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% This program inputs and interprets solar panel power output data,
% calculates an LSRL, and displays relevant figures and calculations to the
% user.
%
% Function Call
% [Vmax, Km] =  M2_HanesWoolf(velocity, concentration)
%
% Input Arguments
% 1. Velocity - The velocity array 
% 2. Concentration - The concentration values from the data file
%
% Output Arguments
% 1. Vmax 
% 2. Km
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
%     Peers we worked with: Name, login@purdue [repeat for each]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% ____________________
%% INITIALIZATION

%% ____________________
%% CALCULATIONS
%Polynomial Function Calculations

coeffs = polyfit(concentration, concentration ./ velocity, 1); %creates the coefficients for the Hanes Woolf Equation
M_lin = coeffs(1); %The slope of the Hanes Woolf Equation
B_lin = coeffs(2); %The y intercept of the Hanes Woolf Equation

%Vmax Calculations
Vmax = 1 ./ M_lin; %Vmax is the reciprocal of the slope of the Hanes Woolf Equation

%Km Calculations
Km = B_lin * Vmax; %Km is the product of the y intercept of the Hanes Woold Equation and Vmax

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

