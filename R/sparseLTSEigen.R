# ----------------------
# Author: Andreas Alfons
#         KU Leuven
# ----------------------

## register RcppEigen back end when package is loaded
#' @import Rcpp 
#' @import RcppEigen
#' @useDynLib sparseLTSEigen
.onLoad <- function(libname, pkgname) registerBackend()
