##################################################################################
#### Parable of Google Flu
#### Code Author: Ryan Kennedy
#### Section: SOM Section 8 -- Neural Network Predictions Using Google Flu and CDC Data
#### Last Modified: February 21, 2014
##################################################################################

# Clean Workspace
rm(list = ls(all = TRUE))

# Load Required Libraries
library(foreign)
library(nnet)

# Set Working Directory
setwd("C:/Users/Ryan/Documents/Data/Google Flu")
# Load Flu Data (Note, data must be saved in Stata 2012 or .csv format first)
fludata <- read.csv("ParableOfGFT(Replication).csv")
# Divide data into pre-September 2009 (In-Sample) and post-September 2009 (Out-Of-Sample)
isflu <- fludata[1:311,]
osflu <- fludata[312:519,]

## First, test it in-sample (prior to Sept. 6, 2009)
## Equation 7 without Seasonality
# Remove missing data for In-Sample Data
isflu1 <- na.omit(subset(isflu, select=c("cflu", "gflu", "lcflu", "dif_2")))
# Leave-One-Out Cross Validation with 1 to 15 hidden nodes.
results <- c()
bsizelist <- c()
merrorlist <- c()
k <- 1
while(k < 50){
  iteration <- c()
  estmae <- c()
  bestsize <- 1
  minerror <- 1000
  for(j in 1:15){
    errvec <- c()
    for(i in 1:nrow(isflu1)){
      nnettemp <- nnet(cflu~., data=isflu1[-i,], size=j, linout=TRUE, maxNWts=10000,
                       trace=FALSE, maxit=100)
      pred <- predict(nnettemp, newdata=isflu1[i,])
      error <- pred-isflu1$cflu[i]
      errvec <- c(errvec, error)
    }
    mae = sum(abs(errvec))/length(errvec)
    iteration <- c(iteration, j)
    estmae <- c(estmae, mae)
    resulting <- cbind(iteration,estmae,k)
    if(mae < minerror){
      minerror <- mae
      bestsize <- j
    }
    print(j)
  }
  results <- rbind(results,resulting)
  bsizelist <- c(bsizelist, bestsize)
  merrorlist <- c(merrorlist, minerror)
  k <- k+1
  print(k)
}
results <- as.data.frame(results)
write.csv(results, "nnetSEq.csv")
plot(0, -20, xlim = range(resEq8b$iteration), ylim=range(resEq8b$estmae), xlab="Number of Hidden Nodes", ylab="Mean Absolute Error", main="Leave-One-Out Cross-Validation: Model 1", cex.lab=1.5)
for(j in 1:50) {
	lines(resEq8b$iteration[which(resEq8b$k==j)], resEq8b$estmae[which(resEq8b$k==j)], lwd=.5, col=rgb(0,0,0,0.4))
  }
## 10 hidden units appears best from the cross validation above
## Using nnet package, run step forward predictions like in manuscript
fludata1 <- na.omit(subset(fludata, select=c("cflu", "gflu", "lcflu", "dif_2")))
mvec <- c()
j <- 1
while(j < 50) {
	predvec <- c()
	errvec <- c()
	for(i in 310:nrow(fludata1)){
		nnetis <- nnet(cflu~., data=fludata1[1:i-1,], size=10, linout=TRUE,MaxNWts=10000,
						trace=FALSE, maxit=100)
		pred <- predict(nnetis, fludata1[i,])
		predvec <- c(predvec, pred)
		error <- pred-fludata1$cflu[i]
		errvec <- c(errvec,error)
	}
	mae = sum(abs(errvec))/length(errvec)
	mvec <- c(mvec, mae)
	j <- j+1
	print(j)
}
write.csv(mvec, "nnresultEq8.csv")
mean(mvec)
range(mvec)
resEq8b <- results
mvecEq8b <- mvec
plot(predvec, fludata2$cflu[310:nrow(fludata2)])


## Leave-one-out cross validation (prior to Sept. 6, 2009)
## Equation 8 -- adding seasonality
isflu2 <- na.omit(subset(isflu, select=c("cflu", "gflu", "lcflu", "dif_2", "week")))
isflu2$week <- as.factor(isflu2$week)

results <- c()
bsizelist <- c()
merrorlist <- c()
k <- 1
while(k < 50){
  iteration <- c()
  estmae <- c()
  bestsize <- 1
  minerror <- 1000
  for(j in 1:10){
    errvec <- c()
    for(i in 1:nrow(isflu2)){
      nnettemp <- nnet(cflu~., data=isflu2[-i,], size=j, linout=TRUE, maxNWts=10000,
                       trace=FALSE, maxit=100)
      pred <- predict(nnettemp, newdata=isflu2[i,])
      error <- pred-isflu2$cflu[i]
      errvec <- c(errvec, error)
    }
    mae = sum(abs(errvec))/length(errvec)
    iteration <- c(iteration, j)
    estmae <- c(estmae, mae)
    resulting <- cbind(iteration,estmae,k)
    if(mae < minerror){
      minerror <- mae
      bestsize <- j
    }
    print(j)
  }
  results <- rbind(results,resulting)
  bsizelist <- c(bsizelist, bestsize)
  merrorlist <- c(merrorlist, minerror)
  k <- k+1
  print(k)
}
results <- as.data.frame(results)
write.csv(results, "nnetEq8.csv")
plot(0, -20, xlim = range(resEq8$iteration), ylim=range(resEq8$estmae), xlab="Number of Hidden Nodes", ylab="Mean Absolute Error", main="Leave-One-Out Cross-Validation: Model 2", cex.lab=1.5)
for(j in 1:50) {
	lines(resEq8$iteration[which(resEq8$k==j)], resEq8$estmae[which(resEq8$k==j)], lwd=.5, col=rgb(0,0,0,0.4))
  }
## 5 hidden units appears best from the cross-validation above
## Using nnet package, run step forward predictions like in manuscript
fludata2 <- na.omit(subset(fludata, select=c("cflu", "gflu", "lcflu", "dif_2", "week")))
mvec <- c()
j <- 1
while(j < 50) {
	predvec <- c()
	errvec <- c()
	for(i in 310:nrow(fludata2)){
		nnetis <- nnet(cflu~., data=fludata2[1:i-1,], size=5, linout=TRUE,MaxNWts=10000,
						trace=FALSE, maxit=100)
		pred <- predict(nnetis, fludata2[i,])
		predvec <- c(predvec, pred)
		error <- pred-fludata2$cflu[i]
		errvec <- c(errvec,error)
	}
	mae = sum(abs(errvec))/length(errvec)
	mvec <- c(mvec, mae)
	j <- j+1
	print(j)
}
write.csv(mvec, "nnresultEq8.csv")
mean(mvecEq8)
range(mvecEq8)
resEq8 <- results
mvecEq8 <- mvec
plot(predvec, fludata2$cflu[310:nrow(fludata2)])

## First, test it in-sample (prior to Sept. 6, 2009)
## Equation 9
isflu3 <- na.omit(subset(isflu, select=c("cflu", "gflu", "lcflu", "dif_2", "dif_3", "week")))
isflu3$week <- as.factor(isflu3$week)

results <- c()
bsizelist <- c()
merrorlist <- c()
k <- 1
while(k < 50){
  iteration <- c()
  estmae <- c()
  bestsize <- 1
  minerror <- 1000
  for(j in 1:10){
    errvec <- c()
    for(i in 1:nrow(isflu3)){
      nnettemp <- nnet(cflu~., data=isflu3[-i,], size=j, linout=TRUE, maxNWts=10000,
                       trace=FALSE, maxit=100)
      pred <- predict(nnettemp, newdata=isflu3[i,])
      error <- pred-isflu3$cflu[i]
      errvec <- c(errvec, error)
    }
    mae = sum(abs(errvec))/length(errvec)
    iteration <- c(iteration, j)
    estmae <- c(estmae, mae)
    resulting <- cbind(iteration,estmae,k)
    if(mae < minerror){
      minerror <- mae
      bestsize <- j
    }
    print(j)
  }
  results <- rbind(results,resulting)
  bsizelist <- c(bsizelist, bestsize)
  merrorlist <- c(merrorlist, minerror)
  k <- k+1
  print(k)
}
results <- as.data.frame(results)
write.csv(results, "nnetEq9.csv")
plot(0, -20, xlim = range(resEq9$iteration), ylim=range(resEq9$estmae), xlab="Number of Hidden Nodes", ylab="Mean Absolute Error", main="Leave-One-Out Cross-Validation: Model 3", cex.lab=1.5)
for(j in 1:50) {
	lines(resEq9$iteration[which(resEq9$k==j)], resEq9$estmae[which(resEq9$k==j)], lwd=.5, col=rgb(0,0,0,0.4))
  }

# Use best model from cross-validation above (5 hidden units)
## Using nnet package, run step forward predictions like in manuscript
fludata3 <- na.omit(subset(fludata, select=c("cflu", "gflu", "lcflu", "dif_2", "dif_3", "week")))
mvec <- c()
j <- 1
while(j < 50) {
	predvec <- c()
	errvec <- c()
	for(i in 310:nrow(fludata3)){
		nnetis <- nnet(cflu~., data=fludata3[1:i-1,], size=5, linout=TRUE,MaxNWts=10000,
						trace=FALSE, maxit=100)
		pred <- predict(nnetis, fludata3[i,])
		predvec <- c(predvec, pred)
		error <- pred-fludata3$cflu[i]
		errvec <- c(errvec,error)
	}
	mae = sum(abs(errvec))/length(errvec)
	mvec <- c(mvec, mae)
	j <- j+1
	print(j)
}
write.csv(mvec, "nnresultEq9.csv")
mean(mvec)
range(mvec)
resEq9 <- results
mvecEq9 <- mvec
plot(predvec, fludata2$cflu[310:nrow(fludata2)])
