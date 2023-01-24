% PSO KODU
function [gbest_pos, gbest_obj] = PSO_function(fonkName, N, maxIterasyon, alt, ust, D)
%% Calisma Kriterleri
% N: surudeki parcacik sayisi
% maxIterasyon: Durdurma kriteri
% ust: Arama uzayinin ust siniridir.
% alt: Arama uzayinin alt siniridir.
% D: problem boyutu

%% PSO'ya ait degerler
c1 = 2; c2 = 2;
inertiaMax = 0.9; % ilk iterasyondaki inertia degeri
inertiaMin = 0.4; % son iterasyondaki inertia degeri

%%
% Parcaciklarin baslangic konumlarini rastgele uret
particle = rand(N,D)*(ust-alt)+alt;
v = zeros(N,D);

for i=1:N
% amac fonksiyonunu (Objective Value (ObjVal) hesapla)
ObjVal(i) = feval(fonkName, particle(i,:));
end

%Lokal bestleri atama
lbest_pos = particle; % local best pozisyonu
lbest_obj = ObjVal;

% Global Best degeri atama
[gbest_obj, indis] = min(ObjVal);
gbest_pos = particle(indis,:);

%% Iterasyonlar Basliyor

iter = 1;

while iter <= maxIterasyon
    inertia = inertiaMax - ((inertiaMax-inertiaMin)/maxIterasyon)*iter;
    
    for i=1:N
        v(i,:) = inertia*v(i,:) + c1*rand(1,D).*(lbest_pos(i,:)-particle(i,:)) + ...
                                  c2*rand(1,D).*(gbest_pos - particle(i,:));
                              
%         v(i,:)= min(v(i,:), ust); % ust sinir kontrolu yapiliyor
%         v(i,:)= max(v(i,:), alt); % alt sinir kontrolu yapiliyor
                
        particle(i,:) = particle(i,:) + v(i,:)*0.2;
        
        particle(i,:) = min(particle(i,:), ust);% ust sinir kontrolu yapiliyor
        particle(i,:) = max(particle(i,:), alt);% alt sinir kontrolu yapiliyor
        
        ObjVal(i) = feval(fonkName, particle(i,:));
        
        % LBest Guncelleme
        if ObjVal(i) < lbest_obj(i)
            lbest_pos(i,:) = particle(i,:);
            lbest_obj(i) = ObjVal(i);
        end    
        
    end % N dongusu
    
    % GBest degeri guncelleme
    [obj, indis] = min(ObjVal);
    if gbest_obj > obj
        gbest_pos = particle(indis,:);
        gbest_obj = obj;
    end
    
    display(['iterasyon:' num2str(iter), ' Obj:' num2str(gbest_obj), '    Pos:' num2str(gbest_pos)]);    
%     plotGoster(particle, gbest_obj, iter);
    plotGoster_ALLSPACES(fonkName, particle, gbest_obj, iter, alt, ust);
    iter = iter +1;
end

end








