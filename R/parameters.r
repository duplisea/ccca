params.f= function(){
params= list(
# reference years
  ref.years= 1995:2000,

# PB model fit options (you can change this)
	q= 1, # catchability of the survey

# Reference point options and simulation starting options (you can change these)
	ref.pt= 1, # a proportion of reference period. If 1 is like a Bmsy proxy assuming your reference period is like Bmsy. 0.4 might be like Blim.
  risk= 0.5, # acceptable risk of not achieving reference point
	time.frame= 10, #desired time (years) to reach reference point
	B.start.prop= 1, #starting biomass for simulation as a proportion of the last year of index data. You might make this really low to see how the stock recovers from a low biomass state

# E model and projection options (you can change these)
	Bstart.mult= 1, # a multiplier of the biomass in the last data year as a starting biomass for the projection
	K= 3, # the carrying capacity as a multiplier of the large B observed in the data
	theta= 1, # the degree of asymmetry in the density dependent assumption. 1=schaeffer.
	model.type= "gam", #gam" #"poly", "gam.adaptive" #this is the kind of model you want to use to fit the PB vs E relationship
	poly.degree= 2, #if you chose "poly" for model.type this is the degree of the polynomial you want to fit
	knots= 12, #floor(nrow(turbot)/2.5), #If you chose "gam.adaptive" for model.type, you can decrease this to give more df to gam smooth, set it to 1 for letting it choose itself.
  add.resids=1, #either 0 or 1 but do not use other value. If 1 it resamples the residuals from P/B vs E and adds to P/B value
  densfun= "normal", # the type of distribution fitted to the E variable for parametric resampling of future scenarios
  Emean.shift=0.0, # the mean temperature shift in the gamma for resampling
  E.var.inc= 1, # Change the sd of the E dist normal
  N= 2000, # This is the number of future climate realisations you want to create for calculation of confidence intervals and risk.
	proj.years= 10, # The number of the years you want to predict into the future. It must be >= time.frame
	N.CCF= 1000, #number of MC runs for determining CCF.
  Emean.shifts= c(0,seq(-2,2,length=75)), #E shifts to test for CCF run
	fs= c(seq(0,.1,length=10),seq(0.11,0.5,length=10)) # F sequence to test for CCF
	)
  if(params$add.resids!=0 && params$add.resids!=1) stop("add resids term must be = 0 or 1")
  params
}

#params= params.f()
#save(params,file="~/github/ccca/data/params.rda")
#mapply(assign, names(params), params, MoreArgs=list(envir = globalenv()))

