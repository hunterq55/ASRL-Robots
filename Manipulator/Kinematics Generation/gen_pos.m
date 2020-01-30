states=cell(3000,1);
for i=1:3000
    
   states{i}=manipFK(path(i,2:7)); 
    
    
    
end
FKz=zeros(3000,1);
for i=1:3000
FKz(i)=states{i}(3);
end

FKz=rescale(FKz,lower,upper);
