# Climate Scenarios:
# This series of functions is used to develop future climate scenarios based on various assumption of how you want to
# create a future climate. Outputs are usually large matrices with dimensions of Number of Monte Carlo samples X the
# number of years you want to project into the future. It is unlikely you would call these functions on their own: they
# are helper functions.
####################################################################################################################



#' Draws samples E variable for future climate scenarios - non-parametric option
#'
#' @param E the time series of environment or ecosystem variable to resample (with replacement)
#' @param E.prediction.years the time series of environment or ecosystem variable
#' @param proj.years The number of years to project into the future
#' @param N The number of different realisations of the future to create
#' @keywords environmental variable, climate scenario, projection, non-parametric
#' @export
Eproj.np.f= function(E,E.prediction.years,proj.years,N){
  Evec= E[E.prediction.years]
  E2= matrix(sample(Evec,proj.years*N,replace=T),ncol=N,nrow=proj.years)
  E2
}

#' Fits a gamma distribution to the E variable. Used for random draws from E
#'
#' @param E the time series of environment or ecosystem variable
#' @keywords environmental variable, gamma distribution, climate scenario
#' @export
#' @examples
#' gamma.fit.f(rgamma(1000,rate=40,shape=200))
Egamma.fit.f= function(E){
  gf= fitdistr(x=E, densfun="gamma")
  gf
}


#' Fits a lognormal distribution to the E variable. Used for random draws from E
#'
#' @param E the time series of environment or ecosystem variable
#' @keywords environmental variable, lognormal distribution, climate scenario
#' @export
#' @examples
#' lnorm.fit.f(rlnorm(1000,2.56,0.055))
lnorm.fit.f= function(E){
  lnf= fitdistr(x=E,densfun="lognormal")
  lnf
}


#' Fits a normal distribution to the E variable. Used for random draws from E
#'
#' @param E the time series of environment or ecosystem variable
#' @keywords environmental variable, normal distribution, climate scenario
#' @export
#' @examples
#' lnorm.fit.f(rnorm(1000,2.65,0.703))
norm.fit.f= function(E){
  E= E[!is.na(E)]
  lnf= fitdistr(E,densfun="normal")
  lnf
}

#' A generic distribution fitting function for the E variable. Used for random draws from E
#'
#' @param E the time series of environment or ecosystem variable
#' @param densfun Either a character string or a function returning a density evaluated at its first argument.
#'      Distributions "beta", "cauchy", "chi-squared", "exponential", "gamma", "geometric", "log-normal",
#'      "lognormal", "logistic", "negative binomial", "normal", "Poisson", "t" and "weibull" are recognised,
#'      case being ignored.
#' @keywords environmental variable, normal distribution, climate scenario
#' @export
#' @examples
#' E.dist.fit.f(rlnorm(1000,6,1.1),densfun="lognormal")
E.dist.fit.f= function(E, densfun=densfun){
  E= E[!is.na(E)]
  lnf= fitdistr(E,densfun=densfun)
  lnf
}

#' Draws samples from a gamma distribution fitted to E for future climate scenarios - parametric option
#'
#' @param shape The gamma distribution shape parameter
#' @param rate The gamma distribution rate parameter
#' @param Emean.shift The shift in gamma disribution to left or right to mimic mean shift in E variable (E units)
#' @param proj.years The number of years to project into the future
#' @param N The number of different realisations of the future to create
#' @keywords environmental variable, climate scenario, projection, non-parametric
#' @export
#' @examples
#' Eprojgamma.f(shape=262, rate=49.6, Emean.shift=1, proj.years=10, N=23)
Eprojgamma.f= function(shape, rate, Emean.shift=1, proj.years, N){
  E= matrix(rgamma(proj.years*N,shape=shape,rate=rate)+Emean.shift,ncol=N,nrow=proj.years)
  E
}

#' Draws samples from a gaussian distribution fitted to E for future climate scenarios
#'
#' @param E.dist.a The mean of the normal distribution
#' @param E.dist.b The standard deviation of the normal distribution
#' @param Emean.shift The shift if the mean. This is done rather than changing the mean directly so it is generic for variety of distributions
#' @param proj.years The number of years to project into the future
#' @param N The number of different realisations of the future to create
#' @keywords environmental variable, climate scenario, projection
#' @export
#' @examples
#' Eprojnorm.f(3, .05, Emean.shift=0, proj.years=10, N=23)
Eprojnorm.f= function(Edist.a, Edist.b, Emean.shift=1, proj.years, N){
  E= matrix(rnorm(proj.years*N,mean=Edist.a,sd=Edist.b)+Emean.shift,ncol=N,nrow=proj.years)
  E
}

#' Sample the P/B values themselves rather than an environmental variable and then calculating P/B.
#'
#' @param PBvec the vector of PB values calculated from running the function PB.f
#' @param PB.prediction.years the years you want to sample from the PBvec (if 5th-10th year, 5:10)
#' @param proj.years The number of years to project into the future
#' @param N The number of different realisations of the future to create
#' @keywords environmental variable, climate scenario, projection, non-parametric
#' @export
EprojPB.f= function(PBvec,PB.prediction.years,proj.years,N){
  PBvec= PBvec[PB.prediction.years]
  PBsamp= matrix(sample(PBvec,proj.years*N,replace=T),ncol=N,nrow=proj.years)
  PBsamp
}

#' A function calculated P/B for projection based on the climate scenario. It samples the residuals of the fitted relationship and adds one to each draw
#'
#' @param PvsE The fitted PB vs E model object
#' @param Eproj The matrix of E values for the projection. From running Eprojgamma.f
#' @param add.residuals if yes=1, no=0. DO NOT USE ANY OTHER VALUE!! This formulation is faster because it avoids an if statement
#' @keywords P/B, E
#' @export
PB.for.projection.f= function(PvsE, Eproj, add.residuals=add.resids){
  median.prediction= Eproj*-9999
  for (i in 1:ncol(Eproj)){
    newdat= Eproj[,i]
    median.prediction[,i]= predict(PvsE, newdata=data.frame(E=newdat))
  }
  error.prediction= PvsE.resids.f(PvsE,proj.years=nrow(Eproj),N=ncol(Eproj))*add.residuals
  PB.prediction= median.prediction+error.prediction
  PB.prediction
}

#' A function random sample of residuals for PB vs E relationship, creates additive terms for the P/B samples
#'
#' @param PvsE The fitted PB vs E model object
#' @param proj.years The number of years to project into the future
#' @param N The number of different realisations of the future to create
#' @keywords P/B, E
#' @export
PvsE.resids.f= function(PvsE, proj.years, N){
  resids= matrix(sample(residuals(PvsE),proj.years*N,replace=T),ncol=N,nrow=proj.years)
  resids
}

#' creates a list of climate scenarios for developing CCF
#'
#' @param mean.shift a vector of shifts in the mean of the gamma distribution of E
#' @param N The number of different realisations of the future to create
#' @param proj.years The number of years to project into the future
#' @param shape The gamma distribution shape parameter
#' @param rate The gamma distribution rate parameter
#' @keywords P/B, E
#' @export
#' @examples
#' E.shifts= c(0,seq(-1,0.47,length=25)) #the first value must always be 0 (i.e. no mean shift)
#' Eprojection= Eproj.list.f(E.shifts, N=N, proj.years=proj.years, shape=gamma.shape, rate=gamma.rate)
Eproj.list.f= function(Emean.shifts, N, proj.years, Edist.a, Edist.b){
  output= list()
  for (i in 1:length(Emean.shifts)){
    output[[i]]= Eprojnorm.f( Edist.a, Edist.b,Emean.shift=Emean.shifts[i],proj.years=proj.years, N=N)
  }
  output
}


#' Creates the PB scenario based on the climate (E) and the P/B vs E relationship
#'
#' @param PvsE the fitted model object of P/B vs E
#' @param Eprojection the list of climate scenarios created by running Eproj.list.f
#' @keywords P/B, E
#' @export
#' @examples
#' PBprojection= PBproj.list(PvsE=PvsE, Eprojection=Eprojection)
PBproj.list.f= function(PvsE,Eprojection){
  output= list()
  for (i in 1:length(Eprojection)){
    output[[i]]= PB.for.projection.f(PvsE=PvsE, Eproj=Eprojection[[i]])
  }
  output
}
