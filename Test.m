function Test
global h dpath dname

dpath=uigetdir;
cd(dpath);
h=ls;

for n=1:length(h(:,1))
    fname=strtrim(h(n,:));
        if ~isdir(fname(1,:)) && ~strcmp(fname,'.') && ~strcmp(fname,'..')
            if ~isdir(fname) && ~strcmp(fname,'.') && ~strcmp(fname,'..')
                if ~strcmp(fname(1,end-4),'V') && strcmp(fname(1,end-2:end),'mat')
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    fname
%                     data=load([dpath '\' fname],'-ascii');
                    data=load([dpath '\' fname]);

                    Time_WT=data.WalkTimeAll_Wild
                    Time_Mutant=data.WalkTimeAll_Mutant
                    
                    Time_WT_Fast3=sort(Time_WT,'acend');
                    
                 
                    
%                     LastPitch3=data.LastPitch123All(:,3);
%                     LastPitch3(LastPitch3==0)=[];
%                     SmallLP3=sort(LastPitch3,'ascend');
%                     MeanSmallLP3=[MeanSmallLP3 mean(SmallLP3(1:3))];
                    
                    
%                     if strcmp(fname(5),'_')  % file name 4桁 (5番目に_がある)→wt
%                         M_W=M_W+1;
%                         WalkTimeAll_Wild{M_W}=WaterApproach(data);
% 
%                     elseif strcmp(fname(6),'_')  % file name 5桁 →KD
%                         M_M=M_M+1;
%                         WalkTimeAll_Mutant{M_M}=WaterApproach(data);

                    end
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                end
            end
        end
end

% if strfind(fname,' ')>0
%     data=xlsread([dpath fname]);%'C:\Documents and Settings\kit\デスクトップ\WR LVdata\6 080811.xls');
% elseif strfind(fname,'_')>0
% %     data=load([dpath '\' fname],'-ascii');
%     data=load([dpath '\' fname]);
% %     [LastPitch123All OffDurationAll]=load([dpath '\' fname]);
% else
%     data=xlsread([dpath fname]);%'C:\Documents and Settings\kit\デスクトップ\WR LVdata\6 080811.xls');
% end
