function AAA(FunName, MaxHesaplama, LB, UB, N, D, Delta, Ap, e)

    Colonies = rand(N,D)*(UB-LB)+LB;
    ObjectiveFun = ones(N,1);
    for i=1:N
        ObjectiveFun(i) = feval(FunName, Colonies(i,:));
    end
    
    G = ones(N,1);
    G = Greatness(G, ObjectiveFun);
    
    StarvationV = zeros (N,1);

    t=0;
    while (t<MaxHesaplama)

        FrictionSurfaces = 2*pi*(3*G/4*pi).^(2/3);
        Energy = NormalizeVector(G);
        
        for i=1: N
            StarvationMarker = 1;
            currentObjFunValue = ObjectiveFun(i);
            
            while(Energy(i)>0)
                j = find(ObjectiveFun == min(ObjectiveFun));          
                RandCells = randperm(D,D);               
                if (D==1)
                    currentCells = Colonies(i,RandCells(1));
                    Colonies(i,RandCells(1)) = Colonies(i,RandCells(1)) + ( Colonies(j,RandCells(1)) -  Colonies(i,RandCells(1))) * (Delta - FrictionSurfaces(i)) * (2*rand(1)-1);
                elseif (D==2)
                    currentCells = [Colonies(i,RandCells(1)), Colonies(i,RandCells(2))];
                    Colonies(i,RandCells(1)) = Colonies(i,RandCells(1)) + ( Colonies(j,RandCells(1)) -  Colonies(i,RandCells(1))) * (Delta - FrictionSurfaces(i)) * (2*rand(1)-1);
                    Colonies(i,RandCells(2)) = Colonies(i,RandCells(2)) + ( Colonies(j,RandCells(2)) -  Colonies(i,RandCells(2))) * (Delta - FrictionSurfaces(i)) * (2*rand(1)-1);
                else
                    currentCells = [Colonies(i,RandCells(1)), Colonies(i,RandCells(2)), Colonies(i,RandCells(3))];
                    Colonies(i,RandCells(1)) = Colonies(i,RandCells(1)) + ( Colonies(j,RandCells(1)) -  Colonies(i,RandCells(1))) * (Delta - FrictionSurfaces(i)) * (2*rand(1)-1);
                    Colonies(i,RandCells(2)) = Colonies(i,RandCells(2)) + ( Colonies(j,RandCells(2)) -  Colonies(i,RandCells(2))) * (Delta - FrictionSurfaces(i)) * (2*rand(1)-1);
                    Colonies(i,RandCells(3)) = Colonies(i,RandCells(3)) + ( Colonies(j,RandCells(3)) -  Colonies(i,RandCells(3))) * (Delta - FrictionSurfaces(i)) * (2*rand(1)-1);                  
                end
                
                ObjectiveFun(i) = feval(FunName, Colonies(i,:));
                if(D>2)
                    PlotPointMoves(currentCells,Colonies(i,1:3),currentObjFunValue,ObjectiveFun(i));
                end
                t = t+1;          
                Energy(i) = Energy(i) - (e/2);
                
                if(ObjectiveFun(i)<currentObjFunValue)
                    StarvationMarker = 0;
                else
                    if (D == 1)
                        Colonies(i,RandCells(1)) = currentCells(1);
                    elseif (D == 2)
                        Colonies(i,RandCells(1)) = currentCells(1);
                        Colonies(i,RandCells(2)) = currentCells(2);
                    else
                        Colonies(i,RandCells(1)) = currentCells(1);
                        Colonies(i,RandCells(2)) = currentCells(2);
                        Colonies(i,RandCells(3)) = currentCells(3);
                    end                    
                    ObjectiveFun(i) = currentObjFunValue;
                    Energy(i) = Energy(i) - (e/2);                   
                end
                display(['Time: ' num2str(t), '     Iteration: ' num2str(i), '    ObjVal: ' num2str(ObjectiveFun(i)), '    Current Colony: ' num2str(find(ObjectiveFun==ObjectiveFun(i))), '    ObjMin: ' num2str(min(ObjectiveFun)), '    Best Colony: ' num2str(find(ObjectiveFun==min(ObjectiveFun)))]); 
            end
            if(StarvationMarker == 1)
                StarvationV(i) = StarvationV(i) + 1;
            end   
        end
        G = Greatness(G, ObjectiveFun);
        cell = randperm(D,1);
        indexBuyuk = G ==max(G);
        indexKucuk = G ==min(G);
        Colonies(indexKucuk,cell) = Colonies(indexBuyuk,cell);
        if(rand < Ap)
            StarvationV(i) = max(StarvationV) + (max(G) - max(StarvationV))*rand;%Adaptation
        end    
    end
    fprintf(' \n');
    display(['Rseult:    Time: ' num2str(t), '    GlobalObjMin: ' num2str(min(ObjectiveFun)), '    Best Colony: ' num2str(find(ObjectiveFun==min(ObjectiveFun)))]);   
end

%%Buyukluk Fonksiyonu
function GV = Greatness(GV, ObjFun)
    ObjFun = 1 - NormalizeVector(ObjFun);
        for i=1:length(GV)
            Ks = abs(GV(i)/2);
            U = ObjFun(i) / (Ks + ObjFun(i));
            GV(i) = GV(i) + U * GV(i);
        end
end

%%Normalize Fonksiyonu
function normalizedV = NormalizeVector (V)
    temp = ones(size(V));
        for i=1:length(V)
            if (max(V)-min(V) == 0)
                temp(i)=V(i)-min(V);
            end
            if (max(V)-min(V) ~= 0)
                temp(i)=(V(i)-min(V))/(max(V)-min(V));
            end
        end
    normalizedV = temp;
end

