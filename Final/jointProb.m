function jointProb(edges,factors,x)

num_of_variables = max(edges(:));
prob = 1; %we will go with multiplying probs from parents to childs

for i=1:num_of_variables
   if any(edges(:,2)==i)==0 %detect nodes with no parent
       prob = prob*factors{i}(x(i)+1);
   else
       parents = [];
       for j=1:length(edges)
           if edges(j,2) == i
               parents = [parents edges(j,1)]; %find all the parents of a node
           end
       end
       prob_vec = factors{i}(:,x(i)+1); %probs for wanted value
       order = 0;
       parent_prob_length = 1;
       %this part computes marginal probability of a node for wanted value
       %to handle conditional probability tables, I designed a system works
       %like truth table but a little bit different because some random variables
       %can take more than two values
       for j=1:length(parents)
           parent = parents(j);
           parent_val = x(parent);
           order = order + parent_val*((parent_prob_length)^(j-1));
           parent_prob_length = length(factors{parent}(1,:));
       end
       order = order + 1;
       prob = prob*prob_vec(order);
   end
end

prob

end