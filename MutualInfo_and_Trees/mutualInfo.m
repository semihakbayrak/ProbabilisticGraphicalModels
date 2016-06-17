function MI = mutualInfo()
%10 categories, 2784 images
%read from mat files to variables
Din = load('diningData.mat');
Cat = load('categoryNames.mat');
Din = Din.diningData;
Cat = Cat.categoryNames;

MI = zeros(10,10); %Mutual Info matrix

for i=1:9
    for j=(i+1):10
        mutval = 0;
        for vali=0:1
            for valj=0:1
                Pi = 0;
                Pj = 0;
                Pij = 0;
                for t=1:2784
                    if Din(i,t) == vali
                        Pi = Pi+1;
                    end
                    if Din(j,t) == valj
                        Pj = Pj+1;
                    end
                    if Din(i,t)==vali && Din(j,t)==valj
                        Pij = Pij + 1;
                    end
                end
                Pi = Pi/2784;
                Pj = Pj/2784;
                Pij = Pij/2784;
                mutval = mutval + Pij*log2(Pij/(Pi*Pj));
            end
        end
        MI(j,i) = mutval;
    end
end

end