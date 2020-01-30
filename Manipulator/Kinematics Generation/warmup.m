function warmup(theta0)
time = zeros(10,1);
for i=1:100000
tic
trajectoryIK([rand(1) rand(1) rand(1) rand(1) rand(1) rand(1)]',theta0);
time(i)=toc;
end
meantime = mean(time)*1000;