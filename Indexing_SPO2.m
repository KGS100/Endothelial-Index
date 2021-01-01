close all;
fname1={'ReadingSPO2'};
fname2={'ReadingSPO2C'};
fname3={'indexlist'};
fname4={'indexlistC'};


[sir,sr,Si]=extract_data(fname1{1,1},fname4{1,1});  

R=sir./sr;

SPO2= -16.666666*(R.^2)+8.333333*R+116;

SPO2_base=mean(SPO2(1:Si(2,3)-Si(1,3)));

SPO2=SPO2-SPO2_base;

[sirc,src,Sic]=extract_data(fname2{1,1},fname4{1,1});  

Rc=sirc./src;

SPO2c= -16.666666*(Rc.^2)+8.333333*Rc+126;

SPO2c_base=mean(SPO2c(1:Sic(2,3)-Sic(1,3)));

SPO2c=SPO2c-SPO2c_base;


Fss=size(SPO2,1)/(13*60);
Fssc=size(SPO2c,1)/(13*60);

%Time axis
XS=(1:1:size(SPO2,1))./(Fss*60);
XSc=(1:1:size(SPO2c,1))./(Fssc*60);


%% Control arm

cocc=SPO2c(Sic(2,3)-Sic(1,3):Sic(3,3)-Sic(1,3));
ccuff=SPO2c(Sic(3,3)-Sic(1,3):Sic(3,3)-Sic(1,3)+round(Fssc*30));

Xscocc=XSc(Sic(2,3)-Sic(1,3):Sic(3,3)-Sic(1,3));
Xsccuff=XSc(Sic(3,3)-Sic(1,3):Sic(3,3)-Sic(1,3)+round(Fssc*30));

pfitcocc=polyfit(Xscocc',cocc,1);
pfitccuff=polyfit(Xsccuff',ccuff,1);

pvalcocc=polyval(pfitcocc,Xscocc);
pvalccuff=polyval(pfitccuff,Xsccuff);




%% Occluded arm

occ=SPO2(Si(2,3)-Si(1,3):Si(3,3)-Si(1,3));
cuff=SPO2(Si(3,3)-Si(1,3):Si(3,3)-Si(1,3)+round(Fss*30));

Xsocc=XS(Si(2,3)-Si(1,3):Si(3,3)-Si(1,3));
Xscuff=XS(Si(3,3)-Si(1,3):Si(3,3)-Si(1,3)+round(Fss*30));

pfitocc=polyfit(Xsocc',occ,1);
pfitcuff=polyfit(Xscuff',cuff,1);

pvalocc=polyval(pfitocc,Xsocc);
pvalcuff=polyval(pfitcuff,Xscuff);

%% Indices

Sfall=pfitocc(1,1);
Srise=pfitcuff(1,1);
Sr_f=abs(Srise/Sfall);
Sarea=trapz(XS,SPO2)-min(SPO2)*13;

Sindex=[Sfall Srise Sr_f Sarea];


Scrise=pfitcocc(1,1);
Scfall=pfitccuff(1,1);
Scr_f=abs(Scrise/Scfall);
Scarea=trapz(XSc,SPO2c)-min(SPO2c)*13;

Scindex=[Scrise Scfall Scr_f Scarea];




figure; hold on;
plot(Xscocc,cocc)
plot(Xsccuff,ccuff)
plot(Xscocc,pvalcocc)
plot(Xsccuff,pvalccuff)

figure; hold on;
plot(Xsocc,occ)
plot(Xscuff,cuff)
plot(Xsocc,pvalocc)
plot(Xscuff,pvalcuff)


figure; hold on;
plot(XS,SPO2,'r')
plot(XSc,SPO2c,'b')
y=get(gca,'ylim');
% plot([0 0],y,'Color',([1 0.5 0]),'LineWidth',3)
plot([5 5],y,'Color',([1 0.5 0]),'LineWidth',3)
plot([8 8],y,'Color',([1 0.5 0]),'LineWidth',3)
set(gca,'Fontsize',20);
xlabel('Time (Minutes)');
ylabel('{SPO_2 variation (%)}');
legend({'Occluded arm','Control arm'},'FontSize',30)
legend('boxoff')


function [sir,sr,si]=extract_data(fn1,fn2)

  sir=csvread(strcat(fn1,'.csv'));  
  sr=sir(:,3);
  sir=sir(:,2);
  
  si=csvread(strcat(fn2,'.csv')); 
%   time=si(4,1);
  
%   FsS=size(sd,1)/(time*60);
%   [q,r] = butter(6,6.5/FsP,'low');
  
%    pd=filter(q,r,pd);
  
  
   sir=sir(si(1,3):end);
   sr=sr(si(1,3):end);
   
end