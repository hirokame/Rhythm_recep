function RLphase191024mean
%仮説１：左右それぞれのスパイクの位相を用いた予測
%y=figureのsubplotコメントアウト　２０２００１２６
%RLphase190415meanからの変更点：1000ビンに直すところjMaxの値を小数第一位までに変更、ヒルベルト変換を使わないようにした
global  ACresult ACresultW CCresultDrinkOn SpikeArrayWon TurnMarkerTime RpegTouchallWon LpegTouchallWon...
    RpNum LpNum   CCresultSpike locsP1time locsP2time locsP1time2 locsP2time2 pksA1 pksA2 CCresultRtouchWon CCresultLtouchWon dpath3...
    StartTime FinishTime DiffMaxMinR DiffMaxMinL fname tfile OneTurnTime EnveRLPhaseTM EnveCCresultSpikePro  dpath meanKldistDiff KldistSame FLName KLfname KLD1...
    meanXaxiserror1 Envedist1 meanXaxiserror Envedist
%%すべてのタッチに位相を当てはめてからターンマーカーでアラインしたバージョン
%一歩に対する位相を掛け算したバージョン
% RmedianPTTM
% LmedianPTTM
% dpath3 = uigetdir('C:\Users\kit\Desktop\CheetahData');
% load ('Bdata.mat','RpegTouchCell','LpegTouchCell');
% yhight=20;
% [fig_touchR_TM,PTTMHistoCell_R RmedianPTTM Rmax]=TouchAlignByTM(RpegTouchCell,TurnMarkerTime,yhight);
% [fig_touchL_TM,PTTMHistoCell_L LmedianPTTM Lmax]=TouchAlignByTM(LpegTouchCell,TurnMarkerTime,yhight);
bin1=20;
phaseR=zeros(1,bin1);
for i=1:length(RpegTouchallWon)-1
    for j=1:length(SpikeArrayWon)-1
        if RpegTouchallWon(i)<SpikeArrayWon(j)&&SpikeArrayWon(j)<RpegTouchallWon(i+1);   %%タッチ間でスパイクがあったか
           binarrayR=linspace(RpegTouchallWon(i),RpegTouchallWon(i+1),bin1+1);     %%タッチ間をbin1の数に分割
           for k=1:length(phaseR)-1
               if binarrayR(k)<SpikeArrayWon(j)&&SpikeArrayWon(j)<binarrayR(k+1);        %%どのビンでスパイクがあったか
                   phaseR(k)=phaseR(k)+1;
               end
           end
        end
    end
end
phaseL=zeros(1,bin1);
for i=1:length(LpegTouchallWon)-1
    for j=1:length(SpikeArrayWon)-1
        if LpegTouchallWon(i)<SpikeArrayWon(j)&&SpikeArrayWon(j)<LpegTouchallWon(i+1);   %%タッチ間でスパイクがあったか
           binarrayL=linspace(LpegTouchallWon(i),LpegTouchallWon(i+1),bin1+1);   %%タッチ間をbin1の数に分割
           for k=1:length(phaseL)-1
               if binarrayL(k)<SpikeArrayWon(j)&&SpikeArrayWon(j)<binarrayL(k+1);  %%どのビンでスパイクがあったか
                   phaseL(k)=phaseL(k)+1;
               end
           end
        end
    end
end
fs=100;%%サンプリング周波数
dft_size=4096;
%右足タッチでアラインしたスパイクのフーリエ変換
Y1=fft(CCresultRtouchWon,dft_size);
k=1:dft_size/2+1;
A1(k)=abs(Y1(k));
P1(k)=abs(Y1(k)).^2;
frequency(k)=(k-1)*fs/dft_size;

%左足タッチでアラインしたスパイクのフーリエ変換
Y2=fft(CCresultLtouchWon,dft_size);
A2(k)=abs(Y2(k));
P2(k)=abs(Y2(k)).^2;
frequency(k)=(k-1)*fs/dft_size;

% 振幅
% 右足
[pksA1,locsA1]=findpeaks(A1,'sortstr','descend');  %%%ピークになる周波数
locsA1=(locsA1-1)*fs/dft_size;
locsA1time=1/locsA1(1)*100;
% 左足
[pksA2,locsA2]=findpeaks(A2,'sortstr','descend');
locsA2=(locsA2-1)*fs/dft_size;
locsA2time=1/locsA2(1)*100;


[MaxR,IndexR]=max(phaseR);
[MaxL,IndexL]=max(phaseL);
RPeakIndexRatio=IndexR/bin1;
LPeakIndexRatio=IndexL/bin1;

Old2=cd;
cd(dpath3);
LS=ls;
for k=1:length(LS(:,1));
    FL=strtrim(LS(k,:));
    if (length(FL)>2 && strcmp(FL(end-4:end),'_98__')) || (length(FL)>2 && strcmp(FL(end-4:end),'_89__'));
        CDdir=[dpath,FL];
cd(CDdir);
FLNAME=[strtrim(tfile),'touchfile.mat'];
load(FLNAME,'RpegTouchallWon98','LpegTouchallWon98','TurnMarkerTime98','OneTurnTime98','FinishTime98','SpikeArray98');
break;
    end
end

% cd('C:\Users\C238\Desktop\CheetahData\2019-2-25_10-48-49 15101-04\15101_190225_98__')
% FLNAME=[strtrim(tfile),'touchfile.mat'];
% load(FLNAME,'RpegTouchallWon98','LpegTouchallWon98','TurnMarkerTime98','OneTurnTime98','FinishTime98','SpikeArray98');


% RmedianPTTM10=round(sort(RmedianPTTM*10,'ascend'));
% LmedianPTTM10=round(sort(LmedianPTTM*10,'ascend'));
% RmedianPTTM10=RmedianPTTM10(find(~isnan(RmedianPTTM10)));
% LmedianPTTM10=LmedianPTTM10(find(~isnan(LmedianPTTM10)));
% RmedianPTTM1=[RmedianPTTM10 RmedianPTTM10+OneTurnTime];
% LmedianPTTM1=[LmedianPTTM10 LmedianPTTM10+OneTurnTime];
RAllTouchPhase=[];
LAllTouchPhase=[];

for i=1:length(RpegTouchallWon98)-1
    bin2=abs(round(RpegTouchallWon98(i)-RpegTouchallWon98(i+1)));
    ROneStepPhase=zeros(1,bin2);
%     if isfinite(DiffMaxMinR)==1;
%         phaseRamp=phaseR*DiffMaxMinR;
%     else
%         phaseRamp=phaseR;
%     end
    phaseRamp=phaseR*pksA1(1);
    B=ceil(bin2/length(phaseRamp));
    for j=1:length(phaseRamp)
        for x=1:B
            if (x+B*(j-1))<bin2;
                ROneStepPhase(x+B*(j-1))=phaseRamp(j);
            end
        end
    end
    RAllTouchPhase=[RAllTouchPhase ROneStepPhase];
end
for i=1:length(LpegTouchallWon98)-1
    bin2=abs(round(LpegTouchallWon98(i)-LpegTouchallWon98(i+1)));
    LOneStepPhase=zeros(1,bin2);
%     if isfinite(DiffMaxMinL)==1;
%         phaseLamp=phaseL*DiffMaxMinL;
%     else
%         phaseLamp=phaseL;
%     end
    phaseLamp=phaseL*pksA2(1);
    B=ceil(bin2/length(phaseLamp));
    for j=1:length(phaseLamp)
        for x=1:B
            if (x+B*(j-1))<bin2;
                LOneStepPhase(x+B*(j-1))=phaseLamp(j);
            end
        end
    end
    LAllTouchPhase=[LAllTouchPhase LOneStepPhase];
end
y=figure;%off
subplot(2,1,1)%off
plot(linspace(0,1,length(phaseRamp)),phaseRamp,'color','b');hold on%off
plot(linspace(0,1,length(phaseLamp)),phaseLamp,'color','r');%off
RAllTouchPhase=[zeros(1,round(RpegTouchallWon98(1))) RAllTouchPhase zeros(1,round(FinishTime98-RpegTouchallWon98(end)))];   %%
LAllTouchPhase=[zeros(1,round(LpegTouchallWon98(1))) LAllTouchPhase zeros(1,round(FinishTime98-LpegTouchallWon98(end)))];

RAllTouchPhaseTMsum=zeros(1,OneTurnTime98*2+1);
LAllTouchPhaseTMsum=zeros(1,OneTurnTime98*2+1);
for i=2:length(TurnMarkerTime98)-1
    RAllTouchPhaseTM=[];
    LAllTouchPhaseTM=[];
    RAllTouchPhaseTM=RAllTouchPhase(round(TurnMarkerTime98(i)-OneTurnTime98):round(TurnMarkerTime98(i)+OneTurnTime98));
    LAllTouchPhaseTM=LAllTouchPhase(round(TurnMarkerTime98(i)-OneTurnTime98):round(TurnMarkerTime98(i)+OneTurnTime98));
    RAllTouchPhaseTMsum=RAllTouchPhaseTMsum+RAllTouchPhaseTM;
    LAllTouchPhaseTMsum=LAllTouchPhaseTMsum+LAllTouchPhaseTM;
end
RAllTouchPhaseTM=RAllTouchPhaseTMsum/(length(TurnMarkerTime98)-1);
LAllTouchPhaseTM=LAllTouchPhaseTMsum/(length(TurnMarkerTime98)-1);
RAllTouchPhaseTM=MovWindow(RAllTouchPhaseTM,20);
LAllTouchPhaseTM=MovWindow(LAllTouchPhaseTM,20);
% RAllTouchPhaseTM=RAllTouchPhaseTM-mean(RAllTouchPhaseTM);
% LAllTouchPhaseTM=LAllTouchPhaseTM-mean(LAllTouchPhaseTM);
% negativeR=find(RAllTouchPhaseTM<0);
% negativeL=find(LAllTouchPhaseTM<0);
% RAllTouchPhaseTM(negativeR)=0;
% LAllTouchPhaseTM(negativeL)=0;

% figure
% plot(linspace(0,OneTurnTime98*2,length(RAllTouchPhaseTM)),RAllTouchPhaseTM,'color','b');hold on 
% plot(linspace(0,OneTurnTime98*2,length(LAllTouchPhaseTM)),LAllTouchPhaseTM,'color','r')
% if max(max(RAllTouchPhaseTM),max(LAllTouchPhaseTM))>0;
% axis([0 OneTurnTime98*2 0 max(max(RAllTouchPhaseTM),max(LAllTouchPhaseTM))*1.1]);
% end

% MeanR=mean(RAllTouchPhase);
% MeanL=mean(LAllTouchPhase);
% RAllTouchPhase=RAllTouchPhase-MeanR;
% LAllTouchPhase=LAllTouchPhase-MeanL;
RLPhase=RAllTouchPhase+LAllTouchPhase;
RLPhase(RLPhase<0)=0;
BIN=1000;
Mbin=round(length(RLPhase)/BIN)+1;
RLPhaseTM1=[];
RLPhaseTMsum=zeros(1,OneTurnTime98*2+1);
S=length(TurnMarkerTime98);
for i=2:length(TurnMarkerTime98)-2
    RLPhaseTM1=[];
    RLPhaseTM1=RLPhase(round(TurnMarkerTime98(i)-OneTurnTime98):round(TurnMarkerTime98(i)+OneTurnTime98));
    RLPhaseTMsum=RLPhaseTMsum+RLPhaseTM1;
end


RLPhaseTM=RLPhaseTMsum/(length(TurnMarkerTime98)-1);
RLPhaseTM=MovWindow(RLPhaseTM,20);
RLPhaseTM=RLPhaseTM-mean(RLPhaseTM);
negative=find(RLPhaseTM<0);
RLPhaseTM(negative)=0;

%ビン数→1000
jMax=round(length(RLPhaseTM)/1000,1);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%変更点 
RLPhaseTM1000=zeros(1,1000);
for i=1:1000
        if jMax+(i-1)*jMax<length(RLPhaseTM);
        RLPhaseTM1000(i)=sum(RLPhaseTM(floor(1+(i-1)*jMax):floor(jMax+(i-1)*jMax)));
        end
end


BIN=1000;
[CrossCoSpike98]=CrossCorr(SpikeArray98',TurnMarkerTime98,OneTurnTime98*2,0,TurnMarkerTime98);
CCresultSpike98=hist(CrossCoSpike98,BIN)/length(TurnMarkerTime98);
CCresultSpike98=MovWindow(CCresultSpike98,5);

C=sum(CCresultSpike98);
CCresultSpikePro=CCresultSpike98/C;
RLPhaseTM1000Pro=RLPhaseTM1000/sum(RLPhaseTM1000);
% dist=KLDiv(RLPhaseTM1000Pro,CCresultSpikePro);


% 平均化フィルター
% N=round(length(RLPhaseTM)/length(CCresultSpike));
N=20;
coeff = ones(1, N)/N;
delay=(length(coeff)-1)/2;
avgRLPhaseTM = filter(coeff, 1, RLPhaseTM1000Pro);
% plot(linspace(0,OneTurnTime98*2-delay,length(RLPhaseTM)),avgRLPhaseTM);
% % % 包絡線
% % x = hilbert(avgRLPhaseTM);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ヒルベルト変換使用しない　                                                      
EnveRLPhaseTM=avgRLPhaseTM;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%20191024変数名変更するのめんどいからそのまま使用                                                                     



% 平均化フィルター
% N=round(length(RLPhaseTM)/length(CCresultSpike));
N=20;
coeff = ones(1, N)/N;
delay=(length(coeff)-1)/2;
avgCCresultSpikePro = filter(coeff, 1, CCresultSpikePro);
% plot(linspace(0,OneTurnTime98*2-delay,length(RLPhaseTM)),CCresultSpikePro);
% % % % 包絡線
% % % x = hilbert(avgCCresultSpikePro);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ヒルベルト変換しない                                                         
EnveCCresultSpikePro=avgCCresultSpikePro;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%20191024変数名変更するのめんどいからそのまま使用

if isnan(EnveRLPhaseTM)==0 & isnan(EnveCCresultSpikePro)==0;
dist=KLDiv(EnveRLPhaseTM,EnveCCresultSpikePro);
else
    dist=Inf;
end
subplot(2,1,2)%off
plot(linspace(0,OneTurnTime98*2,length(EnveRLPhaseTM)),EnveRLPhaseTM,'color','r');hold on %off     
plot(linspace(0,OneTurnTime98*2,length(EnveCCresultSpikePro)),EnveCCresultSpikePro,'color','k');%off          
if max(EnveRLPhaseTM)>0;%off
axis([0 OneTurnTime98*2 0 max(max(EnveRLPhaseTM),max(EnveCCresultSpikePro))*1.1]); %off         
end %off  
ylabel('mean');%off
xlabel(['dist=',num2str(dist)]);%off
% [h,p] = kstest2(EnveRLPhaseTM,EnveCCresultSpikePro);
% h
% p
Old1=cd;
% cd('C:\Users\C238\Desktop\WR_LVdata')
% load('15102_190224_98__touchfile','RmedianPTTM98','LmedianPTTM98','RpegMedian98','LpegMedian98','OneTurnTime98');
% Max=max(RLPhaseTM);
% RmedianPTTM98=round(sort(RmedianPTTM98*10,'ascend'));
% LmedianPTTM98=round(sort(LmedianPTTM98*10,'ascend'));
% RmedianPTTM98=RmedianPTTM98(find(~isnan(RmedianPTTM98)));
% LmedianPTTM98=LmedianPTTM98(find(~isnan(LmedianPTTM98)));
% RmedianPTTM98=[RmedianPTTM98 RmedianPTTM98+OneTurnTime98];
% LmedianPTTM98=[LmedianPTTM98 LmedianPTTM98+OneTurnTime98];
% for n=1:length(RmedianPTTM98)
%     text(RmedianPTTM98(n),Max-0.5,'l','FontSize',18,'color',[0 1 0]);hold on
% end
% for n=1:length(LmedianPTTM98)
%     text(LmedianPTTM98(n),Max,'l','FontSize',18,'color',[1 0 0]);hold on        
% end

% pdR=fitdist(phaseRamp','Normal');
% x_valueR=linspace(0,OneTurnTime98*2,1000);
% yR=pdf(pdR,x_valueR);
% 
% pdL=fitdist(phaseLamp','Normal');
% x_valueL=linspace(0,OneTurnTime98*2,1000);
% yL=pdf(pdL,x_valueL);
% 
% figure
% plot(x_valueR,yR,'color','b');hold on
% plot(x_valueL,yL,'color','r');
% 

% figure
% plot(linspace(0,OneTurnTime98*2,length(RAllTouchPhaseTM)),RAllTouchPhaseTM,'color','b');hold on 
% plot(linspace(0,OneTurnTime98*2,length(LAllTouchPhaseTM)),LAllTouchPhaseTM,'color','r')
% if max(max(RAllTouchPhaseTM),max(LAllTouchPhaseTM))>0;
% axis([0 OneTurnTime98*2 0 max(max(RAllTouchPhaseTM),max(LAllTouchPhaseTM))*1.1]);
% end
% close;
cd(Old1);
% close
cd(Old2);
tfiletrim=strtrim(tfile);
figname=[tfiletrim(1:end-2),'onestepphasemean','.bmp'];
saveas(y,figname);%off
close;%off

% ALLCellKL20190618

% Kl=[FLName '\KLDIV'];
% cd(Kl);
% KLf=[Kl '\' KLfname];
% cd(KLfname);
% filename3=[tfiletrim(1:end-2),'KLdiv'];
% save(filename3,'KldistSame','meanKldistDiff');
% cd(Old2);
% KLD1=KldistSame;
prediction20190729
meanXaxiserror1=meanXaxiserror;
Envedist1=Envedist;



% % 平均化フィルター
% N=round(length(RLPhaseTM)/length(CCresultSpike));
% N=60;
% coeff = ones(1, N)/N;
% delay=(length(coeff)-1)/2;
% avgRLPhaseTM = filter(coeff, 1, RLPhaseTM);
% plot(linspace(0,OneTurnTime98*2-delay,length(RLPhaseTM)),avgRLPhaseTM);
% % 包絡線
% x = hilbert(avgRLPhaseTM);
% EnveRLPhaseTM=abs(x);
% plot(linspace(0,OneTurnTime98*2,length(EnveRLPhaseTM)),EnveRLPhaseTM);

% RasterData=raster(SpikeArray',TurnMarkerTime);
% RasterDataRT=raster(RpegTouchallWon',TurnMarkerTime);
% RasterDataLT=raster(LpegTouchallWon',TurnMarkerTime);
% if isempty(RasterData)==0;
% figure
% plot(RasterData(:,1),RasterData(:,2),'ko');hold on
% plot(RasterDataRT(:,1),RasterDataRT(:,2),'bx');hold on
% plot(RasterDataLT(:,1),RasterDataLT(:,2),'rx');
% axis([0 OneTurnTime 0 length(TurnMarkerTime')]);
% RasterData1=raster(SpikeArray',RpegTouchallWon);
% RasterData2=raster(SpikeArray',LpegTouchallWon);
% figure
% plot(RasterData1(:,1),RasterData1(:,2),'bx');
% axis([0 600 0 length(RpegTouchallWon)]);
% figure
% plot(RasterData2(:,1),RasterData2(:,2),'rx');
% axis([0 600 0 length(LpegTouchallWon)]);
% end



% 平均化フィルター
% N=round(length(RLPhaseTM)/length(CCresultSpike));
% N=200;
% coeff = ones(1, N)/N;
% delay=(length(coeff)-1)/2;
% avgRLPhaseTM = filter(coeff, 1, RLPhaseTM);
% plot(linspace(0,OneTurnTime98*2-delay,length(RLPhaseTM)),avgRLPhaseTM);
% findpeaks(avgRLPhaseTM);
% 







% dist=KLDiv(CCresultSpike,RLPhaseTM);

% Raxis(0  0 max(RLPhaseTM)*1.5)
% RLPhaseTM=CrossCorr(RLPhase',TurnMarkerTime,OneTurnTime*2,0,TurnMarkerTime);
% NewRLPhaseTM=[];
% NewRLPhaseTM1=[];
% for i=1:BIN
%     RLPhaseTMmean=0;
%     RLPhaseTMsum=0;
%     for j=1:Mbin
%         if j+(i-1)*round(Mbin)>length(RLPhaseTM);
%             break;
%         end
%         RLPhaseTMsum=RLPhaseTMsum+RLPhaseTM(j+(i-1)*Mbin);
%         RLPhaseTMmean=RLPhaseTMsum/Mbin;
%     end
%     NewRLPhaseTM1(i)=RLPhaseTMmean;
%     NewRLPhaseTM=[NewRLPhaseTM NewRLPhaseTM1];
% end
% NewRLPhaseTM=hist(NewRLPhaseTM,OneTurnTime*2)/length(TurnMarkerTime);
% NewRLPhaseTM=MovWindow(NewRLPhaseTM,5);
% figure 
% plot(linspace(1,OneTurnTime*2,length(NewRLPhaseTM)),NewRLPhaseTM,'color','b');
% cd(Old);


% ROneTurnPhase=[];
% LOneTurnPhase=[];
% for i=1:length(TurnMarkerTime)-1;
%     ROneTurnPhaseCell(i,:)=RAllTouchPhase(TurnMarkerTime(i)<RAllTouchPhase & RAllTouchPhase<TurnMarkerTime(i+1))
% end
% 
% RAllTouchPhase=[zeros(1,round(RpegTouchallWon(1))) RAllTouchPhase zeros(1,round(OneTurnTime*2-RpegTouchallWon(end)))];
% LAllTouchPhase=[zeros(1,round(LpegTouchallWon(1))) LAllTouchPhase zeros(1,round(OneTurnTime*2-LpegTouchallWon(end)))];
% 
% 
% figure
% subplot(2,2,1);
% plot(linspace(0,OneTurnTime*2,length(RAllTouchPhase)),RAllTouchPhase);
% subplot(2,2,2);
% plot(linspace(0,OneTurnTime*2,length(LAllTouchPhase)),LAllTouchPhase);
% RLPhase=RAllTouchPhase+LAllTouchPhase;
% RLPhase=RLPhase-mean(RLPhase);
% subplot(2,2,[3,4])
% plot(linspace(0,OneTurnTime*2,length(RLPhase)),RLPhase);hold on
% axis([0 OneTurnTime*2 0 max(RLPhase)*1.3]);
% RpegMedian=[RpegMedian,RpegMedian+OneTurnTime];
% LpegMedian=[LpegMedian,LpegMedian+OneTurnTime];
% for n=1:length(RpegMedian)
%         text(RpegMedian(n),max(RLPhase)*1.05,'l','FontSize',16,'color',[0 1 1]);
% end
% for n=1:length(LpegMedian)
%         text(LpegMedian(n),max(RLPhase)*1.13,'l','FontSize',16,'color',[1 0 1]);
% end

