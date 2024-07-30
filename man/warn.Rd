\name{warn}
\alias{warn}
\alias{warn.default}
\title{
  Weaning parameter estimation with approximate Bayesian computation
}
\description{
  \code{warn} estimates weaning parameters (i.e., weaning ages, enrichment factor, and nitrogen isotope ratio (d15N) of weaning food derived collagen) for a given skeletal population under the flamework of approximate Bayesian computation (ABC).
}
\usage{
\method{warn}{default}(age, d15N, female.mean, female.sd = NA,
  fraction = "collagen",
  prior = c(0.5, 3, 3, 3, 1.9, 0.9, female.mean, 3, 0, 1),
  num.particle = 10000, form = "parabolic",
  tolerances = c(2.0, 1.0, 0.5, 0.25, 0.125, 0.0625, 0))
}
\arguments{
  \item{age}{a vector of estimated ages in year of the non-adult skeletons. Ages greater than 10 years are not allowed.}
  \item{d15N}{a vector of bone collagen d15N of non-adult skeletons. Other geochemical values (e.g., d18O, Sr/Ca, and Ba/Ca) can be used with this argument.}
  \item{female.mean}{the mean d15N of the adult females, single value.}
  \item{female.sd}{the one standard deviation of adult female d15Ns, an optional single value. Utilized later in \code{\link{plot.warn}}.}
  \item{fraction}{fraction of bone analyzed. The allowed values are \code{collagen} and \code{mineral}. The turnover rate specific to each fraction will be used.}
  \item{prior}{a vector of hyper parameter values for prior distributions of the weaning parameters and the individual error term. Mean and SD for t1 (age at the start of weaning), t2 (age at the end of weaning), enrichment of d15N, d15N of weaning food derived collagen, and sigma used in ABC-SMC, in sequence. The values are succeeded to \code{mean} and \code{sd} arguments of \code{\link{rnorm}}. The default is \code{c(0.5, 3, 3, 3, 1.9, 0.9, female.mean, 3, 0, 1)}.}
  \item{num.particle}{number of particles in sequential Monte Carlo (SMC) sampling; defaults to 10000.}
  \item{form}{form of the model curve for the weaning process. The allowed values are \code{"linear"}, \code{"parabolic"} (the default), \code{"reverse"}, and \code{"sigmoid"}.}
  \item{tolerances}{a vector of decreasing torelances used in the SMC sampling. The default is \code{c(2.0, 1.0, 0.5, 0.25, 0.125, 0.0625, 0)}.}
}
\details{
  The \code{warn} esimates the age at the start and end of weaning, enrichment of d15N through maternal to infant tissue, and d15N value of collagen synthesized entirely from weaning foods with their posterior probabilities. Other geochemical values that change with breastfeeding and weaning can also be analyzed (e.g., d18O, Sr/Ca, and Ba/Ca). Probabilities are estimated by SMC with partial rejection control, and the algorithm was derived from Sisson et al. (2007, 2009). The posterior probabilities are obtained as a result of kernel density estimation, a product of \code{\link{kde2d}} in \pkg{MASS} package for weaning ages, and \code{\link{density}} for enrichment and weaning foods. The model used to describe the change in d15N during weaning contains a new estimate of bone collagen turnover rates in non-adults, and is shown in Tsutaya and Yoneda (2013).
}
\value{
  \code{warn} returns an object of \code{\link{class}} \code{"warn"}.\cr
  The function \code{\link{summary}} and \code{\link{plot}} are used to obtain and indicate a summary and figure of the results, respectively.\cr
  An object of class \code{"warn"} is a list containing at least the following components:\cr
  \item{mde}{the maximum density estimators and their marginal probabilities for the weaning parameters.}
  \item{prob.2d.age}{the joint probability for combination of the maximum density weaning ages.}
  \item{dist.mde}{the mean squared distance between the measured and modeled d15Ns of non-adults.}
  \item{kde.age}{two-dimensional kernel density estimates of the weaning ages. A product of \code{\link{kde2d}} in \pkg{MASS} package.}
  \item{kde.enrich}{kernel density estimates of the enrichment factor from mother to infant. A product of \code{\link{density}}.}
  \item{kde.wnfood}{kernel density estimates of the d15N of collagen synthesized entirely form weaning foods. A product of \code{\link{density}}.}
  \item{posterior}{a matrix of final particles in SMC sampling.}
  \item{age}{the non-adult ages used.}
  \item{d15N}{the measuerd d15Ns of non-adult bone collagen used.}
  \item{female.mean}{the mean d15N of adult females used.}
  \item{female.sd}{the one standard deviation of adult female d15Ns used.}
  \item{fraction}{the fraction of bone analyzed.}
  \item{prior}{a vector of the hyper parameter values for the prior distributions used.}
  \item{particle}{the number of particles used.}
  \item{form}{the form of the model curve used.}
  \item{call}{the matched call.}\cr
  The band-width of kernel density estimation (i.e., \code{h} in \code{\link{kde2d}} and \code{bw} in \code{\link{density}}) is selected by SJ method, \code{\link{width.SJ}} in \pkg{MASS}, with "direct plug-in".
}
\references{
  Sisson, S. A., Fan, Y., and Tanaka, M. M. (2007, 2009). Sequential Monte Carlo without likelihoods. \emph{Proc. Natl. Acad. Sci.} \bold{104}, 1760--1765.\cr
  \cr
  Tsutaya, T., and Yoneda, M. (2013). Quantitative reconstruction of weaning ages in archaeological human populations using bone collagen nitrogen isotope ratios and approximate Bayesian computation. \emph{PLoS ONE} \bold{8}, e72327.
}
\author{
  Takumi Tsutaya developed this model.
}
\seealso{
  \code{\link{WARN}}, \code{\link{warnCI}}, \code{\link{warnProb}}, \code{\link{summary.warn}}, \code{\link{plot.warn}}
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

## Indicate summary.
summary(warn.lerna)

## Plot.
plot(warn.lerna)

## Plot with adult mean.
plot(warn.lerna,
  hline.adult = TRUE,
  adult.mean = mean(adult$d15N),
  adult.sd = sd(adult$d15N),
  is.female = FALSE)
}
\keyword{math}

