set.seed (2)
x <- matrix ( rnorm (50 * 2), ncol = 2)
x[1:25, 1] <- x[1:25, 1] + 3
x[1:25, 2] <- x[1:25, 2] - 4
km.out <- kmeans (x, 4, nstart = 20)
km.out$cluster
par (mfrow = c(1, 2))
plot (x, col = (km.out$cluster + 1), main = "K- Means Clustering Results with K = 2",xlab = "", ylab = "", pch = 20, cex = 2)