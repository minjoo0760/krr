#' Gaussian Kernel Function
#'
#' @description
#' Compute the Gaussian kernel between two points.
#'
#' @param x A numeric value.
#' @param xprime A numeric value.
#' @param rho A numeric value for the bandwidth parameter. Default is 1.
#'
#' @return A numeric value representing the kernel value.
#' @export
#'
#' @examples
#' gaussian_kernel(0, 0.5, rho = 1)
gaussian_kernel <- function(x, xprime, rho = 1) {
  exp(-rho * (x - xprime)^2)
}


#' Fit Kernel Ridge Regression
#'
#' @description
#' Fit a Kernel Ridge Regression model using Gaussian kernel.
#' This function computes the kernel matrix and solves for the alpha coefficients.
#'
#' @param X A numeric vector of training input data.
#' @param y A numeric vector of training output data.
#' @param lambda A numeric value for the regularization parameter. Default is 0.0001.
#' @param rho A numeric value for the kernel bandwidth parameter. Default is 1.
#'
#' @return An object of class "krr" containing:
#' \item{X}{Training input data}
#' \item{y}{Training output data}
#' \item{alpha}{Computed alpha coefficients}
#' \item{lambda}{Regularization parameter}
#' \item{rho}{Kernel bandwidth parameter}
#' \item{K}{Kernel matrix}
#'
#' @export
#'
#' @examples
#' set.seed(1)
#' n <- 50
#' X <- runif(n, -1, 1)
#' y <- sin(2*pi*X) + rnorm(n, sd = 0.1)
#' model <- fit_krr(X, y, lambda = 0.001, rho = 1)
fit_krr <- function(X, y, lambda = 0.0001, rho = 1) {
  n <- length(y)

  K <- matrix(0, n, n)
  for (i in 1:n) {
    for (j in 1:n) {
      K[i, j] <- gaussian_kernel(X[i], X[j], rho)
    }
  }

  alpha <- solve(K + lambda * diag(n), y)

  result <- list(
    X = X,
    y = y,
    alpha = alpha,
    lambda = lambda,
    rho = rho,
    K = K
  )

  class(result) <- "krr"
  return(result)
}
