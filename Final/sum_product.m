n = 10;
%nodes take message from one factor so only one message for both node-factor and factor-node
message = [0.7 0.3];
factor = [0.3 0.7; 0.5 0.5; 0.5 0.5; 0.3 0.7];
probs = zeros(n-1,1);
for i=1:(n-1)
    message_coef = zeros(4,1);
    c = 1;
    for j=1:2
        for k=1:2
            message_coef(c) = message(j)*message(k);
            c = c + 1;
        end
    end
    m1 = message_coef.*factor(:,1);
    m2 = message_coef.*factor(:,2);
    message(1) = sum(m1);
    message(2) = sum(m2);
    probs(i) = message(2);
end
probs
