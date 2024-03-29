function PlotRepeatTouchSpike20180312(TouchIntervalSet,SpikeA,NN,PegTouchAll,fname,tfile)
%AutoCorrを基準　0.8倍、1.2倍のものと比較、したがってNNの個数は３．
% [FigA FigB FigC FigA3 FigAA]=PlotRepeatTouchSpike20170823(TouchIntervalSet,SpikeA,NN,PegTouchAll,fname,tfile)
global FigA FigA3 FigAA
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
                    Spike20=zeros(1,20);%一歩を20個のビンにわけて発火を分配。タッチの実際の間隔にかかわらず。
                    
                    if (Num-3+p+1)<=length(PegTouchAll) && (Num-3+p)>0
                        Tinterval(k,p)=PegTouchAll(Num-3+p+1)-PegTouchAll(Num-3+p);
                        SS=SpikeA(SpikeA>PegTouchAll(Num-3+p) & SpikeA<PegTouchAll(Num-3+p+1));
                        SS=SS-PegTouchAll(Num-3+p);
                        SS=floor((SS/(PegTouchAll(Num-3+p+1)-PegTouchAll(Num-3+p)))*20);
                        if ~isempty(SS) && ~SS==0
                            Spike20(SS)=1;
                        end
                        SSS=[SSS Spike20];%歩数分、横に連結。2歩の場合でも合計５歩分並べてしまう
%                         SpCount(k,p)=sum(Spike20);%発火回数
                        SpRate(k,p)=sum(Spike20)/Tinterval(k,p);
                    end
                end
                if length(SSS(1,:))==20*(m+3)
                    size(SSS)
                    size(SSSS)
                    SSSS=[SSSS;SSS];%該当するイベント数（3歩が100回見つかったら100回）だけまず縦に並べる
                end
            end
        end
        SpikeAlign=mean(SSSS,1);%全イベントの平均
        
%         Hist0{(n-NN(1)+(NN(2)-NN(1)))/(NN(2)-NN(1)),m}=SpikeAlign;
% %         SpikeCount{(n-NN(1)+(NN(2)-NN(1)))/(NN(2)-NN(1)),m}=SpCount;
% %         SpikeCountMean{(n-NN(1)+(NN(2)-NN(1)))/(NN(2)-NN(1)),m}=mean(SpCount,1);
% %         SpikeCountStd{(n-NN(1)+(NN(2)-NN(1)))/(NN(2)-NN(1)),m}=std(SpCount,0,1);
%         SpikeRate{(n-NN(1)+(NN(2)-NN(1)))/(NN(2)-NN(1)),m}=SpRate;
%         SpikeRateMean{(n-NN(1)+(NN(2)-NN(1)))/(NN(2)-NN(1)),m}=mean(SpRate,1)*1000;%Hz
%         SpikeRateStd{(n-NN(1)+(NN(2)-NN(1)))/(NN(2)-NN(1)),m}=std(SpRate,0,1)/sqrt(length(SpRate(:,1)))*1000;%Hz
%         Interval0{(n-NN(1)+(NN(2)-NN(1)))/(NN(2)-NN(1)),m}=Tinterval;

        Hist0{round((n-NN(1)+(NN(2)-NN(1)))/(NN(2)-NN(1))),m}=SpikeAlign;
%         SpikeCount{(n-NN(1)+(NN(2)-NN(1)))/(NN(2)-NN(1)),m}=SpCount;
%         SpikeCountMean{(n-NN(1)+(NN(2)-NN(1)))/(NN(2)-NN(1)),m}=mean(SpCount,1);
%         SpikeCountStd{(n-NN(1)+(NN(2)-NN(1)))/(NN(2)-NN(1)),m}=std(SpCount,0,1);
        SpikeRate{round((n-NN(1)+(NN(2)-NN(1)))/(NN(2)-NN(1))),m}=SpRate;
        SpikeRateMean{round((n-NN(1)+(NN(2)-NN(1)))/(NN(2)-NN(1))),m}=mean(SpRate,1)*1000;%Hz
        SpikeRateStd{round((n-NN(1)+(NN(2)-NN(1)))/(NN(2)-NN(1))),m}=std(SpRate,0,1)/sqrt(length(SpRate(:,1)))*1000;%Hz
        Interval0{round((n-NN(1)+(NN(2)-NN(1)))/(NN(2)-NN(1))),m}=Tinterval;
    end
end

% FigA2=figure;
% [N,M]=size(SpikeCountMean);
% MAX=0;
% for n=1:N
%     for m=1:m
%         if ~isempty(SpikeCountMean{n,m})
%             MAX=max(MAX,max(SpikeCountMean{n,m}));
%         end
%     end
% end
% for m=2:4 
%     for n=1:length(NN)
%         subplot(length(NN),4,m+4*(n-1))
% %         plot(SpikeCountMean{n,m});
%         errorbar(SpikeCountMean{n,m},SpikeCountStd{n,m});hold on
%         ylim([0,MAX]);
% %         if max(SpikeCountMean{n,m})>0;ylim([0,max(SpikeCountMean{n,m})]);end
%     end
% end
% eval(['title(''SpikeCount, Interval=',int2str(NN),''')']);
% set( FigA2, 'menubar', 'none') 
% set( FigA2, 'position', get(0, 'screensize'))

PeakMean=zeros(length(NN),3);
PeakStd=zeros(length(NN),3);
for n=1:length(NN)
    PeakMean(n,1)=SpikeRateMean{n,2}(3);
    PeakStd(n,1)=SpikeRateStd{n,2}(3);
    [Max idx]=max([SpikeRateMean{n,3}(3) SpikeRateMean{n,3}(4)]);
    PeakMean(n,2)=SpikeRateMean{n,3}(idx+2);
    PeakStd(n,2)=SpikeRateStd{n,3}(idx+2);
    [Max2 idx2]=max([SpikeRateMean{n,4}(3) SpikeRateMean{n,4}(4) SpikeRateMean{n,4}(5)]);
    PeakMean(n,3)=SpikeRateMean{n,4}(idx2+2);
    PeakStd(n,3)=SpikeRateStd{n,4}(idx2+2);
    
    PeakMeanIn(n,1)=SpikeRateMean{n,2}(3);
    PeakMeanPlus(n,1)=mean([SpikeRateMean{n,2}(2), SpikeRateMean{n,2}(3), SpikeRateMean{n,2}(4)]);
    
    PeakMeanIn(n,2)=mean([SpikeRateMean{n,3}(3) SpikeRateMean{n,3}(4)]);
    PeakMeanPlus(n,2)=mean([SpikeRateMean{n,3}(2) SpikeRateMean{n,3}(3) SpikeRateMean{n,3}(4) SpikeRateMean{n,3}(5)]);
    
    PeakMeanIn(n,3)=mean([SpikeRateMean{n,4}(3) SpikeRateMean{n,4}(4) SpikeRateMean{n,4}(5)]);
    PeakMeanPlus(n,3)=mean([SpikeRateMean{n,4}(2) SpikeRateMean{n,4}(3) SpikeRateMean{n,4}(4) SpikeRateMean{n,4}(5) SpikeRateMean{n,4}(6)]);
    
end

%Controlのために、3連タッチの最大値を単一値と比較
RandRate=zeros(1000,3);
RandMaxRate=zeros(1000,3);
for n=1:1000
    Num=ceil(rand*(length(PegTouchAll)-3));
    RandRate(n,1)=length(SpikeA(SpikeA>=PegTouchAll(Num) & SpikeA<PegTouchAll(Num+1)))/(PegTouchAll(Num+1)-PegTouchAll(Num))*1000;
    RandRate(n,2)=length(SpikeA(SpikeA>=PegTouchAll(Num+1) & SpikeA<PegTouchAll(Num+2)))/(PegTouchAll(Num+2)-PegTouchAll(Num+1))*1000;
    RandRate(n,3)=length(SpikeA(SpikeA>=PegTouchAll(Num+2) & SpikeA<PegTouchAll(Num+3)))/(PegTouchAll(Num+3)-PegTouchAll(Num+2))*1000;
    RandMaxRate(n,1)=RandRate(n,1);
    RandMaxRate(n,2)=max(RandRate(n,1),RandRate(n,2));
    RandMaxRate(n,3)=max(RandMaxRate(n,2),RandRate(n,3));
end
RandMaxMean=mean(RandMaxRate,1);
RandMaxSem=std(RandMaxRate,1)/sqrt(1000);

if max(max(PeakMean))>0
%     FigA_1=figure;
%     PeakMeanIn
%     PeakMeanPlus
%     subplot(2,length(NN)+1,1:length(NN)+1);
%     plot(PeakMeanIn(:,1),'k');hold on
%     plot(PeakMeanIn(:,2),'b');
%     plot(PeakMeanIn(:,3),'r');
%     ylim([0 max(max(PeakMeanIn))*1.2]);
%     title([fname,'  ',tfile(1:11),', mean Firing Rate at intervals ',int2str(NN),'ms']);
%     for n=1:length(NN)
%         subplot(2,length(NN)+1,length(NN)+n+1);
%         plot(PeakMeanIn(n,:),'b');
%         ylim([0 max(max(PeakMeanIn))*1.2]);
%         
%         eval(['Len2=length(TouchIntervalSet.TI',int2str(NN(n)),'_2)']);
%         eval(['Len3=length(TouchIntervalSet.TI',int2str(NN(n)),'_3)']);
%         eval(['Len4=length(TouchIntervalSet.TI',int2str(NN(n)),'_4)']);
%         xlabel([int2str(Len2),', ',int2str(Len3),', ',int2str(Len4)]);
%     end
%     subplot(2,length(NN)+1,length(NN)+n+2);
%         plot(mean(PeakMeanIn,1),'b');
%         ylim([0 max(max(PeakMean))*1.2]);
%     title(['1-2-3 steps    total                  .']);
%     
%     
%     FigA_2=figure;
%     PeakMeanIn
%     PeakMeanPlus
%     subplot(2,length(NN)+1,1:length(NN)+1);
%     plot(PeakMeanPlus(:,1),'k');hold on
%     plot(PeakMeanPlus(:,2),'b');
%     plot(PeakMeanPlus(:,3),'r');
%     ylim([0 max(max(PeakMeanPlus))*1.2]);
%     title([fname,'  ',tfile(1:11),', mean Firing Rate at intervals ',int2str(NN),'ms']);
%     for n=1:length(NN)
%         subplot(2,length(NN)+1,length(NN)+n+1);
%         plot(PeakMeanPlus(n,:),'b');
%         ylim([0 max(max(PeakMeanPlus))*1.2]);
%         
%         eval(['Len2=length(TouchIntervalSet.TI',int2str(NN(n)),'_2)']);
%         eval(['Len3=length(TouchIntervalSet.TI',int2str(NN(n)),'_3)']);
%         eval(['Len4=length(TouchIntervalSet.TI',int2str(NN(n)),'_4)']);
%         xlabel([int2str(Len2),', ',int2str(Len3),', ',int2str(Len4)]);
%     end
%     subplot(2,length(NN)+1,length(NN)+n+2);
%         plot(mean(PeakMeanPlus,1),'b');
%         ylim([0 max(max(PeakMean))*1.2]);
%     title(['1-2-3 steps    total                  .']);
    
    
    
    
    FigAA=figure;
    subplot(2,length(NN)+2,1:length(NN));
    errorbar(PeakMean(:,1),PeakStd(:,1),'k');hold on
    errorbar(PeakMean(:,2),PeakStd(:,2),'b');
    errorbar(PeakMean(:,3),PeakStd(:,3),'r');
    ylim([0 max(max(PeakMean))*1.2]);
    title([fname,'  ',tfile(1:11),', max Firing Rate at intervals ',int2str(NN),'ms']);
    for n=1:length(NN)
        subplot(2,length(NN)+2,length(NN)+n+2);
        errorbar(PeakMean(n,:),PeakStd(n,:),'b');
        ylim([0 max(max(PeakMean))*1.2]);
        
        eval(['Len2=length(TouchIntervalSet.TI',int2str(NN(n)),'_2)']);
        eval(['Len3=length(TouchIntervalSet.TI',int2str(NN(n)),'_3)']);
        eval(['Len4=length(TouchIntervalSet.TI',int2str(NN(n)),'_4)']);
        xlabel([int2str(Len2),', ',int2str(Len3),', ',int2str(Len4)]);
    end
    
    PeakMeanAve=mean(PeakMean,1);
    PeakMeanSem=std(PeakMean,0,1)/sqrt(length(NN));
    
    PeakMeanAve_2=mean(PeakMean([1 3],:),1);
    PeakMeanSem_2=std(PeakMean([1 3],:),0,1)/sqrt(length(NN));
    
    subplot(2,length(NN)+2,length(NN)+n+3);
    errorbar(PeakMeanAve_2,PeakMeanSem_2,'b');
    ylim([0 max(max(PeakMean))*1.2]);
    
    subplot(2,length(NN)+2,length(NN)+n+4);
    plot(PeakMean(2,:)./PeakMeanAve_2,'b');    
    ylim([0 max(max(PeakMean))*1.2]);
    title(['1-2-3 steps    total                  ratio                 .']);


% % % % %     FigA3=figure;
% % % % %     [N,M]=size(SpikeRateMean);
% % % % %     MAX=0;
% % % % %     for n=1:N
% % % % %         for m=1:M
% % % % %             if ~isempty(SpikeRateMean{n,m})
% % % % %                 MAX=max(MAX,max(SpikeRateMean{n,m}));
% % % % %             end
% % % % %         end
% % % % %     end  
% % % % %     for m=2:4 
% % % % %         for n=1:length(NN)
% % % % %             subplot(length(NN),4,m+4*(n-1))
% % % % %     %         plot(SpikeRateMean{n,m});
% % % % %             errorbar(SpikeRateMean{n,m},SpikeRateStd{n,m});hold on
% % % % %             ylim([0,MAX*1.2]);
% % % % %     %         if max(SpikeRateMean{n,m})>0;ylim([0,max(SpikeRateMean{n,m})]);end
% % % % %         end
% % % % %     end
% % % % %     % eval(['title(''SpikeRate, Interval=',int2str(NN),''')']);
% % % % %     eval(['title([fname,tfile(1:11),'', SpikeRate, Interval=',int2str(NN),'''])']);
% % % % %     set( FigA3, 'menubar', 'none') 
% % % % %     set( FigA3, 'position', get(0, 'screensize'))
% % % % % 
% % % % %     FigA=figure;
% % % % %     K=[];
% % % % %     % y=0.005:0.005:0.5;
% % % % %     for m=2:4 
% % % % %         for n=1:length(NN)
% % % % %             subplot(length(NN),4,m+4*(n-1))
% % % % %             plot(Hist0{n,m});hold on
% % % % %             K=[K Hist0{n,m}];
% % % % %             SK=sort(K,'descend');
% % % % %         end
% % % % %     end
% % % % %     eval(['title(''Equally spaced, Interval=',int2str(NN),''')']);
% % % % %     eval(['title([fname,tfile(1:11),'', Equally spaced, Interval=',int2str(NN),'''])']);
% % % % %     y=0.01:0.01:0.1;
% % % % %     for m=2:4 
% % % % %         for n=1:length(NN)
% % % % %             subplot(length(NN),4,m+4*(n-1))
% % % % %         if SK(20)>0;ylim([0 SK(20)]);y=0.01:0.01:SK(20);end
% % % % %         plot(20*ones(1,length(y)),y,'k');hold on
% % % % %         plot((length(Hist0{n,m})-20)*ones(1,length(y)),y,'k');hold on
% % % % %             for k=40:20:length(Hist0{n,m})-40
% % % % %                 plot(k*ones(1,length(y)),y,'r');hold on
% % % % %             end
% % % % %         end
% % % % %     end
% % % % %     set( FigA, 'menubar', 'none') 
% % % % %     set( FigA, 'position', get(0, 'screensize'))
end
% 
% %最初のタッチを基準
% K=[];
% Hist2=cell(length(NN),4);
% for n=NN
%     for m=1:4
%         B=[];
%         eval(['TI=TouchIntervalSet.TI',int2str(n),'_',int2str(m),';']);
%         if sum(TI)>0
%             for k=1:length(TI(:,1))
%                 A=SpikeA-TI(k,1);
%                 B=[B A(A>=-n & A<n*(m+1))];
%             end
%         end
%         B=[B -n n*m+1];
%         HH=hist(B,(n*(m)+n)/20)./length(TI(:,1));HH(1)=0;HH(end)=0;
%         Hist2{(n-NN(1)+(NN(2)-NN(1)))/(NN(2)-NN(1)),m}=HH;
%         Max(m)=(n*(m+1)+n)/20;
%     end
% end
% FigB=figure;
% for m=1:4 
%     for n=1:length(NN)
%         subplot(length(NN),4,m+4*(n-1))
%         Z=zeros(1,Max(4));
%         Z(1:length(Hist2{n,m}))=Hist2{n,m};
%         plot(Z);hold on
%         K=[K Hist2{n,m}];
%         SK=sort(K,'descend');%ylim([0 SK(5)]);
%     end
% end
% % title('Aligned by Fisrt touch');
% eval(['title([fname,tfile(1:11),'', Aligned by Fisrt touch, Interval=',int2str(NN),'''])']);
% y=0.01:0.01:0.1;
% for m=1:4 
%     for n=1:length(NN)
%         subplot(length(NN),4,m+4*(n-1))
% %     SK=sort(K,'descend');
%     if SK(20)>0;ylim([0 SK(20)]);y=0.01:0.01:SK(20);end
%     plot(round(NN(n)/20)*ones(1,length(y)),y,'r');hold on
%     end
% end
% set( FigB, 'menubar', 'none') 
% set( FigB, 'position', get(0, 'screensize'))
% 
% 
% %最後のタッチを基準
% K=[];
% Hist=cell(length(NN),4);
% for n=NN
%     for m=1:4
%         B=[];
%         eval(['TI=TouchIntervalSet.TI',int2str(n),'_',int2str(m),';']);
%         if sum(TI)>0
%             for k=1:length(TI(:,1))
%                 A=SpikeA-TI(k,m);
%                 B=[B A(A>=-n*(m) & A<n)];
%             end
%         end
%         B=[B -n*(m) n];
%         HH=hist(B,(n*(m)+n)/20)./length(TI(:,1));HH(1)=0;HH(end)=0;
%         Hist{(n-NN(1)+(NN(2)-NN(1)))/(NN(2)-NN(1)),m}=HH;
%         Max(m)=(n*(m+1)+n)/20;
%     end
% end
% FigC=figure;
% for m=1:4 
%     for n=1:length(NN)
%         subplot(length(NN),4,m+4*(n-1))
%         Z=zeros(1,Max(4));
%         Z(1:length(Hist{n,m}))=Hist{n,m};
%         plot(Z);hold on
%         K=[K Hist{n,m}];
%         SK=sort(K,'descend');%ylim([0 SK(5)]);
%     end
% end
% % title('Aligned by Last touch');
% eval(['title([fname,tfile(1:11),'', Aligned by Last touch, Interval=',int2str(NN),'''])']);
% y=0.01:0.01:0.1;
% for m=1:4 
%     for n=1:length(NN)
%         subplot(length(NN),4,m+4*(n-1))
%     if SK(20)>0;ylim([0 SK(20)]);y=0.01:0.01:SK(20);end
%     plot(round(NN(n)*m/20)*ones(1,length(y)),y,'r');hold on
%     end
% end
% set( FigC, 'menubar', 'none') 
% set( FigC, 'position', get(0, 'screensize'))
                