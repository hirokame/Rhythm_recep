function AllLFPauto20180420
%WheelAnalyzer24chSpike�ŉ�͂��s���A���ʂ��������Ɏc���Ă����Ԃōs��

%MATLAB�t�H���_��Nlx2MatCSC.mexw32��Nlx2MatCSC.mexw64�����Ă����B���Ԃ�ǂ��炩�Е��ł悢�B
%timestamps��270336�������B270ms�Ǝv����Btimestamps�̐���512�̃T���v���B
%270336/512=528. �T���v�����O��0.528ms���ƁBfs=10^6/528
close all

global TurnMarkerTime OneTurnTime StartTime FinishTime fname RpegTimeArray LpegTimeArray...
    RPegTouchAll LPegTouchAll DrinkOnArray WaterOnArrayOriginal WaterOffArrayOriginal filename...
    RpegTouchall LpegTouchall

File=0;
if isempty(WaterOnArrayOriginal) ||  isempty(WaterOffArrayOriginal)
    CCV=[0 6 8 9 13];
else
    CCV=[0 2 3 6 8 9 13];   
end

% CCbase=cell(13);


for CrossCorrValue=CCV
LFParrayALL=[];

%2,3,6,8,9,13
% CrossCorrValue=0
% CrossCorrValue=get(handles.popupmenu_CrossCorr,'Value');
if (CrossCorrValue==0)CCselect=0;S='DFT';
elseif CrossCorrValue==1;CCselect=TurnMarkerTime';S='aligned by TurnMarker';
elseif CrossCorrValue==2;CCselect=WaterOnArrayOriginal';S='aligned by WaterOn';    
elseif CrossCorrValue==3;CCselect=WaterOffArrayOriginal';S='aligned by WaterOff';    
elseif CrossCorrValue==4;CCselect=SpikeArray1';S='aligned by Spike';
elseif (CrossCorrValue==5) CCselect=RpegTimeArray;S='aligned by Right peg';
elseif (CrossCorrValue==6) CCselect=LpegTimeArray;S='aligned by Left peg';
elseif (CrossCorrValue==7) RLpegTimeArray=sort([RpegTimeArray;LpegTimeArray]);CCselect=RLpegTimeArray;S='aligned by R&L peg';
elseif (CrossCorrValue==8) CCselect=RpegTouchall;S='aligned by Right touch';
elseif (CrossCorrValue==9) CCselect=LpegTouchall;S='aligned by Left touch';
elseif (CrossCorrValue==10) CCselect=RLPegTouchAll;S='aligned by R&L touch';
elseif (CrossCorrValue==11) CCselect=FloorTouchArray;S='aligned by FloorTouch';
elseif (CrossCorrValue==12) CCselect=FloorDetachArray;S='aligned by FloorDetach';
elseif (CrossCorrValue==13) CCselect=DrinkOnArray;S='aligned by DrinkOn';
elseif (CrossCorrValue==14) CCselect=DrinkOffArray;S='aligned by DrinkOff';
elseif (CrossCorrValue==15)CCselect=SpikeArray2';S='aligned by Spike2';
elseif (CrossCorrValue==16)CCselect=SpikeArray3';S='aligned by Spike3';
elseif (CrossCorrValue==17)CCselect=SpikeArray4';S='aligned by Spike4';
elseif (CrossCorrValue==18)CCselect=SpikeArray5';S='aligned by Spike5';
end
DurationB=FinishTime-StartTime;

if File==0;
cd C:\Users\B133_2\Desktop\CheetahData
%dpath='C:\Documents and Settings\kit\�f�X�N�g�b�v\WR LVdata\';
% [fname,dpath] = uigetfile('*.xls');
[fname,dpath] = uigetfile('*');
disp(fname);
File=1;
end

[filepath1 fnameEV TimeStamps Evt]=GetCSC_1(fname,dpath)%A1�ȂǂQ�����̂��̂�I��

FigA=figure

LFP32ch=[];
for K=1:32
    
Fname=['A1  ';'A2  '; 'A3  '; 'A4  '; 'A5  '; 'A6  '; 'A7  '; 'A8  '; 'A9  '; 'A10 '; 'A11 '; 'A12 '; 'B1  ';'B2  '; 'B3  '; 'B4  '; 'B5  '; 'B6  '; 'B7  '; 'B8  ';'B9  '; 'B10 '; 'B11 '; 'B12 '; 'CSC1';'CSC2'; 'CSC3'; 'CSC4'; 'CSC5'; 'CSC6'; 'CSC7'; 'CSC8' ];
filepath=[filepath1(1:end-6),strtrim(Fname(K,:)),filepath1(end-3:end)];
    
LenE=length(TimeStamps);
StartT=[];
StopT=[];
for n=1:LenE
    if Evt(n,end-14)=='1'
        StartT=[StartT TimeStamps(n)];
    end
    if Evt(n,end-4)=='1'
        StopT=[StopT TimeStamps(n)];
    end
end
SpikeArray1=0;
for n=1:length(StartT)
    for m=1:length(StopT)
        DurationS=StopT(m)-StartT(n);
        if abs(DurationS-DurationB*1000)<5000
            SpikeArray1=1;
            SpikeStartTime=StartT(n);
            SpikeStopTime=StopT(m);
%             pathnameCSC = 'C:\Users\kit\Documents\MATLABoriginal\CSC1.Ncs';
%             pathnameCSC = 'C:\Users\kit\Desktop\CheetahData\2016-2-12_19-3-56 6711\A1.Ncs';
            [Timestamp, ChanNum, SampleFrequency, NumValSamples, LFPsamples, header] = Nlx2MatCSC(filepath, [1, 1, 1, 1, 1], 1, 1);%���̎����g�������Bfunction�Ƃ��Ďg���K�v�͖����B
            
%             AllTimestamp=[];
            AllTimestamp=zeros(1,length(Timestamp)*512);
            
            TimestampArray=[];

            for k=1:length(Timestamp)
                p=0:511;
%                 AllTimestamp=[AllTimestamp,Timestamp(k)+528*m];%528*512=270336
                AllTimestamp((k-1)*512+1:(k-1)*512+512)=Timestamp(k)+528*p;
            end
            AllTimestampLength=length(AllTimestamp);


            % SpikeStartTime(LabView��Start�{�^���������ꂽ����Neurarynx�̎��ԁj��
            % StartTime(LabView�J�n����Start�{�^�����������܂ł̎���)�����낦��K�v������B
            % �Ȃ̂�Timestamp����SpikeStartTime��������StartTime��������B
            % LFP��528��sec���ƂɋL�^����Ă���A���ԒP�ʂ��}�C�N���b�ɑ����ĂŌv�Z���Ȃ��Ƃ��ꂪ������B
            % disp('LFPTimestamp(1:10)=');disp(AllTimestamp(1:10));

            TimestampArray=AllTimestamp-SpikeStartTime+StartTime*1000;
            BeforeRec=length(TimestampArray(TimestampArray<0));
            TimestampArray(TimestampArray<0)=[];
            AfterRec=length(TimestampArray(TimestampArray>FinishTime*1000));
            TimestampArray(TimestampArray>FinishTime*1000)=[];
            TimestampArayLength=length(TimestampArray)

            LFPsamples_Run=LFPsamples(BeforeRec+1:end-AfterRec);%BeforeRec+RecLength);
            LFPsample_length=length(LFPsamples_Run)

            format short;
        end
    end
end

LFPsamples_RunCC=[];
LFPsamples_RunCC=LFPsamples_Run;

if CCselect==0
    
fs=10^6/528;%1�b�Ԃ̃T���v�����O��//�T���v�����O���g��
% contents = cellstr(get(handles.popupmenu_DFTsize,'String')); 
dft_size=16384*2;%8192;%str2double(contents{get(handles.popupmenu_DFTsize,'Value')});

LFP=LFPsamples_Run;
Y=fft(LFP,dft_size);
k=1:dft_size/2+1;
A(k)=abs(Y(k));
P(k)=abs(Y(k)).^2;
frequency(k)=(k-1)*fs/dft_size;
subplot(8,4,K);%(ceil(K/4)-1)*4+mod((K-(ceil(K/4)-1)),5));

plot(frequency,A)
axis([0 10 0 max(A)])
    
else

MovW=2;
GaussSmooth=0;
 
if CrossCorrValue==1
    duration=(OneTurnTime*1000)/528;
    
elseif CrossCorrValue==2 || CrossCorrValue==3 %WaterEvent
    Dur=12000;
    duration=(Dur*1000)/528;
    
elseif CrossCorrValue==13 || CrossCorrValue==14 %DrinkEvent
    Dur=3000;
    duration=(Dur*1000)/528;
    
else
    Dur=3000;
    duration=(Dur*1000)/528;
%     duration=(OneTurnTime*1000)/528;
%     Dur=duration*528/1000;
end
SuperImpose=0;%get(handles.radiobutton_CCsuperimpose,'Value');
Direction=0;
subplot(8,4,K);%(ceil(K/4)-1)*4+mod((K-(ceil(K/4)-1)),5));
if SuperImpose==0
    [LFParray LFP_aligned]=LFPCrossCorr(LFPsamples_RunCC,CCselect,GaussSmooth,MovW,Direction,TimestampArray,duration);
    
    LFP32ch(K,:)=LFPsamples_RunCC;
    
    
%     figure
    plot(LFParray);
    axis([0 ceil(duration) min(mean(LFP_aligned)) max(mean(LFP_aligned))]);
    
%     if Dur==3000;LFParrayALL(K,:)=LFParray;end
    LFParrayALL(K,:)=LFParray;
    
else
    [LFParray1 LFP_aligned1]=LFPCrossCorr(LFPsamples_Run,CCselect,GaussSmooth,MovW,Direction,TimestampArray,duration);
    [LFParray2 LFP_aligned2]=LFPCrossCorr(LFPsamples_Ref,CCselect,GaussSmooth,MovW,Direction,TimestampArray,duration);
    [LFParray3 LFP_aligned3]=LFPCrossCorr(LFPsamples_RunCC,CCselect,GaussSmooth,MovW,Direction,TimestampArray,duration);  
%     figure
    plot(LFParray1,'b');hold on
    plot(LFParray2,'c');plot(LFParray3,'r');
%     axis([0 ceil(duration) min(mean(LFP_aligned1)) max(mean(LFP_aligned1))]);
end

if CrossCorrValue==1
    set(gca,'xtick',0:ceil(duration)/8:ceil(duration)+1,'xticklabel',0:round(OneTurnTime*0.1/8)*10:round(OneTurnTime*0.1/8)*80);
else

    set(gca,'xtick',0:ceil(duration)/8:ceil(duration)+1,'xticklabel',-round(Dur*0.1/8)*40:round(Dur*0.1/8)*10:round(Dur*0.1/8)*40);
end


end
if K==32;xlabel([filename,'  ',S]);end
end
% if CrossCorrValue==2|CrossCorrValue==3|CrossCorrValue==6|CrossCorrValue==8|CrossCorrValue==9|CrossCorrValue==13
if CrossCorrValue==6|CrossCorrValue==8|CrossCorrValue==9|CrossCorrValue==13
    figure
    fs=10^3*round(duration)/(round(Dur*0.1/8)*40*2);
    dft_size=16384*2;
    for KK=1:32
        LFP=LFParrayALL(KK,:);

        Y=fft(LFP,dft_size);
        k=1:dft_size/2+1;
        A(k)=abs(Y(k));
        P(k)=abs(Y(k)).^2;
        frequency(k)=(k-1)*fs/dft_size;
        % figure
        subplot(8,4,KK);%(ceil(K/4)-1)*4+mod((K-(ceil(K/4)-1)),5));
        % subplot(2,1,1)
        plot(frequency,A)
        axis([0 10 0 max(A)])
        zoom xon
    end
    if KK==32;xlabel([filename,'  ',S]);end
end
end
Dur1=(OneTurnTime*1000)/528;Dur2=(12000*1000)/528;Dur3=(3000*1000)/528;

cd C:\Users\B133_2\Desktop
SaveName=['LFP32_' filename(1:end-4)];
eval(['save ',SaveName,' LFP32ch TurnMarkerTime WaterOnArrayOriginal WaterOffArrayOriginal LpegTimeArray LpegTimeArray RpegTouchall LpegTouchall DrinkOnArray TimestampArray Dur1 Dur2 Dur3']);
    



function [filepath fnameEV TimeStamps Evt]=GetCSC_1(fname,dpath)
%timestamps��270336�������B270ms�Ǝv����Btimestamps�̐���512�̃T���v���B
%270336/512=528. �T���v�����O��0.528ms���ƁBfs=10^6/528
global StartTime FinishTime fname

% StartTime
% FinishTime
DurationB=FinishTime-StartTime;

eval(['fnameEV=','''',dpath,'Events.Nev''']);
[TimeStamps EventStrings Evt]=readEvents(fnameEV);
% fnameEV='C:\Users\B133\Desktop\CheetaData\2016-2-18_18-13-11 6721\Events.Nev';

% filepath='C:\Users\B133\Desktop\CheetaData\2016-2-18_18-13-11 6721\Sc1_SS_01.t';
eval(['filepath=','''',dpath,fname,'''']);

