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
library(xlsx)
library(sp)
library(plm)
library(maptools)
library(rgeos)
library(rgdal)
library(raster)
library(rasterVis)
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
library(RColorBrewer)
#COMPLET : DFTZ <- DFTZ[,c("I_SIREN","DPT","CODE_REGION","I_FJ","FJ_1","NAF2","NAF1","AGE_ENTP","TR_EFF_ENT","EFENCE","A_NBR_ETAB","I_ORIGINE","I_MONOACT","I_TCD","DATE_OUVERTURE","RJ","SAUV","LJ","DATE_PLAN","PLAN","DATE_LIQUID","LIQUID","DATE_CONV","CONV_RJ","DATE_PLAN_CT","PLAN_CT","DATE_MORT","MORT","CD_MORT","DATE_PLAN_CESS","P_CESSION","DATE_CL_CT","CL_CESSION","DATE_PLAN_RJ","PLAN_RJ","S_TC","S_NOMENCL","RJ_VOL","SAUV_VOL","LJ_VOL","TC_VOL","AGE_PLAN_LIQUID","AGE_PLAN_MORT","FAILURE","AGE_FAILURE","FAILURE_12M","FAILURE_24M","FAILURE_36M","RJ_VOL_PCT","SAUV_VOL_PCT","LJ_VOL_PCT","ECHEVINAGE","TX_CHOM_NAT","TX_CHOM","TX_CHOM_MOY","CHOM_BAD","CLIM_AFF","INDIC_RETOUR","TX_CREA","TX_CREA_MOY","PIB","FBCF_ENTP_NF","AGEBILAN","BILAN_24M","BILAN_12M","S_DT_CLO_B0","S_EE_B0","S_FL_B0","EFF","TR_EFF_BILAN","TX_MA_GL","TX_VA","TX_MB_EXP","TX_M_COM","TX_DOB","RENT_B_K_EXP","RENT_N_K_EXP","CAP_GEN_CASH","RENTA_FI","SUR_FI","COUV_IMMO_FP","CRED_BK_COURANT_BFR","CP_VA","PDS_INT","VMC","DET_FOUR","CREA_CLI","DUR_FOUR","DUR_CLI","RENTA_ECO","RES_FIN","RES_EXCEP","PDS_MAS_SAL","SOLDE_COM","LIQUI","CAF","FR","BFR","TRESO_N","ENDET_BRUT","ENDET_NET","TX_ENDET_NET","TX_ENDET_BRUT","CT_ENDET","TX_RENTA_FI_KP","PDS_INT_REV_GLOB","PERS_RRP","PRET_RRP","COMPTES_ASSOCIES","CNAF","RES_HORS_EXP","RRP","STOCKS","CUR_AS_CUR_LI","TRESO_ACT","IMMO","LN_S_EE_B0","LN_S_FL_B0","LN_BFR","LN_TRESO_N","LN_ENDET_BRUT","LN_ENDET_NET","LN_COMPTES_ASSOCIES","LN_DET_FOUR","LN_CREA_CLI","LN_STOCKS","LN_TRESO_ACT","LN_IMMO")]
#####################################################################################################################
#####################################################################################################################
#####################################################################################################################
## chargement base
setwd("/Users/stephaneesquerre/Documents/LA Thèse/Recherche/Dont feed the zombies/DATA")
### reconstitution du fichier TI
#annuaire_ti <- read.csv2("annuaire_ti.csv", sep = ";")
#annuaire_ti <- data.frame(lapply(annuaire_ti, as.character), stringsAsFactors=FALSE)
#annuaire_ti2 <- melt(annuaire_ti, id.vars=c("CD_COM","CD_POST","VILLE","TI","num_TC"),na.rm = TRUE)
#write.table(annuaire_ti2, file = "annuaire_ti4.csv", row.names = FALSE, sep=";")
arrondissement<-readShapeSpatial("ARRONDISSEMENT.SHP", proj4string=CRS("+init=epsg:2154")) #j'ai pris limites plutÃÂ´t
commune<-readShapeSpatial("COMMUNE.SHP", proj4string=CRS("+init=epsg:2154")) #j'ai pris limites plutÃÂ´t

annuaire_ti <- read.csv2("annuaire_ti4.csv", sep = ";")
annuaire_ti <- annuaire_ti[!is.na(annuaire_ti$num_TC),]
annuaire_ti$CODE <- as.factor(substr(as.character(annuaire_ti$CODE),2,nchar(as.character(annuaire_ti$CODE))))
#write.table(annuaire_ti, file = "annuaire_ti3.csv", row.names = FALSE, sep=";")

annuaire_ti_arr <- annuaire_ti[as.character(annuaire_ti$KIND)=="ArrondissementOfFrance",c(3:5,7)]
#annuaire_ti_arrcom <- annuaire_ti[as.character(annuaire_ti$KIND)=="ArrondissementOfCommuneOfFrance",c(8,10:11)]
annuaire_ti_com <- annuaire_ti[as.character(annuaire_ti$KIND)=="CommuneOfFrance"|as.character(annuaire_ti$KIND)=="ArrondissementOfCommuneOfFrance",c(3:5,7)]
annuaire_ti_intercom <- annuaire_ti[as.character(annuaire_ti$KIND)=="IntercommunalityOfFrance",c(3:5,7)]

intercom <- read.csv2("intercom2015.csv", sep = ";")
intercom$CODE <- as.factor(substr(as.character(intercom$CODE),2,nchar(as.character(intercom$CODE))))
intercom$CODE_COM <- as.factor(substr(as.character(intercom$CODE_COM),2,nchar(as.character(intercom$CODE_COM))))
annuaire_ti_intercom <- merge(intercom, annuaire_ti_intercom[,c("VILLE","CODE","TI","num_TC")], by=c("CODE"))

###1. On reprend d'abord les codes arrondissements
arrondissement$CODE <- as.factor(paste(arrondissement$CODE_DEPT,arrondissement$CODE_ARR,sep="-"))
arrondissement_ti <- merge(arrondissement[,c("CODE")], annuaire_ti_arr, by=c("CODE"))
arrondissement_ti <- arrondissement_ti[is.na(arrondissement_ti$num_TC)==FALSE,]
test2 <- unionSpatialPolygons(arrondissement_ti, as.character(arrondissement_ti$num_TC))
# Convert SpatialPolygons to data frame
arrondissement_ti.df <- as(arrondissement_ti, "data.frame")
arrondissement_ti.df <- arrondissement_ti.df[!duplicated(arrondissement_ti.df[,c('num_TC')]),]
arrondissement_ti.df <- arrondissement_ti.df[!is.na(arrondissement_ti.df$num_TC),]
arrondissement_ti.df$num_TC <- as.character(arrondissement_ti.df$num_TC)
row.names(arrondissement_ti.df) <- as.character(arrondissement_ti.df$num_TC) 
# Reconvert data frame to SpatialPolygons
test2.shp <- SpatialPolygonsDataFrame(test2, arrondissement_ti.df)
test2.shp <- spChFIDs(test2.shp, paste("arrondissement",as.character(test2.shp$CODE),sep=""))

commune_ti <- merge(commune[,c("INSEE_COM")], annuaire_ti_com, all.y, by.x=c("INSEE_COM"), by.y=c("CODE"))
commune_ti <- commune_ti[is.na(commune_ti$num_TC)==FALSE,]
test <- unionSpatialPolygons(commune_ti, as.character(commune_ti$num_TC))
# Convert SpatialPolygons to data frame
commune_ti.df <- as(commune_ti, "data.frame")
commune_ti.df <- commune_ti.df[!duplicated(commune_ti.df[,c('num_TC')]),]
commune_ti.df <- commune_ti.df[!is.na(commune_ti.df$num_TC),]
commune_ti.df$num_TC <- as.character(commune_ti.df$num_TC)
#commune_ti.df2 <- data.frame(commune_ti.df[,c(1:3)])
row.names(commune_ti.df) <- as.character(commune_ti.df$num_TC) 
# Reconvert data frame to SpatialPolygons
test.shp <- SpatialPolygonsDataFrame(test, commune_ti.df)
test.shp <- spChFIDs(test.shp, paste("commune",as.character(test.shp$INSEE_COM),sep=""))
names(test.shp) <- c("CODE","VILLE","TI","num_TC") 


intercom_ti <- merge(commune[,c("INSEE_COM")], annuaire_ti_intercom,all.x=TRUE, by.x=c("INSEE_COM"), by.y=c("CODE_COM"))
intercom_ti <- intercom_ti[is.na(intercom_ti$num_TC)==FALSE,]
test3 <- unionSpatialPolygons(intercom_ti, as.character(intercom_ti$num_TC))
# Convert SpatialPolygons to data frame
intercom_ti.df <- as(intercom_ti, "data.frame")
intercom_ti.df <- intercom_ti.df[!duplicated(intercom_ti.df[,c('num_TC')]),]
intercom_ti.df <- intercom_ti.df[!is.na(intercom_ti.df$num_TC),]
intercom_ti.df$num_TC <- as.character(intercom_ti.df$num_TC)
row.names(intercom_ti.df) <- as.character(intercom_ti.df$num_TC) 
# Reconvert data frame to SpatialPolygons
test3.shp <- SpatialPolygonsDataFrame(test3, intercom_ti.df[,c("CODE","VILLE","TI","num_TC")])
test3.shp <- spChFIDs(test3.shp, paste("intercom",as.character(test3.shp$CODE),sep=""))

france=spRbind(spRbind(test.shp,test2.shp),test3.shp) 
france2 <- unionSpatialPolygons(france, as.character(france$num_TC))
france.df <- as(france, "data.frame")
france.id <- france.df[!duplicated(france.df[,c('num_TC')]),]
row.names(france.id) <- as.character(france.id$num_TC) 
france2.shp <- SpatialPolygonsDataFrame(france2, france.id)
#write.table(france.id, file = "ti_tc.csv", row.names = FALSE, sep=";")



plot(france2, col = "red", lwd = 1)
text(france2, france.id$num_TC)







plot(annuaire_ti_com)
plot(test, add = TRUE, border = "red", lwd = 2)


commune$CODECANT <- as.factor(paste(commune$CODE_DEPT,commune$CODE_COM, commune$CODE_CANT,sep=""))
plot(commune[as.character(commune$CODECANT)=="0100594",])

canton<-readShapeSpatial("CANTON.SHP", proj4string=CRS("+init=epsg:2154")) #j'ai pris limites plutÃÂ´t
canton$CODECOM <- as.factor(paste(canton$CODE_DEPT,canton$CODE_CHF,sep=""))
canton$CODECANT <- as.factor(paste(canton$CODE_DEPT,canton$CODE_CHF, canton$CODE_CANT,sep=""))
plot(commune[as.character(commune$CODECOM)=="01005",])

arrondissement <- spChFIDs(arrondissement, paste(arrondissement$CODE_DEPT,arrondissement$CODE_ARR,sep="-"))
arrondissement <- arrondissement[,c("CODE_DEPT")]
commune <- spChFIDs(commune, as.character(commune$CODECOM))
commune <- commune[,c("CODE_DEPT")]
france=spRbind(arrondissement,commune) 


prefecture <- readOGR(dsn="COMMUNE.tab",layer="COMMUNE")
plot(prefecture)
summary(prefecture)


prefecture <- readOGR("Prefecturesetsousprefecturespo.geojson", "OGRGeoJSON")
install.packages("rjson")
library("rjson")
prefecture <- fromJSON(paste(readLines("Prefecturesetsousprefecturespo.json"), collapse=""))
plot(prefecture)






TC2010 <- readOGR(dsn="TC2010.tab",layer="TC2010")
TC2011 <- readOGR(dsn="TC2011.tab",layer="TC2011")




