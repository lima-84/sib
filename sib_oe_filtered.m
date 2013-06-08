function [theta,estavel]=sib_oe_filtered(u,y,na,nb,nz);
%

FF=[.1 .2 .3 .4 .5 .6 .7 .8 .9];

[thetai] = sib_arx(u,y,na,nb,nz);

theta=thetai;


for i=1:length(FF)

    %Filter the data
    [fb,fa] = butter(1,FF(i));
    yf=filter(fb,fa,y);
    uf=filter(fb,fa,u);  

    %Estimate with filtered data

    [theta2] = sib_oe_gradient(uf,yf,theta,nz,nb) ;
    [thetaf,J] = sib_oe_hessian(uf,yf,theta2,2000,nz,nb);


    %Test if the model is stable
    if isnan(thetaf(1))
        theta=thetai;
        estavel(i)=1;
        
    elseif max(abs(roots([1;thetaf(3:4)])))>1
        theta=thetai;
        estavel(i)=1;
    else
        theta=thetaf;
        estavel(i)=0;
    end    
    
end


%Estimate with real data
[thetaf] = sib_oe_gradient(u,y,theta,nz,nb) ;
[theta,J] = sib_oe_hessian(u,y,thetaf,2000,nz,nb);



