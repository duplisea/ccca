% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotting.data.ccf.functions.r
\name{colramp.legend}
\alias{colramp.legend}
\title{A colour ramp legend for the E variable in a Kobe plot}
\usage{
colramp.legend(
  col1 = "red",
  col2 = "blue",
  ncol,
  xleft,
  ybottom,
  xright,
  ytop,
  ...
)
}
\arguments{
\item{col1}{the bottom colour of the colour ramp}

\item{ncol}{the number of colours in the ramp (typically length(E))}

\item{xleft}{a vector (or scalar) of left x positions}

\item{ybottom}{a vector (or scalar) of bottom y positions}

\item{xright}{a vector (or scalar) of right x positions}

\item{ytop}{a vector (or scalar) of top y positions}

\item{...}{par options for plot}
}
\description{
A colour ramp legend for the E variable in a Kobe plot
}
\examples{
colramp.legend(col1="red", col2="blue", ncol=length(PB$E), 2.5, 3.5, 2.7, 4.5)
}
\keyword{Bmsy,}
\keyword{Kobe,}
\keyword{environment}
\keyword{gradient,}
\keyword{legend,}
\keyword{point,}
\keyword{reference}
