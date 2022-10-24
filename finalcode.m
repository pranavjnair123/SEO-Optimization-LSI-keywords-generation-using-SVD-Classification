search1 = "Hyundai elantra"

search2=edit(search1); %tokenization and remove stopwords

split1=search2.split();
ssplit = normalizeWords(split1); % stemming
s=ssplit.size();
s=s(1);

rowNo=1996; 
i=1;

% constructing term document matrix
matrix=zeros(rowNo,s);
while i<=s
    wrd=ssplit(i);
    word=normalizeWords(wrd);
    i=i+1;
    j=1;
    
    while j<=rowNo
        k=data(j,4);
        t=edit(k);
        ct=count(t,word);
        matrix(j,i-1)=ct;
        j=j+1;
    end
end

%computing SVD
[U,S,V]=svd(matrix);

%LSI 
k=s;
Uk = U(:,1:k);
Sk = S(1:k,1:k);
Vk = V(1:k,1:k);
new= Uk*Sk*Vk;
z=size(new);
m=z(1);
n=z(2);

%Printing the best 10 matches
i=1;
SearchResults=10;
while i<=SearchResults
    p=1;
    j=1;
    M = max(new,[],'all');
    result = find(new==M);
    result=result(1);
  
    while j<=n
        g=1;
        while g<=m
            
            if(result==p)
                new(g,j)=-100000;
                str=data(g,1);
                lin=data(g,2);
               
                s="'<a href="+'"'+lin+'"'+">"+str+"</a>'";
                disp(s)
        
            end
             p=p+1;
            g=g+1;
        end
        
        j=j+1;
    end
    i=i+1;
    
end



function out= edit(x)
x=lower(x);
documents = tokenizedDocument([x]);
newDocuments = removeStopWords(documents);
str = joinWords(newDocuments);


c = strrep(str,'(','');
c = strrep(c,')','');
c = strrep(c,'-','');
c = strrep(c,'%','');
c = strrep(c,'!','');
c = strrep(c,'@','');
c = strrep(c,'#','');
c = strrep(c,':','');
c = strrep(c,'"','');
c = strrep(c,"'",'');
c = strrep(c,'*','');
c = strrep(c,'&','');
c = strrep(c,';','');
c = strrep(c,'^','');
c = strrep(c,'{','');
c = strrep(c,'}','');
out = strrep(c,'|','');
end







    








