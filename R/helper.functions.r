# helper functions

#' Draw polygon confidence intervals
#'
#' @param
#' @keywords helper function
#' @export
#' @examples
#'
confint= function(x,ylow,yhigh,...){
	polygon(x = c(x, rev(x)), y = c(ylow,rev(yhigh)), border = NA,...)
}


#' functions to extract P fit diagnostics from an lm object
#'
#' @param
#' @keywords helper function
#' @export
#' @examples
#'
lmP= function(lm.fit.object){
  P= round(anova(lm.fit.object)$'Pr(>F)'[1],4)
  if(P<0.0001) P="<0.0001"
  P
}

#' Adjusted r squared value from lm
#'
#' @param
#' @keywords helper function
#' @export
#' @examples
#'
lmRsq= function(lm.fit.object){
  adjR= round(summary(lm.fit.object)$adj.r.squared,2)
  adjR
}


#' Create a second y axis on the right side
#'
#' @param
#' @keywords helper function
#' @export
#' @examples
#'
yaxis2.f= function(x,y, ylabel="2ndyaxis",cex=0.75, ...){
  par(new=T)
  plot(x, y, axes=F, xlab=NA, ylab=NA, cex=cex, ...)
  axis(side=4)
  mtext(side=4, line=2.5, ylabel, cex=cex*.9)
}


#' Wrapper for the PBSmapping plotMap function
#'
#' @param
#' @keywords helper function
#' @export
#' @examples
#'
map.f= function(longs=c(-74,-50),lats=c(43,52.25),land.colour="sienna3",sea.colour="lightblue"){
  data(worldLLhigh)
  worldLLhigh$X=(worldLLhigh$X+180)%%360-180
  xlim=longs
  ylim=lats
  map.data=clipPolys(worldLLhigh,xlim=xlim,ylim=ylim)
  plotMap(map.data,xlim=xlim,ylim=ylim,lty=1,lwd=.05 ,col="tan",
          bg=rgb(224,253,254,maxColorValue=255),las=1,xaxt="n", yaxt="n",
          xlab="",ylab="")
  xint= seq(longs[1],longs[2],length=5)
  yint= seq(lats[1],lats[2],length=6)
  #mtext("Longitude west",side=1,line=3)
  #mtext("Latitude north",side=2,line=3)
  axis(1, at=xint, labels=xint*-1, lty=1,lwd=1,lwd.ticks= 1, cex.axis=.7)
  axis(2, at=yint, labels=yint*1, lty=1,lwd=1,lwd.ticks=1,las=1, cex.axis=.7)
}

#
#' An inset map for the main map function
#'
#' @param
#' @keywords helper function
#' @export
#' @examples
#'
map.inset.f= function(longs=c(-71,-50),lats=c(43,52.25),land.colour="sienna3",sea.colour="lightblue"){
  library(PBSmapping)
  data(worldLLhigh)
  worldLLhigh$X=(worldLLhigh$X+180)%%360-180
  xlim=longs
  ylim=lats
  map.data=clipPolys(worldLLhigh,xlim=xlim,ylim=ylim)
  plotMap(map.data,xlim=xlim,ylim=ylim,lty=1,lwd=.05 ,col="tan",
          bg=rgb(224,253,254,maxColorValue=255),las=1,xaxt="n", yaxt="n",
          xlab="",ylab="")
  #xint= seq(longs[1],longs[2],length=5)
  #yint= seq(lats[1],lats[2],length=6)
  #mtext("Longitude west",side=1,line=3)
  #mtext("Latitude north",side=2,line=3)
  #axis(1, at=xint, labels=xint*-1, lty=1,lwd=1,lwd.ticks= 1, cex.axis=.7)
  #axis(2, at=yint, labels=yint*1, lty=1,lwd=1,lwd.ticks=1,las=1, cex.axis=.7)
}


#' Get bathymetric data and plot on the map
#'
#' @param
#' @keywords helper function
#' @export
#' @examples
#'
getBathy <- function(bathyFname, isob=c(100,200,500,800,1200,2400), minVerts=3 )
{
  # data source: http://maps.ngdc.noaa.gov/viewers/wcs-client/
  icol    = rgb(0,0,seq(255,100,len=length(isob)),max=255)
  if (!file.exists("ocBathy.rda")) {
    # read.table now renders high-precision numbers as characters, so convert to numeric
    infile  = read.table(bathyFname, header=FALSE, col.names=c("x","y","z"))
    ocean   = as.data.frame(sapply(infile,function(x){if (class(x)=="character") as.numeric(x) else x}))
    ocean$z = -ocean$z                       # change depths from negative to positive
    ocBathy = makeTopography(ocean,digits=5) # this step takes some time
    save("ocBathy",file="ocBathy.rda")
  } else
    load("ocBathy.rda")
  ocCL   = contourLines(ocBathy,levels=isob)
  if (length(ocCL)==0) stop("No contours available for selected isobaths. Choose again.")
  ocCP   = convCP(ocCL, projection="LL")
  ocPoly = ocCP$PolySet
  par(mfrow=c(1,1),mar=c(2,2,0.5,0.5))
  plotMap(ocPoly,type="n",plt=NULL)
  addLines(thinPolys(ocPoly,filter=minVerts),col=icol)
  data(nepacLL)
  addPolys(nepacLL,col="lemonchiffon")
  legend(x="topright",bty="n",col=icol,lwd=2,legend=as.character(isob),inset=0.05,title="Isobaths")
  save("ocCP",file="ocCP.rda")
  invisible(ocCP)
}


#' Join bathymetric contours
#'
#' @param
#' @keywords helper function
#' @export
#' @examples
#'
joinBathy <- function(CP, isobA = 100, isobB = 300, col = "grey") {
    pdatA = CP$PolyData[is.element(CP$PolyData$level, isobA), ]
    pdatB = CP$PolyData[is.element(CP$PolyData$level, isobB), ]

    Apoly = CP$PolySet[is.element(CP$PolySet$PID, pdatA$PID) & is.element(CP$PolySet$SID, pdatA$SID),
        ]
    Bpoly = CP$PolySet[is.element(CP$PolySet$PID, pdatB$PID) & is.element(CP$PolySet$SID, pdatB$SID),
        ]

    ### extract the longest polyline from A and B
    Apoly$ID = .createIDs(Apoly, c("PID", "SID"))
    IDA = rev(sort(sapply(split(Apoly$ID, Apoly$ID), length)))[1]
    Aline = Apoly[is.element(Apoly$ID, names(IDA)), ]
    Bpoly$ID = .createIDs(Bpoly, c("PID", "SID"))
    IDB = rev(sort(sapply(split(Bpoly$ID, Bpoly$ID), length)))[1]
    Bline = Bpoly[is.element(Bpoly$ID, names(IDB)), ]

    ABpoly = convLP(Aline, Bline)
    addPolys(ABpoly, col = col)
    invisible(ABpoly)
}


#' Relist parameter objects from a particular projection
#'
#' @param skeleton the name attribute from the params list
#' @keywords projection, parameters, list
#' @export
#' @examples
#' skel= attr(params,"names")
#' my.projection.params= newpar.f(skeleton=skel)
#' save(my.projection.params, file="my.projection.params.rda")
newpar.f= function(skeleton){
  tmp=list(length=length(skeleton))
  for (ii in 1:length(skeleton)){
  	tmp[[ii]]=get(skeleton[ii])
  }
  names(tmp)= skeleton
  tmp
}
