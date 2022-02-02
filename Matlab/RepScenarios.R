#
# NOTE: This is for calculating the time series of actual , forecast and mean of all scenarios
#       Yellow shows simulations, blue actual, red mean, green forecast
#       Black shows the representative scenarios using K-means

date <-readline(prompt = "Enter date: ")
assetname<-readline(prompt = "Enter asset name: ")
asset<-readline(prompt = "Enter asset type: ")
assetpath <- paste("C:\\Users\\Mahashweta Patra\\Documents\\MikeLudkovski\\ORFEUS\\SimDat_",date,"\\", asset,"\\", assetname, sep = '')
df <-read.csv(assetpath, header=TRUE, stringsAsFactors=FALSE)
Simulations <- unlist(df[3,3:26])
plot(Simulations, type = "l", col="red", xlab = "Time",
     ylab = "Mw")
for (x in 4:1002) {
  Simulations <- unlist(df[x,3:26])
  points(Simulations, type = "l", col="yellow")
}
Actual <- unlist(df[1,3:26])
points(Actual, type = "l", col="green")
Forecast= unlist(df[2,3:26])
points(Forecast, type = "l", col="blue")
meanX <- mapply(mean,df[,c(-1,-2)])
points(meanX, type = "l", col="red")

set.seed(240)
clusters <- kmeans(df[,3:26], 25)
print(clusters)
km <- clusters$centers
for (x in 1:25) {
  Simulations <- unlist(km[x,1:24])
  points(Simulations, type = "l", col="black")
}
pZ <- prcomp(df[,3:26], tol = 0.1)
summary(pZ) # only ~14 PCs (out of 32)
PCs <- pZ$rotation
print(PCs[1:24,1])
