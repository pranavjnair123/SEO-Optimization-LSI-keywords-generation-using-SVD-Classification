rowno=1995;
i=1;
while i<=rowno
    try
        k=webread(data(i,2));
        p=extractHTMLText(k);
        data(i,4)=p;
        i=i+1
    catch
        data(i,4)=data(i,3);
        i=i+1
    end
    
    
end
    