function X_bar = doPositionUncert(X_bar, pozyxInput)
%doPositionUncert find uncertainty in the position measurements
global sigmaPos;
global sigmaPosTime;
global muPosTime;
global dt;
updatePos = [0 0 0];

if(pozyxInput.size() > 1.9/dt)
    timeFromNow = normrnd(muPosTime, sigmaPosTime);
    queue = elements(pozyxInput);
    index = int8(timeFromNow/dt);
    X_old_pozyx = queue{index}(2:3);
    X_old_pozyx = X_old_pozyx + [normrnd(0,sigmaPos), normrnd(0,sigmaPos)];

    timeWeThink = muPosTime;
    IndexUs = int8(timeWeThink/dt);
    X_old_predicted = queue{IndexUs}(2:3);
    updatePos(1) = X_old_pozyx(1) - X_old_predicted(1);
    updatePos(2) = X_old_pozyx(2) - X_old_predicted(2);
    X_bar = X_bar + (updatePos/1000)';
end

end