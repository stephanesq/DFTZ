#####################################################################################################################
rm(list=ls()) #Tout
# Things you might want to change
options(papersize="a4") 
options(editor="notepad") 
options(pager="internal")
# R interactive prompt 
options(prompt="> ")
options(continue="+ ") 
# General options 
options(tab.width = 2) 
options(width = 130)
options(graphics.record=TRUE)
# Chargement des donnÃ©es
options(scipen=50)
options(digits=3)
#chargement des library
install.packages(c("sp","plm","foreign","plyr","maptools","rgeos","rgdal","raster","rasterVis","classInt","doBy","spatstat","geosphere","data.table"))
library(sp)
library(plm)
library(foreign)
library(plyr)
library(maptools)
library(rgeos)
library(rgdal)
library(raster)
library(rasterVis)
library(classInt)
library(doBy)
library(spatstat)
library(geosphere)
library(data.table)
#chargement du dossier principal
setwd("/Users/stephaneesquerre/Documents/LA Thèse/Recherche/DFTZ/DATA")
################
#Code TC et TCABS
TC_CDPOST <- read.csv2("TC_CDPOST.csv", sep = ";", dec =".", na="")
TC_CDPOST$I_CD_POST_SIEGE <- as.factor(substr(as.character(TC_CDPOST$I_CD_POST_SIEGE),2,6)) #encore des code communes sans TC
TC_CDPOST$CDCOM_TC <- as.factor(substr(as.character(TC_CDPOST$CDCOM_TC),2,6)) #encore des code communes sans TC
TC_CDPOST$CDCOM_TCABS <- as.factor(substr(as.character(TC_CDPOST$CDCOM_TCABS),2,6)) #encore des code communes sans TC
#Geoloc des communes
CD_POST_geoloc <- read.csv2("CD_POST_GEOLOC_v3.csv", sep = ";", dec =".",na=".")
CD_POST_geoloc$I_CD_POST_SIEGE <- as.factor(substr(as.character(CD_POST_geoloc$I_CD_POST_SIEGE),2,6))
CD_POST_geoloc$CD_POST_LONG <- as.numeric(as.character(CD_POST_geoloc$CD_POST_LONG))
CD_POST_geoloc <- CD_POST_geoloc[,c("I_CD_POST_SIEGE","CD_POST_LONG","CD_POST_LAT")]
##### merge
TC_CDPOST <- merge(TC_CDPOST, CD_POST_geoloc,all.x=TRUE, by=c("I_CD_POST_SIEGE"))
names(CD_POST_geoloc) <- c("I_CD_POST_SIEGE","numTC_LONG","numTC_LAT")
TC_CDPOST <- merge(TC_CDPOST, CD_POST_geoloc,all.x=TRUE, by.x=c("CDCOM_TC"), by.y=c("I_CD_POST_SIEGE"))
names(CD_POST_geoloc) <- c("CDCOM_TCABS","numTCABS_LONG","numTCABS_LAT")
TC_CDPOST <- merge(TC_CDPOST, CD_POST_geoloc,all.x=TRUE, by=c("CDCOM_TCABS"))

dt <- TC_CDPOST
setDT(dt)[ , distance_TC := distGeo(matrix(c(CD_POST_LONG, CD_POST_LAT), ncol = 2), 
                                matrix(c(numTC_LONG, numTC_LAT), ncol = 2))/1000]
setDT(dt)[ , distance_TCABS := distGeo(matrix(c(CD_POST_LONG, CD_POST_LAT), ncol = 2), 
                                    matrix(c(numTCABS_LONG, numTCABS_LAT), ncol = 2))/1000]
dt <- as.data.frame(dt)
dt <- dt[,c("I_CD_POST_SIEGE","distance_TC","distance_TCABS")]
write.table(dt, file = "dist_tc.csv", row.names = FALSE, sep=";", dec=".",na = ".")


########################################################
########################################################
########################################################
########################################################
#Communes et TC
ti_tc_ville <- read.csv2("ti_tc_ville.csv", sep = ";", dec =",")
ti_tc_ville$I_CD_POST_SIEGE <- as.factor(substr(as.character(ti_tc_ville$I_CD_POST_SIEGE),2,6)) #encore des code communes sans TC
ti_ministere <- read.csv2("ti_ministere.csv", sep = ";", na="NA")
ti_ministere <- ti_ministere[!is.na(ti_ministere$num_TC)==TRUE,]
ti_tc_ville <- merge(ti_tc_ville, ti_ministere[,c(3:7)], all.x=T, by=c("num_TC"))
ti_tc_ville <- ti_tc_ville[!duplicated(ti_tc_ville[,c('INSEE_COM')]),] #a vérifier
ti_tc_ville <- ti_tc_ville[,c("num_TC","I_CD_POST_SIEGE")]
# on merge les deux
TC_CDPOST <- merge(ti_tc_ville, numTC_CDPOST,all.x=TRUE, by=c("num_TC"))
TC_CDPOST <- TC_CDPOST[is.na(TC_CDPOST$CDCOM_TCABS)==FALSE,] #suppr si pas de TC connu
rm(ti_tc_ville)
rm(ti_ministere)
rm(numTC_CDPOST)
###On transforme en 3 séries de points geocord
### coord des TC avant 2009
COORD_numTC <- merge(TC_CDPOST[,c("num_TC","CDCOM_TC")], CD_POST_geoloc,all.x=TRUE, by.x=c("CDCOM_TC"), by.y=c("I_CD_POST_SIEGE"))
coord <- coordinates(COORD_numTC[,c("CD_POST_LONG","CD_POST_LAT")])
pts_tc <- SpatialPoints(coords = coord)
pts_tc@proj4string <- CRS(("+proj=longlat"))
pts_tc <- spTransform(x = pts_tc, CRSobj = CRS("+init=EPSG:4326"))#WGS84
mat <- data.frame(ID = COORD_numTC$num_TC )
pts_tc <- SpatialPointsDataFrame(pts_tc, data = mat)
rm(COORD_numTC)
### coord des TC ABS
COORD_numTCABS <- merge(TC_CDPOST[,c("num_TCABS","CDCOM_TCABS")], CD_POST_geoloc,all.x=TRUE, by.x=c("CDCOM_TCABS"), by.y=c("I_CD_POST_SIEGE"))
coord <- coordinates(COORD_numTCABS[,c("CD_POST_LONG","CD_POST_LAT")])
pts_tcabs <- SpatialPoints(coords = coord)
pts_tcabs@proj4string <- CRS(("+proj=longlat"))
pts_tcabs <- spTransform(x = pts_tcabs, CRSobj = CRS("+init=EPSG:4326"))#WGS84
mat <- data.frame(ID = COORD_numTCABS$num_TCABS )
pts_tcabs <- SpatialPointsDataFrame(pts_tcabs, data = mat)
rm(COORD_numTCABS)
######
### coord des villes
COORD_villes <- merge(TC_CDPOST[,c("num_TC","I_CD_POST_SIEGE")], CD_POST_geoloc,all.x=TRUE, by=c("I_CD_POST_SIEGE"))
coord <- coordinates(COORD_villes[,c("CD_POST_LONG","CD_POST_LAT")])
pts <- SpatialPoints(coords = coord)
pts@proj4string <- CRS(("+proj=longlat"))
pts <- spTransform(x = pts, CRSobj = CRS("+init=EPSG:4326")) #WGS84
mat <- data.frame(ID = COORD_villes$I_CD_POST_SIEGE)
pts <- SpatialPointsDataFrame(pts, data = mat)
rm(COORD_villes)
#########
#### Calcul des distances
dist_numtc <- distm(pts,pts_tc) #apparemment il sorte par ordre alphabétique
test <- diag(dist_numtc)
dist_numtcabs <- distm(pts,pts_tcabs) #apparemment il sorte par ordre alphabétique
dist <- data.frame(I_CD_POST_SIEGE=pts@data$ID, dist_tc_echev)
names(dist) <- c("I_CD_POST_SIEGE","TC_25056","TC_54099","TC_54395","TC_55029","TC_57463","TC_57631","TC_57672","TC_67437","TC_67482","TC_68066","TC_68224","TC_70550","TC_88160","TC_90010")
dist <- dist[!duplicated(dist$I_CD_POST_SIEGE),]
rm(CD_POST_ECHEV)
write.table(dist, file = "DIST_TC_ECHEV.csv", row.names = FALSE, sep=";", dec=".",na = ".")
