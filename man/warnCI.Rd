\name{warnCI}
\alias{warnCI}
\alias{warnCI.default}
\title{
  Calculate credible intervals for posterior probability of the weaning parameters
}
\description{
  \code{warnCI} calculate credible intervals (CIs) of posterior probabilities under a given class \code{"warn"} object and a given threshold of CIs.
}
\usage{
\method{warnCI}{default}(object, threshold = 0.95)
}
\arguments{
  \item{object}{an object of class \code{"warn"}.}
  \item{threshold}{numeric scalar or vector giving the threshold of CI for posterior probabilities of weaning ages, nitrogen isotope ratios (d15Ns) of enrichment factor, and d15Ns of collagen derived entirely from weaning foods. Minimum range with over (\code{threshold * 100})\% of summed posterior probability is calculated. If scalar is given, value is repeated. Values between 0 and 1 must be given.}
}
\details{
  \code{warnCI} calculates minimum ranges with over (\code{threshold * 100})\% of summed posterior probability of the weaning parameters. Posterior probabilities are represented as the product of kernel density estimation performed in \code{\link{warn}}. CIs of weaning ages are obtained from two-dimensional probability distribution, and those of d15Ns of enrichment factor and collagen derived entirely from weaning foods are from one-dimensional. Posterior probability distributions with multiple notable peaks are not supported by \code{warnCI}.
}
\value{
  \code{warnCI} returns an object of \code{\link{class}} \code{"warnCI"} which is a subclass of \code{"warn"}.\cr
  The function \code{\link{plot}} is used to indicate figures of the results.\cr
  An object of class \code{"warnCI"} has following list components in addition to those succeeded from \code{"warn"}:\cr
  \item{ci.age}{a list containing the CIs for the combination of t1 and t2, and its summed posterior probability.}
  \item{ci.enrich}{a list containing the CI for the d15N-enrichment from mother to infant, and its summed posterior probability.}
  \item{ci.wnfood}{a list containing the CI for the d15N value of collagen derived entirelly from weaning foods, and its summed posterior probability.}
  \item{ci.threshold}{a vector showing the thresholds used to calculate the CIs.}
}
\references{
  Tsutaya, T., and Yoneda, M. (2013). Quantitative reconstruction of weaning ages in archaeological human populations using bone collagen nitrogen isotope ratios and approximate Bayesian computation. \emph{PLoS ONE} \bold{8}, e72327.
}
\author{
  Takumi Tsutaya developed this model.
}
\seealso{
  \code{\link{WARN}}, \code{\link{warn}}, \code{\link{warnProb}}, \code{\link{plot.warnCI}}
}
\examples{
## Data from the Lerna population.
nonadult <- subset(lerna, lerna$age <= 10)
adult <- subset(lerna, lerna$age > 17)
female <- subset(adult, adult$sex == "f")

## Calculate maximum density estimators using ABC.
warn.lerna <- warn(
  age = nonadult$age,
  d15N = nonadult$d15N,
  female.mean = mean(female$d15N),
  num.particle = 500,
  female.sd = sd(female$d15N),
  prior = c(0.2, 0.2, 1.6, 0.2, 2.5, 0.2, 8.1, 0.2, 0, 0.7),
  tolerances = c(1.5, 0.7))

## Calculate over (>=) 50% CIs.
warn.lerna.50ci <- warnCI(warn.lerna, 0.50)

## Indicate result.
warn.lerna.50ci

## Plot.
plot(warn.lerna.50ci, "age")
plot(warn.lerna.50ci, "enrich")

}
\keyword{math}

