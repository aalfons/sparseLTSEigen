\name{sparseLTSEigen-package}
\alias{sparseLTSEigen-package}
\alias{sparseLTSEigen}
\docType{package}
\title{
RcppEigen back end for sparse least trimmed squares
regression
}
\description{
Use RcppEigen to fit least trimmed squares
    regression models with an L1 penalty in order to obtain
    sparse models.
}
\details{
\tabular{ll}{
Package: \tab sparseLTSEigen\cr
Type: \tab Package\cr
Version: \tab 0.1.0\cr
Date: \tab 2012-04-10\cr
Depends: \tab 
Rcpp (>= 0.9.10),
robustHD\cr
Imports: \tab 
RcppEigen (>= 0.2.0)\cr
Suggests: \tab 
mvtnorm\cr
LinkingTo: \tab Rcpp, RcppEigen\cr
License: \tab GPL (>= 2)\cr
LazyLoad: \tab yes\cr
}

Index:
\preformatted{
sparseLTSEigen-package
                        RcppEigen back end for sparse least trimmed
                        squares regression
}
}
\note{
Package \pkg{sparseLTSEigen} provides an alternative back end for sparse least 
trimmed squares regression from package \pkg{robustHD}.  The back end built 
into \pkg{robustHD} uses the C++ library Armadillo, whereas this back end uses 
the C++ library Eigen.  The latter is faster, but not available on all 
platforms.  For instance, \pkg{sparseLTSEigen} currently does not work on 
32-bit \R for Windows.  In addition, there is currently no binary package for 
OS X available on CRAN due to problems with the PowerPC 
architecture.  Nevertheless, OS X users with Intel machines can install 
\pkg{RcppEigen} and \pkg{sparseLTSEigen} from source if the standard \R 
developer tools are installed.

When \pkg{sparseLTSEigen} is loaded, its back end is used automatically for 
sparse least trimmed squares regression, except on 32-bit \R for Windows.
}
\examples{
## generate data
library("mvtnorm")
set.seed(1234)  # for reproducibility
n <- 100  # number of observations
p <- 200  # number of variables
beta <- rep.int(c(1, 0), c(5, p-5))  # coefficients
sigma <- 0.5      # controls signal-to-noise ratio
epsilon <- 0.1    # contamination level
Sigma <- 0.5^t(sapply(1:p, function(i, j) abs(i-j), 1:p))
x <- rmvnorm(n, sigma=Sigma)    # predictor matrix
e <- rnorm(n)                   # error terms
i <- 1:ceiling(epsilon*n)       # observations to be contaminated
e[i] <- e[i] + 5                # vertical outliers
y <- c(x \%*\% beta + sigma * e)  # response
x[i,] <- x[i,] + 5              # bad leverage points

## fit sparse LTS model
# since package sparseLTSEigen is loaded, its back end based on 
# the C++ library Eigen is used rather than the back end built 
# into package robustHD, except on 32-bit R for Windows
fit <- sparseLTS(x, y, lambda = 0.05, mode = "fraction")
coef(fit, zeros = FALSE)
}
\author{
Andreas Alfons

Maintainer: Andreas Alfons <andreas.alfons@econ.kuleuven.be>
}
\keyword{package}