function PlotPointMoves(P1,P2,objVal, newObjVal)
pts = [P1; P2];
plot3(pts(:,1), pts(:,2), pts(:,3),'--r');
hold on;
plot3(P1(1), P1(2), P1(3),'*g');
plot3(P2(1), P2(2), P2(3),'*r');
if(newObjVal<objVal)
    msg = 'Accepted';
else
    msg = 'Rejected';
end
title(strcat('Colony1 objVal (green):', int2str(objVal), '     Colony2 newObjVal(red): ', num2str(newObjVal),'        R: ',msg));
hold off;
pause(0.5);
end

