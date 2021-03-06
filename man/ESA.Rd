% Generated by roxygen2 (4.1.1): do not edit by hand
% Please edit documentation in R/ESA_BCV.R
\name{ESA}
\alias{ESA}
\title{Estimate Latent Factor Matrix With Known Number of Factors}
\usage{
ESA(Y, r, X = NULL, center = F, niter = 3, svd.method = "fast")
}
\arguments{
\item{Y}{observed data matrix. p is the number of variables and
n is the sample size. Dimension is \code{c(n, p)}}

\item{r}{The number of factors to use}

\item{X}{the known predictors of size \code{c(n, k)} if any. Default is NULL (no known predictors).
\code{k} is the number of known covariates.}

\item{center}{logical, whether to add an intercept term in the model.
Default is False.}

\item{niter}{the number of iterations for ESA. Default is 3.}

\item{svd.method}{either "fast", "propack" or "standard".
"fast" is using the \code{\link[corpcor]{fast.svd}} function in package corpcor to compute SVD, "propack" is using the \code{\link[svd]{propack.svd}} to compute SVD and "standard"
is using the \code{\link[base]{svd}} function in the base package. Because of PROPACK
issues, "propack" fails for some matrices, and when that happens,
the function will use "fast" to
compute the SVD of that matrix instead. Default method is "fast".}
}
\value{
The returned value is a list with components
  \item{estSigma}{the diagonal entries of estimated \eqn{\Sigma}
  which is a vector of length \code{p}}
  \item{estU}{the estimated \eqn{U}. Dimension \code{c(n, r)}}
  \item{estD}{the estimated diagonal entries of \eqn{D}
  which is a vector of length \code{r}}
  \item{estV}{the estimated \eqn{V}. Dimension is \code{c(p, r)}}
  \item{beta}{the estimated \eqn{beta} which is a matrix of size \code{c(k, p)}.
  Return NULL if the argument \code{X} is NULL.}
  \item{estS}{the estimated signal (factor) matrix \eqn{S} where
              \deqn{S = 1 \mu' + X \beta + n^{1/2}U D V'}}
  \item{mu}{the sample centers of each variable which is a vector of length
  \code{p}. It's an estimate of \eqn{\mu}. Return
  NULL if the argument \code{center} is False.}
}
\description{
Estimate the latent factor matrix and noise variance using early stopping
alternation (ESA) given the number of factors.
}
\details{
The model used is
\deqn{Y = 1 \mu' + X \beta + n^{1/2}U D V' + E \Sigma^{1/2}}
where \eqn{D} and \eqn{\Sigma} are diagonal matrices, \eqn{U} and \eqn{V}
are orthogonal and \eqn{\mu'}
and \eqn{V'} mean _mu transposed_ and _V transposed_ respectively.
The entries of \eqn{E} are assumed to be i.i.d. standard Gaussian.
The model assumes heteroscedastic noises and especially works well for
high-dimensional data. The method is based on Owen and Wang (2015). Notice that
when nonnull \code{X} is given or centering the data is required (which is essentially
adding a known covariate with all \eqn{1}), for identifiability, it's required that
\eqn{<X, U> = 0} or \eqn{<1, U> = 0} respectively. Then the method will first make a rotation
of the data matrix to remove the known predictors or centers, and then use
the latter \code{n - k} (or \code{n - k - 1} if centering is required) samples to
estimate the latent factors.
}
\examples{
Y <- matrix(rnorm(100), nrow = 10) + 3 * rnorm(10) \%*\% t(rep(1, 10))
ESA(Y, 1)
}
\references{
Art B. Owen and Jingshu Wang(2015), Bi-cross-validation for factor analysis,
\url{http://arxiv.org/abs/1503.03515}
}

