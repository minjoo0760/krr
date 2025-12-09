gaussian_kernel <- function(x, xprime, rho = 1) {
  exp(-rho * (x - xprime)^2)
}

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
