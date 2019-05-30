# dataset documentation

#' Projection parameters
#'
#' A list with all the default projection parameters needed to run a projection. You need to unlist this
#' so that each named element (level 1) in the list is an object in the global environment. You can change
#' these unlisted objects individually. It can be a good idea to unlist the basic parameters file before
#' each projection and then changing only the things you want to make sure you are always starting from
#' the same point each time.
#'
#' \itemize{
#'   \item q. Survey catchability. Probably 1 or less (scalar)
#'   \item ref.pt. A multiplier of the biomass in the reference period to estimate the reference point (scalar)
#'   \item risk. The acceptable risk of not achieving the reference point in the specified time.frame (scalar 0--1).
#'   \item time.frame. The acceptable time period for achieving the reference point objective (scalar)
#'   \item Bstart.mult. The multiplier of the last data year's biomass which will start the projection (scalar)
#'   \item K. Multiplier of the maximum observed biomass that will be considered the carrying capacity for the density dependent model (scalar)
#'   \item theta. The degree of asymmetry in the density dependent production curve (scalar, 1=symmetric).
#'   \item model.type. This is the kind of model you want to use to fit the PB vs E relationship: gam.adaptive" "poly", "gam.adaptive"
#'   \item poly.degree. The degree of the polynomial to fit for P/B vs E if you chose "poly" for model type
#'   \item knots. The number of knots for a gam.adaptive fit. A good value is n/2.5
#'   \item add.resids. If 1 then multiplicative residuals are sampled from P/B vs E curve. 0 if no residuals (scalar values other than 0 and 1 should NEVER be used)
#'   \item Emean.shift. The change in the mean of the E distribution for a future climate scenario (scalar, + or -)
#'   \item E.var.inc. The change in the variance of the E distribution for a future climate scenario (scalar, 1 for as is, >1 decreases variance)
#'   \item N. The number of Monte Carlo samples for the projection (scalar)
#'   \item proj.years. The number of years to project into the future. Must be >= time.frame (scalar)
#'   \item N.CCF. The number of Monte Carlo samples for each projection for very unique commbination of Emean.shift and F into the future (scalar)
#'   \item Emean.shifts. The Emean.shifts to try for determining CCFs (vector)
#'   \item fs. The exploitation rates to try for determining CCFs (vector)
#'
#' }
#'
#' @docType data
#' @keywords datasets
#' @name params
#' @usage data(params)
#' @format A list with 19 elements
NULL


#' Turbot data
#'
#' Gulf of St Lawrence turbot (Reinhardus hippoglosoides) survey index biomass, commercial landings and environmental variables.
#' A dataframe with the year, survey index, catch and various environmental variables. Missing values with NA.
#'
#' \itemize{
#'   \item Year. The year
#'   \item Index. The survey swept area index biomass for the stock fish >40 cm (kt)
#'   \item Catch. The reported catch of the stock (kt)
#'   \item E. The E variable you choose to be your climate variable (probably one of the variables below)
#'   \item E2. A second E variable you choose to be one of your climate variables (probably one of the variables below)
#'   \item Gulf.T.P50.40cm. Temperature (C) of the whole survey area at depth where 50 percent of the cumulative survey catch of fish >40 cm caught
#'   \item Esqui.T.P50.40cm. Temperature (C) of the Esquiman Chan area at depth where 50 percent of the cumulative survey catch of fish >40 cm caught
#'   \item NEAnt.T.P50.40cm. Temperature (C) of the NE Anticosti area at depth where 50 percent of the cumulative survey catch of fish >40 cm caught
#'   \item Wgulf.T.P50.40cm. Temperature (C) of the W Gulf area at depth where 50 percent of the cumulative survey catch of fish >40 cm caught
#'   \item Gulf.T150. Temperature (C) of the whole Gulf at 150 m
#'   \item Gulf.T200. Temperature (C) of the whole Gulf at 200 m
#'   \item Gulf.T250. Temperature (C) of the whole Gulf at 250 m
#'   \item Gulf.T300. Temperature (C) of the whole Gulf at 200 m
#'   \item Gulf.S150. Salinity (ppt) of the whole Gulf at 150 m
#'   \item Gulf.S200. Salinity (ppt) of the whole Gulf at 200 m
#'   \item Gulf.S250. Salinity (ppt) of the whole Gulf at 250 m
#'   \item Gulf.S300. Salinity (ppt) of the whole Gulf at 300 m
#'   \item Estuary.T150. Temperature (C) of the estuary at 150 m
#'   \item Estuary.T200. Temperature (C) of the estuary at 200 m
#'   \item Estuary.T250. Temperature (C) of the estuary at 250 m
#'   \item Estuary.T300. Temperature (C) of the estuary at 300 m
#'   \item NWGulf.T150. Temperature (C) of the northwestern Gulf at 150 m
#'   \item NWGulf.T200. Temperature (C) of the northwestern Gulf at 200 m
#'   \item NWGulf.T250. Temperature (C) of the northwestern Gulf at 250 m
#'   \item NWGulf.T300. Temperature (C) of the northwestern Gulf at 300 m
#'   \item AnticostiChannel.T150. Temperature (C) of the Anticosti Channel at 150 m
#'   \item AnticostiChannel.T200. Temperature (C) of the Anticosti Channel at 200 m
#'   \item AnticostiChannel.T250. Temperature (C) of the Anticosti Channel at 250 m
#'   \item MecatinaTrough.T150. Temperature (C) of the Mecatina Trough at 150 m
#'   \item MecatinaTrough.T200. Temperature (C) of the Mecatina Trough at 200 m
#'   \item EsquimanChannel.T150. Temperature (C) of the Esquiman Channel at 150 m
#'   \item EsquimanChannel.T200. Temperature (C) of the Esquiman Channel at 200 m
#'   \item EsquimanChannel.T250. Temperature (C) of the Esquiman Channel at 250 m
#'   \item CentralGulf.T150. Temperature (C) of the Central Gulf at 150 m
#'   \item CentralGulf.T200. Temperature (C) of the Central Gulf at 200 m
#'   \item CentralGulf.T250. Temperature (C) of the Central Gulf at 250 m
#'   \item CentralGulf.T300. Temperature (C) of the Central Gulf at 300 m
#'   \item CabotStrait.T150. Temperature (C) of the Cabot Strait at 150 m
#'   \item CabotStrait.T200. Temperature (C) of the Cabot Strait at 200 m
#'   \item CabotStrait.T250. Temperature (C) of the Cabot Strait at 250 m
#'   \item CabotStrait.T300. Temperature (C) of the Cabot Strait at 300 m
#'   \item O2.mMol. Oxygen concentration (mmol/L) of deep waters (>295 m) of the St Lawrence estuary
#'   \item O2.saturation. Oxygen percent saturation of deep waters (>295 m) of the St Lawrence estuary
#'
#' }
#'
#' @docType data
#' @keywords datasets
#' @name turbot
#' @usage data(turbot)
#' @format A dataframe with four essential columns named (Year, Index, Catch, E) and many other E variable columns.
#' @source DFO. 2018. Assessment of the Greenland Halibut stock in the Gulf of St. Lawrence (4RST) in 2017. DFO Can. Sci. Advis. Sec. Sci. Advis. Rep. 2018/035. http://waves-vagues.dfo-mpo.gc.ca/Library/40714007.pdf
#'
#'        Galbraith, P.S., Chassé, J., Nicot, P., Caverhill, C., Gilbert, D., Pettigrew, B., Lefaivre, D., Brickman, D., Devine, L., and Lafleur, C. 2015. Physical Oceanographic Conditions in the Gulf of St. Lawrence in 2014. DFO Can. Sci. Advis. Sec. Res. Doc. 2015/032. v + 82 p http://www.dfo-mpo.gc.ca/csas-sccs/Publications/ResDocs-DocRech/2015/2015_032-eng.html
#'
#'        Gilbert, D., B. Sundby, C. Gobeil, A. Mucci, G.-H. Tremblay 2005. A seventy-two-year record of diminishing deep-water oxygen in the St. Lawrence estuary: The northwest Atlantic connection. Limnology and Oceanography. 50: 1654-1666.
NULL


#' Fishing area 1 - Estuary
#'
#' A dataframe describing a polygon one of the three main turbot fishing areas in the Gulf - St Lawrence estuary
#'
#' \itemize{
#'   \item PID. The polygon id
#'   \item POS. The position
#'   \item X. Position of a longitude in decimal degrees. Western hemisphere is - degrees from the prime meridian
#'   \item Y. Position of a latitude in decimal degrees. Southern hemisphere is - degrees from the equator
#'
#' }
#'
#' @docType data
#' @keywords datasets
#' @name fishing.area1
#' @usage data(fishing.area1)
#' @format A dataframe with four columns named. To be used by PBSmapping
NULL

#' Fishing area 2 - Equiman Channel
#'
#' A dataframe describing a polygon one of the three main turbot fishing areas in the Gulf - Esquiman Channel
#'
#' \itemize{
#'   \item PID. The polygon id
#'   \item POS. The position
#'   \item X. Position of a longitude in decimal degrees. Western hemisphere is - degrees from the prime meridian
#'   \item Y. Position of a latitude in decimal degrees. Southern hemisphere is - degrees from the equator
#'
#' }
#'
#' @docType data
#' @keywords datasets
#' @name fishing.area2
#' @usage data(fishing.area2)
#' @format A dataframe with four columns named. To be used by PBSmapping
NULL


#' Fishing area 3 - North Anticosti
#'
#' A dataframe describing a polygon one of the three main turbot fishing areas in the Gulf - North Anticosti
#'
#' \itemize{
#'   \item PID. The polygon id
#'   \item POS. The position
#'   \item X. Position of a longitude in decimal degrees. Western hemisphere is - degrees from the prime meridian
#'   \item Y. Position of a latitude in decimal degrees. Southern hemisphere is - degrees from the equator
#'
#' }
#'
#' @docType data
#' @keywords datasets
#' @name fishing.area3
#' @usage data(fishing.area3)
#' @format A dataframe with four columns named. To be used by PBSmapping
NULL



#' Eastern Canada Bathymetry
#'
#' A large list with x, y, z elements for plotting isobaths on the map
#'
#' \itemize{
#'   \item X. Position of a longitude in decimal degrees. Western hemisphere is - degrees from the prime meridian
#'   \item Y. Position of a latitude in decimal degrees. Southern hemisphere is - degrees from the equator
#'   \item Z. The depth in m at the x, y point
#'
#' }
#'
#' @docType data
#' @keywords datasets
#' @name ocBathy
#' @usage data(ecan.bathy)
#' @format A list
NULL



#' Estuary Shrimp data
#'
#' Gulf of St Lawrence shrimp (Pandalus borealis) survey index biomass, commercial landings and environmental variables.
#' A dataframe with the year, survey index, catch and various environmental variables. Missing values with NA.
#'
#' \itemize{
#'   \item Year. The year
#'   \item Index. The survey swept area biomass of shrimp (t). Estimated by krigged surface integration.
#'   \item Catch. The reported catch of the stock (t)
#'   \item E. The E variable you choose to be your climate variable (probably one of the variables below)
#'   \item Gulf.T150. Temperature (C) of the whole Gulf at 150 m
#'   \item Gulf.T200. Temperature (C) of the whole Gulf at 200 m
#'   \item Gulf.T250. Temperature (C) of the whole Gulf at 250 m
#'   \item Gulf.T300. Temperature (C) of the whole Gulf at 200 m
#'   \item Gulf.S150. Salinity (ppt) of the whole Gulf at 150 m
#'   \item Gulf.S200. Salinity (ppt) of the whole Gulf at 200 m
#'   \item Gulf.S250. Salinity (ppt) of the whole Gulf at 250 m
#'   \item Gulf.S300. Salinity (ppt) of the whole Gulf at 300 m
#'   \item Estuary.T150. Temperature (C) of the estuary at 150 m
#'   \item Estuary.T200. Temperature (C) of the estuary at 200 m
#'   \item Estuary.T250. Temperature (C) of the estuary at 250 m
#'   \item Estuary.T300. Temperature (C) of the estuary at 300 m
#'   \item NWGulf.T150. Temperature (C) of the northwestern Gulf at 150 m
#'   \item NWGulf.T200. Temperature (C) of the northwestern Gulf at 200 m
#'   \item NWGulf.T250. Temperature (C) of the northwestern Gulf at 250 m
#'   \item NWGulf.T300. Temperature (C) of the northwestern Gulf at 300 m
#'   \item AnticostiChannel.T150. Temperature (C) of the Anticosti Channel at 150 m
#'   \item AnticostiChannel.T200. Temperature (C) of the Anticosti Channel at 200 m
#'   \item AnticostiChannel.T250. Temperature (C) of the Anticosti Channel at 250 m
#'   \item MecatinaTrough.T150. Temperature (C) of the Mecatina Trough at 150 m
#'   \item MecatinaTrough.T200. Temperature (C) of the Mecatina Trough at 200 m
#'   \item EsquimanChannel.T150. Temperature (C) of the Esquiman Channel at 150 m
#'   \item EsquimanChannel.T200. Temperature (C) of the Esquiman Channel at 200 m
#'   \item EsquimanChannel.T250. Temperature (C) of the Esquiman Channel at 250 m
#'   \item CentralGulf.T150. Temperature (C) of the Central Gulf at 150 m
#'   \item CentralGulf.T200. Temperature (C) of the Central Gulf at 200 m
#'   \item CentralGulf.T250. Temperature (C) of the Central Gulf at 250 m
#'   \item CentralGulf.T300. Temperature (C) of the Central Gulf at 300 m
#'   \item CabotStrait.T150. Temperature (C) of the Cabot Strait at 150 m
#'   \item CabotStrait.T200. Temperature (C) of the Cabot Strait at 200 m
#'   \item CabotStrait.T250. Temperature (C) of the Cabot Strait at 250 m
#'   \item CabotStrait.T300. Temperature (C) of the Cabot Strait at 300 m
#'   \item O2.mMol. Oxygen concentration (mmol/L) of deep waters (>295 m) of the St Lawrence estuary
#'   \item O2.saturation. Oxygen percent saturation of deep waters (>295 m) of the St Lawrence estuary
#'
#' }
#'
#' @docType data
#' @keywords datasets
#' @name ShrimpEstuary
#' @usage data(shrimpEstuary)
#' @format A dataframe with four essential columns named (Year, Index, Catch, E) and many other E variable columns.
#' @source Bourdages, H. and Marquis, M.C. 2019. Assessment of northern shrimp stocks in the Estuary and Gulf of St. Lawrence in 2017: commercial fishery data. DFO Can. Sci. Advis. Sec. Res. Doc. 2018/056. iv + 99 p.
#'
#'        Bourdages, H., Marquis, M.C., Nozères, C. and Ouellette-Plante, J. 2018. Assessment of northern shrimp stocks in the Estuary and Gulf of St. Lawrence in 2017: data from the research survey. DFO Can. Sci. Advis. Sec. Res. Doc. 2018/057. iv + 67 p.
#'
#'        Galbraith, P.S., Chassé, J., Nicot, P., Caverhill, C., Gilbert, D., Pettigrew, B., Lefaivre, D., Brickman, D., Devine, L., and Lafleur, C. 2015. Physical Oceanographic Conditions in the Gulf of St. Lawrence in 2014. DFO Can. Sci. Advis. Sec. Res. Doc. 2015/032. v + 82 p http://www.dfo-mpo.gc.ca/csas-sccs/Publications/ResDocs-DocRech/2015/2015_032-eng.html
#'
#'        Gilbert, D., B. Sundby, C. Gobeil, A. Mucci, G.-H. Tremblay 2005. A seventy-two-year record of diminishing deep-water oxygen in the St. Lawrence estuary: The northwest Atlantic connection. Limnology and Oceanography. 50: 1654-1666.
NULL

#' Sept Iles Shrimp data
#'
#' Gulf of St Lawrence shrimp (Pandalus borealis) survey index biomass, commercial landings and environmental variables.
#' A dataframe with the year, survey index, catch and various environmental variables. Missing values with NA.
#'
#' \itemize{
#'   \item Year. The year
#'   \item Index. The survey swept area biomass of shrimp (t). Estimated by krigged surface integration.
#'   \item Catch. The reported catch of the stock (t)
#'   \item E. The E variable you choose to be your climate variable (probably one of the variables below)
#'   \item Gulf.T150. Temperature (C) of the whole Gulf at 150 m
#'   \item Gulf.T200. Temperature (C) of the whole Gulf at 200 m
#'   \item Gulf.T250. Temperature (C) of the whole Gulf at 250 m
#'   \item Gulf.T300. Temperature (C) of the whole Gulf at 200 m
#'   \item Gulf.S150. Salinity (ppt) of the whole Gulf at 150 m
#'   \item Gulf.S200. Salinity (ppt) of the whole Gulf at 200 m
#'   \item Gulf.S250. Salinity (ppt) of the whole Gulf at 250 m
#'   \item Gulf.S300. Salinity (ppt) of the whole Gulf at 300 m
#'   \item Estuary.T150. Temperature (C) of the estuary at 150 m
#'   \item Estuary.T200. Temperature (C) of the estuary at 200 m
#'   \item Estuary.T250. Temperature (C) of the estuary at 250 m
#'   \item Estuary.T300. Temperature (C) of the estuary at 300 m
#'   \item NWGulf.T150. Temperature (C) of the northwestern Gulf at 150 m
#'   \item NWGulf.T200. Temperature (C) of the northwestern Gulf at 200 m
#'   \item NWGulf.T250. Temperature (C) of the northwestern Gulf at 250 m
#'   \item NWGulf.T300. Temperature (C) of the northwestern Gulf at 300 m
#'   \item AnticostiChannel.T150. Temperature (C) of the Anticosti Channel at 150 m
#'   \item AnticostiChannel.T200. Temperature (C) of the Anticosti Channel at 200 m
#'   \item AnticostiChannel.T250. Temperature (C) of the Anticosti Channel at 250 m
#'   \item MecatinaTrough.T150. Temperature (C) of the Mecatina Trough at 150 m
#'   \item MecatinaTrough.T200. Temperature (C) of the Mecatina Trough at 200 m
#'   \item EsquimanChannel.T150. Temperature (C) of the Esquiman Channel at 150 m
#'   \item EsquimanChannel.T200. Temperature (C) of the Esquiman Channel at 200 m
#'   \item EsquimanChannel.T250. Temperature (C) of the Esquiman Channel at 250 m
#'   \item CentralGulf.T150. Temperature (C) of the Central Gulf at 150 m
#'   \item CentralGulf.T200. Temperature (C) of the Central Gulf at 200 m
#'   \item CentralGulf.T250. Temperature (C) of the Central Gulf at 250 m
#'   \item CentralGulf.T300. Temperature (C) of the Central Gulf at 300 m
#'   \item CabotStrait.T150. Temperature (C) of the Cabot Strait at 150 m
#'   \item CabotStrait.T200. Temperature (C) of the Cabot Strait at 200 m
#'   \item CabotStrait.T250. Temperature (C) of the Cabot Strait at 250 m
#'   \item CabotStrait.T300. Temperature (C) of the Cabot Strait at 300 m
#'   \item O2.mMol. Oxygen concentration (mmol/L) of deep waters (>295 m) of the St Lawrence estuary
#'   \item O2.saturation. Oxygen percent saturation of deep waters (>295 m) of the St Lawrence estuary
#'
#' }
#'
#' @docType data
#' @keywords datasets
#' @name ShrimpSeptIles
#' @usage data(shrimpSeptIles)
#' @format A dataframe with four essential columns named (Year, Index, Catch, E) and many other E variable columns.
#' @source Bourdages, H. and Marquis, M.C. 2019. Assessment of northern shrimp stocks in the Estuary and Gulf of St. Lawrence in 2017: commercial fishery data. DFO Can. Sci. Advis. Sec. Res. Doc. 2018/056. iv + 99 p.
#'
#'        Bourdages, H., Marquis, M.C., Nozères, C. and Ouellette-Plante, J. 2018. Assessment of northern shrimp stocks in the Estuary and Gulf of St. Lawrence in 2017: data from the research survey. DFO Can. Sci. Advis. Sec. Res. Doc. 2018/057. iv + 67 p.
#'
#'        Galbraith, P.S., Chassé, J., Nicot, P., Caverhill, C., Gilbert, D., Pettigrew, B., Lefaivre, D., Brickman, D., Devine, L., and Lafleur, C. 2015. Physical Oceanographic Conditions in the Gulf of St. Lawrence in 2014. DFO Can. Sci. Advis. Sec. Res. Doc. 2015/032. v + 82 p http://www.dfo-mpo.gc.ca/csas-sccs/Publications/ResDocs-DocRech/2015/2015_032-eng.html
#'
#'        Gilbert, D., B. Sundby, C. Gobeil, A. Mucci, G.-H. Tremblay 2005. A seventy-two-year record of diminishing deep-water oxygen in the St. Lawrence estuary: The northwest Atlantic connection. Limnology and Oceanography. 50: 1654-1666.
NULL


#' Anticosti Shrimp data
#'
#' Gulf of St Lawrence shrimp (Pandalus borealis) survey index biomass, commercial landings and environmental variables.
#' A dataframe with the year, survey index, catch and various environmental variables. Missing values with NA.
#'
#' \itemize{
#'   \item Year. The year
#'   \item Index. The survey swept area biomass of shrimp (t). Estimated by krigged surface integration.
#'   \item Catch. The reported catch of the stock (t)
#'   \item E. The E variable you choose to be your climate variable (probably one of the variables below)
#'   \item Gulf.T150. Temperature (C) of the whole Gulf at 150 m
#'   \item Gulf.T200. Temperature (C) of the whole Gulf at 200 m
#'   \item Gulf.T250. Temperature (C) of the whole Gulf at 250 m
#'   \item Gulf.T300. Temperature (C) of the whole Gulf at 200 m
#'   \item Gulf.S150. Salinity (ppt) of the whole Gulf at 150 m
#'   \item Gulf.S200. Salinity (ppt) of the whole Gulf at 200 m
#'   \item Gulf.S250. Salinity (ppt) of the whole Gulf at 250 m
#'   \item Gulf.S300. Salinity (ppt) of the whole Gulf at 300 m
#'   \item Estuary.T150. Temperature (C) of the estuary at 150 m
#'   \item Estuary.T200. Temperature (C) of the estuary at 200 m
#'   \item Estuary.T250. Temperature (C) of the estuary at 250 m
#'   \item Estuary.T300. Temperature (C) of the estuary at 300 m
#'   \item NWGulf.T150. Temperature (C) of the northwestern Gulf at 150 m
#'   \item NWGulf.T200. Temperature (C) of the northwestern Gulf at 200 m
#'   \item NWGulf.T250. Temperature (C) of the northwestern Gulf at 250 m
#'   \item NWGulf.T300. Temperature (C) of the northwestern Gulf at 300 m
#'   \item AnticostiChannel.T150. Temperature (C) of the Anticosti Channel at 150 m
#'   \item AnticostiChannel.T200. Temperature (C) of the Anticosti Channel at 200 m
#'   \item AnticostiChannel.T250. Temperature (C) of the Anticosti Channel at 250 m
#'   \item MecatinaTrough.T150. Temperature (C) of the Mecatina Trough at 150 m
#'   \item MecatinaTrough.T200. Temperature (C) of the Mecatina Trough at 200 m
#'   \item EsquimanChannel.T150. Temperature (C) of the Esquiman Channel at 150 m
#'   \item EsquimanChannel.T200. Temperature (C) of the Esquiman Channel at 200 m
#'   \item EsquimanChannel.T250. Temperature (C) of the Esquiman Channel at 250 m
#'   \item CentralGulf.T150. Temperature (C) of the Central Gulf at 150 m
#'   \item CentralGulf.T200. Temperature (C) of the Central Gulf at 200 m
#'   \item CentralGulf.T250. Temperature (C) of the Central Gulf at 250 m
#'   \item CentralGulf.T300. Temperature (C) of the Central Gulf at 300 m
#'   \item CabotStrait.T150. Temperature (C) of the Cabot Strait at 150 m
#'   \item CabotStrait.T200. Temperature (C) of the Cabot Strait at 200 m
#'   \item CabotStrait.T250. Temperature (C) of the Cabot Strait at 250 m
#'   \item CabotStrait.T300. Temperature (C) of the Cabot Strait at 300 m
#'   \item O2.mMol. Oxygen concentration (mmol/L) of deep waters (>295 m) of the St Lawrence estuary
#'   \item O2.saturation. Oxygen percent saturation of deep waters (>295 m) of the St Lawrence estuary
#'
#' }
#'
#' @docType data
#' @keywords datasets
#' @name ShrimpAnticosti
#' @usage data(shrimpAnticosti)
#' @format A dataframe with four essential columns named (Year, Index, Catch, E) and many other E variable columns.
#' @source Bourdages, H. and Marquis, M.C. 2019. Assessment of northern shrimp stocks in the Estuary and Gulf of St. Lawrence in 2017: commercial fishery data. DFO Can. Sci. Advis. Sec. Res. Doc. 2018/056. iv + 99 p.
#'
#'        Bourdages, H., Marquis, M.C., Nozères, C. and Ouellette-Plante, J. 2018. Assessment of northern shrimp stocks in the Estuary and Gulf of St. Lawrence in 2017: data from the research survey. DFO Can. Sci. Advis. Sec. Res. Doc. 2018/057. iv + 67 p.
#'
#'        Galbraith, P.S., Chassé, J., Nicot, P., Caverhill, C., Gilbert, D., Pettigrew, B., Lefaivre, D., Brickman, D., Devine, L., and Lafleur, C. 2015. Physical Oceanographic Conditions in the Gulf of St. Lawrence in 2014. DFO Can. Sci. Advis. Sec. Res. Doc. 2015/032. v + 82 p http://www.dfo-mpo.gc.ca/csas-sccs/Publications/ResDocs-DocRech/2015/2015_032-eng.html
#'
#'        Gilbert, D., B. Sundby, C. Gobeil, A. Mucci, G.-H. Tremblay 2005. A seventy-two-year record of diminishing deep-water oxygen in the St. Lawrence estuary: The northwest Atlantic connection. Limnology and Oceanography. 50: 1654-1666.
NULL


#' Esquiman Shrimp data
#'
#' Gulf of St Lawrence shrimp (Pandalus borealis) survey index biomass, commercial landings and environmental variables.
#' A dataframe with the year, survey index, catch and various environmental variables. Missing values with NA.
#'
#' \itemize{
#'   \item Year. The year
#'   \item Index. The survey swept area biomass of shrimp (t). Estimated by krigged surface integration.
#'   \item Catch. The reported catch of the stock (t)
#'   \item E. The E variable you choose to be your climate variable (probably one of the variables below)
#'   \item Gulf.T150. Temperature (C) of the whole Gulf at 150 m
#'   \item Gulf.T200. Temperature (C) of the whole Gulf at 200 m
#'   \item Gulf.T250. Temperature (C) of the whole Gulf at 250 m
#'   \item Gulf.T300. Temperature (C) of the whole Gulf at 200 m
#'   \item Gulf.S150. Salinity (ppt) of the whole Gulf at 150 m
#'   \item Gulf.S200. Salinity (ppt) of the whole Gulf at 200 m
#'   \item Gulf.S250. Salinity (ppt) of the whole Gulf at 250 m
#'   \item Gulf.S300. Salinity (ppt) of the whole Gulf at 300 m
#'   \item Estuary.T150. Temperature (C) of the estuary at 150 m
#'   \item Estuary.T200. Temperature (C) of the estuary at 200 m
#'   \item Estuary.T250. Temperature (C) of the estuary at 250 m
#'   \item Estuary.T300. Temperature (C) of the estuary at 300 m
#'   \item NWGulf.T150. Temperature (C) of the northwestern Gulf at 150 m
#'   \item NWGulf.T200. Temperature (C) of the northwestern Gulf at 200 m
#'   \item NWGulf.T250. Temperature (C) of the northwestern Gulf at 250 m
#'   \item NWGulf.T300. Temperature (C) of the northwestern Gulf at 300 m
#'   \item AnticostiChannel.T150. Temperature (C) of the Anticosti Channel at 150 m
#'   \item AnticostiChannel.T200. Temperature (C) of the Anticosti Channel at 200 m
#'   \item AnticostiChannel.T250. Temperature (C) of the Anticosti Channel at 250 m
#'   \item MecatinaTrough.T150. Temperature (C) of the Mecatina Trough at 150 m
#'   \item MecatinaTrough.T200. Temperature (C) of the Mecatina Trough at 200 m
#'   \item EsquimanChannel.T150. Temperature (C) of the Esquiman Channel at 150 m
#'   \item EsquimanChannel.T200. Temperature (C) of the Esquiman Channel at 200 m
#'   \item EsquimanChannel.T250. Temperature (C) of the Esquiman Channel at 250 m
#'   \item CentralGulf.T150. Temperature (C) of the Central Gulf at 150 m
#'   \item CentralGulf.T200. Temperature (C) of the Central Gulf at 200 m
#'   \item CentralGulf.T250. Temperature (C) of the Central Gulf at 250 m
#'   \item CentralGulf.T300. Temperature (C) of the Central Gulf at 300 m
#'   \item CabotStrait.T150. Temperature (C) of the Cabot Strait at 150 m
#'   \item CabotStrait.T200. Temperature (C) of the Cabot Strait at 200 m
#'   \item CabotStrait.T250. Temperature (C) of the Cabot Strait at 250 m
#'   \item CabotStrait.T300. Temperature (C) of the Cabot Strait at 300 m
#'   \item O2.mMol. Oxygen concentration (mmol/L) of deep waters (>295 m) of the St Lawrence estuary
#'   \item O2.saturation. Oxygen percent saturation of deep waters (>295 m) of the St Lawrence estuary
#'
#' }
#'
#' @docType data
#' @keywords datasets
#' @name ShrimpEsquiman
#' @usage data(shrimpEsquiman)
#' @format A dataframe with four essential columns named (Year, Index, Catch, E) and many other E variable columns.
#' @source Bourdages, H. and Marquis, M.C. 2019. Assessment of northern shrimp stocks in the Estuary and Gulf of St. Lawrence in 2017: commercial fishery data. DFO Can. Sci. Advis. Sec. Res. Doc. 2018/056. iv + 99 p.
#'
#'        Bourdages, H., Marquis, M.C., Nozères, C. and Ouellette-Plante, J. 2018. Assessment of northern shrimp stocks in the Estuary and Gulf of St. Lawrence in 2017: data from the research survey. DFO Can. Sci. Advis. Sec. Res. Doc. 2018/057. iv + 67 p.
#'
#'        Galbraith, P.S., Chassé, J., Nicot, P., Caverhill, C., Gilbert, D., Pettigrew, B., Lefaivre, D., Brickman, D., Devine, L., and Lafleur, C. 2015. Physical Oceanographic Conditions in the Gulf of St. Lawrence in 2014. DFO Can. Sci. Advis. Sec. Res. Doc. 2015/032. v + 82 p http://www.dfo-mpo.gc.ca/csas-sccs/Publications/ResDocs-DocRech/2015/2015_032-eng.html
#'
#'        Gilbert, D., B. Sundby, C. Gobeil, A. Mucci, G.-H. Tremblay 2005. A seventy-two-year record of diminishing deep-water oxygen in the St. Lawrence estuary: The northwest Atlantic connection. Limnology and Oceanography. 50: 1654-1666.
NULL

#' Gulf of St Lawrence Shrimp data
#'
#' Gulf of St Lawrence shrimp (Pandalus borealis) survey index biomass, commercial landings and environmental variables.
#' A dataframe with the year, survey index, catch and various environmental variables. Missing values with NA. The sum of
#' all four shrimp fishing area (Estuary, Sept Iles, Anticosti and Esquiman).
#'
#' \itemize{
#'   \item Year. The year
#'   \item Index. The survey swept area biomass of shrimp (t). Estimated by krigged surface integration.
#'   \item Catch. The reported catch of the stock (t)
#'   \item E. The E variable you choose to be your climate variable (probably one of the variables below)
#'   \item Gulf.T150. Temperature (C) of the whole Gulf at 150 m
#'   \item Gulf.T200. Temperature (C) of the whole Gulf at 200 m
#'   \item Gulf.T250. Temperature (C) of the whole Gulf at 250 m
#'   \item Gulf.T300. Temperature (C) of the whole Gulf at 200 m
#'   \item Gulf.S150. Salinity (ppt) of the whole Gulf at 150 m
#'   \item Gulf.S200. Salinity (ppt) of the whole Gulf at 200 m
#'   \item Gulf.S250. Salinity (ppt) of the whole Gulf at 250 m
#'   \item Gulf.S300. Salinity (ppt) of the whole Gulf at 300 m
#'   \item Estuary.T150. Temperature (C) of the estuary at 150 m
#'   \item Estuary.T200. Temperature (C) of the estuary at 200 m
#'   \item Estuary.T250. Temperature (C) of the estuary at 250 m
#'   \item Estuary.T300. Temperature (C) of the estuary at 300 m
#'   \item NWGulf.T150. Temperature (C) of the northwestern Gulf at 150 m
#'   \item NWGulf.T200. Temperature (C) of the northwestern Gulf at 200 m
#'   \item NWGulf.T250. Temperature (C) of the northwestern Gulf at 250 m
#'   \item NWGulf.T300. Temperature (C) of the northwestern Gulf at 300 m
#'   \item AnticostiChannel.T150. Temperature (C) of the Anticosti Channel at 150 m
#'   \item AnticostiChannel.T200. Temperature (C) of the Anticosti Channel at 200 m
#'   \item AnticostiChannel.T250. Temperature (C) of the Anticosti Channel at 250 m
#'   \item MecatinaTrough.T150. Temperature (C) of the Mecatina Trough at 150 m
#'   \item MecatinaTrough.T200. Temperature (C) of the Mecatina Trough at 200 m
#'   \item EsquimanChannel.T150. Temperature (C) of the Esquiman Channel at 150 m
#'   \item EsquimanChannel.T200. Temperature (C) of the Esquiman Channel at 200 m
#'   \item EsquimanChannel.T250. Temperature (C) of the Esquiman Channel at 250 m
#'   \item CentralGulf.T150. Temperature (C) of the Central Gulf at 150 m
#'   \item CentralGulf.T200. Temperature (C) of the Central Gulf at 200 m
#'   \item CentralGulf.T250. Temperature (C) of the Central Gulf at 250 m
#'   \item CentralGulf.T300. Temperature (C) of the Central Gulf at 300 m
#'   \item CabotStrait.T150. Temperature (C) of the Cabot Strait at 150 m
#'   \item CabotStrait.T200. Temperature (C) of the Cabot Strait at 200 m
#'   \item CabotStrait.T250. Temperature (C) of the Cabot Strait at 250 m
#'   \item CabotStrait.T300. Temperature (C) of the Cabot Strait at 300 m
#'   \item O2.mMol. Oxygen concentration (mmol/L) of deep waters (>295 m) of the St Lawrence estuary
#'   \item O2.saturation. Oxygen percent saturation of deep waters (>295 m) of the St Lawrence estuary
#'
#' }
#'
#' @docType data
#' @keywords datasets
#' @name ShrimpGSL
#' @usage data(shrimpGSL)
#' @format A dataframe with four essential columns named (Year, Index, Catch, E) and many other E variable columns.
#' @source Bourdages, H. and Marquis, M.C. 2019. Assessment of northern shrimp stocks in the Estuary and Gulf of St. Lawrence in 2017: commercial fishery data. DFO Can. Sci. Advis. Sec. Res. Doc. 2018/056. iv + 99 p.
#'
#'        Bourdages, H., Marquis, M.C., Nozères, C. and Ouellette-Plante, J. 2018. Assessment of northern shrimp stocks in the Estuary and Gulf of St. Lawrence in 2017: data from the research survey. DFO Can. Sci. Advis. Sec. Res. Doc. 2018/057. iv + 67 p.
#'
#'        Galbraith, P.S., Chassé, J., Nicot, P., Caverhill, C., Gilbert, D., Pettigrew, B., Lefaivre, D., Brickman, D., Devine, L., and Lafleur, C. 2015. Physical Oceanographic Conditions in the Gulf of St. Lawrence in 2014. DFO Can. Sci. Advis. Sec. Res. Doc. 2015/032. v + 82 p http://www.dfo-mpo.gc.ca/csas-sccs/Publications/ResDocs-DocRech/2015/2015_032-eng.html
#'
#'        Gilbert, D., B. Sundby, C. Gobeil, A. Mucci, G.-H. Tremblay 2005. A seventy-two-year record of diminishing deep-water oxygen in the St. Lawrence estuary: The northwest Atlantic connection. Limnology and Oceanography. 50: 1654-1666.
NULL


#' Northern cod data
#'
#' Northern cod (2J3KL) data. The survey index is not used here but the output of Regular's extended northern cod model. Therefore
#' there is no need for a q different than 1. The environmental indices are all from NOAA (https://www.cpc.ncep.noaa.gov/products/precip/CWlink/pna/nao.shtml)
#'
#' \itemize{
#'   \item Year. The year
#'   \item Index. The survey swept area biomass of shrimp (kt). Also male and female spit bionmass.
#'   \item Catch. The reported catch of the stock (kt)
#'   \item E. The E variable you choose to be your climate variable (probably one of the variables below)
#'   \item X. Various oscillation indices. Annual averages of daily values.
#'
#' }
#'
#' @docType data
#' @keywords datasets
#' @name ncod
#' @usage data(ncod)
#' @format A dataframe with four essential columns named (Year, Index, Catch, E) and many other E variable columns.
#' @source Regular, P. 2019. Northern cod assessment res doc and dash board. CSAS in press
#'
#'        NOAA Weather Service. 2019. https://www.cpc.ncep.noaa.gov/products/precip/CWlink/pna/nao.shtml
#'
NULL
