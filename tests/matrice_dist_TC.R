#####################################################################################################################
#######
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
# Chargement des données
options(scipen=50)
options(digits=3)
# Chargement des données
library(sp)
library(maptools)
library(rgeos)
library(rgdal)
library(raster)
library(rasterVis)
library(plm)
library(foreign)
library(plyr)
#############
setwd("/Users/stephaneesquerre/Dropbox/Articles/2013 - Premiers travaux/Dont feed the zombies/DATA")
DFTZ <- read.csv2("20141127_DFTZ_INC_v2.csv", sep = ";")
DFTZ <- subset(DFTZ, select = - c(REGION_NAME,CODE_REGION,DPT,S_NOMENCL,ANNEETRIM_OUV,TX_CHOM_NAT,TX_CHOM,TX_CHOM_MOY,CHOM_BAD,RJ_VOL,LJ_VOL,SAUV_VOL,TC_VOL,PIB,PIB_PLAN,FBCF_ENTP_NF,FBCF_ENTP_NF_PLAN,TX_CHOM_PLAN, TRIM, TRIM_PLAN,TX_CHOM_NAT_PLAN,FAILURE_12M,FAILURE_24M,FAILURE_36M,RJ_VOL_PCT,SAUV_VOL_PCT,LJ_VOL_PCT))


coord <- coordinates(data_buf_echevin_select[,c("CD_POST_LONG","CD_POST_LAT")])
pts_echev <- SpatialPoints(coords = coord)
pts_echev@proj4string <- CRS(("+proj=longlat"))
ptsp_echev <- spTransform(x = pts_echev, CRSobj = CRS("+init=epsg:2154"))
mat <- data.frame(ID = data_buf_echevin_select$I_SIREN, echev = data_buf_echevin_select$echev,  def= data_buf_echevin_select$def )
ptsp_echev <- SpatialPointsDataFrame(ptsp_echev, data = mat)
dist <- gDistance(ptsp_echev,z, byid = TRUE)
data_buf_echevin_select$dist <- t(dist)
library(rgdal)
par(mar = c(0, 0, 0, 0))
plot(pol, col = "gray")
plot(france2, col = "gray", add = T)
points(ptsp_echev, pch = 18, col = "blue", add = T)
#points coord TC
#CD_POST_TC <- read.csv2("CD_POST_TC_LOC.csv", sep = ";", dec =",")
CD_POST_TC <- CD_POST_TC[,-c(1:3)]
CD_POST_TC <-  CD_POST_TC[!duplicated(CD_POST_TC),]
CD_POST_TC$TC_LAT <- as.integer(as.character(CD_POST_TC$TC_LAT))
CD_POST_TC$TC_LONG <- as.integer(as.character(CD_POST_TC$TC_LONG))
coord <- coordinates(CD_POST_TC[,c("TC_LONG","TC_LAT")])
ptsp_tc <- SpatialPoints(coords = coord)
ptsp_tc@proj4string <- CRS(("+proj=longlat"))
ptsp_tc <- spTransform(x = ptsp_tc, CRSobj = CRS("+init=epsg:2154"))
mat <- data.frame(ID = CD_POST_TC$S_TC, echev = CD_POST_TC$TC_ECHEVIN)
ptsp_tc <- SpatialPointsDataFrame(ptsp_tc, data = mat)

CD_POST_geoloc <- read.csv2("CD_POST_GEOLOC_v3.csv", sep = ";", dec =".")
CD_POST_geoloc$I_CD_POST_SIEGE <- as.factor(substr(as.character(CD_POST_geoloc$I_CD_POST_SIEGE),2,6))
CD_COM_TC <- read.csv2("CD_COM_TC.csv", sep = ";", dec =".")
CD_COM_TC$I_CD_POST_SIEGE <- as.factor(substr(as.character(CD_COM_TC$CODE_COM),2,6))
CD_COM_TC <- CD_COM_TC[,c("I_CD_POST_SIEGE","CD_TC","Lib_TC_maj")]
CD_COM_TC <- merge(CD_COM_TC, CD_POST_geoloc,all.x=TRUE, by=c("I_CD_POST_SIEGE"))

jurid_com<-readShapeSpatial("jurid_com.SHP", proj4string=CRS("+init=epsg:2154")) #j'ai pris limites plutÃ´t



write.table(DFTZ, file = "DFTZ_EXP.csv", sep = ";", dec=".", na=".", row.names = FALSE)


