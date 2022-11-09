clear;
clear Plotting;
clear PlottingTest;
clear SensorModel;
clear drawTire;
clear Control;
clear controlCircle;
clear controlLine;
clear MotorModels;
clear drawChassis;
clear drawTire;
clf;
global controlArray;
global controlIndex;
global velocity;
global dt; 

global driveTable;
global steerTable;

driveTable = [78 0.92; 80 1.56; 82 2.19; 84 2.61;]; % sample data pwm, speed;
steerTable = [60, 45; 62, 45; 64, 55; 66, 60;...
                68, 70; 70 75; 72 80; 74 90;...
                76 95; 78 105; 80 110; 82 115;...
                84 120; 86 125; 88 130;]; % sample data pwm, angle

global includeUncertainty;
global sigmaSteering;
global sigmaDrive;
global sigmaPos;
global sigmaPosTime;
global muPosTime;
includeUncertainty = true;
sigmaSteering = deg2rad(5);
sigmaDrive = 0.2;
sigmaPos = .1;
sigmaPosTime = .1;
muPosTime = 0.7;

velocity = 1;
dt = 0.05;
testing = false;
if (testing)
    carLocation = [8 5]';
else
    carLocation = [9.3 11]';  %Car location in the pool frame
end
thetaC = -pi/2; %set the initial angle of the car
%thetaS = -pi/6; %set the initial steering angle of the car
X = [carLocation(1) carLocation(2) thetaC]'; %x, y, thetaC
U = [velocity, 0]; %, vel, thetaS
seed = rng('shuffle');

% circ/line(0/1), C_x/W1_x, C_y/W1_y, R/W2_x, CW/CCW (0,1) / W2_y,
    % Nx(halfplane), Ny(Halfplane), Px(halfplane), Py(Halfplane)
    if (testing)
        controlArray = [0, 5, 5, 3, 0, 1, 0, 100, 100];
    else
%          controlArray = [1, 0.85, 9.2, 0.75, 3.1, 0, -1, 0.75, 3.1; 
%                         0, 2.0, 2.40, 1, 1, 1, 0, 2.7, 1.2
%                         1, 0.7, 0.9, 5.7, 1.6, 1, 0, 5.7, 1.6
%                         1, 5.7, 1.6, 9, 1, 1, 0, 9, 1
%                         0, 9.42, 2.35, 1, 1, 0, 1, 10.8, 2.5
%                         1, 10.8, 2.5, 10.9, 5.1, 0, 1, 10.9, 5.1
%                         0, 9.50, 4.48, 1, 1, -1, 0, 8.5, 5.9
%                         0, 6.66, 5.64, 1, 0, -1, 0, 7.8, 4
%                         1, 7.8, 4, 4.6, 4, -1, 0, 4.6, 4
%                         0, 4.83, 5.65, 1, 0, 0, 1, 3.2, 5.4
%                         1, 3.2, 5.4, 3.2, 7.3, 0, 1, 3.2, 7.3
%                         0, 4.9, 6.75, 1, 0, 1, 0, 4.2, 8.3
%                         1, 4.2, 8.3, 9.2, 8.6, 1, 0, 9.2, 8.6
%                         0, 9.25, 10.25, 1.65, 1, -1, 0, 9, 11.9
%                         1, 9.3, 11.9, 5.4, 10.4, -1, 0, 5.4, 10.4
%                         1, 5.4, 10.4, 2.5, 10.5, -1, 0, 2.5, 10.5
%                         0, 2.53, 8.64, 1, 1, 0, -1, 0.85, 9.2];
         %controlArray = [1, 10.927, 9.55, 5.366, 9.464, -1, 0, -100, 0]; %line
       %controlArray = [0, 9.415, 9.592, 1.5, 1, 0, 1, 0, 100];
       controlArray = [1, 9.352, 11.069, 6.823, 11.054, -1, 0, 6.7, 11.054; 
                        0, 6.857, 9.552, 1.5, 1, 1, 0, 6.9, 8.037; 
                        1, 6.959, 8.037, 9.446, 8.058, 1, 0, 9.4, 8.058;
                        0, 9.415, 9.592, 1.5, 1, -1, 0, 9.2, 11.069];
    end
    controlIndex = 1;