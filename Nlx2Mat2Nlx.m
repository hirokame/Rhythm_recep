function Nlx2Mat2Nlx
%tetrode�̖{���Ɠ����������t�H���_�������ׂċL��
%�u�ŏ��̃t�H���_+�}�E�X���{join�v�Ƃ����t�H���_���쐬����e�g���[�h���Ƃɓ������ꂽntt�t�@�C����
%Event.mat���ۑ������B
clear all;
CoreFolder='C:\Users\B133_2\Desktop\CheetahData';

NumTetrode=8;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Folder{1}=[CoreFolder '\' '2016-9-15_16-29-21 8701'];
% Folder{2}=[CoreFolder '\' '2016-9-15_17-45-23 8711'];
% Folder{3}=[CoreFolder '\' '2016-9-15_19-3-16 8721'];
% Folder{4}=[CoreFolder '\' '2016-9-15_20-3-8 8731'];


Folder{1}=[CoreFolder '\' '2018-1-15_15-54-39 4301'];
Folder{2}=[CoreFolder '\' '2018-1-15_17-38-9 4302'];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

NewFolder=Folder{1};
NewFolder=[NewFolder(1,1:end-2) 'join'];
cd(CoreFolder);
mkdir(NewFolder);
TimeStampsEv=[];
Event=[];
for m=1:NumTetrode
    
    TimestampsSp=[];%1000000000*(n-1)+Timestamps;
    ScNumbersSp=[];
    CellNumbersSp=[];
    FeaturesSp=[];
    SamplesSp=[];
    for n=1:length(Folder)
        cd(Folder{n});
        
        if m==1
            eval(['fnameEV=','''',Folder{n},'\Events.Nev''']);
            [TimeStampsE EventStrings Evt]=readEvents(fnameEV);
            TimeStampsEv=[TimeStampsEv 1000000000*(n-1)+TimeStampsE];
            Event=[Event; Evt];
        end
    
        Ch1=[Folder{n} '\Sc' int2str(m) '.ntt'];

        % [Timestamps, ScNumbers, CellNumbers, Features, Samples, Header] = Nlx2MatSpike('C:\Users\kit\Desktop\CheetahData\2016-3-3_17-14-24 6701-21\Sc2.ntt', [1 1 1 1 1], 1, 1, [] );
        [Timestamps, ScNumbers, CellNumbers, Features, Samples, Header] = Nlx2MatSpike(Ch1, [1 1 1 1 1], 1, 1, [] );
        TimestampsSp=[TimestampsSp 1000000000*(n-1)+Timestamps];
        
        SamplesSp(:,:,length(ScNumbersSp)+1:length(TimestampsSp))=Samples;
        
        ScNumbersSp=[ScNumbersSp ScNumbers];
        CellNumbersSp=[CellNumbersSp CellNumbers];
        FeaturesSp=[FeaturesSp Features];      

    end
    Timestamps=TimestampsSp;ScNumbers=ScNumbersSp;CellNumbers=CellNumbersSp;Features=FeaturesSp;Samples=SamplesSp;
    cd(NewFolder);
    Mat2NlxSpike([NewFolder '\Sc' int2str(m) '.ntt'], 0, 1, [], [1 1 1 1 1], Timestamps, ScNumbers, CellNumbers, Features, Samples, Header);
    
end
save Event.mat TimeStampsEv Event;% Event file �̕ۑ�
cd('C:\Users\B133_2\Desktop\CheetahData');


function [TimeStamps EventStrings Evt]=readEvents(fnameEV)

[TimeStamps, EventStrings] = Nlx2MatEV(fnameEV,[1, 0, 0, 0, 1], 0, 1);

EventStrings1 = EventStrings;
CharStrings = char(EventStrings1);

putativedigits = CharStrings(:, end-3:end);

% firstdigits = hex2dec(putativedigits(:, 1));
% nosync = find(firstdigits < 8);

disp('Converting event IDs to binary form.');
Evt = dec2bin(hex2dec(putativedigits));