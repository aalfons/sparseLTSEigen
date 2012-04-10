# ----------------------
# Author: Andreas Alfons
#         KU Leuven
# ----------------------

# access environment containing function to call back end
backendEnv <- function() {
    pos <-  match(".BackendEnv", search())
    if(is.na(pos)) { # must create it
        attach(list(), name=".BackendEnv")
        pos <- match(".BackendEnv", search())
    }
    return(pos.to.env(pos))
}

# put in back end environment
putBackendEnv <- function(x, value) {
    assign(x, value, envir=backendEnv())
}

# function to call RcppEigen back end
.CallSparseLTSEigen <- function(.NAME, ..., PACKAGE) {
    .Call(.NAME, ..., PACKAGE="sparseLTSEigen")
}

# register RcppEigen back end
registerBackend <- function() {
    putBackendEnv("eigen", .CallSparseLTSEigen)
}
