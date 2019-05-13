clc
u=(randn(1000,1));
polos=[0.9 0.8 0.7];

yi=filter([0 prod(1-polos)],poly(polos),u);

T=[];
for i=1:1

vi=randn(1000,1)*0.000001;
y=yi+vi;

tic()
[t] = sib_oe(u,y,3,1,1) 
toc()
T=[T t];

end

figure(2)
plot(T(1,:),T(2,:),'o')
figure(3)
plot(T(3,:),T(4,:),'o')


figure(1)
Q=2
G=tf(T(1:2,Q)',[1 T(3:5,Q)'],1);
step(G);
hold on
G1=tf(T(1:2,1)',[1 T(3:5,1)'],1);
step(G1);
hold off