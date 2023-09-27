function SpikeDataAnalysis20180708
clear all;
close all;
% AllSpikeData����SpikeDataMatrix���쐬�A�����SpikeDayMatrix���쐬���āASpike�f�[�^�ꗗ���쐬�B�ǂ̓���Rec����͂���ׂ������l���邽�߁B

% SpikeDataMatrix//3�����A���ׂĂ�3�����ō�������t�A�^�X�N#
% 3������, 1.���זE��, 2.�����זE���i0.5�j,3.�E�������זE���A4.���������A5.�ǂ������̑������A6.4���~2�{�A7.2.5�{�A8.3�{

% SpikeDayMatrix//���t�ABgra�ۑ�ԍ��A89or89�ۑ�ԍ��AC�ۑ�ԍ��A�e�g���[�hx8�i>Ratio�ARcell���j

%�@AllSpikeData�̗�@���蓖��
% �P�D�}�E�X�A�^�X�N��
% �Q�DDate
% �R�DPegPattern
% �S�DTetrode#
% �T�D Hz�@Woff�̂Ƃ����܂�
% �U�D RtouchMaxMinRatio
% �V�D L
% �W�D MaxMinRatio
% �X�D AutoCorr��interval�iWon�̂݁j
% �P�O�D Rtouch�ACrossCorr��Interval
% �P�P�D Ltouch�ACrossCorr��Interval
% �P�Q�D SpikePerTouchWon
% �P�R�DSpikePerTouchWoff


cd('C:\Users\B133_2\Desktop\CheetahWRLV\119');
load AllSpikeData

% SpikeDataMatrix//3�����A���ׂĂ�3�����ō�������t�A�^�X�N#
% 3������, 1.���זE��, 2.�����זE���i0.5�j,3.�E�������זE���A4.���������A5.�ǂ������̑������A6.4���~2�{�A7.2.5�{�A8.3�{
%���זE��
%�����זE���@0.5Hz�ȏ�
%�E���^�b�`�����L���A4�{
%�����^�b�`�����L���A4�{
%���E�ǂ��炩�ł��^�b�`����
%�l���~Modulation�L���A2�{
%�l���~Modulation�L���A2.5�{
%�l���~Modulation�L���A3�{

% SpikeDayMatrix//���t�ABgra�ۑ�ԍ��A89or89�ۑ�ԍ��AC�ۑ�ԍ��A�e�g���[�hx8�i>Ratio�ARcell���j�ł�Rcell���i>x3�j
%Bgra���邢��89or98�ň��Rcell���������������^�X�N�ł̃e�g���[�h���Ƃ�Rcell����\��
%Bgra, 98or89, C+��3�킪�����Ă��邩�H

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
    SpikeDataMatrix(Line,3+AllSpikeData(n,4),1)=SpikeDataMatrix(Line,3+AllSpikeData(n,4),1)+1;%�S�זE��
    if AllSpikeData(n,5)>=0.5%0.5Hz�ȏ�̎��ɍזE�J�E���g
%         Line
        SpikeDataMatrix(Line,3+AllSpikeData(n,4),2)=SpikeDataMatrix(Line,3+AllSpikeData(n,4),2)+1;%�זE��
    
        if AllSpikeData(n,6)>=4%�E��
            SpikeDataMatrix(Line,3+AllSpikeData(n,4),3)=SpikeDataMatrix(Line,3+AllSpikeData(n,4),3)+1;
        end
        if AllSpikeData(n,7)>=4%����
            SpikeDataMatrix(Line,3+AllSpikeData(n,4),4)=SpikeDataMatrix(Line,3+AllSpikeData(n,4),4)+1;
        end
        if AllSpikeData(n,6)>=4 || AllSpikeData(n,7)>=4%�ǂ��炩�̑�
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

%�ǂ��������߂邽�߂ɁB
% SpikeDayMatrix//���t�ABgra�ۑ�ԍ��A89or89�ۑ�ԍ��AC�ۑ�ԍ��A�e�g���[�hx8�i>Ratio�ARcell���j�ł�Rcell���i>x3�j

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

%6�͑S���c��
%

%Tetrode���Ƃɂ킯��

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
