close all;
fname1={'ReadingIMP'};
fname2={'ReadingIMPC'};
fname3={'indexlist'};
fname4={'indexlistC'};


[I5,I10,I20,I50,ii]=extract_data(fname1{1,1},fname3{1,1});

[I5c,I10c,I20c,I50c,iic]=extract_data(fname2{1,1},fname4{1,1});

% Calculate baseline mean
I5base=mean(I5(1:ii(2,2)-ii(1,2)));
I5cbase=mean(I5c(1:iic(2,2)-iic(1,2)));

I10base=mean(I10(1:ii(2,2)-ii(1,2)));
I10cbase=mean(I10c(1:iic(2,2)-iic(1,2)));

I20base=mean(I20(1:ii(2,2)-ii(1,2)));
I20cbase=mean(I20c(1:iic(2,2)-iic(1,2)));

I50base=mean(I50(1:ii(2,2)-ii(1,2)));
I50cbase=mean(I50c(1:iic(2,2)-iic(1,2)));

%Remove baseline mean and detrend
I5=detrend(I5-I5base);
I5c=detrend(I5c-I5cbase);

I10=detrend(I10-I10base);
I10c=detrend(I10c-I10cbase);

I20=detrend(I20-I20base);
I20c=detrend(I20c-I20cbase);

I50=detrend(I50-I50base);
I50c=detrend(I50c-I50cbase);

%Sampling frequency
Fsi=size(I5,1)/(13*60);
Fsic=size(I5c,1)/(13*60);

%Time axis
XI=(1:1:size(I5,1))./(Fsi*60);
XIc=(1:1:size(I5c,1))./(Fsic*60);

figure; hold on;
plot(XI,I50)
plot(XIc,I50c)


%% Control arm
i5cocc=I5c(iic(2,2)-iic(1,2):iic(3,2)-iic(1,2));
i5ccuff=I5c(iic(3,2)-iic(1,2):iic(3,2)-iic(1,2)+round(Fsic*120));

i10cocc=I10c(iic(2,2)-iic(1,2):iic(3,2)-iic(1,2));
i10ccuff=I10c(iic(3,2)-iic(1,2):iic(3,2)-iic(1,2)+round(Fsic*120));

i20cocc=I20c(iic(2,2)-iic(1,2):iic(3,2)-iic(1,2));
i20ccuff=I20c(iic(3,2)-iic(1,2):iic(3,2)-iic(1,2)+round(Fsic*120));

i50cocc=I50c(iic(2,2)-iic(1,2):iic(3,2)-iic(1,2));
i50ccuff=I50c(iic(3,2)-iic(1,2):iic(3,2)-iic(1,2)+round(Fsic*120));


Xicocc=XIc(iic(2,2)-iic(1,2):iic(3,2)-iic(1,2));
Xiccuff=XIc(iic(3,2)-iic(1,2):iic(3,2)-iic(1,2)+round(Fsic*120));

i5pfitcocc=polyfit(Xicocc',i5cocc,1);
i5pfitccuff=polyfit(Xiccuff',i5ccuff,1);

i5pvalcocc=polyval(i5pfitcocc,Xicocc);
i5pvalccuff=polyval(i5pfitccuff,Xiccuff);

i10pfitcocc=polyfit(Xicocc',i10cocc,1);
i10pfitccuff=polyfit(Xiccuff',i10ccuff,1);

i10pvalcocc=polyval(i10pfitcocc,Xicocc);
i10pvalccuff=polyval(i10pfitccuff,Xiccuff);

i20pfitcocc=polyfit(Xicocc',i20cocc,1);
i20pfitccuff=polyfit(Xiccuff',i20ccuff,1);

i20pvalcocc=polyval(i20pfitcocc,Xicocc);
i20pvalccuff=polyval(i20pfitccuff,Xiccuff);

i50pfitcocc=polyfit(Xicocc',i50cocc,1);
i50pfitccuff=polyfit(Xiccuff',i50ccuff,1);

i50pvalcocc=polyval(i50pfitcocc,Xicocc);
i50pvalccuff=polyval(i50pfitccuff,Xiccuff);



%% Occluded arm
i5occ=I5(ii(2,2)-ii(1,2):ii(3,2)-ii(1,2));
i5cuff=I5(ii(3,2)-ii(1,2):ii(3,2)-ii(1,2)+round(Fsi*120));

i10occ=I10(ii(2,2)-ii(1,2):ii(3,2)-ii(1,2));
i10cuff=I10(ii(3,2)-ii(1,2):ii(3,2)-ii(1,2)+round(Fsi*120));

i20occ=I20(ii(2,2)-ii(1,2):ii(3,2)-ii(1,2));
i20cuff=I20(ii(3,2)-ii(1,2):ii(3,2)-ii(1,2)+round(Fsi*120));

i50occ=I50(ii(2,2)-ii(1,2):ii(3,2)-ii(1,2));
i50cuff=I50(ii(3,2)-ii(1,2):ii(3,2)-ii(1,2)+round(Fsi*120));


Xiocc=XI(ii(2,2)-ii(1,2):ii(3,2)-ii(1,2));
Xicuff=XI(ii(3,2)-ii(1,2):ii(3,2)-ii(1,2)+round(Fsi*120));

i5pfitocc=polyfit(Xiocc',i5occ,1);
i5pfitcuff=polyfit(Xicuff',i5cuff,1);

i5pvalocc=polyval(i5pfitocc,Xiocc);
i5pvalcuff=polyval(i5pfitcuff,Xicuff);

i10pfitocc=polyfit(Xiocc',i10occ,1);
i10pfitcuff=polyfit(Xicuff',i10cuff,1);

i10pvalocc=polyval(i10pfitocc,Xiocc);
i10pvalcuff=polyval(i10pfitcuff,Xicuff);

i20pfitocc=polyfit(Xiocc',i20occ,1);
i20pfitcuff=polyfit(Xicuff',i20cuff,1);

i20pvalocc=polyval(i20pfitocc,Xiocc);
i20pvalcuff=polyval(i20pfitcuff,Xicuff);

i50pfitocc=polyfit(Xiocc',i50occ,1);
i50pfitcuff=polyfit(Xicuff',i50cuff,1);

i50pvalocc=polyval(i50pfitocc,Xiocc);
i50pvalcuff=polyval(i50pfitcuff,Xicuff);

%% Indices

I5rise=i5pfitocc(1,1);
I5fall=i5pfitcuff(1,1);
I5f_r=abs(I5fall/I5rise);
I5area=trapz(XI,I5)-min(I5)*13;

I10rise=i10pfitocc(1,1);
I10fall=i10pfitcuff(1,1);
I10f_r=abs(I10fall/I10rise);
I10area=trapz(XI,I10)-min(I10)*13;

I20rise=i20pfitocc(1,1);
I20fall=i20pfitcuff(1,1);
I20f_r=abs(I20fall/I20rise);
I20area=trapz(XI,I20)-min(I20)*13;

I50rise=i50pfitocc(1,1);
I50fall=i50pfitcuff(1,1);
I50f_r=abs(I50fall/I50rise);
I50area=trapz(XI,I50)-min(I50)*13;

% Iindex=[I5rise I5fall I5f_r I5area ;I10rise I10fall I10f_r I10area; ...
%     I20rise I20fall I20f_r I20area ;I50rise I50fall I50f_r I50area ];

Iindex=[I50rise I50fall I50f_r I50area ];

I5crise=i5pfitcocc(1,1);
I5fall=i5pfitccuff(1,1);
I5cf_r=abs(I5cfall/I5crise);
I5carea=trapz(XIc,I5c)-min(I5c)*13;

I10crise=i10pfitcocc(1,1);
I10cfall=i10pfitccuff(1,1);
I10cf_r=abs(I10cfall/I10crise);
I10carea=trapz(XIc,I10c)-min(I10c)*13;

I20crise=i20pfitcocc(1,1);
I20cfall=i20pfitccuff(1,1);
I20cf_r=abs(I20cfall/I20crise);
I20carea=trapz(XIc,I20c)-min(I20c)*13;

I50crise=i50pfitcocc(1,1);
I50cfall=i50pfitccuff(1,1);
I50cf_r=abs(I50cfall/I50crise);
I50carea=trapz(XIc,I50c)-min(I50c)*13;

% Icindex=[I5crise I5cfall I5cf_r I5carea ;I10crise I10cfall I10cf_r I10carea; ...
%     I20crise I20cfall I20cf_r I20carea ;I50crise I50cfall I50cf_r I50carea ];

Icindex=[I50crise I50cfall I50cf_r I50carea ];


figure; hold on;
plot(Xicocc,i50cocc)
plot(Xiccuff,i50ccuff)
plot(Xicocc,i50pvalcocc)
plot(Xiccuff,i50pvalccuff)

figure; hold on;
plot(Xiocc,i50occ)
plot(Xicuff,i50cuff)
plot(Xiocc,i50pvalocc)
plot(Xicuff,i50pvalcuff)


%% functions

function [i5,i10,i20,i50,ii]=extract_data(fn1,fn2)

  i5=csvread(strcat(fn1,'.csv'));  
  i10=smooth(medfilt1(i5(:,5),200,'truncate'),1);
  i20=smooth(medfilt1(i5(:,8),200,'truncate'),1);
  i50=smooth(medfilt1(i5(:,11),200,'truncate'),1);
  i5=smooth(medfilt1(i5(:,2),200,'truncate'),1);
  
  ii=csvread(strcat(fn2,'.csv')); 

  
  
   i5=i5(ii(1,2):end);
   i10=i10(ii(1,2):end);
   i20=i20(ii(1,2):end);
   i50=i50(ii(1,2):end);
   
end