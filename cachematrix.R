
makeVector <- function(x = numeric()) {
  ## creates a special "vector", which is really a list containing a function to:
  ## 1. set the value of the vector
  ## 2. get the value of the vector
  ## 3. set the value of the mean
  ## 4. get the value of the mean
  
    m <- NULL
    set <- function(y) {
    x <<- y
    m <<- NULL
  }
    get <- function() x
  setmean <- function(mean) m <<- mean
  getmean <- function() m
  list(set = set, get = get,
       setmean = setmean,
       getmean = getmean)
}


cachemean <- function(x, ...) {
  ## calculates the mean of the special "vector" created with the above function. 
  ## However, it first checks to see if the mean has already been calculated. 
  ## If so, it gets the mean from the cache and skips the computation. 
  ## Otherwise, it calculates the mean of the data and sets the value of the mean 
  ## in the cache via the setmean function.
  
  m <- x$getmean()
  if(!is.null(m)) {
    message("getting cached data")
    return(m)
  }
  data <- x$get()
  m <- mean(data, ...)
  x$setmean(m)
  m
}


## /-------------------------------------------------------------------------------------------/

##  <<- operator which can be used to assign a value to an object in an environment that
##  is different from the current environment

makeCacheMatrix <- function(x = matrix()) {
        ## This function creates a special "matrix" object that can cache its inverse.
  inv = NULL
  set = function(y) {
    x <<- y
    inv <<- NULL
  }
  get = function() x
  setInv = function(inverse) inv <<- inverse 
  getInv = function() inv
  list(set = set, get = get, setInv = setInv, getInv = getInv)
  }



cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        ## This function computes the inverse of the special "matrix" returned by makeCacheMatrix above. If the inverse has already been calculated (and the matrix has not changed), then cacheSolve should retrieve the inverse from the cache.

  inv = x$getInv()
  
  ## if the inverse already calculated

    if (!is.null(inv)){
    ## gets from cache 
    message("retrieving cached data")
    return(inv)
  }
  
  ## otherwise, calculates the inverse 
  mat.data = x$get()
  inv = solve(mat.data, ...)
  
  # sets the value of the inverse in the cache via the setinv function.
  x$setInv(inv)
  
  return(inv)
  
  }
