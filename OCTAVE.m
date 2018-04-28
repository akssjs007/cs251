
train_data=csvread('train.csv');
if(train_data(1,1)==0)
  train_data = dlmread('train.csv',',',0,0);
 endif
X_train = train_data(:,1);
Y_train = train_data(:,2);
len_Xtrain = size(X_train,1);
##### Step 1
X_t= [ones(len_Xtrain,1) X_train];
##### Step 2
w = rand(2,1);
#w = [1,1]'
#   Step 3 TODO: legends and data scatter plot
figure(1);
hold on
xlabel ("Feature");
ylabel ("Label");
title ("Feature-Label(Step-3)");
h=legend("location","northwestoutside");
plot(X_train,Y_train,"o;Scatter plot;");
plot(X_train,X_t*w,'o-r ;Line with w;');
#print -dpng "step3.png";
legend(h,"location","northwest");
print -dpng "step3.png";
hold off
#Step 4
inv_X_T = inv(X_t'*X_t);
XxY = X_t'*Y_train;
w_direct = inv_X_T*(XxY);
#######
figure(2);
hold on
xlabel ("Feature");
ylabel ("Label");
title ("Feature-Label(Step-4) Best Fit Line");
plot(X_train,Y_train,'o;Scatter Plot;');
plot(X_train,X_t*w_direct,'o-k;With W-Direct;');
legend(h,"location","northwest");
print -dpng "step4.png";
hold off
##########
figure(3);
#STEP 5
eta = 0.00000001;
N   =  2;
%hold off;
hold on
xlabel ("Feature");
ylabel ("Label");
title ("Feature-Label(Step-5) Regression Line");
for i = 1:N
  ########
  for j = 1:len_Xtrain
    tmp= train_data(j,:);
    y = Y_train(j);
    xt = X_t(j,:)';
    w  = w  - eta*(w'*xt-y)*xt;
    if(mod(j,100) == 0)
      #PLot the data
       plot(X_train,X_t*w,'-'); 
    endif
  endfor
endfor
print -dpng "step5.png";
hold off
##########
#Step  6
#hold on;
figure(4);
hold on;
xlabel ("Feature");
ylabel ("Label");
title ("Feature-Label(Step-6) Final Approx. Fit Line");
plot(X_train,X_t*w,'b-');
print -dpng "step6.png";

#plot(X_t,X_t*w_direct,'o-k');
#hold off;
##########
#step 7
test_data=csvread('test.csv');
if(test_data(1,1)==0)
  test_data = dlmread('test.csv',',',0,0);
endif
#test_data=dlmread('test.csv','',1,0);
x_test= test_data(:,1);
y_test = test_data(:,2);
len_test = size(x_test,1);
x_t = [ones(len_test,1) x_test];
y_pred1=x_t*w;
y_pred2 = x_t*w_direct;
sum1=0;
sum2=0;
for i = 1:len_test
  t1=y_pred1(i)-y_test(i);
  t2=y_pred2(i)-y_test(i);
  sum1 = sum1+t1*t1;
  sum2 = sum2+t2*t2;
endfor
sum1= sum1/len_test;
sum2= sum2/len_test;
rms1=sqrt(sum1);
rms2=sqrt(sum2);
op1 =sprintf("        Rmse with w: %f",rms1);
op2= sprintf("Rmse with  w_direct: %f",rms2);
disp(op1);
disp(op2);

;
