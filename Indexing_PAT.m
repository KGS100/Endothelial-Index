close all;
fname1={'ReadingPAT'};
fname2={'ReadingPATC'};
fname3={'indexlist'};
fname4={'indexlistC'};


[P,Pi]=extract_data(fname2{1,1},fname4{1,1});  
[Pc,Pci]=extract_data(fname1{1,1},fname3{1,1});  

% Calculate baseline mean
Pbase=mean(P(1:Pi(2,5)-Pi(1,5)));
Pcbase=mean(Pc(1:Pci(2,5)-Pci(1,5)));


%Remove baseline mean and detrend
P=detrend(P-Pbase);
Pc=detrend(Pc-Pcbase);


%Sampling frequency
Fsp=size(P,1)/(13*60);
Fspc=size(Pc,1)/(13*60);

%Time axis
XP=(1:1:size(P,1))./(Fsp*60);
XPc=(1:1:size(Pc,1))./(Fspc*60);



%% Control arm
cocc=Pc(Pci(2,5)-Pci(1,5):Pci(3,5)-Pci(1,5));
ccuff=Pc(Pci(3,5)-Pci(1,5):Pci(3,5)-Pci(1,5)+round(Fspc*120));

Xpcocc=XPc(Pci(2,5)-Pci(1,5):Pci(3,5)-Pci(1,5));
Xpccuff=XPc(Pci(3,5)-Pci(1,5):Pci(3,5)-Pci(1,5)+round(Fspc*120));

pfitcocc=polyfit(Xpcocc',cocc,1);
pfitccuff=polyfit(Xpccuff',ccuff,1);

pvalcocc=polyval(pfitcocc,Xpcocc);
pvalccuff=polyval(pfitccuff,Xpccuff);

%% Occluded arm
occ=P(Pi(2,5)-Pi(1,5):Pi(3,5)-Pi(1,5));
cuff=P(Pi(3,5)-Pi(1,5):Pi(3,5)-Pi(1,5)+round(Fsp*120));

Xpocc=XP(Pi(2,5)-Pi(1,5):Pi(3,5)-Pi(1,5));
Xpcuff=XP(Pi(3,5)-Pi(1,5):Pi(3,5)-Pi(1,5)+round(Fsp*120));

pfitocc=polyfit(Xpocc',occ,1);
pfitcuff=polyfit(Xpcuff',cuff,1);

pvalocc=polyval(pfitocc,Xpocc);
pvalcuff=polyval(pfitcuff,Xpcuff);


%% Indices

Pfall=pfitocc(1,1);
Prise=pfitcuff(1,1);
Pr_f=abs(Prise/Pfall);
Parea=trapz(XP,P)-min(P)*13;

Pindex=[Pfall Prise Pr_f Parea];


Pcrise=pfitcocc(1,1);
Pcfall=pfitccuff(1,1);
Pcr_f=abs(Pcrise/Pcfall);
Pcarea=trapz(XPc,Pc)-min(Pc)*13;

Pcindex=[Pcrise Pcfall Pcr_f Pcarea];


figure; hold on;
plot(Xpcocc,cocc)
plot(Xpccuff,ccuff)
plot(Xpcocc,pvalcocc)
plot(Xpccuff,pvalccuff)

figure; hold on;
plot(Xpocc,occ)
plot(Xpcuff,cuff)
plot(Xpocc,pvalocc)
plot(Xpcuff,pvalcuff)

figure; hold on;
plot(XP,P,'r','LineWidth',0.5)
plot(XPc,Pc,'b','LineWidth',0.5)
y=get(gca,'ylim');
% plot([0 0],y,'Color',([1 0.5 0]),'LineWidth',3)
plot([5 5],y,'Color',([1 0.5 0]),'LineWidth',3)
plot([8 8],y,'Color',([1 0.5 0]),'LineWidth',3)

set(gca,'Fontsize',20);
xlabel('Time (Minutes)');
ylabel('{Pressure (mmHg)}');
legend({'Occluded arm','Control arm'},'FontSize',30)
legend('boxoff')







function [pd,pi]=extract_data(fn1,fn2)

  pd=csvread(strcat(fn1,'.csv'));  
  pd=pd(:,2);
  
  pi=csvread(strcat(fn2,'.csv')); 
  time=pi(4,1);
  
  FsP=size(pd,1)/(time*60);
  [q,r] = butter(6,6.5/FsP,'low');
  
   pd=filter(q,r,pd);
  
  
   pd=medfilt1(pd(pi(1,5):end),1000,'truncate');
  
end


% Pb=P(1:Pi(2,5)-Pi(1,5));
% Pcb=Pc(1:Pci(2,5)-Pci(1,5));
% 
% Prest=detrend(P(Pi(2,5)-Pi(1,5)+1:end));
% Pcrest=detrend(Pc(Pci(2,5)-Pci(1,5)+1:end));
% 
% Prest=Prest-(Prest(2)-Pb(end));
% Pcrest=Pcrest-(Pcrest(2)-Pcb(end));
% 
% P=[Pb;Prest];
% Pc=[Pcb;Pcrest];

% 
% figure; hold on;
% plot(Pb)
% plot(Pcb)
% plot(detrend(Prest))
% plot(detrend(Pcrest))

%  plot(mean(P,2),'r')
%  plot(mean(Pc,2),'b')
%  plot(XP,detrend(mean(P,2)),'r','LineWidth',0.5)
%  plot(XPc,detrend(mean(Pc,2)),'b','LineWidth',0.5)

% plot([5 5],[-3 3],'Color',([1 0.5 0]),'LineWidth',3)
% plot([8 8],[-3 3],'Color',([1 0.5 0]),'LineWidth',3)