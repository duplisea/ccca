% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dataset.documentation.r
\docType{data}
\name{ShrimpEstuary}
\alias{ShrimpEstuary}
\title{Estuary Shrimp data}
\format{
A dataframe with four essential columns named (Year, Index, Catch, E) and many other E variable columns.
}
\source{
Bourdages, H. and Marquis, M.C. 2019. Assessment of northern shrimp stocks in the Estuary and Gulf of St. Lawrence in 2017: commercial fishery data. DFO Can. Sci. Advis. Sec. Res. Doc. 2018/056. iv + 99 p.

       Bourdages, H., Marquis, M.C., Nozères, C. and Ouellette-Plante, J. 2018. Assessment of northern shrimp stocks in the Estuary and Gulf of St. Lawrence in 2017: data from the research survey. DFO Can. Sci. Advis. Sec. Res. Doc. 2018/057. iv + 67 p.

       Galbraith, P.S., Chassé, J., Nicot, P., Caverhill, C., Gilbert, D., Pettigrew, B., Lefaivre, D., Brickman, D., Devine, L., and Lafleur, C. 2015. Physical Oceanographic Conditions in the Gulf of St. Lawrence in 2014. DFO Can. Sci. Advis. Sec. Res. Doc. 2015/032. v + 82 p http://www.dfo-mpo.gc.ca/csas-sccs/Publications/ResDocs-DocRech/2015/2015_032-eng.html

       Gilbert, D., B. Sundby, C. Gobeil, A. Mucci, G.-H. Tremblay 2005. A seventy-two-year record of diminishing deep-water oxygen in the St. Lawrence estuary: The northwest Atlantic connection. Limnology and Oceanography. 50: 1654-1666.
}
\usage{
data(shrimpEstuary)
}
\description{
Gulf of St Lawrence shrimp (Pandalus borealis) survey index biomass, commercial landings and environmental variables.
A dataframe with the year, survey index, catch and various environmental variables. Missing values with NA.
}
\details{
\itemize{
  \item Year. The year
  \item Index. The survey swept area biomass of shrimp (t). Estimated by krigged surface integration.
  \item Catch. The reported catch of the stock (t)
  \item E. The E variable you choose to be your climate variable (probably one of the variables below)
  \item Gulf.T150. Temperature (C) of the whole Gulf at 150 m
  \item Gulf.T200. Temperature (C) of the whole Gulf at 200 m
  \item Gulf.T250. Temperature (C) of the whole Gulf at 250 m
  \item Gulf.T300. Temperature (C) of the whole Gulf at 200 m
  \item Gulf.S150. Salinity (ppt) of the whole Gulf at 150 m
  \item Gulf.S200. Salinity (ppt) of the whole Gulf at 200 m
  \item Gulf.S250. Salinity (ppt) of the whole Gulf at 250 m
  \item Gulf.S300. Salinity (ppt) of the whole Gulf at 300 m
  \item Estuary.T150. Temperature (C) of the estuary at 150 m
  \item Estuary.T200. Temperature (C) of the estuary at 200 m
  \item Estuary.T250. Temperature (C) of the estuary at 250 m
  \item Estuary.T300. Temperature (C) of the estuary at 300 m
  \item NWGulf.T150. Temperature (C) of the northwestern Gulf at 150 m
  \item NWGulf.T200. Temperature (C) of the northwestern Gulf at 200 m
  \item NWGulf.T250. Temperature (C) of the northwestern Gulf at 250 m
  \item NWGulf.T300. Temperature (C) of the northwestern Gulf at 300 m
  \item AnticostiChannel.T150. Temperature (C) of the Anticosti Channel at 150 m
  \item AnticostiChannel.T200. Temperature (C) of the Anticosti Channel at 200 m
  \item AnticostiChannel.T250. Temperature (C) of the Anticosti Channel at 250 m
  \item MecatinaTrough.T150. Temperature (C) of the Mecatina Trough at 150 m
  \item MecatinaTrough.T200. Temperature (C) of the Mecatina Trough at 200 m
  \item EsquimanChannel.T150. Temperature (C) of the Esquiman Channel at 150 m
  \item EsquimanChannel.T200. Temperature (C) of the Esquiman Channel at 200 m
  \item EsquimanChannel.T250. Temperature (C) of the Esquiman Channel at 250 m
  \item CentralGulf.T150. Temperature (C) of the Central Gulf at 150 m
  \item CentralGulf.T200. Temperature (C) of the Central Gulf at 200 m
  \item CentralGulf.T250. Temperature (C) of the Central Gulf at 250 m
  \item CentralGulf.T300. Temperature (C) of the Central Gulf at 300 m
  \item CabotStrait.T150. Temperature (C) of the Cabot Strait at 150 m
  \item CabotStrait.T200. Temperature (C) of the Cabot Strait at 200 m
  \item CabotStrait.T250. Temperature (C) of the Cabot Strait at 250 m
  \item CabotStrait.T300. Temperature (C) of the Cabot Strait at 300 m
  \item O2.mMol. Oxygen concentration (mmol/L) of deep waters (>295 m) of the St Lawrence estuary
  \item O2.saturation. Oxygen percent saturation of deep waters (>295 m) of the St Lawrence estuary

}
}
\keyword{datasets}
