# Plotting functions:
# These are functions that create some standard plots of both the input data, the simple P/B model and the projected
# impacts of different climate scenarios on the fate of the stock

####################################################################################################################
#' Make Kobe plots from simple data with overlay of another time series
#'
#' @param PB the data and model fit coming from applying the PB model (PB.f)
#' @param E the time series to overlay and colour code Kobe years
#' @param col1 the colour at lowest value
#' @param col2 the colour at the highest value
#' @param ... par options for plot
#' @keywords Kobe, reference point, Bmsy, environment
#' @export
#' @examples
#' Kobe.f(PB=PB,E=PB$E)
Kobe.f= function(PB, E, col1="blue", col2="red", ...){

	Year= PB$Year
	F.rel= PB$F.rel
	Index.q= PB$Index.q
	base= PB$refererence.years==1
	E.kobe= E/mean(E[base])
	F.kobe= F.rel/mean(F.rel[base])
	B.kobe= Index.q/mean(Index.q[base])

  plot(B.kobe,F.kobe,type="b",pch="    ",xlab=expression("B/B"["base"]),ylab=expression("F/F"["base"]),...)
  E.categ= floor(E*4)/4 #quarter degree C categories
  tempcol=colorRampPalette(c(col1, col2))(length(E.kobe))
  temperaturecolours= tempcol[order(E.categ)]
  last.year= length(F.kobe)
  points(B.kobe,F.kobe,pch=21,bg=temperaturecolours,col=temperaturecolours,cex=1)
  points(B.kobe[1],F.kobe[1],pch=21,bg=temperaturecolours[1],col=temperaturecolours[1],cex=3)
  text(B.kobe[1],F.kobe[1],PB$Year[1],col="white",cex=0.55,font=2)
  points(B.kobe[last.year],F.kobe[last.year],pch=21,bg=temperaturecolours[last.year],col=temperaturecolours[last.year],cex=3)
  text(B.kobe[last.year],F.kobe[last.year],PB$Year[last.year],col="white",cex=0.55,font=2)
  abline(h=1,col="grey")
  abline(v=1,col="grey")
}

#' A colour ramp legend for the E variable in a Kobe plot
#'
#' @param col1 the top colour of the colour ramp
#' @param col1 the bottom colour of the colour ramp
#' @param ncol the number of colours in the ramp (typically length(E))
#' @param xleft a vector (or scalar) of left x positions
#' @param ybottom a vector (or scalar) of bottom y positions
#' @param xright a vector (or scalar) of right x positions
#' @param ytop a vector (or scalar) of top y positions
#' @param ... par options for plot
#' @keywords Kobe, legend, gradient, reference point, Bmsy, environment
#' @export
#' @examples
#' colramp.legend(col1="red", col2="blue", ncol=length(PB$E), 2.5, 3.5, 2.7, 4.5)
colramp.legend= function(col1="red", col2="blue", ncol, xleft, ybottom, xright, ytop, ...){
  tempcol=colorRampPalette(c(col1, col2))(ncol)
  legend_image <- as.raster(matrix(tempcol, ncol=1))
  rasterImage(legend_image, xleft=xleft, ybottom=ybottom, xright=xright, ytop=ytop)
  rasterImage(legend_image, 12,2,13,8)
  text(xright*1.02,ytop,labels=round(max(PB$E,na.rm=T),1),cex=0.8)
  text(xright*1.02,ybottom,labels=round(min(PB$E,na.rm=T),1),cex=0.8)
}



#' Summarise a projection with multiple Monte Carlo realisations to make a dataframe with quantiles for plotting
#'
#' @param PB the data and model fit coming from applying the PB model (PB.f)
#' @param Bproj the projected biomass for the climate and fishing scenario
#' @param PBproj the projected P/B ratio for the climate scenario
#' @param Eproj the projected climate scenario
#' @keywords projection, quantile, confidence interval
#' @export
#' @examples
#' proj.summary.f(PB,Bproj,PBproj,Eproj)
Bproj.summary.f= function(PB,Bproj,PBproj,Eproj){
	Bref= sum(PB$Index.q * PB$refererence.years)/sum(PB$refererence.years)
  Bproj.quants.di= t(apply(Bproj$proj.di,1,quantile,c(0.05,0.5,0.95)))
  Bproj.quants.dd= t(apply(Bproj$proj.dd,1,quantile,c(0.05,0.5,0.95)))
  Eproj.quants= t(apply(Eproj,1,quantile,c(0.05,0.5,0.95)))
  PBproj.quants= t(apply(PBproj,1,quantile,c(0.05,0.5,0.95)))
  #combine data with project in single data object
  proj.and.data= data.frame(
    year= c(PB$Year,max(PB$Year)+(1:nrow(PBproj))),
    B.di.CI.low= c(PB$Index.q,Bproj.quants.di[,1]),
    B.di.CI.med= c(PB$Index.q,Bproj.quants.di[,2]),
    B.di.CI.high= c(PB$Index.q,Bproj.quants.di[,3]),
    B.dd.CI.low= c(PB$Index.q,Bproj.quants.dd[,1]),
    B.dd.CI.med= c(PB$Index.q,Bproj.quants.dd[,2]),
    B.dd.CI.high= c(PB$Index.q,Bproj.quants.dd[,3]),
    E.CI.low= c(PB$E,Eproj.quants[,1]),
    E.CI.med= c(PB$E,Eproj.quants[,2]),
    E.CI.high= c(PB$E,Eproj.quants[,3]),
    PB.CI.low= c(PB$PB[-length(PB$PB)],PBproj.quants[,1],NA),
    PB.CI.med= c(PB$PB[-length(PB$PB)],PBproj.quants[,2],NA),
    PB.CI.high= c(PB$PB[-length(PB$PB)],PBproj.quants[,3],NA)
  )
  proj.and.data
}


#' Density of the gamma for different E accounting for mean and variance changes
#'
#' @param Nrand, the number of random values to make
#' @param shape
#' @param rate
#' @param Emean.shift
#' @param E.variance
#' @keywords
#' @export
#' @examples
Egamma.plot.f= function(Nrand, shape, rate, Emean.shift, E.variance){
  gval= rgamma(Nrand,rate=rate*E.variance,shape=shape*E.variance)+Emean.shift
  gval
}

#' Density of the gamma for different E accounting for mean and variance changes
#'
#' @param Nrand, the number of random values to make
#' @param Edist.a
#' @param Edist.b
#' @param Emean.shift
#' @param E.var.inc
#' @keywords
#' @export
#' @examples
norm.plot.f= function(Nrand, Edist.a, Edist.b, Emean.shift, E.var.inc){
  nval= rnorm(Nrand,mean=Edist.a,sd=Edist.b*E.var.inc)+Emean.shift
  nval
}
