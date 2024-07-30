\name{warnProb}
\alias{warnProb}
\alias{warnProb.default}
\title{
  Calculate posterior probability of the weaning parameters
}
\description{
  \code{warnProb} calculate posterior probabilities under a given class \code{"warn"} object and a given parameter range.
}
\usage{
\method{warnProb}{default}(object, weaning.par = "age", range.x, range.y = NA)
}
\arguments{
  \item{object}{an object of class \code{"warn"}.}
  \item{weaning.par}{character for the intended weanig parameter. The allowed values are \code{"age"} (the default), \code{"enrich"}, and \code{"wnfood"}.}
  \item{range.x, range.y}{numeric vectors of length 2, giving the range of the intended weanig parameters. For example, \code{range.x} corresponds to the age at the start of weaning if \code{weaning.par = "age"}. \code{range.y} is used only if \code{weaning.par = "age"}, and corresponds to the age at the end of weaning. Fractional point lower than e-002 is rounded.}
}
\details{
  \code{warnProb} calculates posterior probability of the weaning parameter that ranges between designated range. Parameter distribution is represented as the product of kernel density estimation performed in \code{\link{warn}}. Weaning ages are estimated from two-dimensional probability distribution, and nitrogen isotope ratios (d15Ns) of enrichment factor and weaning food derived collagen are from one-dimensional.
}
\value{
  \code{warnProb} returns an object of \code{\link{class}} \code{"warnProb"} which is a subclass of \code{"warn"}.\cr
  The functions \code{\link{summary}} and \code{\link{plot}} are used to obtain and indicate a summary and figure of the results, respectively.\cr
  An object of class \code{"warnProb"} at least has following list components in addition to those succeeded from \code{"warn"}:\cr
  \item{probability}{posterior probability of parameter that range between the designated range.}
  \item{range}{a vector giving the range of the intended weanig parameter.}
  \item{weaning.par}{a character indicating the weaning parameter used.}
}
\references{
  Tsutaya, T., and Yoneda, M. (2013). Quantitative reconstruction of weaning ages in archaeological human populations using bone collagen nitrogen isotope ratios and approximate Bayesian computation. \emph{PLoS ONE} \bold{8}, e72327.
}
\author{
  Takumi Tsutaya developed this model.
}
\seealso{
  \code{\link{WARN}}, \code{\link{warn}}, \code{\link{warnCI}}, \code{\link{summary.warnProb}}, \code{\link{plot.warnProb}}
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

## Calculate probabilities for a given parameter range.
warnprob.age <- warnProb(warn.lerna, "age", c(0.0, 1.1), c(0.8, 2.3))
warnprob.enrich <- warnProb(warn.lerna, "enrich", c(1.5, 3.5))
warnprob.wnfood <- warnProb(warn.lerna, "wnfood", c(7.3, 8.8))

## Indicate summary.
summary(warnprob.age)
summary(warnprob.enrich)

## Plot.
plot(warnprob.age)
plot(warnprob.wnfood)

## Plot with image.
plot(warnprob.age, is.image = TRUE)
}
\keyword{math}

