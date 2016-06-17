n = 10;
X = zeros(n,n); %X values
a = 0.7;
b = 0.5;
c = 0.3;

Cs = 1-a;
alfa = log(b*(1-a)/(a*(1-b)));
beta = log((1-b)/(1-a));
gama = log(a/(1-a));
sigma = log(c/(1-c));

m = 200; %number of samples
count = zeros(n-1,1); %count the number of 1 values
plot_vals = zeros(m,1);

for t=1:m
    for i=1:n
        for j=1:(n-i+1)
            rand_num = rand;
            if i==1
                p_s_ij_1 = Cs*exp(sigma*1);
                p_s_ij_0 = Cs*exp(sigma*0);
                if j==1
                    p_child_left_1 = 1;
                    p_child_left_0 = 1;
                else
                    y = X(i,j-1);
                    z = 1;
                    x = X(i+1,j-1);
                    p_child_left_1 = Cs*exp(alfa*x*(y-z)^2+beta*(y-z)^2+gama*x);
                    y = X(i,j-1);
                    z = 0;
                    x = X(i+1,j-1);
                    p_child_left_0 = Cs*exp(alfa*x*(y-z)^2+beta*(y-z)^2+gama*x);
                end
                if j==(n-i+1)
                    p_child_right_1 = 1;
                    p_child_right_0 = 1;
                else
                    y = 1;
                    z = X(i,j+1);
                    x = X(i+1,j);
                    p_child_right_1 = Cs*exp(alfa*x*(y-z)^2+beta*(y-z)^2+gama*x);
                    y = 0;
                    z = X(i,j+1);
                    x = X(i+1,j);
                    p_child_right_0 = Cs*exp(alfa*x*(y-z)^2+beta*(y-z)^2+gama*x);
                end
            elseif i==n
                y = X(i-1,j);
                z = X(i-1,j+1);
                x = 1;
                p_s_ij_1 = Cs*exp(alfa*x*(y-z)^2+beta*(y-z)^2+gama*x);
                y = X(i-1,j);
                z = X(i-1,j+1);
                x = 0;
                p_s_ij_0 = Cs*exp(alfa*x*(y-z)^2+beta*(y-z)^2+gama*x);
                p_child_left_1 = 1;
                p_child_left_0 = 1;
                p_child_right_1 = 1;
                p_child_right_0 = 1;
            else
                y = X(i-1,j);
                z = X(i-1,j+1);
                x = 1;
                p_s_ij_1 = Cs*exp(alfa*x*(y-z)^2+beta*(y-z)^2+gama*x);
                y = X(i-1,j);
                z = X(i-1,j+1);
                x = 0;
                p_s_ij_0 = Cs*exp(alfa*x*(y-z)^2+beta*(y-z)^2+gama*x);
                if j==1
                    p_child_left_1 = 1;
                    p_child_left_0 = 1;
                else
                    y = X(i,j-1);
                    z = 1;
                    x = X(i+1,j-1);
                    p_child_left_1 = Cs*exp(alfa*x*(y-z)^2+beta*(y-z)^2+gama*x);
                    y = X(i,j-1);
                    z = 0;
                    x = X(i+1,j-1);
                    p_child_left_0 = Cs*exp(alfa*x*(y-z)^2+beta*(y-z)^2+gama*x);
                end
                if j==(n-i+1)
                    p_child_right_1 = 1;
                    p_child_right_0 = 1;
                else
                    y = 1;
                    z = X(i,j+1);
                    x = X(i+1,j);
                    p_child_right_1 = Cs*exp(alfa*x*(y-z)^2+beta*(y-z)^2+gama*x);
                    y = 0;
                    z = X(i,j+1);
                    x = X(i+1,j);
                    p_child_right_0 = Cs*exp(alfa*x*(y-z)^2+beta*(y-z)^2+gama*x);
                end
            end
            prob_1 = p_s_ij_1*p_child_left_1*p_child_right_1;
            prob_0 = p_s_ij_0*p_child_left_0*p_child_right_0;
            prob = prob_1/(prob_1+prob_0);
            if rand_num < prob
                X(i,j) = 1;
            else
                X(i,j) = 0;
            end
        end
    end
    count = count + X(2:n,1);
    plot_vals(t) = count(n-1)/t;
end
probs = count/m

t=1:m;
plot(t,plot_vals(t))
xlabel('time');
ylabel('Marginal Probability P(Xs_n_1=1)')
title('Gibbs Sampling')