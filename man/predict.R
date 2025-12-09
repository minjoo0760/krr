#' Predict Method for KRR
#'
#' @description
#' Predict method for Kernel Ridge Regression objects.
#' Computes predictions for new data points using the fitted KRR model.
#'
#' @param object An object of class "krr" from fit_krr().
#' @param newdata A numeric vector of new input data points for prediction.
#' @param ... Additional arguments (not used).
#'
#' @return A numeric vector of predicted values.
#'
#' @export
#'
#' @examples
#' set.seed(1)
#' n <- 50
#' X <- runif(n, -1, 1)
#' y <- sin(2*pi*X) + rnorm(n, sd = 0.1)
#' model <- fit_krr(X, y, lambda = 0.001, rho = 1)
#' x_test <- seq(-1, 1, length.out = 10)
#' y_pred <- predict(model, x_test)
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
