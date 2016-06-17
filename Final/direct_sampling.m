n = 10;
X_matrix = zeros(n,n); %X values
a = 0.7;
b = 0.5;
c = 0.3;

m = 500; %number of samples
count = zeros(n-1,1); %count the number of 1 values
plot_vals = zeros(m,1);

for k=1:m
    for i=1:n
        for j=1:(n-i+1)
            rand_num = rand;
            if i==1
                if rand_num < c
                    X_matrix(i,j) = 1;
                else
                    X_matrix(i,j) = 0;
                end
            else
                if X_matrix(i-1,j) == X_matrix(i-1,j+1)
                    if rand_num < a
                        X_matrix(i,j) = 1;
                    else
                        X_matrix(i,j) = 0;
                    end
                else
                    if rand_num < b
                        X_matrix(i,j) = 1;
                    else
                        X_matrix(i,j) = 0;
                    end
                end
            end
        end
    end
    count = count + X_matrix(2:n,1);
    plot_vals(k) = count(n-1)/k;
end

t=1:m;
plot(t,plot_vals(t))
xlabel('time');
ylabel('Marginal Probability P(Xs_n_1=1)')
title('Direct Sampling')
probs = count/m
