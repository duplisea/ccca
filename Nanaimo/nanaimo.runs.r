# a ccca run and a series of analyses and graphs that we developed at our Nanaimo work week
# 16-20 Sept 2019. Karen, MJ, Dan

#################################################
# you probably only want to run the whole script just once for you objective and perhaps just the PB model part
# below this model run and plotting code is the scoring based stuff
#################################################

#install and load the CCCA and climatestripes packages from github
  devtools::install_github("duplisea/ccca")
  devtools::install_github("duplisea/climatestripes")
  library(ccca)
  library(climatestripes)

  #setwd("~/github/ccca/Nanaimo/")
# begin setting up and then do a CCCA run
  data(params)
  mapply(assign, names(params), params, MoreArgs=list(envir = globalenv()))

  # a ccca run with the USR reference point (0.8), 8 years, risk of 0.2 (1-0.8)
  time.frame=8
  proj.years=time.frame
  risk=0.8
  ref.years=1996:2002
  ref.pt=0.8
  cccf.contour=F #if you want the safe operating space graph set this to T. It takes sometime to run though (minutes)

  #run the model PB model
  PB= PB.f(turbot, ref.years=ref.years, q=q) #turbot projection
  #PB= PB.f(shrimp, ref.years=ref.years, q=q) #shrimp projection

  # fit the PvsE relationship
  PvsE= PBE.fit.f(PB,model.type=model.type, knots=knots, poly.degree=poly.degree)

  # fit a normal distirbution to E variable
  Enorm= norm.fit.f(E=PB$E)
  Edist.a=Enorm$estimate[1]
  Edist.b=Enorm$estimate[2]

  # setup the E projections given specifications in parameters file
  Eproj= Eprojnorm.f(Edist.a=Edist.a, Edist.b=Edist.b, Emean.shift=Emean.shift, proj.years=proj.years, N)

  # Determine P/B projection based on E projection and the PvsE relationship
  PBproj= PB.for.projection.f(PvsE=PvsE,Eproj,add.residuals=add.resids)

  # Determine the fishing strategy for projections
  Fstrat= F.strategy(PB, 2014:2018, moratorium=F)

  # Run the projections and calculate various summaries and statistics from them
  Bproj= projection.f(PB=PB, Bstart.mult=Bstart.mult, PBproj=PBproj, Fstrat, K=K, theta=1)
  Fout= Fseq.f(PB,PBproj=PBproj,Fseq=fs,time.frame=time.frame, N=N, K=K)
  PofF= PofF.f(PB,Fout,ref.pt=ref.pt)
  Bproj.summary= Bproj.summary.f(PB,Bproj,PBproj,Eproj)
  P= rankprob.f(Bproj,PB,ref.pt)

  # Run the projections for the Null model
  PvsE.null= PBE.fit.f(PB,model.type="avg", knots=knots, poly.degree=poly.degree)
  PBproj.null= PB.for.projection.f(PvsE=PvsE.null,Eproj,add.residuals=add.resids)
  Bproj.null= projection.f(PB=PB, Bstart.mult=Bstart.mult, PBproj=PBproj.null, Fstrat, K=K, theta=1)
  Fout.null= Fseq.f(PB,PBproj=PBproj.null,Fseq=fs,time.frame=time.frame, N=N, K=K)
  PofF.null= PofF.f(PB,Fout.null,ref.pt=ref.pt)
  Bproj.summary.null= Bproj.summary.f(PB,Bproj.null,PBproj.null,Eproj)
  P.null= rankprob.f(Bproj.null,PB,ref.pt)

  # Run projections for a warm shift of 0.25 degrees
  Emean.shift.warm=0.25
  Eproj.warm= Eprojnorm.f(Edist.a=Edist.a, Edist.b=Edist.b, Emean.shift=Emean.shift.warm, proj.years=proj.years, N)
  PBproj.warm= PB.for.projection.f(PvsE=PvsE,Eproj.warm,add.residuals=add.resids)
  Bproj.warm= projection.f(PB=PB, Bstart.mult=Bstart.mult, PBproj=PBproj.warm, Fstrat, K=K, theta=1)
  Fout.warm= Fseq.f(PB,PBproj=PBproj.warm,Fseq=fs,time.frame=time.frame, N=N, K=K)
  PofF.warm= PofF.f(PB,Fout.warm,ref.pt=ref.pt)
  Bproj.summary.warm= Bproj.summary.f(PB,Bproj.warm,PBproj.warm,Eproj.warm)
  P.warm= rankprob.f(Bproj.warm,PB,ref.pt)

  # Run projections for a cold shift of 0.25 degrees
  Emean.shift.cold=-0.25
  Eproj.cold= Eprojnorm.f(Edist.a=Edist.a, Edist.b=Edist.b, Emean.shift=Emean.shift.cold, proj.years=proj.years, N)
  PBproj.cold= PB.for.projection.f(PvsE=PvsE,Eproj.cold,add.residuals=add.resids)
  Bproj.cold= projection.f(PB=PB, Bstart.mult=Bstart.mult, PBproj=PBproj.cold, Fstrat, K=K, theta=1)
  Fout.cold= Fseq.f(PB,PBproj=PBproj.cold,Fseq=fs,time.frame=time.frame, N=N, K=K)
  PofF.cold= PofF.f(PB,Fout.cold,ref.pt=ref.pt)
  Bproj.summary.cold= Bproj.summary.f(PB,Bproj.cold,PBproj.cold,Eproj.cold)
  P.cold= rankprob.f(Bproj.cold,PB,ref.pt)

  # Run projections for a status quo mean termperature but increase sd of temperature distribution by factor of 1.2
  Emean.shift=0.0
  E.var.inc=1.2
  Edist.b= Edist.b*E.var.inc
  Eproj.var= Eprojnorm.f(Edist.a=Edist.a, Edist.b=Edist.b, Emean.shift=Emean.shift,
    proj.years=proj.years, N)
  PBproj.var= PB.for.projection.f(PvsE=PvsE,Eproj.var,add.residuals=add.resids)
  Bproj.var= projection.f(PB=PB, Bstart.mult=Bstart.mult, PBproj=PBproj.var, Fstrat, K=K, theta=1)
  Fout.var= Fseq.f(PB,Fseq=fs,PBproj=PBproj.var,time.frame=time.frame, N=N, K=K)
  PofF.var= PofF.f(PB,Fout.var,ref.pt=ref.pt)
  Bproj.summary.var= Bproj.summary.f(PB,Bproj.var,PBproj.var,Eproj.var)
  P.var= rankprob.f(Bproj.var,PB,ref.pt)

  if(cccf.contour){
  # contour plot projections given different F strategies and shifts in the mean temperature
    Edist.a=Enorm$estimate[1]
    Edist.b=Enorm$estimate[2]
    ECCF= Eproj.list.f(Emean.shifts=Emean.shifts, N=N.CCF, proj.years=proj.years, Edist.a=Edist.a,Edist.b=Edist.b)
    PBCCF= PBproj.list.f(PvsE=PvsE, Eprojection=ECCF)
    CCF.raw= P.R.for.EF.f(E.CCF=ECCF, PB.CCF=PBCCF, Fs=fs, PB=PB, ref.pt=ref.pt, Bstart.mult=Bstart.mult,K=K, theta=theta)

    ## save these as objects if you want because they take a long time to run
     save(ECCF,file="ECCF.rda")
     save(PBCCF,file="PBCCF.rda")
     save(CCF.raw,file="CCF.rda")
    # load("ECCF.rda")
    # load("PBCCF.rda")
    # load("CCF.rda")
  }

  ## Plots of the data and projections (it will save them as .png or .svg to your disk

  # Figure 1: Map of the Gulf of St Lawrence showing the main turbot fishing areas
  png("Fig1.png")
  	map.f(longs=c(-70,-57),lats=c(46,52))
  	polygon(fishing.area1$X,fishing.area1$Y,col="green",density=NA,border=NA,angle=0)
  	polygon(fishing.area2$X,fishing.area2$Y,col="green",density=NA,border=NA,angle=0)
  	polygon(fishing.area3$X,fishing.area3$Y,col="green",density=NA,border=NA,angle=0)
  	bathy=T
  	if (bathy){
	    isob=c(150,300)
      isob.col= c("blue","slategrey")
  	  ocCL = contourLines(ocBathy, levels =isob)
      ocCP = convCP(ocCL, projection = "LL")
      ocPoly = ocCP$PolySet
      addLines(thinPolys(ocPoly, tol=1,filter = 5), col =isob.col)
      legend("bottomleft", bty = "n", col = isob.col, lwd = 1, legend = as.character(isob), inset = 0.05,
         title = "Isobaths (m)",cex=0.7)
  	}
  	mtext("Longitude west", side=1,line=2.7,cex=1.2)
  	mtext("Latitude north", side=2,line=3.5,cex=1.2)
  	#inset map to place in North America
    	par(fig = c(0,0.4,.6,.83), new = T) #position of the inset box on the current map
    	map.inset.f(longs=c(-130,-50),lats=c(10,65)) #coordinates of land area covered by inset
    	rect(-70,46,-57,52,border="blue",lwd=1) #smaller area highlighted in the inset
    	box(lwd=2,col="black")
	dev.off()


  # Figure 2: the basic inputs to the P/B model.
	png("Fig2.png")
  	par(omi=c(1,1,1,1))
    matplot(turbot$Year, cbind(turbot$Index,turbot$Catch),type="l",lty=c(1,1),lwd=2,xlab="Year",ylab="Survey biomass and catch (kt)",col=c("black","green"))
    yaxis2.f(turbot$Year, turbot$E,ylabel=expression('Temperature ('^o*C*')'),type="l",cex=1.1,lwd=2,lty=1,col="red")
  #    mtext(side=4,line=1,text=expression('Temperature ('^o*C*')'))
    legend("topleft",bty="n",legend=c("Survey","Catch","Temperature"),lwd=2,lty=c(1),cex=0.7,col=c("black","green","red"))
  dev.off()

  #Figure 3: a Kobe plot of biomass relative to the reference period (1995-2000) biomass and the relative exploitation rate in the reference period. The water temperature at 250 m is colour coded on top (blue-red:cold-warm)
  png("Fig3.png")
    Kobe.f(PB=PB,E=PB$E)
    colramp.legend(col1="red", col2="blue", ncol=length(PB$E), 2.5, 3.5, 2.7, 4.5)
  dev.off()


  # Figure 4: The relationship between the stock P/B ratio and the environmental variable (temperature Central Gulf 150 m) with an adaptive GAM model fitted to the relationship."}
  png("Fig4.png")
    PvsE= PBE.fit.f(PB,model.type=model.type, knots=knots, poly.degree=poly.degree)
    na.year= nrow(PB)
    plot(na.omit(cbind(PB$E,PB$PB)),pch=20,xlab="E",ylab="P/B",col="darkgrey",type="n")
    text(PB$E[-na.year],PB$PB[-na.year],PB$Year[-na.year],cex=.7)
    pred.x= seq(min(PB$E)*.90,max(PB$E)*1.05,length=1000)
    lines(pred.x,predict(PvsE.null,newdata=data.frame(E=pred.x)),lwd=2,col="grey")
    lines(pred.x,predict(PvsE,newdata=data.frame(E=pred.x)),lwd=2)
  dev.off()

  # Figure 5: The distributions of temperature used for projection scenarios. Black is the baseline where the distribution was fitted to all years; red is shift in the mean 0.5 C warmer than the baseline; blue line is 0.5 C colder than the baseline; green line has the same mean as the baseline but a 50% increase in standard deviation
  png("Fig5.png")
    Nrand=1000000
    Edist.a=Enorm$estimate[1]
    Edist.b=Enorm$estimate[2]
    Ebase=density(norm.plot.f(Nrand=Nrand, Edist.a=Edist.a, Edist.b=Edist.b,Emean.shift=0,E.var.inc=1))
    Ewarm=density(norm.plot.f(Nrand=Nrand, Edist.a=Edist.a, Edist.b=Edist.b,Emean.shift=Emean.shift.warm,E.var.inc=1))
    Ecold=density(norm.plot.f(Nrand=Nrand, Edist.a=Edist.a, Edist.b=Edist.b,Emean.shift=Emean.shift.cold,E.var.inc=1))
    Evar=density(norm.plot.f(Nrand=Nrand, Edist.a=Edist.a, Edist.b=Edist.b,Emean.shift=0,E.var.inc=1.2))
    plot(Ebase, xlab=expression('Temperature('^o*C*')'), ylab="Density",xlim=c(0,6),lwd=2,main="")
    lines(Ewarm, lwd=2,col="red")
    lines(Ecold, lwd=2,col="blue")
    lines(Evar, lwd=2,col="green")
  dev.off()

  # Figure 6: the P/B distributions used in projections for the different climate scenarios. Black is the baseline where the temperature distribution was fitted to all years; red is shift in the mean 0.5 C warmer than the baseline; blue line is 0.5 C colder than the baseline; green line has the same mean as the baseline but a 50% increase in standard deviation
  png("Fig6.png")
    plot(density(PBproj.null),xlab="P/B",ylab="Density",lwd=2,main="",col="grey")
    lines(density(PBproj.cold),lwd=2,col="blue")
    lines(density(PBproj.warm),lwd=2,col="red")
    lines(density(PBproj.var),lwd=2,col="green")
    lines(density(PBproj),lwd=2,col="black")
  dev.off()

  #Figure 7: the probability of achieving the objective each year during a 10 year projection of the status quo fishing rate and baseline temperature scenario.
  svg("Fig7.svg")
    par(mfcol=c(5,1),mar=c(1,4,2,2),omi=c(.6,2.2,.1,2.2))
    matplot(P.null[,1],P.null[,-1],type='l',xlab="",ylab="",lwd=3,ylim=c(0,1),lty=1,col=c("black","blue"))
    legend("topright",legend=c("Density independent","Density dependent"),lwd=2,col=c("black","blue"),bty="n",cex=0.75)
    legend("topleft",legend="Null",bty="n",cex=0.75)
    abline(h=1-risk,lty=2,col="grey")
    box()

    matplot(P[,1],P[,-1],type='l',xlab="",ylab="",lwd=3,ylim=c(0,1),lty=1,col=c("black","blue"))
    legend("topleft",legend="Mean temperature",bty="n",cex=0.75)
    abline(h=1-risk,lty=2,col="grey")
    box()

    matplot(P.warm[,1],P.warm[,-1],type='l',xlab="",ylab="",lwd=3,ylim=c(0,1),lty=1,col=c("black","blue"))
    legend("topleft",legend="0.25 °C warmer",bty="n",cex=0.75)
    abline(h=1-risk,lty=2,col="grey")
    box()

    matplot(P.cold[,1],P.cold[,-1],type='l',xlab="",ylab="",lwd=3,ylim=c(0,1),lty=1,col=c("black","blue"))
    legend("topleft",legend="0.25 °C colder",bty="n",cex=0.75)
    abline(h=1-risk,lty=2,col="grey")
    box()

    matplot(P.var[,1],P.var[,-1],type='l',xlab="",ylab="",lwd=3,ylim=c(0,1),lty=1,col=c("black","blue"))
    legend("topleft",legend="sd x 1.2",bty="n",cex=0.75)
    abline(h=1-risk,lty=2,col="grey")
    box()

    mtext(side=1,outer=F,text="Year",line=4)
    mtext(outer=T,side=2,text="Probability of being at or above biomass objective",line=-1)
  dev.off()


  svg("Fig8.svg")
    # The maximum exploitation rate that would allow the stock to achieve the objective in the specified period of time at the specified risk level for density independent and density dependent models and the baseline temperature scenario
    par(mfcol=c(5,1),mar=c(1,4,2,2),omi=c(.6,2.2,.1,2.2))

    matplot(PofF.null[,1],PofF.null[,-1],xlab="", ylab="" ,ylim=c(0,1),
    type="l",lwd=3,xaxs="i",yaxs="i",lty=1,col=c("black","blue"))
    legend("topright",legend=c("Density independent","Density dependent"),lwd=2,col=c("black","blue"),bty="n",cex=0.75)
    legend("topleft",legend="Null",bty="n",cex=0.75)
    di.intersection= predict(gam(f~s(P.di),data=PofF.null),newdata=data.frame(P.di=1-risk))
    dd.intersection= predict(gam(f~s(P.dd),data=PofF.null),newdata=data.frame(P.dd=1-risk))
    rect(0,0,di.intersection,1-risk,lty=2,border="darkgrey")
    rect(0,0,dd.intersection,1-risk,lty=2,border="darkgrey")
    box()

    matplot(PofF[,1],PofF[,-1],xlab="", ylab="" ,ylim=c(0,1),
    type="l",lwd=3,xaxs="i",yaxs="i",lty=1,col=c("black","blue"))
    legend("topleft",legend="Mean temperature",bty="n",cex=0.75)
    di.intersection= predict(gam(f~s(P.di),data=PofF),newdata=data.frame(P.di=1-risk))
    dd.intersection= predict(gam(f~s(P.dd),data=PofF),newdata=data.frame(P.dd=1-risk))
    rect(0,0,di.intersection,1-risk,lty=2,border="darkgrey")
    rect(0,0,dd.intersection,1-risk,lty=2,border="darkgrey")
    box()

    # warm
    matplot(PofF.warm[,1],PofF.warm[,-1],xlab="", ylab= "",ylim=c(0,1),
    type="l",lwd=3,xaxs="i",yaxs="i",lty=1,col=c("black","blue"))
    legend("topleft",legend="0.25 °C warmer",bty="n",cex=0.75)
    di.intersection= predict(gam(f~s(P.di),data=PofF.warm),newdata=data.frame(P.di=1-risk))
    dd.intersection= predict(gam(f~s(P.dd),data=PofF.warm),newdata=data.frame(P.dd=1-risk))
    rect(0,0,di.intersection,1-risk,lty=2,border="darkgrey")
    rect(0,0,dd.intersection,1-risk,lty=2,border="darkgrey")
    box()

    # cold
    matplot(PofF.cold[,1],PofF.cold[,-1],xlab="", ylab= "",ylim=c(0,1),
    type="l",lwd=3,xaxs="i",yaxs="i",lty=1,col=c("black","blue"))
    legend("topleft",legend="0.25 °C colder",bty="n",cex=0.75)
    di.intersection= predict(gam(f~s(P.di),data=PofF.cold),newdata=data.frame(P.di=1-risk))
    dd.intersection= predict(gam(f~s(P.dd),data=PofF.cold),newdata=data.frame(P.dd=1-risk))
    rect(0,0,di.intersection,1-risk,lty=2,border="darkgrey")
    rect(0,0,dd.intersection,1-risk,lty=2,border="darkgrey")
    box()

    # increased variance
    matplot(PofF.var[,1],PofF.var[,-1],xlab="", ylab= "",ylim=c(0,1),
    type="l",lwd=3,xaxs="i",yaxs="i",lty=1,col=c("black","blue"))
    legend("topleft",legend="sd x 1.2",bty="n",cex=0.75)
    di.intersection= predict(gam(f~s(P.di),data=PofF.var),newdata=data.frame(P.di=1-risk))
    dd.intersection= predict(gam(f~s(P.dd),data=PofF.var),newdata=data.frame(P.dd=1-risk))
    rect(0,0,di.intersection,1-risk,lty=2,border="darkgrey")
    rect(0,0,dd.intersection,1-risk,lty=2,border="darkgrey")
    box()

    mtext(side=1,outer=F,text="Exploitation rate",line=4)
    mtext(outer=T,side=2,text="Probability of being at or above biomass objective in 10 years",line=-1)
  dev.off()


  # a contour plot showing the probability of achieveing the obective in the specified time period under different exploitatin rates and future temperature scenarios for the density independent model. The actual time series of temperature an exploitation rate  is shown as the blue line overlay."}
  if(cccf.contour){
    svg("Fig9.svg")
      CCF.contour=interp(x=CCF.raw$E.med,y=CCF.raw$Fval,z=CCF.raw$P.di)
      contour(CCF.contour,xlab="Median temperature (°C)",ylab="Exploitation rate",xaxs="i",yaxs="i")
      risk.equi.exp.rate.di= contourLines(CCF.contour$x,CCF.contour$y,CCF.contour$z,nlevels=1,levels=1-risk)
      confint(risk.equi.exp.rate.di[[1]]$x,risk.equi.exp.rate.di[[1]]$y*0,risk.equi.exp.rate.di[[1]]$y,col=rgb(0, 1, 0,0.5))
      lines(PB$E,PB$F.rel,col="slateblue",lwd=1)
      points(PB$E,PB$F.rel,col="slateblue",pch=20)
      year.endpoints= match(range(PB$Year),PB$Year)
      points(PB$E[year.endpoints],PB$F.rel[year.endpoints],pch=22,cex=3,bg="white",col="slateblue")
      text(PB$E[year.endpoints],PB$F.rel[year.endpoints],PB$Year[year.endpoints],cex=.5)
    dev.off()
  }
################################################################
  # you only need to run the part above once per session
################################################################


  # stuff done at the Nanaimo meeting

  ref= PB$refererence.years==1
  Eref=sum(PB$E*PB$refererence.years)/sum(PB$refererence.years)

  #min max scaling function
  minmax.scaling.f= function(X, ...){
    X.mms= (X-min(X, ...))/(max(X, ...)-min(X, ...))
    X.mms
  }

  Emms= minmax.scaling.f(PB[,2], na.rm=T)
  Emms2= minmax.scaling.f(PB[,2]/Eref, na.rm=T)
  Eref.mms= minmax.scaling.f(PB$E[ref])
  plot(density(Emms))
  #hist(Eref.mms)
  abline(v=Emms)
  abline(v=quantile(Emms,c(.1,.25,.5,.75,.9)),col="red",lwd=4)

  cols=minmax.scaling.f(rank(floor(PB$Year/10)*10))
  cols[cols==1]="red"
  cols[cols==0]="blue"
  cols[cols!="red" & cols!="blue"]="green"

  # flagging plots. Vertical lines coloured by decade
  par(mfcol=c(1,2))
  plot(density(PB$E[ref]),xlab="E variable",main="",lwd=3)
  abline(v=PB$E,col=cols)
  abline(v=quantile(PB$E[ref],c(.1,.25,.5,.75,.9)),col="grey",lwd=4,lty=2)
  text(PB$E,seq(0.7,.2,length=length(PB$E)),PB$Year,cex=.6)

  library(climatestripes)
  temperature.vector=PB$E/Eref
  time.vector=PB$Year
  title.name= "Greenland halibut relevant E variable"
  climate.col.stripes.f(time.vector= time.vector,temperature.vector=temperature.vector,
  colour.vec=c("navyblue","lightblue", "red","darkred"),
  title="",
  legend=F,
  text.col.legend="yellow")
  superimpose.data.f(time.vector=time.vector, temperature.vector=temperature.vector, data.colour="yellow",
    spline=F, spline.colour="white",lwd=4)

  title(title.name, outer=TRUE,line=-2)

  # need to develop some kind of runs test to visually show when successive years are in the tails of
  # distributions.


  Estd= PB$E/Eref
  Estd.minmax= minmax.scaling.f(Estd)
  Estd.minmax #E over E ref minmax standardised
  S.GHAL= 3.8/4 #max sensitivity score, standardised
  x.years=3
  catch.recent= mean(tail(PB$Catch,x.years)) #status quo catch of last x years
  E.recent= mean(tail(Estd.minmax,x.years)) #E/Eref mean deviation over the last x years
  buffer= 1-S.GHAL*E.recent
  buffer
  buffer*catch.recent


  # a scoring function approach
  ccf.scoring.f= function(E.series, E.base, status.quo.years=3, Smin, Smax, k, N=1000){
    Estd= E.series/E.base
    Estd.minmax= minmax.scaling.f(Estd)
    E.recent= mean(tail(Estd.minmax,status.quo.years)) #E/Eref mean deviation over the last x years
    S= runif(N,Smin,Smax)
    buffer.vector=vector()
    for (i in 1:N){
      buffer.vector[i]= 1-S[i]*E.recent*k
    }
    #buffer.vector[buffer.vector<(1-max.change)]= 1-max.change
    buffer.vector
  }

  Y=ccf.scoring.f(PB$E, E.base=2.78,status.quo.years=3,Smin=0.7,Smax=0.9,k=0.5, N=1000)
  hist(Y)

  new.advice= mean(tail(PB$Catch,x.years))*quantile(Y,c(0.25,0.75))
  mean(tail(PB$Catch,x.years))
  new.advice


  # this determines how the probability of being in the crticial zone might change as a result
  # of a climate induced change in distribution that affects the observation uncertainty of B
  # in the last data year. Here is uses the same k as above but this is not correct because
  # the k above is meant as an input to the equation which is a buffer on the management measure
  # catch but this is a multiplier of the uncertainty on the B estimate.
  CV=0.2 # a cv on biomass in th last year
  LRP= 10 #limit reference point from Gauthier & Bourdages
  B2018=tail(PB$Index.q,1) # biomass in the last year from the survey index
  std= CV*B2018 # standard deviation given the CV and mean biomass in the last year
  std

  enhanced.std= CV*B2018/mean(Y) #enhance the stdev from the function above based on the buffer
  enhanced.std

  p.regular= pnorm(LRP,B2018,std) #probability that biomass is below LRP given the mean B and CV with estimated stdev
  p.enhanced= pnorm(LRP,B2018,enhanced.std) #probability that biomass is below LRP given the mean B and enhanced stdev

  par(mfcol=c(1,2))
  curve(dnorm(x,B2018,std),1,B2018*3,col="blue",lwd=2,
    ylab="Density",xlab="Survey biomass estimate in 2018")
  abline(v=B2018,col="blue")
  abline(v=LRP,col="red")
  enhanced.std.curve=dnorm(seq(1,B2018*3,length=1000),B2018,enhanced.std)
  lines(seq(1,B2018*3,length=1000),dnorm(seq(1,B2018*3,length=1000),B2018,enhanced.std),col="green",lwd=2)
  abline(h=dnorm(LRP,B2018,enhanced.std),col="red")
  legend("topright", legend=c("regular variance","enhanced variance"),lwd=2,col=c("blue","green"),bty="n",cex=0.7)

  curve(pnorm(x,B2018,std),1,B2018*3,col="blue",lwd=2,
      ylab="Cumulative probability",xlab="Survey biomass estimate in 2018")
  abline(v=B2018,col="blue")
  abline(v=LRP,col="red")
  enhanced.std.curve=pnorm(seq(1,B2018*3,length=1000),B2018,enhanced.std)
  lines(seq(1,B2018*3,length=1000),pnorm(seq(1,B2018*3,length=1000),B2018,enhanced.std),col="green",lwd=2)
  abline(h=pnorm(LRP,B2018,enhanced.std),col="red")
  legend("right", legend=c(paste0("regular variance=",round(p.regular,3)),
    paste0("enhanced variance=",round(p.enhanced,3))),bty="n",cex=0.7)

  title("Amount of probability of B estimate below the Limit",outer=TRUE,line=-2)

  Y=ccf.scoring.f(PB$E, E.base=2.78,status.quo.years=3,Smin=0.7,Smax=0.9,k=0.8, N=1000)
  CV*B2018/mean(Y) #enhance the stdev from the function above based on the buffer
