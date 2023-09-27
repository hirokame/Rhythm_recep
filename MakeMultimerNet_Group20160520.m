function MakeMultimerNet_Group20160520

%MakeMultimerProb20160517.m(Exp=5�̏ꍇ�j
%MakeMultimerProb20160526.m�iExp=10�̏ꍇ�j
%�ɂ���v�����ƂɃt�@�C�����쐬
%�����p����MultimerConProbAll�t�@�C�����쐬����BMatching10����̌��������ۑ������B
%MakeMultimerNet_Group20160520.m�Ńl�b�g���[�N�쐬

%��`�q�����l���@1:�d���Ȃ��Amonoallele�A2:biallel�A�E�E�E�A-1:�d���L��

% load MultimerConProbAllM4_E5_R1_Match100000 NumConnAll NumConnSort CumSumProb
% load MultimerConProbAllM3_E5_R1_Match100000 NumConnAll NumConnSort CumSumProb
% load MultimerConProbAllM4_E10_R1_Match100000 NumConnAll NumConnSort CumSumProb
load MultimerConProbAllM3_E5_R1_Match100000 NumConnAll NumConnSort CumSumProb

Neurons=10000;
%MultimerConnProb�𗘗p����ꍇ�͕ύX�s��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Repeat=1;
Multimer=1;
Genes=50;
Exp=5;
Matching=1000;%���ʑ̔�r��
%MultimerConnProb�𗘗p����ꍇ�͕ύX�s��%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ExpMatrix=zeros(Neurons,Exp);
VarMatrix=zeros(Neurons,Genes);
CnxMatrix=zeros(Neurons,Neurons);
for m=1:Neurons
    GeneRepeat=ones(1,Genes).*Repeat;
    %Expression choose genes 
    ExpGene=zeros(1,Exp);
    for n=1:Exp
        N=ceil(rand*Genes);
        if Repeat==-1
            ExpGene(n)=N;
        elseif Repeat~=-1
            while GeneRepeat(N)==0
                N=ceil(rand*Genes);
            end
            ExpGene(n)=N;
            GeneRepeat(N)=GeneRepeat(N)-1;              
        end
    end
    ExpMatrix(m,:)=sort(ExpGene,'ascend');
    for n=1:Exp
        VarMatrix(m,ExpMatrix(m,n))=1;
    end
end
ExpMatrix
VarMatrix

MatchMatrix=zeros(Neurons,Neurons);
for n=1:Neurons
    n
%     Multimer1=[ExpMatrix(n,ceil(rand(1,Matching)*Exp));ExpMatrix(n,ceil(rand(1,Matching)*Exp));ExpMatrix(n,ceil(rand(1,Matching)*Exp));ExpMatrix(n,ceil(rand(1,Matching)*Exp))];
%     Multimer1=sort(Multimer1,1,'ascend');
    for m=1:Neurons
%         [n m]
        if n~=m
            V=VarMatrix(n,:)*VarMatrix(m,:)';
            MatchMatrix(n,m)=V;
            if V>0
    %             A=NumConnAll(V,:);
    %             B=sort(A,'Ascend');
    %             C=cumsum(B);
    %             D=C/max(C);
    %             CumSumProb(n,:)=D;

                R=rand;
    %             E=CumSumProb(CumSumProb<R);
    %             F=length(E);
%     a=length(CumSumProb(CumSumProb<R));
                CSP=CumSumProb(V,:);
                Num=length(CSP(CSP<R));
                if Num~=0
                    CnxMatrix(n,m)=NumConnSort(V,length(CSP(CSP<R)));
                else
                    CnxMatrix(n,m)=NumConnSort(V,1);
                end

    %             Multimer2=[ExpMatrix(m,ceil(rand(1,Matching)*Exp));ExpMatrix(m,ceil(rand(1,Matching)*Exp));ExpMatrix(m,ceil(rand(1,Matching)*Exp));ExpMatrix(m,ceil(rand(1,Matching)*Exp))];
    %             Multimer2=sort(Multimer2,1,'ascend');

    %             M1=Multimer1(:);
    %             M2=Multimer2(:);
    %             MM=M1-M2;
    %             Len0=length(MM(MM==0));
    %             MP1=Len0/(Matching*4);
    %             ProbMatrixMP4(n,m)=MP1^4*Matching;            

    %             Sum=sum(abs(Multimer1- Multimer2),1);
    %             Matrix(n,m)=length(Sum(Sum==0));
            end
        end
    end
end
% CnxMatrix=Matrix;
ProbMatrix=CnxMatrix/sum(sum(CnxMatrix));

SaveName=strcat('Group_CnxMatrix010_M',num2str(Multimer),'_N',num2str(Neurons),'_G',num2str(Genes),'_E',num2str(Exp),'_R',num2str(Repeat),'_Match',num2str(Matching));
save(SaveName,'ExpMatrix','ProbMatrix','CnxMatrix','VarMatrix','MatchMatrix');
