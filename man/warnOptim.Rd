\name{warnOptim}
\alias{warnOptim}
\alias{warnOptim.default}
\title{
  Optimize the weaning parameters
}
\description{
  \code{warnOptim} optimzes the weaning parameters for a given skeletal population. This function can be preliminaly used in order to set efficient priors of the weaning parameters.
}
\usage{
\method{warnOptim}{default}(age, d15N, female.mean,
  fraction = "collagen",
  par.initial = c(0.5, 3, 1.9, female.mean), 
  form = "parabolic", \dots)
}
\arguments{
  \item{age}{a vector of estimated ages of non-adult skeletons. Ages greater than 10 years are not allowed.}
  \item{d15N}{a vector of bone collagen nitrogen isotope ratio (d15N) of non-adult skeletons. Other geochemical values (e.g., d18O, Sr/Ca, and Ba/Ca) can be used with this argument.}
  \item{fraction}{fraction of bone analyzed. The allowed values are \code{collagen} and \code{mineral}.}
  \item{par.initial}{a vector of the initial parameter values for optimizetion: t1, t2, enrichment, and weaning food, in sequence. The values are succeeded to the \code{par} arguments of \code{\link{optim}}.}
  \item{female.mean}{the mean d15N (or other geochemical value) of adult females, single value.}
  \item{form}{form of the model curve for the weaning process. The allowed values are \code{"linear"}, \code{"parabolic"} (the default), \code{"reverse"}, and \code{"sigmoid"}.}
  \item{\dots}{additional argunemts passed to \code{\link{optim}}.}
}
\details{
 The \code{warnOptim} calculates the weaning parameters (i.e., weaning ages, enrichment factor, and d15N of bone collagen synthesized entirely from the weaning foods), which minimize the mean squared distance between the measured and modeled d15Ns using \code{\link{optim}}. Result of this function is just a rough indication and initial parameter dependent, and can be preliminaly used in order to set efficient priors of the weaning parameters.
}
\value{
  \code{warnOptim} directly returns a result list of \code{\link{optim}}.
}
\seealso{
  \code{\link{WARN}}, \code{\link{warn}}, \code{\link{warnCI}}, \code{\link{warnProb}}
}
\examples{
## Data from the Lerna population.
nonadult <- subset(lerna, lerna$age <= 10)
adult <- subset(lerna, lerna$age > 17)
female <- subset(adult, adult$sex == "f")

## Simple optimization without probability.
(opt.lerna <- warnOptim(
  age = nonadult$age,
  d15N = nonadult$d15N,
  female.mean = mean(female$d15N),
  control = list(maxit = 10000, ndeps = 1e-2, reltol = 1e-7)))
}
\keyword{math}

