function RLt_Sum_20200303
%%%%%%%���E�����̃E�B���h�E�𓮂���
global CCresultRtouchWon CCresultLtouchWon RpegTouchallWon LpegTouchallWon SpikeArrayWon RtouchSpikeOnUnit LtouchSpikeOnUnit RtouchSpikeOffUnit LtouchSpikeOffUnit...
    pegpatternum pegpatternname RTroughlocsInterval LTroughlocsInterval LlocsInterval RlocsInterval
 




%SpikeArray��LPegTouchAll�ARpegTouchall���A���C�������N���X�R���I�O����
%SpikeArray��LPegTouchAll���A���C������
duration=5000;
CrossCoL=[];
CrossCoR=[];
%������
for n=1:(length(SpikeArrayWon))
        Interval=LpegTouchallWon((LpegTouchallWon>SpikeArrayWon(n)-duration/2)&(SpikeArrayWon(n)>LpegTouchallWon-duration/2))-SpikeArrayWon(n);
        CrossCoL=[CrossCoL Interval];
end
    
CrossCoL=[-1*duration/2 CrossCoL duration/2];

CrossCoL(CrossCoL==0)=[];

bin=500;
% CCresultLtouchWon�̍X�V�ɕK�v
CCresultLtouchWon=hist(CrossCoL,bin);
CCresultLtouchWon=CCresultLtouchWon/sum(CCresultLtouchWon);
CCresultLtouchWon=MovWindow(CCresultLtouchWon,10);


%SpikeArray��RPegTouchAll���A���C������
for n=1:(length(SpikeArrayWon))
        Interval=RpegTouchallWon((RpegTouchallWon>SpikeArrayWon(n)-duration/2)&(SpikeArrayWon(n)>RpegTouchallWon-duration/2))-SpikeArrayWon(n);
        CrossCoR=[CrossCoR Interval];
end
    
CrossCoR=[-1*duration/2 CrossCoR duration/2];

CrossCoR(CrossCoR==0)=[];
% CCresultRtouchWon�̍X�V�ɕK�v
CCresultRtouchWon=hist(CrossCoR,bin);
CCresultRtouchWon=CCresultRtouchWon/sum(CCresultRtouchWon);
CCresultRtouchWon=MovWindow(CCresultRtouchWon,10);

%%%%%%%%%%%%%%%%%%%%�s�[�N��Trough�̌��o
% crosscorrelogram����s�[�N��Trough�����o
%%Ltouch
%�s�[�N�����o
[Lpks,Llocs,Lwidth,Lproms]=findpeaks(CCresultLtouchWon,'MinPeakDistance',20);
[Lpks,Llocs,Lwidth,Lproms]=findpeaks(CCresultLtouchWon,'MinPeakDistance',20,'MinPeakProminence',mean(Lproms)*0.3);%%%%%%%��Ōv�Z�����v���~�l���X�̕��ρ��O�D�P�ȏ�̃s�[�N�����o
LlocsInterval=Llocs-250;
LlocsInterval1=LlocsInterval(LlocsInterval>=0);%%%%�������̃s�[�N���o
Linterval1=sort(abs(LlocsInterval1),'ascend');
LlocsInterval2=LlocsInterval(LlocsInterval<0);%%%%�������̃s�[�N���o
Linterval2=sort(LlocsInterval2,'descend');



%Trough�̌��o
CCresultLtouchWonTrough=(-1)*CCresultLtouchWon;

% %%%%off
% findpeaks(CCresultLtouchWonTrough,'MinPeakDistance',20);
% %%%%off

[LTroughpks,LTroughlocs,LTroughwidth,LTroughproms]=findpeaks(CCresultLtouchWonTrough,'MinPeakDistance',20);
[LTroughpks,LTroughlocs,LTroughwidth,LTroughproms]=findpeaks(CCresultLtouchWonTrough,'MinPeakDistance',20,'MinPeakProminence',mean(LTroughproms)*0.3);%%%%%%%��Ōv�Z�����v���~�l���X�̕��ρ��O�D�P�ȏ�̃s�[�N�����o
LTroughlocsInterval=LTroughlocs-250;
LTroughlocsInterval1=LTroughlocsInterval(LTroughlocsInterval>=0);%%%%�������̃s�[�N���o
LTroughinterval1=sort(abs(LTroughlocsInterval1),'ascend');
LTroughlocsInterval2=LTroughlocsInterval(LTroughlocsInterval<0);%%%%�������̃s�[�N���o
LTroughinterval2=sort(LTroughlocsInterval2,'descend');

% %%%%%%%%%%%off
% figure
% plot(linspace(1,5000,bin),CCresultLtouchWon,'color','r','LineWidth',2);hold on
% plot(linspace(1,5000,bin),CCresultLtouchWonTrough,'color','r','LineWidth',2);
% figure
% findpeaks(CCresultLtouchWon,'MinPeakDistance',20,'MinPeakProminence',mean(Lproms)*0.3);
% figure
% findpeaks(CCresultLtouchWonTrough,'MinPeakDistance',20,'MinPeakProminence',mean(LTroughproms)*0.3);
% 
% %%%%%%%%%%%


%%Rtouch
%�s�[�N�����o
[Rpks,Rlocs,Rwidth,Rproms]=findpeaks(CCresultRtouchWon,'MinPeakDistance',20);
[Rpks,Rlocs,Rwidth,Rproms]=findpeaks(CCresultRtouchWon,'MinPeakDistance',20,'MinPeakProminence',mean(Rproms)*0.3);%%%%%%%��Ōv�Z�����v���~�l���X�̕��ρ��O�D�P�ȏ�̃s�[�N�����o
RlocsInterval=Rlocs-250;
RlocsInterval1=RlocsInterval(RlocsInterval>=0);
Rinterval1=sort(abs(RlocsInterval1),'ascend');
RlocsInterval2=RlocsInterval(RlocsInterval<0);
Rinterval2=sort(RlocsInterval2,'descend');
TouchArray=[LlocsInterval,RlocsInterval];
TouchArray1=sort(abs(TouchArray),'ascend');




%%%%%Trough�̌��o
CCresultRtouchWonTrough=(-1)*CCresultRtouchWon;

% %%%%%off
% findpeaks(CCresultRtouchWonTrough,'MinPeakDistance',20);
% %%%%%

[RTroughpks,RTroughlocs,RTroughwidth,RTroughproms]=findpeaks(CCresultRtouchWonTrough,'MinPeakDistance',20);   %%%%%%%��xprominence���v�Z
[RTroughpks,RTroughlocs,RTroughwidth,RTroughproms]=findpeaks(CCresultRtouchWonTrough,'MinPeakDistance',20,'MinPeakProminence',mean(RTroughproms)*0.3); %%%%%%%��Ōv�Z�����v���~�l���X�̕��ρ��O�D�P�ȏ�̃s�[�N�����o
RTroughlocsInterval=RTroughlocs-250;
RTroughlocsInterval1=RTroughlocsInterval(RTroughlocsInterval>=0);%%%%�������̃s�[�N���o
RTroughinterval1=sort(abs(RTroughlocsInterval1),'ascend');
RTroughlocsInterval2=RTroughlocsInterval(RTroughlocsInterval<0);%%%%�������̃s�[�N���o
RTroughinterval2=sort(RTroughlocsInterval2,'descend');


% %%%%%%%%%%%off
% figure
% plot(linspace(1,5000,bin),CCresultRtouchWon,'color','b','LineWidth',2);hold on
% plot(linspace(1,5000,bin),CCresultRtouchWonTrough,'color','b','LineWidth',2);
% figure
% findpeaks(CCresultRtouchWon,'MinPeakDistance',25,'MinPeakProminence',mean(Rproms)*0.3);
% figure
% findpeaks(CCresultRtouchWonTrough,'MinPeakDistance',25,'MinPeakProminence',mean(RTroughproms)*0.3);
% %%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
WindowNum=5;%�g��window�̐�

if length(LlocsInterval)>WindowNum && length(RlocsInterval)>WindowNum...
        length(LTroughlocsInterval)>WindowNum && length(RlocsInterval)>WindowNum
    
     %%%%%%%%�s�[�N�ԂɃg���t�����ȏ�������̓g���t�ԂɃs�[�N�����ȏ゠�邩�𒲂ׂ�
    %%%%�������ꍇ�A�ׂȂ��s�[�N�ǂ����������̓g���t�̒��Ԓn�_��V���ȃs�[�N�i�g���t�j�Ƃ���
   %%%%%%%%���r�̃s�[�N�ƃg���t�̊֌W�𒲂ׂ�
   %�g���t�Ԃ̃s�[�N����������ꍇ�̏C��
    for i=1:length(LTroughlocsInterval)-1
        if length(LlocsInterval(LTroughlocsInterval(i)<LlocsInterval & LlocsInterval<LTroughlocsInterval(i+1)))>=2;
           Index=find(LTroughlocsInterval(i)<LlocsInterval & LlocsInterval<LTroughlocsInterval(i+1));  %%%% �g���t�Ԃɂ��镡���̃s�[�N�����o
           NewPeak=mean(LlocsInterval(Index));                                                          %%%%%�����̃s�[�N�̒��Ԓn�_��V���ȃs�[�N�ɐݒ�
           LlocsInterval(Index)=NaN;                                                                    %%%%%%���Ƃ��ƕ����̃s�[�N���������l��NaN�ɒu������
           LlocsInterval(Index(1))=NewPeak;                                                             %%%%%%NaN�̂����̈��V���ȃs�[�N�ɐݒ�
           LlocsInterval = LlocsInterval(find(~isnan(LlocsInterval))) ;                                 %%%%%%%Nan����菜�����z��ɕϊ�
        end
    end
    %�s�[�N�Ԃ̃g���t����������ꍇ�̏C��
    for i=1:length(LlocsInterval)-1
        if length(LTroughlocsInterval(LlocsInterval(i)<LTroughlocsInterval & LTroughlocsInterval<LlocsInterval(i+1)))>=2;
           Index=find(LlocsInterval(i)<LTroughlocsInterval & LTroughlocsInterval<LlocsInterval(i+1));  %%%% �s�[�N�Ԃɂ��镡���̃g���t�����o
           NewPeak=mean(LTroughlocsInterval(Index));                                                          %%%%%�����̃g���t�̒��Ԓn�_��V���ȃg���t�ɐݒ�
           LTroughlocsInterval(Index)=NaN;                                                                    %%%%%%���Ƃ��ƕ����̃g���t���������l��NaN�ɒu������
           LTroughlocsInterval(Index(1))=NewPeak;                                                             %%%%%%NaN�̂����̈��V���ȃg���t�ɐݒ�
           LTroughlocsInterval = LTroughlocsInterval(find(~isnan(LTroughlocsInterval))) ;                                 %%%%%%%Nan����菜�����z��ɕϊ�
        end
    end
    
     %%%%%%%%�E�r�̃s�[�N�ƃg���t�̊֌W�𒲂ׂ�
   %�g���t�Ԃ̃s�[�N����������ꍇ�̏C��
    for i=1:length(RTroughlocsInterval)-1
        if length(RlocsInterval(RTroughlocsInterval(i)<RlocsInterval & RlocsInterval<RTroughlocsInterval(i+1)))>=2;
           Index=find(RTroughlocsInterval(i)<RlocsInterval & RlocsInterval<RTroughlocsInterval(i+1));  %%%% �g���t�Ԃɂ��镡���̃s�[�N�����o
           NewPeak=mean(RlocsInterval(Index));                                                          %%%%%�����̃s�[�N�̒��Ԓn�_��V���ȃs�[�N�ɐݒ�
           RlocsInterval(Index)=NaN;                                                                    %%%%%%���Ƃ��ƕ����̃s�[�N���������l��NaN�ɒu������
           RlocsInterval(Index(1))=NewPeak;                                                             %%%%%%NaN�̂����̈��V���ȃs�[�N�ɐݒ�
           RlocsInterval = RlocsInterval(find(~isnan(RlocsInterval))) ;                                 %%%%%%%Nan����菜�����z��ɕϊ�
        end
    end
    %�s�[�N�Ԃ̃g���t����������ꍇ�̏C��
    for i=1:length(RlocsInterval)-1
        if length(RTroughlocsInterval(RlocsInterval(i)<RTroughlocsInterval & RTroughlocsInterval<RlocsInterval(i+1)))>=2;
           Index=find(RlocsInterval(i)<RTroughlocsInterval & RTroughlocsInterval<RlocsInterval(i+1));  %%%% �s�[�N�Ԃɂ��镡���̃g���t�����o
           NewPeak=mean(RTroughlocsInterval(Index));                                                          %%%%%�����̃g���t�̒��Ԓn�_��V���ȃg���t�ɐݒ�
           RTroughlocsInterval(Index)=NaN;                                                                    %%%%%%���Ƃ��ƕ����̃g���t���������l��NaN�ɒu������
           RTroughlocsInterval(Index(1))=NewPeak;                                                             %%%%%%NaN�̂����̈��V���ȃg���t�ɐݒ�
           RTroughlocsInterval = RTroughlocsInterval(find(~isnan(RTroughlocsInterval))) ;                                 %%%%%%%Nan����菜�����z��ɕϊ�
        end
    end
    
%���E���ꂼ��̃s�[�N��Trough�̔z�񂩂��Βl������������WindowNum���̃s�[�N�iTrough�j��I��
%peak�̌��o
%Ltouh
[LlocsIntervalB LlocsIntervalIndex]=sort(abs(LlocsInterval),'ascend');
LtouchWindowPeak=sort(LlocsInterval(LlocsIntervalIndex-2:LlocsIntervalIndex+2),'ascend');        %%%%WindowNum���̃s�[�N

%Rtouch
[RlocsIntervalB RlocsIntervalIndex]=sort(abs(RlocsInterval),'ascend');
RtouchWindowPeak=sort(RlocsInterval(RlocsIntervalIndex-2:RlocsIntervalIndex+2),'ascend');        %%%%WindowNum���̃s�[�N

%%%%

%Trough�̌��o
%Ltouh
[LTroughlocsIntervalB LTroughlocsIntervalIndex]=sort(abs(LTroughlocsInterval),'ascend');
LtouchWindowTrough=sort(LTroughlocsInterval(LTroughlocsIntervalIndex(1:WindowNum+1)),'ascend');        %%%%WindowNum����Trough%Trough��window�͎���4��

%Rtouch
[RTroughlocsIntervalB RTroughlocsIntervalIndex]=sort(abs(RTroughlocsInterval),'ascend');
RtouchWindowTrough=sort(RTroughlocsInterval(RTroughlocsIntervalIndex(1:WindowNum+1)),'ascend');        %%%%WindowNum���̃s�[�N%Trough��window�͎���4��


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%�s�[�N��Trough�̈ʒu���o�I���
[RLPeakPosition IndexRLPeak]=sort([LtouchWindowPeak RtouchWindowPeak]);
IndexLPeak=find(IndexRLPeak<=5);
IndexRPeak=find(IndexRLPeak>=6);

LTrough=LtouchWindowTrough(LtouchWindowTrough>min(LtouchWindowPeak) & max(LtouchWindowPeak)>LtouchWindowTrough);
RTrough=RtouchWindowTrough(RtouchWindowTrough>min(RtouchWindowPeak) & max(RtouchWindowPeak)>RtouchWindowTrough);

[RLTroughPosition IndexRLTrough]=sort([LTrough RTrough]);
IndexLTrough=find(IndexRLTrough<=4);
IndexRTrough=find(IndexRLTrough>=5);


%%%%%%%window��start��end��ݒ�

%%%%%%%%%%PositiveWindow%%%%%%%%%%%%%%Ltouch%%%%%

LPWS=zeros(1,WindowNum);
LPWE=zeros(1,WindowNum);
for n=1:WindowNum
    [DistancefromPeakN LocsDistancefromPeakN]=sort((LTroughlocsInterval-LtouchWindowPeak(n)),'ascend');%Peak����ł��߂�Trough���I�ԁiPeak(n)�̗��ׂɂ���Trough�j
    DistancefromPeakNLeft=DistancefromPeakN(DistancefromPeakN<0);
    DistancefromPeakNRight=DistancefromPeakN(DistancefromPeakN>0);                                         
    LPWS(n)=LtouchWindowPeak(n)-abs(max(DistancefromPeakNLeft))/2;%Peak�̍��ׂɂ���Trough�Ƃ̔����̋�����window�̒[�iwindowstart�j�ɐݒ�
    LPWE(n)=LtouchWindowPeak(n)+abs(min(DistancefromPeakNRight))/2;%Peak�̉E�ׂɂ���Trough�Ƃ̔����̋�����window�̒[��(windowEnd)�ɐݒ�
end

%%%%%%%%%%PositiveWindow%%%%%%%%%%%%%%Ltouch%%%%%
RPWS=zeros(1,WindowNum);
RPWE=zeros(1,WindowNum);
for n=1:WindowNum
    [DistancefromPeakN LocsDistancefromPeakN]=sort((RTroughlocsInterval-RtouchWindowPeak(n)),'ascend');%Peak����ł��߂�Trough���I�ԁiPeak(n)�̗��ׂɂ���Trough�j
    DistancefromPeakNLeft=DistancefromPeakN(DistancefromPeakN<0);
    DistancefromPeakNRight=DistancefromPeakN(DistancefromPeakN>0);           
    RPWS(n)=RtouchWindowPeak(n)-abs(max(DistancefromPeakNLeft))/2;%Peak�̍��ׂɂ���Trough�Ƃ̔����̋�����window�̒[�iwindowstart�j�ɐݒ�
    RPWE(n)=RtouchWindowPeak(n)+abs(min(DistancefromPeakNRight))/2;%Peak�̉E�ׂɂ���Trough�Ƃ̔����̋�����window�̒[��(windowEnd)�ɐݒ�
end
%%%%%%NegativeTroughWindow%%%%%Ltouch
LPWS
LPWE
LNWS=zeros(1,WindowNum-1);
LNWE=zeros(1,WindowNum-1)
for n=1:WindowNum-1
    LNWS(n)=LPWE(n)
    LNWE(n)=LPWS(n+1)
end


%%%%%%NegativeTroughWindow%%%%%Rtouch
RPWS
RPWE
RNWS=zeros(1,WindowNum-1);
RNWE=zeros(1,WindowNum-1);
for n=1:WindowNum-1
    RNWS(n)=RPWE(n)
    RNWE(n)=RPWS(n+1)
end



% %%%%%%%%%off%%%%�E�B���h�E�̈ʒu�m���߂�
% LNWSsort=sort(LNWS);%kuro
% LNWEsort=sort(LNWE);%kurofilled
% LPWSsort=sort(LPWS);%green 
% LPWEsort=sort(LPWE);%greenfilled
% fig1=figure;
% subplot(2,2,[1,2]);
% plot(linspace(1,5000,bin),CCresultLtouchWon,'color','r','LineWidth',2);
% axis([0 5000 0 max(CCresultLtouchWon)*1.1]);
% hold on
% scatter(LNWSsort*10+2500,[mean(CCresultLtouchWon)*1.1,mean(CCresultLtouchWon)*1.1,mean(CCresultLtouchWon)*1.1,mean(CCresultLtouchWon)*1.1],'k');hold on 
% scatter(LNWEsort*10+2500,[mean(CCresultLtouchWon)*1.1,mean(CCresultLtouchWon)*1.1,mean(CCresultLtouchWon)*1.1,mean(CCresultLtouchWon)*1.1],'k','filled');hold on 
% scatter(LPWSsort*10+2500,[mean(CCresultLtouchWon),mean(CCresultLtouchWon),mean(CCresultLtouchWon),mean(CCresultLtouchWon),mean(CCresultLtouchWon)],'g');
% scatter(LPWEsort*10+2500,[mean(CCresultLtouchWon),mean(CCresultLtouchWon),mean(CCresultLtouchWon),mean(CCresultLtouchWon),mean(CCresultLtouchWon)],'g','filled');
% %%%%%%%%%%
% RNWSsort=sort(RNWS);%kuro
% RNWEsort=sort(RNWE);%kurofilled
% RPWSsort=sort(RPWS);%green 
% RPWEsort=sort(RPWE);%greenfilled
% subplot(2,2,[3,4]);
% plot(linspace(1,5000,bin),CCresultRtouchWon,'color','b','LineWidth',2);
% axis([0 5000 0 max(CCresultRtouchWon)*1.1]);
% hold on
% scatter(RNWSsort*10+2500,[mean(CCresultRtouchWon)*1.1,mean(CCresultRtouchWon)*1.1,mean(CCresultRtouchWon)*1.1,mean(CCresultRtouchWon)*1.1],'k');hold on 
% scatter(RNWEsort*10+2500,[mean(CCresultRtouchWon)*1.1,mean(CCresultRtouchWon)*1.1,mean(CCresultRtouchWon)*1.1,mean(CCresultRtouchWon)*1.1],'k','filled');hold on 
% scatter(RPWSsort*10+2500,[mean(CCresultRtouchWon),mean(CCresultRtouchWon),mean(CCresultRtouchWon),mean(CCresultRtouchWon),mean(CCresultRtouchWon)],'g');
% scatter(RPWEsort*10+2500,[mean(CCresultRtouchWon),mean(CCresultRtouchWon),mean(CCresultRtouchWon),mean(CCresultRtouchWon),mean(CCresultRtouchWon)],'g','filled');
% 
% 
% %%%%%%%%off


%%%%%%�E�B���h�E�P�̃X�^�[�Ƃ̈ʒu���O���Ƃ���l�ɕϊ��iLPWS(1)orRPWS(1)���A�l�����炷�j
LPWS1=LPWS;
LPWE1=LPWE;
LNWS1=LNWS;
LNWE1=LNWE;
RPWS1=RPWS;
RPWE1=RPWE;
RNWS1=RNWS;
RNWE1=RNWE;


%%%%�X�p�C�N�E�B���h�E�̐ݒ聓������40ms��
LSWS1=-2;
LSWE1=LSWS1+4;


%%%%%%%%



%%%%%���r�E�B���h�E(positive)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%�E�B���h�E�𓮂����񐔂̌v�Z
 MoveWindowNum=fix((LpegTouchallWon(end)-LpegTouchallWon(1))/10)+1;

 
%%%%�^�b�`�Ԃ̃C���^�[�o����1�b�ȏ�󂢂Ă��镔����ۑ�
LtouchWaterBreakTime=[];
LtouchWaterRestartTime=[];
for n=1:length(LpegTouchallWon)-1
    LpegTouchWonInterval1=LpegTouchallWon(n+1)-LpegTouchallWon(n);
    if LpegTouchWonInterval1>1000
        LtouchWaterBreakTime=[LtouchWaterBreakTime;LpegTouchallWon(n)];
        LtouchWaterRestartTime=[LtouchWaterRestartTime;LpegTouchallWon(n+1)];
    end
end
LtouchWaterBreakRestartArray=[LtouchWaterBreakTime,LtouchWaterRestartTime];
%%%%%%%
%%%%�^�b�`�Ԃ̃C���^�[�o����1�b�ȏ�󂢂Ă��镔����ۑ�
RtouchWaterBreakTime=[];
RtouchWaterRestartTime=[];
for n=1:length(RpegTouchallWon)-1
    RpegTouchWonInterval1=RpegTouchallWon(n+1)-RpegTouchallWon(n);
    if RpegTouchWonInterval1>1000
        RtouchWaterBreakTime=[RtouchWaterBreakTime;RpegTouchallWon(n)];
        RtouchWaterRestartTime=[RtouchWaterRestartTime;RpegTouchallWon(n+1)];
    end
end
RtouchWaterBreakRestartArray=[RtouchWaterBreakTime,RtouchWaterRestartTime];
%%%%%%%

WindowPoint=0;
NegativeWindowPoint=0;
Positive_NegativeUnit=[];
NegativeUnit=[];
%%%%%Ltouch�ŃE�B���h�E�𓮂����Ă�����������10ms�b��������
for n=1:MoveWindowNum
    LPWStart=LPWS1*10+SpikeArrayWon(1)+(n-1)*10;
    LPWEnd=LPWE1*10+SpikeArrayWon(1)+(n-1)*10;
    LNWStart=LNWS1*10+SpikeArrayWon(1)+(n-1)*10;
    LNWEnd=LNWE1*10+SpikeArrayWon(1)+(n-1)*10;
    
    RPWStart=RPWS1*10+SpikeArrayWon(1)+(n-1)*10;
    RPWEnd=RPWE1*10+SpikeArrayWon(1)+(n-1)*10;
    RNWStart=RNWS1*10+SpikeArrayWon(1)+(n-1)*10;
    RNWEnd=RNWE1*10+SpikeArrayWon(1)+(n-1)*10;
    
    SWSart=LSWS1*10+SpikeArrayWon(1)+(n-1)*10;
    SWEnd=LSWE1*10+SpikeArrayWon(1)+(n-1)*10;
    
    SpikePoint=0;                                                   
    WindowPointArray=zeros(1,(WindowNum)*2);  %%%% WindowPointArray��SpikePoint�̓E�B���h�E���������тɃ��Z�b�g                               
    NegativeWindowPointArray=zeros(1,(WindowNum-1)*2);
    a=0;      %%%%a=0�̎�Won�Aa=1�̎�Woff�̂��ߐ����Ȃ�
    b=0;
    if ~isempty(LtouchWaterBreakRestartArray) 
        for k=1:length(LtouchWaterBreakRestartArray(:,1))
            if LtouchWaterBreakRestartArray(k,1)<LPWStart(1) && LPWEnd(end)<LtouchWaterBreakRestartArray(k,2)
               a=1;
            end
        end
    end
    if ~isempty(RtouchWaterBreakRestartArray) 
        for k=1:length(RtouchWaterBreakRestartArray(:,1))
            if RtouchWaterBreakRestartArray(k,1)<RPWStart(1) && RPWEnd(end)<RtouchWaterBreakRestartArray(k,2)
               b=1;
            end
        end
    end
    if a==0 && b==0;   %%%%a=0�̎��E�B���h�E�Ƀ^�b�`�����Ă͂܂邩�J�E���g�Aa==1�Ȃ�΁A�X���[���ăE�B���h�E�𓮂���
        %%%%%%%%%%%%%%%%
       if ~isempty(SpikeArrayWon(SWSart<SpikeArrayWon & SpikeArrayWon<SWEnd));
           SpikePoint=1;
           SpikeKaisu=length(SpikeArrayWon(SWSart<SpikeArrayWon & SpikeArrayWon<SWEnd));
       elseif isempty(SpikeArrayWon(SWSart<SpikeArrayWon & SpikeArrayWon<SWEnd));
           SpikePoint=0; 
           SpikeKaisu=0;
       end
       %%%Ltouch
       %%%%%%%%%%%%%%%%%Positewindow
       for i=1:WindowNum
           if ~isempty(LpegTouchallWon(LPWStart(i)<LpegTouchallWon & LpegTouchallWon<LPWEnd(i))) %%%% i�Ԗڂ̃E�B���h�E�̒��Ƀ^�b�`������΁A�A�A
               WindowPointArray(IndexLPeak(i))=1;                                                       %%%%�@WindowPointArray��[0,0,0,0,0]��[1,0,0,0,0]�ɂȂ�                                                
           end    
       end
       %%%%%%%%%%%%%%%%%Negativewindow
       for i=1:WindowNum-1
           if ~isempty(LpegTouchallWon(LNWStart(i)<LpegTouchallWon & LpegTouchallWon<LNWEnd(i))) %%%% i�Ԗڂ̃E�B���h�E�̒��Ƀ^�b�`������΁A�A�A
               NegativeWindowPointArray(IndexLTrough(i))=-1;                                                       %%%%�@WindowPointArray��[0,0,0,0,0]��[1,0,0,0,0]�ɂȂ�                                                
           end    
       end
       
       %%%%%Rtouch
       %%%%%%%%%%%%%%%%Positive
       for i=1:WindowNum
           if ~isempty(RpegTouchallWon(RPWStart(i)<RpegTouchallWon & RpegTouchallWon<RPWEnd(i))) %%%% i�Ԗڂ̃E�B���h�E�̒��Ƀ^�b�`������΁A�A�A
               WindowPointArray(IndexRPeak(i))=1;                                                       %%%%�@WindowPointArray��[0,0,0,0,0]��[1,0,0,0,0]�ɂȂ�                                                
           end
       end
       %%%%%%%%%%%%%%%%%Negative
       for i=1:WindowNum-1
           if ~isempty(RpegTouchallWon(RNWStart(i)<RpegTouchallWon & RpegTouchallWon<RNWEnd(i))) %%%% i�Ԗڂ̃E�B���h�E�̒��Ƀ^�b�`������΁A�A�A
               NegativeWindowPointArray(IndexRTrough(i))=-1;                                                       %%%%�@WindowPointArray��[0,0,0,0,0]��[1,0,0,0,0]�ɂȂ�                                                
           end
       end
    end
    

       Positive_NegativeUnit=[Positive_NegativeUnit;[SpikeKaisu WindowPointArray NegativeWindowPointArray]]; %%%%%%�X�p�C�N�E�B���h�E���ɃX�p�C�N������΃X�p�C�N�񐔂ƃE�B���h�E�z���ۑ��i10�~�E�B���h�E�������񐔂̍s��j
       

%        NegativeUnit=[NegativeUnit;[SpikeKaisu NegativeWindowPointArray]];  %%%%%%�X�p�C�N�E�B���h�E���ɃX�p�C�N���Ȃ���΃E�B���h�E�z���ۑ��i9�~�E�B���h�E�������񐔂̍s��j
       
end
end
%%%%%%%PositiveUnit
XArray=[];
for x=1:length(Positive_NegativeUnit(:,1))
    IndexRLt=find(Positive_NegativeUnit(x,[2:10])==1 | Positive_NegativeUnit(x,[2:10])==-1);
    if length(IndexRLt)<4;
        XArray=[XArray x];
    end
end
Positive_NegativeUnit(XArray(1:end),:)=[];

% %%%%%%%NegativeUnit
% XArray=[];
% for x=1:length(NegativeUnit(:,1))
%     IndexRLt=find(NegativeUnit(x,[2:9])==-1);
%     if length(IndexRLt)<4;
%          XArray=[XArray x];
%     end
% end
% NegativeUnit(XArray,:)=[];




Positive_NegativeUnit
NegativeUnit

% figname=[pegpatternum,pegpatternname,'CC.bmp'];
% saveas(fig1,figname);
filename=[pegpatternum,pegpatternname,'Both_LtRt_Unit.mat'];
save(filename,'IndexLPeak','IndexLTrough','IndexRPeak','IndexRTrough','Positive_NegativeUnit'...
    ,'SpikeArrayWon','RpegTouchallWon','LpegTouchallWon','CCresultRtouchWon','CCresultLtouchWon'...
    ,'LPWS','LPWE','LNWS','LNWE','RPWS','RPWE','RNWS','RNWE','LtouchWindowPeak','RtouchWindowPeak','LTrough','RTrough');





