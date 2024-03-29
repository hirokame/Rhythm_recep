function SpikeDataAnalysis20180708
clear all;
close all;
% AllSpikeDataからSpikeDataMatrixを作成、さらにSpikeDayMatrixを作成して、Spikeデータ一覧を作成。どの日のRecを解析するべきかを考えるため。

% SpikeDataMatrix//3次元、すべての3次元で左から日付、タスク#
% 3次元は, 1.総細胞数, 2.活動細胞数（0.5）,3.右足反応細胞数、4.左足反応、5.どっちかの足反応、6.4分円2倍、7.2.5倍、8.3倍

% SpikeDayMatrix//日付、Bgra課題番号、89or89課題番号、C課題番号、テトロードx8（>Ratio、Rcell数）

%　AllSpikeDataの列　割り当て
% １．マウス、タスク＃
% ２．Date
% ３．PegPattern
% ４．Tetrode#
% ５． Hz　Woffのときを含む
% ６． RtouchMaxMinRatio
% ７． L
% ８． MaxMinRatio
% ９． AutoCorrのinterval（Wonのみ）
% １０． Rtouch、CrossCorrのInterval
% １１． Ltouch、CrossCorrのInterval
% １２． SpikePerTouchWon
% １３．SpikePerTouchWoff


cd('C:\Users\B133_2\Desktop\CheetahWRLV\119');
load AllSpikeData

% SpikeDataMatrix//3次元、すべての3次元で左から日付、タスク#
% 3次元は, 1.総細胞数, 2.活動細胞数（0.5）,3.右足反応細胞数、4.左足反応、5.どっちかの足反応、6.4分円2倍、7.2.5倍、8.3倍
%総細胞数
%活動細胞数　0.5Hz以上
%右足タッチ反応有無、4倍
%左足タッチ反応有無、4倍
%左右どちらかでもタッチ反応
%四分円Modulation有無、2倍
%四分円Modulation有無、2.5倍
%四分円Modulation有無、3倍

% SpikeDayMatrix//日付、Bgra課題番号、89or89課題番号、C課題番号、テトロードx8（>Ratio、Rcell数）でのRcell数（>x3）
%Bgraあるいは89or98で一番Rcell総数が多かったタスクでのテトロードごとのRcell数を表示
%Bgra, 98or89, C+の3種が揃っているか？

Line=0;
Mouse=0;
Date=0;
Pattern=0;
SpikeDataMatrix=zeros(300,11,8);
for n=1:length(AllSpikeData(:,1))
    MouseA=AllSpikeData(n,2);
    DateA=AllSpikeData(n,1);
    PatternA=AllSpikeData(n,3);
    if Mouse==MouseA && Date==DateA && Pattern==PatternA
    else
        Line=Line+1;
        SpikeDataMatrix(Line,1,:)=MouseA;
        Mouse=MouseA;
        SpikeDataMatrix(Line,2,:)=DateA;
        Date=DateA;
        SpikeDataMatrix(Line,3,:)=PatternA;
        Pattern=PatternA;
    end
    SpikeDataMatrix(Line,3+AllSpikeData(n,4),1)=SpikeDataMatrix(Line,3+AllSpikeData(n,4),1)+1;%全細胞数
    if AllSpikeData(n,5)>=0.5%0.5Hz以上の時に細胞カウント
%         Line
        SpikeDataMatrix(Line,3+AllSpikeData(n,4),2)=SpikeDataMatrix(Line,3+AllSpikeData(n,4),2)+1;%細胞数
    
        if AllSpikeData(n,6)>=4%右足
            SpikeDataMatrix(Line,3+AllSpikeData(n,4),3)=SpikeDataMatrix(Line,3+AllSpikeData(n,4),3)+1;
        end
        if AllSpikeData(n,7)>=4%左足
            SpikeDataMatrix(Line,3+AllSpikeData(n,4),4)=SpikeDataMatrix(Line,3+AllSpikeData(n,4),4)+1;
        end
        if AllSpikeData(n,6)>=4 || AllSpikeData(n,7)>=4%どちらかの足
            SpikeDataMatrix(Line,3+AllSpikeData(n,4),5)=SpikeDataMatrix(Line,3+AllSpikeData(n,4),5)+1;
        
            if AllSpikeData(n,8)>=2 %Ratio x2
                SpikeDataMatrix(Line,3+AllSpikeData(n,4),6)=SpikeDataMatrix(Line,3+AllSpikeData(n,4),6)+1;
            end
            if AllSpikeData(n,8)>=2.5 %Ratio x2
                SpikeDataMatrix(Line,3+AllSpikeData(n,4),7)=SpikeDataMatrix(Line,3+AllSpikeData(n,4),7)+1;
            end
            if AllSpikeData(n,8)>=3 %Ratio x2
                SpikeDataMatrix(Line,3+AllSpikeData(n,4),8)=SpikeDataMatrix(Line,3+AllSpikeData(n,4),8)+1;
            end
        end
    end
end
SpikeDataMatrix(Line+1:300,:,:)=[];

%良い日を決めるために。
% SpikeDayMatrix//日付、Bgra課題番号、89or89課題番号、C課題番号、テトロードx8（>Ratio、Rcell数）でのRcell数（>x3）

SizeSDM=size(SpikeDataMatrix);
SpikeDayMatrix=zeros(300,12);
Day=SpikeDataMatrix(1,1,1);
Sum=0;
SumBgra=0;
Sum98=0;
Line=1;
for n=1:length(SpikeDataMatrix(:,1,1))

    if SpikeDataMatrix(n,1,1)==Day
        SpikeDayMatrix(Line,1)=Day;
        SpikeDataMatrix(n,3,1)
        if SpikeDataMatrix(n,3,1)==6%Bgra
            Sum1=sum(SpikeDataMatrix(n,4:11,3));
            if Sum1>=SumBgra
                SumBgra=Sum1;
                SpikeDayMatrix(Line,2)=SpikeDataMatrix(n,2,1);%task#
                SpikeDayMatrix(Line,2)
                if Sum1>=Sum%SpikeDayMatrix(Line,2)==0
    %                 SpikeDayMatrix(Line,2)=SpikeDataMatrix(n,1,1);%task#
                    SpikeDayMatrix(Line,5:12)=SpikeDataMatrix(n,4:11,8);
                    Sum=Sum1;
%                 else
%                     Sum=Sum1;
                end
            end
        end
        if SpikeDataMatrix(n,3,1)==3 || SpikeDataMatrix(n,3,1)==4%89or98
            Sum1=sum(SpikeDataMatrix(n,4:11,3));
            if Sum1>=Sum98
                Sum98=Sum1;
                SpikeDayMatrix(Line,3)=SpikeDataMatrix(n,2,1);%task#
                if Sum1>=Sum%SpikeDayMatrix(Line,2)==0
    %                 SpikeDayMatrix(Line,3)=SpikeDataMatrix(n,1,1);%task#
                    SpikeDayMatrix(Line,5:12)=SpikeDataMatrix(n,4:11,8);
                    Sum=Sum1;
                end
            end
        end
        if SpikeDataMatrix(n,3,1)>=7 || SpikeDataMatrix(n,3,1)<=14%complex
            SpikeDayMatrix(Line,4)=SpikeDataMatrix(n,2,1);%task#
        end
    else
        Day=SpikeDataMatrix(n,1,1);
        Line=Line+1;
        Sum=0;
        SumBgra=0;
        Sum98=0;
        SpikeDayMatrix(Line,1)=Day;
        SpikeDataMatrix(n,3,1)
        if SpikeDataMatrix(n,3,1)==6%Bgra
            Sum1=sum(SpikeDataMatrix(n,4:11,3));
            if Sum1>=SumBgra
                SumBgra=Sum1;
                SpikeDayMatrix(Line,2)=SpikeDataMatrix(n,2,1);%task#
                SpikeDayMatrix(Line,2)
                if Sum1>=Sum%SpikeDayMatrix(Line,2)==0
    %                 SpikeDayMatrix(Line,2)=SpikeDataMatrix(n,1,1);%task#
                    SpikeDayMatrix(Line,5:12)=SpikeDataMatrix(n,4:11,7);
                    Sum=Sum1;
%                 else
%                     Sum=Sum1;
                end
            end
        end
        if SpikeDataMatrix(n,3,1)==3 || SpikeDataMatrix(n,3,1)==4%89or98
            Sum1=sum(SpikeDataMatrix(n,4:11,3));
            if Sum1>=Sum98
                Sum98=Sum1;
                SpikeDayMatrix(Line,3)=SpikeDataMatrix(n,2,1);%task#
                if Sum1>=Sum%SpikeDayMatrix(Line,2)==0
    %                 SpikeDayMatrix(Line,3)=SpikeDataMatrix(n,1,1);%task#
                    SpikeDayMatrix(Line,5:12)=SpikeDataMatrix(n,4:11,7);
                    Sum=Sum1;
                end
            end
        end
        if SpikeDataMatrix(n,3,1)>=7 || SpikeDataMatrix(n,3,1)<=14%complex
            SpikeDayMatrix(Line,4)=SpikeDataMatrix(n,2,1);%task#
        end
    end
end
SpikeDayMatrix(Line+1:300,:)=[];
SpikeDayMatrix

%6は全部残す
%

%Tetrodeごとにわける

% S4=AllSpikeData(:,4);
% for n=1:max(AllSpikeData(:,4))
% %     eval(['Spike',int2str(n),'=[];']);
%     idx=find(S4==n);
%     SpikeData{n}=AllSpikeData(idx,:);
% %     eval(['SpikeData',int2str(n),'=AllSpikeData(idx,:);']);
% end
% SpikeData
% a=SpikeData{1}
% b=SpikeData{2}

