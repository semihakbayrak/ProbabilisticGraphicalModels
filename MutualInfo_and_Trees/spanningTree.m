function spanningTree

Cat = load('categoryNames.mat');
Cat = Cat.categoryNames;

MI = mutualInfo();
arrayMI = zeros(45,3);
count = 0;
for i=1:9
    for j=(i+1):10
        count = count + 1;
        arrayMI(count,1) = MI(j,i);
        arrayMI(count,2) = i;
        arrayMI(count,3) = j;
    end
end

sortedarrayMI = -1*sortrows(-arrayMI,1); %sorting mutual info values

E = zeros(18,2); %tree with connected pairs
i = 1;
while i<=9
    checkedloop = 0;
    for j=1:18
        if E(j,1)==sortedarrayMI(i,2)
            %check if there is loop, by using depth first search
            if depthFirstSearch(E,E(j,2),sortedarrayMI(i,3),0) == 1
                checkedloop = 1;
                sortedarrayMI(i,:) = [];
                i = i - 1;
                break
            end
        end
    end
    %if no loop, add highest weighted edge to the tree
    if checkedloop == 0
        E(i,1) = sortedarrayMI(i,2);
        E(i,2) = sortedarrayMI(i,3);
        E(19-i,1) = sortedarrayMI(i,3);
        E(19-i,2) = sortedarrayMI(i,2);
    end
    i = i+1;
end

    function sit = depthFirstSearch(A,x,y,count)
        count = count + 1; %to prevent unnecessary searches
        sit = 0;
        for t=1:length(A(:,1))
            if A(t,1) == x
                if A(t,2) == y
                    sit = 1;
                    break
                else
                    if count>5
                        break
                    else
                        if depthFirstSearch(A,A(t,2),y,count) == 1
                            sit = 1;
                            break;
                        end
                    end
                end
            end
        end
    end

for i=1:9
    E(19-i,:) = [];
end

E

%I keep the node pairs in E which shows the edges between pairs
%Now let's create and plot tree
treeVec = -1*ones(1,10);

for i=1:10
    if i==1
        pos = E(1,1);
        treeVec(pos) = 0;
    elseif i==2
        pos = E(1,2);
        treeVec(pos) = E(1,1);
        E(1,:) = [];
        j = 1;
        L = length(E(:,1));
        while j<=L
            for k=1:2
                r = 3-k;
                if E(j,k) == pos
                    treeVec(E(j,r)) = pos;
                    E(j,:) = [];
                    j = j-1;
                end
            end
            j = j+1;
            if j > length(E(:,1))
                break
            end
        end
    else
        for j=1:length(E(:,1))
            sit = 0;
            for k=1:2
                r = 3-k;
                if treeVec(E(j,k)) ~= -1
                    treeVec(E(j,r)) = E(j,k);
                    E(j,:) = [];
                    sit = 1;
                    break
                end
            end
            if sit == 1
                break
            end
        end
    end
end

treeVec

treeplot(treeVec);

[x,y] = treelayout(treeVec);
x = x';
y = y';
text(x(:,1), y(:,1), Cat, 'VerticalAlignment','bottom','HorizontalAlignment','right')
title({'Tree generated by Kruskal Algorithm'},'FontSize',12,'FontName','Halvetica');

end