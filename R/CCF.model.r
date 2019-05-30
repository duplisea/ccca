# PB model and projection:
# This series of functions calculate the P/B from input data time series, makes projections into the future given
# different climate scenarios and calculates climate conditioning factors based on these future scenarios
####################################################################################################################


#' Determine the annual P/B of the population. Write input file with P/B column
#'
#' @param dataset the dataframe with at least the columns named "Year", "Catch", "Index", "E".
#' There cannot be missing years but the code does not check for that - beware!
#' @param ref.years the years which are considered the reference point year (e.g. for B, E, catch). It is up to you
#' think it is representative of Blim, Bmsy, Busr or whatever. Just beware that reference point multipliers will be
#' based on it in other areas of the simulation. So if it is a Bmsy proxy then the Blim ref.pt input logically might be about 0.4.
#' @param q the survey catchability
#' @keywords P/B, carrying capacity, environmental variable, survey catcahbility, commercial catch
#' @export
#' @examples
#' PB= PB.f(dataset,1)
PB.f= function(dataset, ref.years, q){
  ref.pos= match(ref.years, dataset$Year)
  reference.years= dataset$Index*0
  reference.years[ref.pos]=1
  Index.q= dataset$Index/q
	F.rel =dataset$Catch/Index.q
	PB=(diff(Index.q)+dataset$Catch[-length(dataset$Catch)])/Index.q[-length(Index.q)]
	PB= data.frame(Year=dataset$Year, Index.q= Index.q, Catch=dataset$Catch, F.rel=F.rel,
		E=dataset$E, PB= c(PB,NA),refererence.years= reference.years)
	PB
}


#' Fit a PB vs E relationship
#'
#' @param PB the data and model fit coming from applying the PB model (PB.f)
#' @param model.type the kind of model to fit ("poly", "gam", "gam.adaptive","avg")
#' @param knots the number of knots for adaptive GAM
#' @param poly.degree the degree of the polynomial to fit
#' @keywords trend line, P/B, E
#' @description The various model fits: polynomial "poly", GAM "gam", adaptive GAM "gam.adaptive"
#'     and resamples from the PB values "avg" can be chosen. avg just fits a linear model with slope = 0
#'     and then resamples the residuals which is effectively the same as just sampling the P/B values directly,
#'     i.e. it does not force a relationship between P/B and E and therefore the future is just a resampling
#'     of the past.
#' @export
PBE.fit.f= function(PB,model.type,knots,poly.degree){
  PB=na.omit(PB)
  switch(model.type,
    poly= lm(PB~poly(E,degree=poly.degree),data= PB),
    gam= gam(PB~s(E), data=PB),
    gam.adaptive= gam(PB~s(E,k=knots,bs="ad"), data=PB),
    avg= lm(PB - 0*E ~ 1, data=PB))
}


#' The fishing strategy as exploitation rate. F must be <=1
#'
#' @param PB the data and model fit coming from applying the PB model (PB.f)
#' @param years the years whos mean will become the F for projections
#' @param moratorium if TRUE then there is no fishing going forward, otherwise calculated from relative F in specified years
#' @keywords Fishing strategy, harvest control rule, projections
#' @export
F.strategy= function(PB, years, moratorium=F){
  year.match= match(years,PB$Year)
  F.rel= mean(PB$F.rel[year.match])
  if(moratorium) F.rel=0
  if(is.na(F.rel)) warning('your F strategy is NA. You probably selected years outside data')
  F.rel
}



#' Performs the projection with climate scenario and fishing strategy
#'
#' @param PB the data and model fit coming from applying the PB model (PB.f)
#' @param Bstart.mult the proporption of the last data year's biomass used to start the projection
#' @param PBproj The matrix of projected PB values based on climate scenario
#' @param Fstrat The fishing strategy
#' @param K The multiplier of maximum observed biomass to be carrying capacity
#' @param theta the skewness of the density dependence factor (1=Schaeffer)
#' @keywords projection, fishing, climate change, production, density dependence
#' @export
#' @examples
#' Bproj= projection.f(PB=PB, Bstart.mult=Bstart.mult, PBproj=PBproj, Fstrat, K=K, theta=1)
projection.f= function(PB, Bstart.mult, PBproj, Fstrat, K, theta=1){
  if(theta<=0) stop('theta must be >0 and probably should be <=1')
  K= K*max(PB$Index.q)
  N= ncol(PBproj)
  proj.years= nrow(PBproj)
  proj.di= matrix(ncol=N,nrow=proj.years)
  proj.dd= matrix(ncol=N,nrow=proj.years)
  for (MC in 1:N){
    B.di= tail(PB$Index.q,1)*Bstart.mult
    B.dd= B.di
    for (i in 1:proj.years){
      PB.ratio= PBproj[i,MC]
      B.di= max(c(.001,(B.di+B.di*PB.ratio-B.di*Fstrat))) #density independent
      if(PB.ratio<0) B.dd= max(c(.001,(B.dd+B.dd*PB.ratio-B.dd*Fstrat)))
      if(PB.ratio>=0) B.dd= max(c(.001,(B.dd+B.dd*PB.ratio*(1-(B.dd/K)^theta)-B.dd*Fstrat)))
      proj.di[i,MC]= B.di
      proj.dd[i,MC]= B.dd
    }
  }
  proj.out= list(proj.di=proj.di,proj.dd=proj.dd)
  proj.out
}



#' Determines the probability of achieving objective (reference point) each year for each monte carlo run
#'
#' @param proj.out the output of the monte carlo projections (generated by running projection.f)
#' @param PB the PB model output
#' @param ref.pt the multiplier of the reference period biomass to calculate reference point of interest
#' @keywords projection, reference point, rank, probability
#' @export
rankprob.f= function(proj.out, PB, ref.pt){
  Bref= ref.pt*sum(PB$Index.q * PB$refererence.years)/sum(PB$refererence.years)
  obj.prob.di= cbind(rep(Bref,nrow(proj.out$proj.di)),proj.out$proj.di)
  obj.prob.dd= cbind(rep(Bref,nrow(proj.out$proj.dd)),proj.out$proj.dd)
  P.di= vector(length=nrow(proj.out$proj.di))
  P.dd= P.di
  N= ncol(proj.out$proj.di)
  for (i in 1:nrow(obj.prob.di)){
    vec.di= obj.prob.di[i,]
    P.di[i]= 1-rank(vec.di)[1]/N
    vec.dd= obj.prob.dd[i,]
    P.dd[i]= 1-rank(vec.dd)[1]/N
  }
  years= (tail(PB$Year,1)+1):(tail(PB$Year,1)+length(P.di))
  P= data.frame(year= years, P.di= P.di, P.dd= P.dd)
  P
}


#' The final B value at the specified time period at different Fs and climate scenario.
#' @param PB the PB model output
#' @param Fseq a vector of F values to see how they perform
#' @param time.frame the time frame that you want to test make the test for. e.g. 5 years
#' @param N the number of monte carlo runs for projections
#' @param K the multiplier of maximum observed B (from Index.q) which will be the carrying capacity for the density dependent model
#' @keywords projection, reference point, rank, probability
#' @export
#' @examples
#' Fout= Fseq.f(PB,Fseq=seq(0,.2,length=100),time.frame=time.frame, N=N, K=K)
Fseq.f= function(PB, PBproj, Fseq, time.frame, N, K){
  keep.di= matrix(ncol=N,nrow=length(Fseq))
  keep.dd= keep.di
  Kabs= K*max(PB$Index.q)
  fcounter=1
  for(f in Fseq){
    for(MC in 1:N) {
    B.di= tail(PB$Index.q,1)*Bstart.mult
    B.dd= B.di
    for(i in 1:time.frame){
      PB.ratio= PBproj[i,MC]
      B.di= max(c(.001,(B.di+B.di*PB.ratio-B.di*f)))
      if(PB.ratio<0) B.dd= max(c(.001,(B.dd+B.dd*PB.ratio-B.dd*f)))
      if(PB.ratio>=0) B.dd= max(c(.001,(B.dd+B.dd*PB.ratio*(1-(B.dd/Kabs)^theta)-B.dd*f)))
      } # we only need to keep the last value in the projection
      keep.di[fcounter,MC]= B.di
      keep.dd[fcounter,MC]= B.dd
   }
    fcounter=fcounter+1
  }
  F.out= list(f= Fseq,f.di= keep.di, f.dd= keep.dd)
}

#' Calculates the probability of being at or above the reference B value at the end of the time frame specified.
#'
#' @param PB the PB model output
#' @param Fprob the output of Fseq.f, i.e. the final B value at the end of a specified period
#' @param ref.pt the multiplier of the reference period giving the reference point
#' @keywords projection, reference point, rank, probability
#' @export
#' @examples
#' PofF.f(PB,Fout)
PofF.f=function(PB,Fprob,ref.pt){
  Bref= ref.pt*sum(PB$Index.q * PB$refererence.years)/sum(PB$refererence.years)
  obj.prob.di= cbind(rep(Bref,nrow(Fprob$f.di)),Fprob$f.di)
  obj.prob.dd= cbind(rep(Bref,nrow(Fprob$f.dd)),Fprob$f.dd)
  P.di= vector(length=nrow(obj.prob.di))
  P.dd= P.di
  N= ncol(Fprob$f.di)
  for (i in 1:nrow(obj.prob.di)){
    vec.di= obj.prob.di[i,]
    P.di[i]= 1-rank(vec.di)[1]/N
    vec.dd= obj.prob.dd[i,]
    P.dd[i]= 1-rank(vec.dd)[1]/N
  }
  years= (tail(PB$Year,1)+1):(tail(PB$Year,1)+length(P.di))
  P= data.frame(f= Fprob$f, P.di= P.di, P.dd= P.dd)
  P
}

#' For multiple E and F scenario, the probability of achieving the refernece point is determined
#'
#' @param E.CCF The list of E scenarios
#' @param PB.CCF the list of PB scenarios from E.CCF and PvsE relationship
#' @param Fs The vector of Fs to test
#' @param PB the data and model fit coming from applying the PB model (PB.f)
#' @param ref.pt there reference point multiplier as a proportion of the reference period
#' @param Bstart.mult the starting biomass as a proportion of the last data year biomass (Index.q)
#' @param K The multiplier of maximum observed biomass to be carrying capacity
#' @param theta the skewness of the density dependence factor (1=Schaeffer)
#' @keywords projection, reference point, rank, probability
#' @export
#' @examples
#'	fs= c(seq(0,.1,length=10),seq(0.11,0.5,length=10))
#'	P.R.for.EF.f(E.CCF=ECCF,PB.CCF=PBCCF,Fs=fs, PB=PB, ref.pt=ref.pt, Bstart.mult=Bstart.mult, K=K, theta=theta)
P.R.for.EF.f= function(E.CCF, PB.CCF, Fs, PB, ref.pt, Bstart.mult, K, theta=1){
	Pend= data.frame(ncol=7,nrow=length(Fs)*length(PB.CCF))
	Fcounter=1
	for (Erun in 1:length(PB.CCF)){
		PBproj= PB.CCF[[Erun]]
		Eproj= E.CCF[[Erun]]
		for(i in Fs){
			Pend[Fcounter,1]= i
			Pend[Fcounter,2:4]= quantile(Eproj,c(0.05,0.5,0.95))
			projf= projection.f(PB=PB, Bstart.mult=Bstart.mult, PBproj=PBproj, Fstrat=i, K=K, theta=theta)
			Pend[Fcounter,5:7]= tail(rankprob.f(projf, PB=PB, ref.pt=ref.pt),1)
			Fcounter= Fcounter+1
		}
	}
	names(Pend)= c("Fval","E.low","E.med","E.high","year","P.di","P.dd")
	Pend
}
