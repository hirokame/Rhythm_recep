function [FigA FigB FigC]=PlotRepeatTouchSpike20170823(TouchIntervalSet,SpikeA,NN,PegTouchAll)

%全てのタッチ感間隔を補正
Hist0=cell(length(NN),4);
SpikeCount=cell(length(NN),4);
SpikeRate=cell(length(NN),4);
Interval0=cell(length(NN),4);
% NumFire=zeros(length(NN),4);
for n=NN
    for m=2:4
        B=[];
        eval(['TI=TouchIntervalSet.TI',int2str(n),'_',int2str(m),';']);
        SSSS=[];
        SpCount=zeros(length(TI(:,1)),m+3);
        SpRate=zeros(length(TI(:,1)),m+3);
        Tinterval=zeros(length(TI(:,1)),m+3);
        if sum(TI)>0
            for k=1:length(TI(:,1))
                Num=find(PegTouchAll==TI(k,1));
                SSS=[];
                for p=1:m+3%目的のタッチ数（１〜４）とその前後のタッチのその向こうのタッチまでの間。２タッチなら５
                    Spike25=zeros(1,25);%一歩を25個のビンにわけて発火を分配。タッチの実際の間隔にかかわらず。
                    
                    if (Num-3+p+1)<=length(PegTouchAll) & (Num-3+p)>0
                        Tinterval(k,p)=PegTouchAll(Num-3+p+1)-PegTouchAll(Num-3+p);
                        SS=SpikeA(SpikeA>PegTouchAll(Num-3+p) & SpikeA<PegTouchAll(Num-3+p+1));
                        SS=SS-PegTouchAll(Num-3+p);
                        SS=floor((SS/(PegTouchAll(Num-3+p+1)-PegTouchAll(Num-3+p)))*25);
                        if ~isempty(SS) & ~SS==0
                            Spike25(SS)=1;
                        end
                        SSS=[SSS Spike25];%歩数分、横に連結。2歩の場合でも合計５歩分並べてしまう
                        SpCount(k,p)=sum(Spike25);%発火回数
                        SpRate(k,p)=sum(Spike25)/Tinterval(k,p);
                    end
                end
                if length(SSS(1,:))==25*(m+3)
                    size(SSS)
                    size(SSSS)
                    SSSS=[SSSS;SSS];%該当するイベント数（3歩が100回見つかったら100回）だけまず縦に並べる
                end
            end
        end
        SpikeAlign=mean(SSSS,1);%全イベントの平均
        Hist0{(n-NN(1)+(NN(2)-NN(1)))/(NN(2)-NN(1)),m}=SpikeAlign;
        SpikeCount{(n-NN(1)+(NN(2)-NN(1)))/(NN(2)-NN(1)),m}=SpCount;
        SpikeCountMean{(n-NN(1)+(NN(2)-NN(1)))/(NN(2)-NN(1)),m}=mean(SpCount,1);
        SpikeCountStd{(n-NN(1)+(NN(2)-NN(1)))/(NN(2)-NN(1)),m}=std(SpCount,0,1);
        SpikeRate{(n-NN(1)+(NN(2)-NN(1)))/(NN(2)-NN(1)),m}=SpRate;
        SpikeRateMean{(n-NN(1)+(NN(2)-NN(1)))/(NN(2)-NN(1)),m}=mean(SpRate,1)*1000;%Hz
        SpikeRateStd{(n-NN(1)+(NN(2)-NN(1)))/(NN(2)-NN(1)),m}=std(SpRate,0,1)*1000;%Hz
        Interval0{(n-NN(1)+(NN(2)-NN(1)))/(NN(2)-NN(1)),m}=Tinterval;
    end
end

FigA2=figure;
[N,M]=size(SpikeRateMean);
MAX=0;
for n=1:N
    for m=1:M
        if ~isempty(SpikeRateMean{n,m})
            MAX=max(MAX,max(SpikeRateMean{n,m}));
        end
    end
end  
for m=2:4 
    for n=1:length(NN)
        subplot(length(NN),4,m+4*(n-1))
        plot(SpikeRateMean{n,m});hold on
        ylim([0,MAX]);
%         if max(SpikeRateMean{n,m})>0;ylim([0,max(SpikeRateMean{n,m})]);end
    end
end
set( FigA2, 'menubar', 'none') 
set( FigA2, 'position', get(0, 'screensize'))


FigA3=figure;
[N,M]=size(SpikeCountMean);
MAX=0;
for n=1:N
    for m=1:m
        if ~isempty(SpikeCountMean{n,m})
            MAX=max(MAX,max(SpikeCountMean{n,m}));
        end
    end
end
for m=2:4 
    for n=1:length(NN)
        subplot(length(NN),4,m+4*(n-1))
        plot(SpikeCountMean{n,m});hold on
        ylim([0,MAX]);
%         if max(SpikeCountMean{n,m})>0;ylim([0,max(SpikeCountMean{n,m})]);end
    end
end
set( FigA3, 'menubar', 'none') 
set( FigA3, 'position', get(0, 'screensize'))


FigA=figure;
K=[];
% y=0.005:0.005:0.5;
for m=2:4 
    for n=1:length(NN)
        subplot(length(NN),4,m+4*(n-1))
        plot(Hist0{n,m});hold on
        K=[K Hist0{n,m}];
        SK=sort(K,'descend');
    end
end
eval(['title(''Equally spaced, Interval=',int2str(NN),''')']);
y=0.01:0.01:0.1;
for m=2:4 
    for n=1:length(NN)
        subplot(length(NN),4,m+4*(n-1))
    if SK(20)>0;ylim([0 SK(20)]);y=0.01:0.01:SK(20);end
    plot(25*ones(1,length(y)),y,'k');hold on
    plot((length(Hist0{n,m})-25)*ones(1,length(y)),y,'k');hold on
        for k=50:25:length(Hist0{n,m})-50
            plot(k*ones(1,length(y)),y,'r');hold on
        end
    end
end
set( FigA, 'menubar', 'none') 
set( FigA, 'position', get(0, 'screensize'))

%最初のタッチを基準
K=[];
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
FigB=figure;
for m=1:4 
    for n=1:length(NN)
        subplot(length(NN),4,m+4*(n-1))
        Z=zeros(1,Max(4));
        Z(1:length(Hist2{n,m}))=Hist2{n,m};
        plot(Z);hold on
        K=[K Hist2{n,m}];
        SK=sort(K,'descend');%ylim([0 SK(5)]);
    end
end
% title('Aligned by Fisrt touch');
eval(['title(''Aligned by Fisrt touch, Interval=',int2str(NN),''')']);
y=0.01:0.01:0.1;
for m=1:4 
    for n=1:length(NN)
        subplot(length(NN),4,m+4*(n-1))
%     SK=sort(K,'descend');
    if SK(20)>0;ylim([0 SK(20)]);y=0.01:0.01:SK(20);end
    plot(round(NN(n)/25)*ones(1,length(y)),y,'r');hold on
    end
end
set( FigB, 'menubar', 'none') 
set( FigB, 'position', get(0, 'screensize'))


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
FigC=figure;
for m=1:4 
    for n=1:length(NN)
        subplot(length(NN),4,m+4*(n-1))
        Z=zeros(1,Max(4));
        Z(1:length(Hist{n,m}))=Hist{n,m};
        plot(Z);hold on
        K=[K Hist{n,m}];
        SK=sort(K,'descend');%ylim([0 SK(5)]);
    end
end
% title('Aligned by Last touch');
eval(['title(''Aligned by Last touch, Interval=',int2str(NN),''')']);
y=0.01:0.01:0.1;
for m=1:4 
    for n=1:length(NN)
        subplot(length(NN),4,m+4*(n-1))
    if SK(20)>0;ylim([0 SK(20)]);y=0.01:0.01:SK(20);end
    plot(round(NN(n)*m/25)*ones(1,length(y)),y,'r');hold on
    end
end
set( FigC, 'menubar', 'none') 
set( FigC, 'position', get(0, 'screensize'))
                
% B=[];
% for n=1:length(PegTouchAll)
%     A=SpikeA-PegTouchAll(n);
%     B=[B A(A>=-1000 & A<1000)];
% end
% figure;hist(B,200);
