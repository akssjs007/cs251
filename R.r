####################################################################################
#     Author	 : Ankit Kumar Singh
#     Roll No.   : 160122
#     Assign #	 : 10
####################################################################################
#	                              	STEP 1
####################################################################################
#define the length of the vector
num_vector <- 50000
num_Part <- 100
#create the vector
lambda <- 0.2
data <- rexp(num_vector,lambda)
#prepare the plot data
plt_data <- data.frame(X=seq(1,num_vector,1),sort(data))
#plot the plt_data
plot(plt_data,main="Scatter Plot(of Sorted Data)",xlab="x")
plot(data,main="Scatter PLot",xlab="x")
#sort the random vector
#data <- sort(data)
####################################################################################
#	                              	STEP 2
####################################################################################
#function to partition the data
partitioned<- function(data,num_Part){
	starts = seq(1,length(data),by=num_Part)
	ends = starts +num_Part -1
	ends[ends > length(data)] = length(data)
	lapply(1:length(starts),function(i) data[starts[i]:ends[i]])
}
#Now partition the data with the function created.
Y <- partitioned(data,num_Part)

####################################################################################
#	                              	STEP 3
####################################################################################
for(j in 1:5){
  pdata = rep(0,100)
  D <- Y[[j]]
  for(i in 1:length(D)){
    val=round(D[i], 0)
    #index begins with 1
    pdata[(val+1)] = pdata[(val+1)] + 1/num_Part
   
  }
  title= paste("Y",j)
  xcols =  0:99
  plot(xcols, pdata, "p", main=paste("PDF of",title),xlab="X", ylab="f(X)")
  cdata <- rep(0, 100)
  cdata[1] <- pdata[1]
  for(i in 2:100){
    cdata[i] = cdata[i-1] + pdata[i]
  }
  plot(xcols[1:50], cdata[1:50], "s", main=paste("CDF of",title),col="blue", xlab="X", ylab="F(X)")
}
##Calculate the Mean and S.D.
Mean <- rep(0,length(Y))
SD <- rep(0,length(Y))
for(i in 1:length(Y)){
  Mean[i] = mean(Y[[i]])
  SD[i] =  sd(Y[[i]])
}
cat ("Yis\tMean\tS.D.\n")
cat ("Y1", Mean[1],SD[1],"\n")
cat ("Y2", Mean[2],SD[2],"\n")
cat ("Y3", Mean[3],SD[3],"\n")
cat ("Y4", Mean[4],SD[4],"\n")
cat ("Y5", Mean[5],SD[5],"\n")
####################################################################################
#                                      STEP 4
####################################################################################
Z <- rep(0,length(Y))
for(i in 1:length(Y)){
  Z[i]=Mean[i]
}

tbl <- table(round(Z))
plot(tbl, "h", main="Frequency Plot for Z",xlab="Value", ylab="Frequency")
len_Z <- length(Z)
pdata <- rep(0,len_Z)
for(i in 1:len_Z){
  val=round(Z[i], 0)
  if(val < len_Z){
    #index begins with 1
    pdata[val+1] = pdata[val+1] + 1/ len_Z
  }
}

xcols <- c(0:(len_Z-1))
plot(xcols, pdata,main="PDF for Z", "p", xlab="X", ylab="f(X)")
cdata <- rep(0,len_Z)
cdata[1] <- pdata[1]
for(i in 2:len_Z){
  cdata[i] = cdata[i-1] + pdata[i]
}
plot(xcols, cdata,main="CDF for Z", "s", col="red", xlab="X", ylab="F(X)")
###################################################################################
#                                    STEP 5
###################################################################################
mean_Z = mean(Z)
sd_Z = sd(Z)
cat("\tZ\tmean =",mean_Z,"\t s.d.=",sd_Z,"\n")
###################################################################################
#                                     STEP 6
###################################################################################
cat("Original:\tmean =",mean(data),"\t s.d.=",sd(data),"\n")
####################################################################################
#                                     END
####################################################################################

