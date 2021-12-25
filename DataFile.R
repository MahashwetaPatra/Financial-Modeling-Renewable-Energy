#
# NOTE: This is for calculating the time series of actual , forecast and mean of all scenarios
#
data <- read.csv("C:\\Users\\Mahashweta Patra\\Documents\\MikeLudkovski\\Aguayo_Wind.csv", header=TRUE, stringsAsFactors=FALSE)
Simulations <- unlist(data[3,3:26])
plot(Simulations, type = "l", col="red")
for (x in 4:1002) {
  Simulations <- unlist(data[x,3:26])
  points(Simulations, type = "l", col="yellow")
}
Actual <- unlist(data[1,3:26])
points(Actual, type = "l", col="green")
Forecast= unlist(data[2,3:26])
points(Forecast, type = "l", col="blue")
meanX <- mapply(mean,data[,c(-1,-2)])
points(meanX, type = "l", col="red")