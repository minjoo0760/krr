predict.krr <- function(object, newdata, ...) {
  n_train <- length(object$X)
  n_new <- length(newdata)
  predictions <- numeric(n_new)

  for (i in 1:n_new) {
    k_vec <- sapply(object$X, function(x) {
      gaussian_kernel(newdata[i], x, object$rho)
    })
    predictions[i] <- sum(k_vec * object$alpha)
  }

  return(predictions)
}


