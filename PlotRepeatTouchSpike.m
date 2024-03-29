function PlotRepeatTouchSpike(TouchIntervalSet,SpikeA,NN)

%最初のタッチを基準
K=[];
% NN=300:50:700;

Hist2=cell(length(NN),4);
for n=NN
    for m=1:4
        B=[];
        eval(['TI=TouchIntervalSet.TI',int2str(n),'_',int2str(m),';']);
        if sum(TI)>0
            for k=1:length(TI(:,1))
                A=SpikeA-TI(k,1);
                B=[B A(A>=-n & A<n*(m+1))];
            end
        end
        B=[B -n n*m+1];
        HH=hist(B,(n*(m)+n)/25)./length(TI(:,1));HH(1)=0;HH(end)=0;
        Hist2{(n-NN(1)+(NN(2)-NN(1)))/(NN(2)-NN(1)),m}=HH;
        Max(m)=(n*(m+1)+n)/25;
    end
end
figure
y=0.001:0.001:0.5;
for m=1:4 
    for n=1:length(NN)
        subplot(length(NN),4,m+4*(n-1))
        Z=zeros(1,Max(4));
        Z(1:length(Hist2{n,m}))=Hist2{n,m};
        plot(round(NN(n)/25),y,'r');hold on
        plot(Z);hold on
        K=[K Hist2{n,m}];
        SK=sort(K,'descend');%ylim([0 SK(5)]);
    end
%     SK=sort(K,'descend');
%     ylim([0 SK(5)]);
end
title('Aligned by Fisrt touch');
for m=1:4 
    for n=1:length(NN)
        subplot(length(NN),4,m+4*(n-1))
%     SK=sort(K,'descend');
    ylim([0 SK(20)]);
    end
end
%最後のタッチを基準
K=[];
Hist=cell(length(NN),4);
for n=NN
    for m=1:4
        B=[];
        eval(['TI=TouchIntervalSet.TI',int2str(n),'_',int2str(m),';']);
        if sum(TI)>0
            for k=1:length(TI(:,1))
                A=SpikeA-TI(k,m);
                B=[B A(A>=-n*(m) & A<n)];
            end
        end
        B=[B -n*(m) n];
        HH=hist(B,(n*(m)+n)/25)./length(TI(:,1));HH(1)=0;HH(end)=0;
        Hist{(n-NN(1)+(NN(2)-NN(1)))/(NN(2)-NN(1)),m}=HH;
        Max(m)=(n*(m+1)+n)/25;
    end
end
figure
y=0.001:0.001:0.5;
for m=1:4 
    for n=1:length(NN)
        subplot(length(NN),4,m+4*(n-1))
        Z=zeros(1,Max(4));
        Z(1:length(Hist{n,m}))=Hist{n,m};
        plot(round(NN(n)*m/25),y,'r');hold on
        plot(Z);hold on
        
        K=[K Hist{n,m}];
        SK=sort(K,'descend');%ylim([0 SK(5)]);
    end
end
title('Aligned by Last touch');
for m=1:4 
    for n=1:length(NN)
        subplot(length(NN),4,m+4*(n-1))
%     SK=sort(K,'descend');
    ylim([0 SK(20)]);
    end
end
                
% B=[];
% for n=1:length(PegTouchAll)
%     A=SpikeA-PegTouchAll(n);
%     B=[B A(A>=-1000 & A<1000)];
% end
% figure;hist(B,200);
