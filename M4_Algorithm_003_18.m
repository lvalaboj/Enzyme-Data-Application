function [Vmax, Km, Velocities] = M4_Algorithm_003_18(time, All_Data, concentration, ReferenceV0, RefCoeffs)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% Uses looping structures to calculate data model to the raw data file
% while making use of UDF subfunctions. It also plots the data model
% results for the 5 different enzymes in the data file along with the
% original raw data.
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

SavitskyStrength = .043; %Strength of Savitsky-Golay filter to be used in V0
PercentageVelo = .036; %Percentage of data to go through before drawing tangent line in V0
BestWeight = .65;

%% ____________________
%% CALCULATIONS
% IMPROVEMENT 1- Optimization program for V0 to best match reference V0 values

%%CODE TO RUN TO OPTIMIZE PARAMETERS (SavitskyStrength & PercentageVelo)

% SSE = 0;
% SSEmin = 100000000000;
% for s = .01:.001:.5
%     Smooth_Conc = smoothdata(All_Data, 'sgolay', 'SmoothingFactor', s); 
%     for v = .01:.001:.25
%         for j = 1:1:10
%             Velocities(1,j) = M4_V0_003_18(time, Smooth_Conc(:,j), s, v);
%         
%         end
%         SSE = sum(abs(Velocities - ReferenceV0) / ReferenceV0);
%         if (SSE < SSEmin)
%             SSEmin = SSE;
%             SavitskyStrength = s;
%             PercentageVelo = v;
%             
%         end
%     end
% end
% disp(SSEmins)
% disp(SSEminv)


%%CODE TO RUN IN NORMAL CASE
Smooth_Conc = smoothdata(All_Data, 'sgolay', 'SmoothingFactor', SavitskyStrength);
for j = 1:1:10
    Velocities(1,j) = M4_V0_003_18(time, All_Data(:,j), SavitskyStrength, PercentageVelo);
    
end


%Calculating the Km and Vmax values using udf subfunction

%%IMPROVEMENT 2- USING OPTIMIZATION PROGRAM TO SOLVE FOR BEST WEIGHTS OF
%%LINEARIZATION METHODS
% PercentDiffmin = 100000000;
% 
% [Vmax2,Km2] = M4_HanesWoolf_003_18(Velocities(1,:), concentration);
% [Vmax1,Km1] = M4_LineWeaverBurk_003_18(Velocities(1,:), concentration);
% 
% for weight = 0:.001:1
%     PercentDiff = (RefCoeffs(1) - weight * Vmax1 - (1 - weight) * Vmax2) / RefCoeffs(1);
%     PercentDiff = PercentDiff + (RefCoeffs(2) - weight * Km1 - (1 - weight) * Km2) / RefCoeffs(2);
%     if (PercentDiff < PercentDiffmin)
%         PercentDiffmin = PercentDiff;
%         BestWeight = weight;
%     end
% end
% %disp(BestWeight);


%%CODE TO RUN ONCE OPTIMIZED PARAMETERS (BestWeight) HAS BEEN INPUT
[VmaxHanes, KmHanes] = M4_HanesWoolf_003_18(Velocities(1,:), concentration);
[VmaxLineWB, KmLineWB] = M4_LineWeaverBurk_003_18(Velocities(1,:), concentration);
Vmax = VmaxHanes * BestWeight + (1 - BestWeight) * VmaxLineWB;
Km = KmHanes * BestWeight + (1 - BestWeight) * KmLineWB;




%OLD CODE
%Code to calculate array of V0's
% for j = 1:1:10
%     Velocities(1,j) = M4_V0_003_18(time, All_Data(:,j));
%     
% end
%Code to calculate Vmax and Km
%[Vmax,Km] = M4_HanesWoolf_003_18(Velocities(1,:), concentration);
% [Vmax,Km] = M4_LineWeaverBurk_003_18(Velocities(1,:), concentration);



%% ____________________
%% FORMATTED TEXT/FIGURE DISPLAYS

%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% I have not used source code obtained from any other unauthorized
% source, either modified or unmodified.  Neither have I provided
% access to my code to another. The function I am submitting
% is my own original work.