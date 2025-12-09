# krr

Kernel Ridge Regression (KRR) with Gaussian kernel 


## Description

This package provides functions to fit and predict using Kernel Ridge Regression with Gaussian kernel. KRR is a non-parametric regression method that combines ridge regression with the kernel trick.

## Functions

- `fit_krr()`: Fit a KRR model
- `predict.krr()`: Make predictions on new data
- `gaussian_kernel()`: Compute Gaussian kernel values

## Basic Usage

### Example

```r
library(krr)

# Simulate regression data
set.seed(1)
n <- 100
X <- runif(n, -1, 1)
y <- sin(2*pi*X) + rnorm(n, sd = 0.1)

# Fit KRR model
model <- fit_krr(X, y, lambda = 0.001, rho = 1)

# Make predictions
x_test <- seq(-1, 1, length.out = 100)
y_pred <- predict(model, x_test)
```


## Parameters

### `fit_krr(X, y, lambda, rho)`

- `X`: Numeric vector of input training data
- `y`: Numeric vector of output training data
- `lambda`: Regularization parameter (default: 0.0001)
  - Smaller values: less regularization, more flexible fit
  - Larger values: more regularization, smoother fit
- `rho`: Kernel bandwidth parameter (default: 1)
  - Smaller values: wider kernel, smoother predictions
  - Larger values: narrower kernel, more local predictions

### `predict.krr(object, newdata)`

- `object`: Fitted KRR model from `fit_krr()`
- `newdata`: Numeric vector of new input points



## Theory

Kernel Ridge Regression solves:

$$\min_{\alpha} ||y - K\alpha||^2 + \lambda \alpha^T K \alpha$$

The solution is:

$$\hat{\alpha} = (K + \lambda I)^{-1} y$$

Predictions are made using:

$$\hat{f}(x) = \sum_{i=1}^{n} \hat{\alpha}_i k(x, x_i)$$

where the Gaussian kernel is:

$$k(x, x') = \exp(-\rho(x-x')^2)$$

## Step-by-Step Tutorial

### Step 1: Load the package

```r
library(KRRpackage)
```

### Step 2: Prepare your data

```r
# Your training data
X_train <- c(0.1, 0.3, 0.5, 0.7, 0.9)
y_train <- c(0.2, 0.8, 1.2, 0.9, 0.3)
```

### Step 3: Fit the model

```r
model <- fit_krr(X_train, y_train, lambda = 0.01, rho = 1)
```

### Step 4: Make predictions

```r
# Predict at new points
X_new <- seq(0, 1, length.out = 50)
y_pred <- predict(model, X_new)
```
