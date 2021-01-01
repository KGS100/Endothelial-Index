close all;
fname1={'ReadingTemp'};
fname2={'ReadingTempC'};
fname3={'indexlist'};
fname4={'indexlistC'};


[T,ti]=extract_data2(fname2{1,1},fname4{1,1});  

[Tc,tic]=extract_data(fname1{1,1},fname3{1,1});  

T=detrend(T);
Tc=detrend(Tc);

%Sampling frequency
Fst=size(T,1)/(13*60);
Fstc=size(Tc,1)/(13*60);

%Time axis
XT=(1:1:size(T,1))./(Fst*60);
XTc=(1:1:size(Tc,1))./(Fstc*60);

figure; hold on;
%  plot(mean(P,2),'r')
%  plot(mean(Pc,2),'b')
plot(XTc,smooth(Tc,501),'r','LineWidth',2)
plot(XT,smooth(T,501),'b','LineWidth',2)
y=get(gca,'ylim');
% plot([0 0],y,'Color',([1 0.5 0]),'LineWidth',3)
plot([5 5],y,'Color',([1 0.5 0]),'LineWidth',3)
plot([8 8],y,'Color',([1 0.5 0]),'LineWidth',3)
set(gca,'Fontsize',20);
xlabel('Time (Minutes)');
ylabel('{Relative Temperature (^oC)}');
legend({'Occluded arm','Control arm'},'FontSize',30)
legend('boxoff')

%% Control arm
cocc=T(ti(2,4)-ti(1,4):ti(3,4)-ti(1,4));
ccuff=T(ti(3,4)-ti(1,4):ti(3,4)-ti(1,4)+round(Fst*120));

Xtcocc=XT(ti(2,4)-ti(1,4):ti(3,4)-ti(1,4));
Xtccuff=XT(ti(3,4)-ti(1,4):ti(3,4)-ti(1,4)+round(Fst*120));

pfitcocc=polyfit(Xtcocc',cocc,1);
pfitccuff=polyfit(Xtccuff',ccuff,1);

pvalcocc=polyval(pfitcocc,Xtcocc);
pvalccuff=polyval(pfitccuff,Xtccuff);

%% Occluded arm
occ=Tc(tic(2,4)-tic(1,4):tic(3,4)-tic(1,4));
cuff=Tc(tic(3,4)-tic(1,4):tic(3,4)-tic(1,4)+round(Fstc*120));

Xtocc=XTc(tic(2,4)-tic(1,4):tic(3,4)-tic(1,4));
Xtcuff=XTc(tic(3,4)-tic(1,4):tic(3,4)-tic(1,4)+round(Fstc*120));

pfitocc=polyfit(Xtocc',occ,1);
pfitcuff=polyfit(Xtcuff',cuff,1);

pvalocc=polyval(pfitocc,Xtocc);
pvalcuff=polyval(pfitcuff,Xtcuff);

%% Indices

Tfall=pfitocc(1,1);
Trise=pfitcuff(1,1);
Tr_f=abs(Trise/Tfall);
Tarea=trapz(XTc,Tc)-min(Tc)*13;

Tindex=[Tfall Trise Tr_f Tarea];


Tcrise=pfitcocc(1,1);
Tcfall=pfitccuff(1,1);
Tcr_f=abs(Tcrise/Tcfall);
Tcarea=trapz(XT,T)-min(T)*13;

Tcindex=[Tcrise Tcfall Tcr_f Tcarea];


figure; hold on;
plot(Xtcocc,cocc)
plot(Xtccuff,ccuff)
plot(Xtcocc,pvalcocc)
plot(Xtccuff,pvalccuff)

figure; hold on;
plot(Xtocc,occ)
plot(Xtcuff,cuff)
plot(Xtocc,pvalocc)
plot(Xtcuff,pvalcuff)


function [td,ti]=extract_data(fn1,fn2)

  td=csvread(strcat(fn1,'.csv'));  
  td=td(:,2)-td(:,3);
  
  ti=csvread(strcat(fn2,'.csv')); 

  
  
   td=smooth(td(ti(1,4):end)-mean(td(ti(1,4):ti(2,4)-ti(1,4))),51);
  
end

function [td,ti]=extract_data2(fn1,fn2)

  td=csvread(strcat(fn1,'.csv'));  
  td=td(:,3)-td(:,2);
  
  ti=csvread(strcat(fn2,'.csv')); 

  
  
   td=smooth(td(ti(1,4):end)-mean(td(ti(1,4):ti(2,4)-ti(1,4))),51);
  
end