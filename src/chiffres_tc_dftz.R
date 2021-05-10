#####################################################################################################################
## chargement base
rm(list=ls()) #Tout
setwd("/Users/stephaneesquerre/Documents/LA Thèse/Recherche/DFTZ/DATA")
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
setwd("/Users/stephaneesquerre/Documents/LA Thèse/Recherche/DFTZ/DATA")
DFTZ <- read.csv2("DFTZ_EXP.csv", sep = ";", dec=".", na=".")
##################
#préparation data
DFTZ <- DFTZ[,c("I_SIREN","I_CD_POST_SIEGE","I_FJ","FJ_1","NAF2","NAF1","AGE_ENTP","TR_EFF_ENT","EFENCE","I_ORIGINE","DATE_OUVERTURE","RJ","SAUV","LJ","DATE_PLAN","DATE_LIQUID","DATE_CONV","DATE_PLAN_CT","DATE_MORT","CD_MORT","DATE_PLAN_CESS","P_CESSION","DATE_CL_CT","CL_CESSION","FAILURE","AGE_FAILURE","A_PCL_TC")]
DFTZ$PROC <- as.factor(ifelse(DFTZ$RJ==1,"RJ", ifelse(DFTZ$SAUV==1, "SAUV", "LJ")))
DFTZ <- DFTZ[DFTZ$SAUV==0,] #on enlève sauvegarde
DFTZ <- DFTZ[which(DFTZ$FJ_1==5|DFTZ$FJ_1==6),] #on conserve quesociétés commerciales (FJ 5 et 6)
DFTZ$TR_EFF_ENT <- as.factor(DFTZ$TR_EFF_ENT)
DFTZ$TR_EFF_ENT <- as.numeric(as.character(DFTZ$TR_EFF_ENT))
DFTZ$L_TR_EFF <- as.factor(ifelse(is.na(DFTZ$TR_EFF_ENT )==TRUE|DFTZ$TR_EFF_ENT == 0,0, ifelse(DFTZ$TR_EFF_ENT > 0 & DFTZ$TR_EFF_ENT < 10 ,0, 1)))
DFTZ$FJ_2 <- as.factor(substr(as.character(DFTZ$I_FJ),1,2))
DFTZ$ANNEE <- as.factor(substr(as.character(DFTZ$DATE_OUVERTURE),1,4))
DFTZ$ANNEEMOIS <- as.factor(substr(as.character(DFTZ$DATE_OUVERTURE),1,6))
DFTZ$ANNEEMOIS_PLAN <- as.factor(substr(as.character(DFTZ$DATE_PLAN),1,6))
DFTZ$FJ <- as.character(DFTZ$FJ_2)
DFTZ$FJ <- as.factor(ifelse(DFTZ$FJ=="51"|DFTZ$FJ=="52"|DFTZ$FJ=="53"|DFTZ$FJ=="56","AUTRES", DFTZ$FJ))
DFTZ$DPT <- as.factor(substr(as.character(DFTZ$I_CD_POST_SIEGE),1,2))
DFTZ$DOMTOM <- ifelse(substr(as.character(DFTZ$DPT),1,2)=="97",1,0)
DFTZ$NAF1 <- as.character(DFTZ$NAF1)
DFTZ$NAF <- as.factor(ifelse(DFTZ$NAF1=="B"|DFTZ$NAF1=="D"|DFTZ$NAF1=="E","Z",DFTZ$NAF1))
DFTZ$NAF1 <- as.factor(DFTZ$NAF1)
DFTZ$DNAF <- ifelse(DFTZ$NAF=="C"|DFTZ$NAF=="F"|DFTZ$NAF=="G"|DFTZ$NAF=="H"|DFTZ$NAF=="I"|DFTZ$NAF=="J"|DFTZ$NAF=="L"|DFTZ$NAF=="N"|DFTZ$NAF=="T"|DFTZ$NAF=="Z",1,0) 
#DFTZ$ANNEE_NAF <- paste(substr(as.character(DFTZ$DATE_OUVERTURE),1,4),as.character(DFTZ$NAF), sep="")
#DFTZ$ANNEE_NAF <- as.factor(DFTZ$ANNEE_NAF)
#DFTZ$ANNEEMOIS <- substr(as.character(DFTZ$DATE_OUVERTURE),1,6)
DFTZ <- DFTZ[which(DFTZ$DNAF==1 & DFTZ$DOMTOM==0),]
DFTZ2 <- DFTZ
# info sur date
DFTZ$MOIS <- as.numeric(format(as.Date(substr(DFTZ$DATE_OUVERTURE,1,8), format="%Y%m%d"), "%m"))
DFTZ$ANNEE_TRIM <- ifelse(DFTZ$MOIS<=3,"T1",ifelse(DFTZ$MOIS>=3 & DFTZ$MOIS<=6,"T2",ifelse(DFTZ$MOIS>=3 & DFTZ$MOIS<=6,"T2",ifelse(DFTZ$MOIS>=6 & DFTZ$MOIS<=9,"T3","T4"))))
DFTZ$ANNEE_SEM <- ifelse(DFTZ$MOIS<=6,"S1","S2")
DFTZ$TRIM <- paste(DFTZ$ANNEE,DFTZ$ANNEE_TRIM, sep="")
DFTZ$TRIM <- as.factor(DFTZ$TRIM)
DFTZ$SEM <- paste(DFTZ$ANNEE,DFTZ$ANNEE_SEM, sep="")
DFTZ$SEM <- as.factor(DFTZ$SEM)
DFTZ <- subset(DFTZ, select = - c(ANNEE_TRIM,ANNEE_SEM))
#table(DFTZB[as.character(DFTZB$ANNEEMOIS)=="201008",]$JOUR)
DFTZ$date <- (as.numeric(as.character(DFTZ$ANNEE))-2008)*100 + DFTZB$MOIS
DFTZ$time = ifelse(as.numeric(as.character(DFTZ$ANNEEMOIS))>=200901, 1, 0)
#info PCL
DFTZ$PLAN <- ifelse(as.character(DFTZ$DATE_PLAN)=="", 0,1)
DFTZ$PLAN <- ifelse(as.character(DFTZ$LJ)=="1", NA,DFTZ$PLAN)
DFTZ$PCL <- DFTZ$RJ + DFTZ$LJ
#attribution des tc et leurs informations (absorbtion)
tc_ville <- read.csv2("CDPOST_TC_MJ.csv", sep = ";", dec =",", na="")
tc_ville$I_CD_POST_SIEGE <- as.factor(substr(as.character(tc_ville$I_CD_POST_SIEGE),2,6)) #encore des code communes sans TC
tc_ville$num_TC_2009 <- tc_ville$ferm_2009
tc_ville <- tc_ville[!is.na(tc_ville$num_TC_2009)==TRUE,]
lien_tc <- read.csv2("LIEN_TC_MJ.csv", sep = ";", na="")
lien_tc$num_TC_2009 <- lien_tc$i_elst
tc_ville <- merge(tc_ville[,c('num_TC_2009','I_CD_POST_SIEGE')], lien_tc[,c('num_TC_2009','libel_crt','tc_abs','num_TC','TGI')], all.x=T, by=c("num_TC_2009"))
tc_ville <- tc_ville[!duplicated(tc_ville[,c('I_CD_POST_SIEGE')]),] #a vérifier
DFTZ3 <- DFTZ[,c("I_SIREN","NAF","FJ","L_TR_EFF","I_CD_POST_SIEGE","DATE_OUVERTURE","DATE_PLAN","DATE_LIQUID","DATE_MORT","ANNEEMOIS","MOIS","SEM","TRIM","ANNEE","RJ","LJ",'PCL',"PLAN")]
DFTZ4 <- merge(DFTZ3, tc_ville, by=c("I_CD_POST_SIEGE"))
DFTZ4$time <-DFTZ4$TRIM
write.table(DFTZ4, file = "DFTZ_NBR.csv", row.names = FALSE, sep=";", dec=".", na=".")
#rajout des stats par date et par TC
DFTZ4 <- read.csv2("DFTZ_NBR.csv", sep=";", dec=".", na=".")
DFTZ_TC_VOL <- summaryBy(  PCL + RJ ~ as.factor(time) + as.factor(tc_abs) + as.factor(num_TC_2009) , data= DFTZ4, FUN= sum)
names(DFTZ_TC_VOL) <- c("time","tc_abs","num_TC_2009","TC_VOL", "RJ_VOL") #, "num_TC_2119"
write.table(DFTZ_TC_VOL, file = "stat_tc_vol.csv", row.names = FALSE, sep=";", dec=".", na=".")
DFTZ_RJ_PCT <- summaryBy(  RJ ~ as.factor(time) + as.factor(tc_abs) + as.factor(num_TC_2009) , data= DFTZ4, FUN= mean)
names(DFTZ_RJ_PCT) <- c("time","tc_abs","num_TC_2009","RJ_PCT") #, "num_TC_2119"
write.table(DFTZ_RJ_PCT, file = "stat_rj_pct.csv", row.names = FALSE, sep=";", dec=".", na=".")
