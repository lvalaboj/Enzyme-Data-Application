%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132
% Program Description
% This program controls the M4 Algorithm to accept Vmax and Km values for
% the calculated curve. Then, it plots the corresponding tangent V0 lines
% and the MM curve using the calculated coefficients.
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
clear

ReferenceV0 = [0.025, 0.049, 0.099, 0.176 ,0.329, 0.563 , 0.874 , 1.192, 1.361, 1.603];
ReferenceCoeffs = [1.806, 269.74];


%%CODE BLOCK FOR RUNNING ENZYME A-E
All_Data = readmatrix("Data_nextGen_KEtesting_allresults.csv"); %Importing data from the main excel dataset
Substrate_Conc = All_Data(1,2:11); %Getting the concentration values for the concentration axis from main dataset
Enzymes = ["A", "A Duplicate", "B", "B Duplicate","C", "C Duplicate","D", "D Duplicate","E", "E Duplicate",]; %String vector used for later looping structure to name subplot titles
NUMROWS = length(All_Data(:,1)) - 2; %Indexing variable to ensure array bounds are kept
times = All_Data(3:NUMROWS,1); %Importing time column from main dataset
All_Product_Conc = All_Data(3:NUMROWS, 2:length(All_Data(1,:)));

%%CODE BLOCK FOR RUNNING PGO-X50
% All_Data = readmatrix("Data_PGOX50_enzyme.csv");
% Substrate_Conc = All_Data(2,2:11); %Getting the concentration values for the concentration axis from main dataset
% NUMROWS = length(All_Data(:,1)) - 3; %Indexing variable to ensure array bounds are kept
% times = All_Data(4:NUMROWS,1); %Importing time column from main dataset
% All_Product_Conc = All_Data(4:NUMROWS, 2:11);
% Enzymes = ["PGO-X50"];

%% ____________________
%% CALCULATIONS
count = 1;
for i = 1:10:length(All_Product_Conc(1,:))
    [TempVmax, TempKm, TempVelo] = M4_Algorithm_003_18(times, All_Product_Conc(:, i:i+9), Substrate_Conc, ReferenceV0, ReferenceCoeffs);
    Vmax(count) = TempVmax;
    Km(count) = TempKm;
    Velocities(count, 1:10) = TempVelo;
    count = count + 1;
end
%% ____________________
%% FORMATTED TEXT/FIGURE DISPLAYS
%V0 DISPLAYS

for V0Disp = 1:2:length(Enzymes)
    figure(V0Disp)
    set(gcf, 'Position',  [100, 100, 1200, 650])
    PlottingCounter = 1;
    
    for j = (1 + (V0Disp - 1) * 10):1:(10 + (V0Disp - 1) * 10)
        
        Product_Conc = All_Product_Conc(:,j);
        
        Product_Conc = Product_Conc';
        Product_Conc = Product_Conc(~isnan(Product_Conc))';
        Current_time = times(1:length(Product_Conc));
        
        clear val
        i = 1;
        val(i) = 0;
        %Loop to stop plotting the V0 tangent line when it exceeds the max
        %value of the concentration curve so as to make graphs have usable axis
        while (val(i) < max(Product_Conc) * 1.25)
            i = i + 1;
            val(i) = Velocities(V0Disp, PlottingCounter) * Current_time(i);
        end
        
        subplot(2,5,PlottingCounter);
        plot(Current_time, Product_Conc, '-k')
        hold on
        grid on
        plot(Current_time(1:i), val, '-r');
        xlabel('Time [s]');
        ylabel('Concentration [\muM]');
        legend('Original Data', 'V0 Tangent Line','Location','southeast');
        titleStr = "Conc. vs Time @ S_{0} ="  + string(Substrate_Conc(PlottingCounter) + "\muM");
        title(titleStr);
        sgtitleStr = "Product Conc Vs Time with V0 Tangent lines for Enzyme " + Enzymes(V0Disp);
        sgtitle(sgtitleStr);
        PlottingCounter = PlottingCounter + 1;
        
    end
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%MICHAELIS-MENTEN DISPLAYS

for MM = 1:2:length(Enzymes)
    %INDIVIDUAL ENZYME GRAPHS
    figure(MM + V0Disp)
    set(gcf, 'Position',  [100, 100, 600, 400])
    x = linspace(Substrate_Conc(1), Substrate_Conc(10), 2000);
    
    plot(Substrate_Conc, Velocities(MM,:), '*b', 'MarkerSize', 10)
    hold on
    grid on
    MichaelisData = (x .* Vmax(MM)) ./ (Km(MM) + x); %Calculating smooth data curve given our Michaelis-Menten coefficient
    plot(x, MichaelisData, '-k');
    xlabel('Concentration (\muM)');
    ylabel('Reaction Velocity (\muM/s)');
    axis([0, 2000, 0, 2]);
    legend('Original Data', 'Michaelis-Menten Approx.','Location','best');
    sgtitleStr = "Michaelis-Menten Plot for Enzyme " + Enzymes(MM);
    sgtitle(sgtitleStr);
    sgtitle(sgtitleStr);
    
    SSE(MM) = sum((Velocities(MM,:) - (Substrate_Conc .* Vmax(MM) ./ (Km(MM) + Substrate_Conc))) .^2);
    
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %TEXT DISPLAYS
    fprintf("\n-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n");
    StatsStr = "ENZYME " + Enzymes(MM);
    fprintf(StatsStr);
    fprintf("\nVmax: %.4d uM/s, Km: %.2d uM", (Vmax(MM)), (Km(MM)));
    fprintf("\nSSE = %.4d", SSE(MM));
    
end
fprintf("\n-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-\n");

%ALL ENZYMES ONE AXIS
if (length(Enzymes) > 2)
    figure('Name','Michaelis-Menten Plots for a Set of Detergent Enzymes','NumberTitle','off')
    set(gcf, 'Position',  [100, 100, 1000, 600])
    x = linspace(Substrate_Conc(1), Substrate_Conc(10), 2000);
    hold on
    grid on
    MichaelisData = (x .* Vmax(1)) ./ (Km(1) + x);
    plot(x, MichaelisData, '-k');
    MichaelisData = (x .* Vmax(3)) ./ (Km(2) + x);
    plot(x, MichaelisData, '-r');
    MichaelisData = (x .* Vmax(5)) ./ (Km(3) + x);
    plot(x, MichaelisData, '-b');
    MichaelisData = (x .* Vmax(7)) ./ (Km(4) + x);
    plot(x, MichaelisData, '-g');
    MichaelisData = (x .* Vmax(9)) ./ (Km(5) + x);
    plot(x, MichaelisData, '-c');
    hold off
    xlabel('Concentration (\muM)');
    ylabel('Reaction Velocity (\muM/s)');
    axis([0, 2000, 0, 2]);
    legend('ENZYME A','ENZYME B','ENZYME C','ENZYME D','ENZYME E','Location','best');
    title('Michaelis-Menten Plots for a Set of Detergent Enzymes');
end
clear
%% ____________________
%% RESULTS


%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.



