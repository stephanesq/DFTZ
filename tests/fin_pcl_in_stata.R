#####################################################################################################################
#######
rm(list=ls()) #Tout
#######
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
library(doBy, lib.loc="//intra/profils/D000/H825086/D/Documents/R/win-library/3.1")
library(Hmisc, lib.loc="//intra/profils/D000/H825086/D/Documents/R/win-library/3.1")
library(foreign, lib.loc="//intra/profils/D000/H825086/D/Documents/R/win-library/3.1")
library(plyr, lib.loc="//intra/profils/D000/H825086/D/Documents/R/win-library/3.1")
library(qte, lib.loc="//intra/profils/D000/H825086/D/Documents/R/win-library/3.1")
library(lubridate, lib.loc="//intra/profils/D000/H825086/D/Documents/R/win-library/3.1")
#chargement des fonctions
lagpad <- function(x, k) { if (!is.vector(x)) 
  stop('x must be a vector')
  if (!is.numeric(x)) 
    stop('x must be numeric')
  if (!is.numeric(k))
    stop('k must be numeric')
  if (1 != length(k))
    stop('k must be a single number')
  c(rep(NA, k), x)[1 : length(x)] }
eom <- function(date) {
  # date character string containing POSIXct date
  date.lt <- as.POSIXlt(date) # add a month, then subtract a day:
  mon <- date.lt$mon + 2 
  year <- date.lt$year
  year <- year + as.integer(mon==13) # if month was December add a year
  mon[mon==13] <- 1
  iso = ISOdate(1900+year, mon, 1, hour=0, tz="UTC")
  result = as.POSIXct(iso) - 86400 # subtract one day
  result + (as.POSIXlt(iso)$isdst - as.POSIXlt(result)$isdst)*3600
}
shift<-function(x,shift_by){
  stopifnot(is.numeric(shift_by))
  stopifnot(is.numeric(x))
  
  if (length(shift_by)>1)
    return(sapply(shift_by,shift, x=x))
  
  out<-NULL
  abs_shift_by=abs(shift_by)
  if (shift_by > 0 )
    out<-c(tail(x,-abs_shift_by),rep(NA,abs_shift_by))
  else if (shift_by < 0 )
    out<-c(rep(NA,abs_shift_by), head(x,-abs_shift_by))
  else
    out<-x
  out
}
#############
#chargement du dossier principal
setwd("//intra/partages/UA2771_Data/6_Utilisateurs/Stephane/4_Donnees/PERSO")
#############
FIN_PCL <- read.csv2("MSTATE_TVC.csv", sep = ";", dec=",")
FIN_PCL <- FIN_PCL[order(FIN_PCL$I_SIREN,FIN_PCL$AGE_DBT),]
FIN_PCL <- FIN_PCL[!duplicated(FIN_PCL$I_SIREN),] 
FIN_PCL <- subset(FIN_PCL, select = - c(AGE_FIN,CLIM_AFF,INDIC_RETOUR,NAF_DPT,TX_CHOM,TX_CHOM_NAT,PIB ,FBCF_ENTP_NF,RJ_Sum,LJ_Sum, SAUV_Sum, Effectif, TX_CREA_Mean, S_NOMENCL,TX_CREA,REGION_NAME,TX_CHOM_MOY,CHOM_BAD,RJ_VOL,SAUV_VOL, LJ_VOL, TC_VOL, TX_CREA_MOY,PIB_PLAN,TX_CHOM_NAT_PLAN,TX_CHOM_PLAN,TX_CREA_PLAN,FJ_1,FAILURE_12M,FAILURE_24M,FAILURE_36M,I_EFENCE_Sum,I_EFENCE_Mean,Emploi  ))
write.table(FIN_PCL, file = "FIN_PCL.csv", row.names = FALSE, sep=";", dec=",",na=".")
