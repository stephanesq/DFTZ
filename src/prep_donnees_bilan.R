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
setwd("/Users/stephaneesquerre/Documents/LA Thèse/Recherche/DFTZ/DATA")
DFTZ <- read.csv2("DFTZ_EXP.csv", sep = ";", dec=".", na=".")
##################
##### A. Traitement statistique des données
##1. infos sur TC
DFTZ$ANNEE <- as.factor(substr(as.character(DFTZ$DATE_OUVERTURE),1,4))
A_TC <- DFTZ[,c("ANNEE","A_PCL_TC","S_TC")]
A_TC$num_A_PCL_TC <- factor(A_TC$A_PCL_TC)
levels(A_TC$num_A_PCL_TC) <-  c(1:length(unique(A_TC$num_A_PCL_TC)))
stats_com <- summaryBy(as.factor(ANNEE) ~ num_A_PCL_TC , data = A_TC, FUN = function(x) { c(l = length(x)) } )
table_tc_annee <- table(A_TC$num_A_PCL_TC,A_TC$ANNEE)
table_tc_nom <- A_TC[,c("num_A_PCL_TC","A_PCL_TC")]
table_tc_nom <- unique(table_tc_nom)
corresp_tc_nom <- A_TC[,c("num_A_PCL_TC","A_PCL_TC","S_TC")]
corresp_tc_nom <-corresp_tc_nom[corresp_tc_nom$A_PCL_TC!="",]
corresp_tc_nom <- unique(corresp_tc_nom)
write.table(table_tc_annee, file = "table_tc_annee.csv", sep=";")
write.table(table_tc_nom, file = "table_tc_nom.csv", row.names = FALSE, sep=";")
write.table(corresp_tc_nom, file = "corresp_tc_nom.csv", row.names = FALSE, sep=";")


A_TC_BILAN <- DFTZ[,c("ANNEE","A_PCL_TC","S_TC","BILAN_24M")]
A_TC_BILAN <- A_TC_BILAN[A_TC_BILAN$BILAN_24M==1,]
summary(A_TC_BILAN)
##################
##################
DFTZ <- read.csv2("DFTZ_EXP.csv", sep = ";", dec=".", na=".")
##################
#préparation data
DFTZ <- DFTZ[,c("I_SIREN","I_CD_POST_SIEGE","I_FJ","FJ_1","NAF2","NAF1","AGE_ENTP","TR_EFF_ENT","EFENCE","A_NBR_ETAB","I_ORIGINE","DATE_OUVERTURE","RJ","SAUV","LJ","DATE_PLAN","DATE_LIQUID","DATE_CONV","DATE_PLAN_CT","DATE_MORT","CD_MORT","DATE_PLAN_CESS","P_CESSION","DATE_CL_CT","CL_CESSION","FAILURE","AGE_FAILURE","AGEBILAN","BILAN_24M","S_DT_CLO_B0","S_EE_B0","S_FL_B0","EFF","TX_MA_GL","TX_VA","TX_MB_EXP","TX_DOB","RENT_B_K_EXP","RENT_N_K_EXP","CAP_GEN_CASH","RENTA_FI","SUR_FI","COUV_IMMO_FP","CRED_BK_COURANT_BFR","CP_VA","PDS_INT","VMC","DET_FOUR","CREA_CLI","DUR_FOUR","DUR_CLI","RENTA_ECO","RES_FIN","RES_EXCEP","PDS_MAS_SAL","SOLDE_COM","LIQUI","CAF","FR","BFR","TRESO_N","ENDET_BRUT","ENDET_NET","TX_ENDET_NET","TX_ENDET_BRUT","CT_ENDET","TX_RENTA_FI_KP","PDS_INT_REV_GLOB","PERS_RRP","PRET_RRP","COMPTES_ASSOCIES","CNAF","RES_HORS_EXP","RRP","STOCKS","CUR_AS_CUR_LI","TRESO_ACT","IMMO","A_PCL_TC")]
DFTZ$PROC <- as.factor(ifelse(DFTZ$RJ==1,"RJ", ifelse(DFTZ$SAUV==1, "SAUV", "LJ")))
DFTZ <- DFTZ[DFTZ$SAUV==0,] #on enlève sauvegarde
DFTZ <- DFTZ[which(DFTZ$FJ_1==5|DFTZ$FJ_1==6),] #on conserve quesociétés commerciales (FJ 5 et 6)
DFTZ$TR_EFF_ENT <- as.factor(DFTZ$TR_EFF_ENT)
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
####### Fusion réforme
#num_A_PCL_TC <- read.xlsx("corresp_tc_nom.xlsx", , sheetName ="corresp_tc_nom")
#num_A_PCL_TC$num_A_PCL_TC <-as.factor(as.character(num_A_PCL_TC$num_A_PCL_TC))
#num_A_PCL_TC$num_TC_2009 <-as.factor(as.character(num_A_PCL_TC$num_TC_2009))
#DFTZ <- merge(DFTZ, num_A_PCL_TC,all.x=TRUE, by=c("A_PCL_TC"))
#DFTZ$num_TC_2009 <-as.factor(ifelse(is.na(DFTZ$Ref2009)==TRUE, as.character(DFTZ$num_A_PCL_TC), as.character(DFTZ$num_TC_2009)))
#DFTZ$Ref2009 <- ifelse(is.na(DFTZ$Ref2009)==TRUE,0,DFTZ$Ref2009)
#DFTZ$str <- as.character(DFTZ$str)
#DFTZ$pb_tc <- ifelse(DFTZ$str=="CA"|DFTZ$str=="TI"|DFTZ$str=="TGI"|DFTZ$str=="TMC"|DFTZ$str=="TPI",1,0) #suppr aussi TC echev
#DFTZ$pb_tc <- DFTZ$pb_tc + DFTZ$Ref2009
#DFTZ$str <- as.factor(as.character(DFTZ$str))
#DFTZ$tc_absorbant <- ifelse(is.na(DFTZ$tc_absorbant)==TRUE,2,DFTZ$tc_absorbant)
#DFTZ <- DFTZ[which(as.numeric(as.character(DFTZ$num_TC_2009))!=1|DFTZ$pb_tc>=1),]  
#DFTZ$TGI <- ifelse(is.na(DFTZ$TGI)==TRUE,0,DFTZ$TGI)
#DFTZ$str_pre_2009 <-as.factor(ifelse(DFTZ$TGI==1, "TC", as.character(DFTZ$str_pre_2009)))
#Réconciliation des infos de la réforme
#DFTZ$str_pre_2009 <-as.factor(ifelse(is.na(DFTZ$Ref2009)==TRUE, "TC", as.character(DFTZ$str_pre_2009)))
#DFTZ$abs_ref2009 <- ifelse(is.na(DFTZ$Ref2009)==FALSE,0,1)
#Suppression des obs sans TC reporté
#DFTZ2 <- DFTZ

#carte post reforme
#map_greffe <- readOGR("greffes_cd_com.geojson", "OGRGeoJSON")
#map_greffe$I_CD_POST_SIEGE <- map_greffe$code_commune
#map_greffe$TC <- map_greffe$greffe
#map_greffe <- map_greffe@data[,c("I_CD_POST_SIEGE","TC")]
#map_greffe$I_CD_POST_SIEGE <- paste("A",map_greffe$I_CD_POST_SIEGE, sep="")
#write.table(map_greffe, file = "map_greffe.csv", row.names = FALSE, sep=";", dec=",")
#map_greffe <- unique(map_greffe)
map_greffe <- read.csv2("map_greffe.csv", sep = ";", dec =",")
map_greffe$I_CD_POST_SIEGE <- as.factor(substr(as.character(map_greffe$I_CD_POST_SIEGE),2,6)) #encore des code communes sans TC
map_greffe$CDCOM_TC <- as.factor(substr(as.character(map_greffe$CDCOM_TC),2,6)) #encore des code communes sans TC
DFTZ <- merge(DFTZ, map_greffe,all.x=TRUE, by=c("I_CD_POST_SIEGE"))
DFTZ <- DFTZ[is.na(DFTZ$num_TC2009)==FALSE,] #suppr si pas de TC connu

#ville_tc_abs <- read.csv2("ville_tc_abs.csv", sep = ";", dec =",")
#ville_tc_abs$CDCOM_TCABS <- as.factor(substr(as.character(ville_tc_abs$CDCOM_TCABS),2,6)) #encore des code communes sans TC
#DFTZ <- merge(DFTZ, ville_tc_abs,all.x=TRUE, by.x=c("I_CD_POST_SIEGE"), by.y=c("CDCOM_TCABS"))
#DFTZ$num_TC <- ifelse(is.na()==TRUE,,)

#DFTZ_greffe <- DFTZ[,c("I_CD_POST_SIEGE","num_A_PCL_TC","num_TC_2009","TC")]
#DFTZ_greffe <- unique(DFTZ_greffe)
#write.table(DFTZ_greffe, file = "DFTZ_greffe.csv", row.names = FALSE, sep=";", dec=",")
#### Fusion région
dpts <- read.csv2("depts2008.csv", sep = ";", dec =",")
dpts$DPT <- as.factor(substr(as.character(dpts$DPT),2,3))
dpts$REGION <- as.factor(as.character(dpts$REGION))
DFTZ <- merge(DFTZ, dpts,all.x=TRUE, by=c("DPT"))
#DFTZ$ECHEV <- ifelse(as.character(DFTZ$DPT)=="57"|as.character(DFTZ$DPT)=="67"|as.character(DFTZ$DPT)=="68",1,0)
#DFTZ <- DFTZ[DFTZ$ECHEV==0,]
DFTZ <- subset(DFTZ, select = - c(A_PCL_TC))

####### TC qualifié de TI
#tc_ti <- read.csv2("tc_ti.csv", sep = ";", dec =",")
#tc_ti$num_A_PCL_TC <-as.factor(as.character(tc_ti$num_A_PCL_TC))
#tc_ti$num_tc <-as.factor(as.character(tc_ti$num_tc))
#DFTZ <- merge(DFTZ, tc_ti,all.x=TRUE, by=c("num_A_PCL_TC"))
#DFTZ$num_tc <- ifelse(is.na(DFTZ$num_tc)==TRUE,DFTZ$num_A_PCL_TC,DFTZ$num_tc)
#DFTZ <- subset(DFTZ, select = - c(num_tc))

#reforme_TC2009 <- read.csv2("reforme_TC2009.csv", sep = ";", dec =",")
#reforme_TC2009$num_A_PCL_TC <-as.factor(as.character(reforme_TC2009$num_A_PCL_TC))
#reforme_TC2009$num_TC_2009 <-as.factor(as.character(reforme_TC2009$num_TC_2009))
#DFTZ <- merge(DFTZ, reforme_TC2009,all.x=TRUE, by=c("num_A_PCL_TC"))
#DFTZ <- subset(DFTZ, select = - c(num_TC_2009,str_pre_2009))
#Conversion des TC reportés dans la base en TI

# info sur date
DFTZ$MOIS <- as.numeric(format(as.Date(substr(DFTZ$DATE_OUVERTURE,1,8), format="%Y%m%d"), "%m"))
DFTZ$ANNEE_TRIM <- ifelse(DFTZ$MOIS<=3,"T1",ifelse(DFTZ$MOIS>=3 & DFTZ$MOIS<=6,"T2",ifelse(DFTZ$MOIS>=3 & DFTZ$MOIS<=6,"T2",ifelse(DFTZ$MOIS>=6 & DFTZ$MOIS<=9,"T3","T4"))))
DFTZ$ANNEE_SEM <- ifelse(DFTZ$MOIS<=6,"S1","S2")
DFTZ$TRIM <- paste(DFTZ$ANNEE,DFTZ$ANNEE_TRIM, sep="")
DFTZ$TRIM <- as.factor(DFTZ$TRIM)
DFTZ$SEM <- paste(DFTZ$ANNEE,DFTZ$ANNEE_SEM, sep="")
DFTZ$SEM <- as.factor(DFTZ$SEM)
DFTZ <- subset(DFTZ, select = - c(ANNEE_TRIM,ANNEE_SEM))
#info PCL
DFTZ$PLAN <- ifelse(as.character(DFTZ$DATE_PLAN)=="", 0,1)
DFTZ$PLAN <- ifelse(as.character(DFTZ$LJ)=="1", NA,DFTZ$PLAN)


#On ne conserve qu'observations avec info fin
DFTZB <- DFTZ[DFTZ$AGEBILAN<=24,]
# Frais : Décret n°85-1390 du 27 décembre 1985
##1.0 Pour les mandataires + liquidateurs : 
######Droit fixe (Article R663-18 - QUE SI RJ)
DFTZB$dt_fixe <- 2500
###### Relevé des créances salariales (Article R663-24)
DFTZB$relev_crean_sal <- 120*DFTZB$EFF
##1.1 cout ouverture pcl - diagnostic (Article R663-4) 
DFTZB$frais_ouv_eff<-cut(DFTZB$EFENCE, c(0,5,20,50,150,Inf),right=FALSE, labels=c("10", "20", "40", "80", "100"))
DFTZB$frais_ouv_eff <- as.numeric(as.character(DFTZB$frais_ouv_eff))
DFTZB$frais_ouv_ca<-cut(DFTZB$S_FL_B0, c(0,750000,3000000,7000000,20000000 ,Inf),right=FALSE, labels=c("10", "20", "40", "80", "100"))
DFTZB$frais_ouv_ca <- as.numeric(as.character(DFTZB$frais_ouv_ca))
DFTZB$frais_ouv_bilan<-cut(DFTZB$S_EE_B0, c(0,3650000,10000000 ,Inf),right=FALSE, labels=c("0","80", "100"))
DFTZB$frais_ouv_bilan <- as.numeric(as.character(DFTZB$frais_ouv_bilan))
DFTZB$frais_ouv_petitbil <- pmax(DFTZB$frais_ouv_eff,DFTZB$frais_ouv_ca)
DFTZB$frais_ouv_pcl <- ifelse(DFTZB$S_EE_B0>3650000,DFTZB$frais_ouv_bilan, DFTZB$frais_ouv_petitbil) #a verifier
##1.2 cout mandataire pcl (Article 3) mission d'administration - Article  R663-5
#DFTZB$frais_pct_ca<-cut(DFTZB$S_FL_B0, c(0,150000,750000,3000000,7000000,Inf),right=FALSE, labels=c("0.02", "0.01", "0.006", "0.004", "0.003"))
#DFTZB$frais_pct_ca <- as.numeric(as.character(DFTZB$frais_pct_ca))  #a vérifier si admin ou surveillance en gnl
DFTZB$mis_admin <- ifelse(DFTZB$S_FL_B0<150000,DFTZB$S_FL_B0*0.02,ifelse(DFTZB$S_FL_B0<750000,150000*0.02+DFTZB$S_FL_B0*0.01,ifelse(DFTZB$S_FL_B0<3000000,150000*0.02+750000*0.01+DFTZB$S_FL_B0*0.006,ifelse(DFTZB$S_FL_B0<7000000,150000*0.02+750000*0.01+3000000*0.006+DFTZB$S_FL_B0*0.004,150000*0.02+750000*0.01+3000000*0.006+7000000*0.004+DFTZB$S_FL_B0*0.004))))
DFTZB$mis_admin <- ifelse(DFTZB$S_FL_B0<0,0,DFTZB$mis_admin)
DFTZB$mis_admin <- DFTZB$mis_admin*1.5
##1.3 cout bilan economique et social + arret plan
DFTZB$frais_bes_eff<-cut(DFTZB$EFENCE, c(0,5,20,50,150,Inf),right=FALSE, labels=c("15", "20", "60", "100", "150"))
DFTZB$frais_bes_eff <- as.numeric(as.character(DFTZB$frais_bes_eff))
DFTZB$frais_bes_ca<-cut(DFTZB$S_FL_B0, c(0,750000,3000000,7000000,20000000 ,Inf),right=FALSE, labels=c("15", "20", "60", "100", "150"))
DFTZB$frais_bes_ca <- as.numeric(as.character(DFTZB$frais_bes_ca))
DFTZB$frais_bes_bilan<-cut(DFTZB$S_EE_B0, c(0,3650000,10000000 ,Inf),right=FALSE, labels=c("0","80", "100"))
DFTZB$frais_bes_bilan <- as.numeric(as.character(DFTZB$frais_bes_bilan))
DFTZB$frais_bes_petitbil <- pmax(DFTZB$frais_bes_eff,DFTZB$frais_bes_ca)
DFTZB$frais_bes <- ifelse(DFTZB$S_EE_B0>3650000,DFTZB$frais_bes_bilan, DFTZB$frais_bes_petitbil) #a verifier
#2.. calcul frais et insuff actif
DFTZB$remun_admin <- (DFTZB$frais_ouv_pcl+DFTZB$frais_bes)*100 + DFTZB$mis_admin + DFTZB$relev_crean_sal + DFTZB$dt_fixe
DFTZB$remun_admin_plan <- (DFTZB$frais_ouv_pcl+DFTZB$frais_bes*1.5)*100 + DFTZB$mis_admin*1.5 + DFTZB$relev_crean_sal + DFTZB$dt_fixe
#DFTZB$remun_admin <-ifelse(is.na(DFTZB$PLAN)==TRUE| DFTZB$PLAN == 0, DFTZB$remun_admin,DFTZB$remun_admin_plan)
DFTZB <- subset(DFTZB, select = - c(dt_fixe,relev_crean_sal,frais_ouv_eff, frais_ouv_ca, frais_ouv_bilan, frais_ouv_petitbil, mis_admin, frais_bes_eff, frais_bes_ca, frais_bes_bilan, frais_bes_petitbil))
DFTZB$actif <- DFTZB$STOCKS+DFTZB$TRESO_ACT+DFTZB$IMMO
DFTZB$insuff_actif <- ifelse(DFTZB$actif< DFTZB$remun_admin,1,0)
DFTZB$insuff_actif <- ifelse(DFTZB$actif<= 0, NA,DFTZB$insuff_actif)
DFTZB$insuff_actif_pct <- ifelse(DFTZB$actif<DFTZB$remun_admin,1, DFTZB$remun_admin/DFTZB$actif)#
DFTZB$insuff_actif_pct <- ifelse(DFTZB$actif<= 0, NA, DFTZB$insuff_actif_pct)
DFTZB$insuff_actif_RJ <- DFTZB$insuff_actif*DFTZB$RJ
DFTZB$insuff_actif_LJ <- DFTZB$insuff_actif*DFTZB$LJ
DFTZB$insuff_actif_PLAN <- ifelse(DFTZB$actif< DFTZB$remun_admin_plan,1,0)
DFTZB$insuff_actif_PLAN <- ifelse(DFTZB$RJ==0,NA,DFTZB$insuff_actif_PLAN)

DFTZB$JOUR <- as.factor(substr(as.character(DFTZB$DATE_OUVERTURE),1,8))
#table(DFTZB[as.character(DFTZB$ANNEEMOIS)=="201008",]$JOUR)
DFTZB$date <- (as.numeric(as.character(DFTZB$ANNEE))-2008)*100 + DFTZB$MOIS
DFTZB$time = ifelse(as.numeric(as.character(DFTZB$ANNEEMOIS))>=200901, 1, 0)
#DFTZB2 <- DFTZB[DFTZB$MOIS!=8,]
DFTZB$PCL <- DFTZB$RJ + DFTZB$LJ
DFTZB$treated = as.factor(ifelse(as.numeric(as.character(DFTZB$tc_absorbant))==2,"2",ifelse(as.numeric(as.character(DFTZB$tc_absorbant))==3,"0","1")))
DFTZB$LN_S_EE_B0 <- ifelse(DFTZB$S_EE_B0<0,NA,log(1+DFTZB$S_EE_B0))
DFTZB$LN_S_FL_B0 <- ifelse(DFTZB$S_FL_B0<0,NA,log(1+DFTZB$S_FL_B0))
DFTZB$LN_AGE_ENTP <- ifelse(DFTZB$AGE_ENTP<0,NA,log(1+DFTZB$AGE_ENTP))
DFTZB$LN_EFENCE <- ifelse(DFTZB$EFENCE<0,NA,log(1+DFTZB$EFENCE))
DFTZB$TR_EFF_ENT <- as.numeric(as.character(DFTZB$TR_EFF_ENT))
DFTZB$L_TR_EFF <- as.factor(ifelse(is.na(DFTZB$TR_EFF_ENT )==TRUE|DFTZB$TR_EFF_ENT == 0,0, ifelse(DFTZB$TR_EFF_ENT > 0 & DFTZB$TR_EFF_ENT < 10 ,0, 1)))


ti_tc_ville <- read.csv2("ti_tc_ville.csv", sep = ";", dec =",")
ti_tc_ville$I_CD_POST_SIEGE <- as.factor(substr(as.character(ti_tc_ville$I_CD_POST_SIEGE),2,6)) #encore des code communes sans TC
ti_ministere <- read.csv2("ti_ministere.csv", sep = ";", na="NA")
ti_ministere <- ti_ministere[!is.na(ti_ministere$num_TC)==TRUE,]
ti_tc_ville <- merge(ti_tc_ville, ti_ministere[,c(3:7)], all.x=T, by=c("num_TC"))
ti_tc_ville <- ti_tc_ville[!duplicated(ti_tc_ville[,c('INSEE_COM')]),] #a vérifier
DFTZ3 <- DFTZB[,c("I_SIREN","NAF","FJ","L_TR_EFF","LN_S_EE_B0","LN_S_FL_B0","LN_AGE_ENTP","LN_EFENCE","RENTA_ECO","RENT_B_K_EXP","RENT_N_K_EXP","CAP_GEN_CASH","SUR_FI","COUV_IMMO_FP","CUR_AS_CUR_LI","ENDET_BRUT","I_CD_POST_SIEGE","DATE_OUVERTURE","DATE_PLAN","DATE_LIQUID","DATE_MORT","ANNEEMOIS","MOIS","SEM","TRIM","ANNEE","RJ","LJ","PCL","PLAN","AGE_FAILURE","insuff_actif_pct","insuff_actif_LJ","insuff_actif_RJ","insuff_actif")]
DFTZ4 <- merge(DFTZ3, ti_tc_ville, by=c("I_CD_POST_SIEGE"))
DFTZ4 <- DFTZ4[DFTZ4$Exploitable==1,]
DFTZ4$time <-DFTZ4$TRIM
#DFTZ4 <- DFTZ4[DFTZ4$MOIS!=8,]

write.table(DFTZ4, file = "DFTZ_STATA.csv", row.names = FALSE, sep=";", dec=".", na=".")


#######  1. Statistiques
########
## ID : comparaison des ecart entre les ratio pour les TC absorbes et ceux absorbants
#on choisit la periode d'etude
#
myfun6 <- function(x){c(m = mean(x,na.rm = TRUE))}
myfun7 <- function(x){c(q = quantile(x,c(.25,.75),na.rm = TRUE),M = mean(x,na.rm = TRUE), s=sd(x,na.rm=T))} # calcul malgré valeurs manquantes 

stats_ref13a0 <- summaryBy( insuff_actif_pct_LJ + insuff_actif_pct_RJ + RJ  ~ as.factor(time)    + as.factor(num_TCABS), data= DFTZ4[which(as.numeric(as.character(DFTZ4$ANNEE))>=2006 & DFTZ4$TC_ABS==0) ,], FUN= myfun6)
names(stats_ref13a0) <- c("time","num_TCABS","insuff_actif_pct_LJm0","insuff_actif_pct_RJm0","RJm0") #, "num_TC_2009"

stats_ref13a1 <- summaryBy( insuff_actif_pct_LJ + insuff_actif_pct_RJ + RJ  ~ as.factor(time) + as.factor(num_TC)  + as.factor(num_TCABS), data= DFTZ4[which(as.numeric(as.character(DFTZ4$ANNEE))>=2006 & DFTZ4$TC_ABS==1) ,], FUN= myfun6)
names(stats_ref13a1) <- c("time","num_TC","num_TCABS","insuff_actif_pct_LJm1","insuff_actif_pct_RJm1","RJm1") #, "num_TC_2119"

stats_ref13all0 <- summaryBy( insuff_actif_pct_LJm0 + insuff_actif_pct_RJm0 + RJm0  ~ as.factor(time) , data= stats_ref13a0, FUN= myfun7)
names(stats_ref13all0) <- c("time","insuff_actif_pct_LJq25","insuff_actif_pct_LJq75","insuff_actif_pct_LJm","insuff_actif_pct_LJs","insuff_actif_pct_RJq25","insuff_actif_pct_RJq75","insuff_actif_pct_RJm","insuff_actif_pct_RJs","RJq25","RJq75","RJm","RJs") #, "num_TC_2009"
stats_ref13all0$TC_ABS <- 0
stats_ref13all0$insuff_actif_pct_LJintq <- stats_ref13all0$insuff_actif_pct_LJq75 / stats_ref13all0$insuff_actif_pct_LJq25
stats_ref13all0$insuff_actif_pct_RJintq <- stats_ref13all0$insuff_actif_pct_RJq75 / stats_ref13all0$insuff_actif_pct_RJq25
stats_ref13all0$RJintq <- stats_ref13all0$RJq75 / stats_ref13all0$RJq25

stats_ref13all1 <- summaryBy( insuff_actif_pct_LJm1 + insuff_actif_pct_RJm1 + RJm1  ~ as.factor(time) , data= stats_ref13a1, FUN= myfun7)
names(stats_ref13all1) <- c("time","insuff_actif_pct_LJq25","insuff_actif_pct_LJq75","insuff_actif_pct_LJm","insuff_actif_pct_LJs","insuff_actif_pct_RJq25","insuff_actif_pct_RJq75","insuff_actif_pct_RJm","insuff_actif_pct_RJs","RJq25","RJq75","RJm","RJs") #, "num_TC_2119"
stats_ref13all1$TC_ABS <- 1
stats_ref13all1$insuff_actif_pct_LJintq <- stats_ref13all1$insuff_actif_pct_LJq75 / stats_ref13all1$insuff_actif_pct_LJq25
stats_ref13all1$insuff_actif_pct_RJintq <- stats_ref13all1$insuff_actif_pct_RJq75 / stats_ref13all1$insuff_actif_pct_RJq25
stats_ref13all1$RJintq <- stats_ref13all1$RJq75 / stats_ref13all1$RJq25

stats_ref13a3 <- summaryBy( insuff_actif_pct_LJ + insuff_actif_pct_RJ + RJ  ~ as.factor(time) + as.factor(num_TC)  + as.factor(num_TCABS), data= DFTZ4[which(as.numeric(as.character(DFTZ4$ANNEE))>=2006 & DFTZ4$TC_ABS==3) ,], FUN= myfun6)
names(stats_ref13a3) <- c("time","num_TC","num_TCABS","insuff_actif_pct_LJm3","insuff_actif_pct_RJm3","RJm3") #, "num_TC_2339"
stats_ref13all3 <- summaryBy( insuff_actif_pct_LJm3 + insuff_actif_pct_RJm3 + RJm3  ~ as.factor(time) , data= stats_ref13a3, FUN= myfun7)
names(stats_ref13all3) <- c("time","insuff_actif_pct_LJq25","insuff_actif_pct_LJq75","insuff_actif_pct_LJm","insuff_actif_pct_LJs","insuff_actif_pct_RJq25","insuff_actif_pct_RJq75","insuff_actif_pct_RJm","insuff_actif_pct_RJs","RJq25","RJq75","RJm","RJs") #, "num_TC_2119"
stats_ref13all3$TC_ABS <- 3
stats_ref13all3$insuff_actif_pct_LJintq <- stats_ref13all3$insuff_actif_pct_LJq75 / stats_ref13all3$insuff_actif_pct_LJq25
stats_ref13all3$insuff_actif_pct_RJintq <- stats_ref13all3$insuff_actif_pct_RJq75 / stats_ref13all3$insuff_actif_pct_RJq25
stats_ref13all3$RJintq <- stats_ref13all3$RJq75 / stats_ref13all3$RJq25

stats_ref13all <- merge(stats_ref13a1,stats_ref13a0,all.x=T, by=c("time","num_TCABS"))
stats_ref13all$ecartRJ <- stats_ref13all$RJm1 - stats_ref13all$RJm0
stats_ref13all$ecartIARJ <- stats_ref13all$insuff_actif_pct_RJm1 - stats_ref13all$insuff_actif_pct_RJm0
stats_ref13all$ecartIALJ <- stats_ref13all$insuff_actif_pct_LJm1 - stats_ref13all$insuff_actif_pct_LJm0    
stats_ref13all2 <- summaryBy(   ecartIALJ + ecartIARJ + ecartRJ~ as.factor(time) , data= stats_ref13all, FUN= myfun7)
names(stats_ref13all2) <- c("time","insuff_actif_pct_LJq25","insuff_actif_pct_LJq75","insuff_actif_pct_LJm","insuff_actif_pct_LJs","insuff_actif_pct_RJq25","insuff_actif_pct_RJq75","insuff_actif_pct_RJm","insuff_actif_pct_RJs","RJq25","RJq75","RJm","RJs") #, "num_TC_2119"
stats_ref13all2$TC_ABS <- 2
stats_ref13all2$insuff_actif_pct_LJintq <- stats_ref13all2$insuff_actif_pct_LJq75 / stats_ref13all2$insuff_actif_pct_LJq25
stats_ref13all2$insuff_actif_pct_RJintq <- stats_ref13all2$insuff_actif_pct_RJq75 / stats_ref13all2$insuff_actif_pct_RJq25
stats_ref13all2$RJintq <- stats_ref13all2$RJq75 / stats_ref13all2$RJq25

all_stats_ref13 <- rbind(stats_ref13all0,rbind(stats_ref13all1,rbind(stats_ref13all3,stats_ref13all2)))
all_stats_ref13 <- all_stats_ref13[,c("time","TC_ABS","insuff_actif_pct_LJm","insuff_actif_pct_LJs","insuff_actif_pct_LJintq","insuff_actif_pct_RJm","insuff_actif_pct_RJs","insuff_actif_pct_RJintq","RJm","RJs","RJintq")] #, "num_TC_2119"
write.table(all_stats_ref13, file = "all_stats_ref13.csv", row.names = FALSE, sep=";", dec=",")

#######  2 . Sortie pour stata
########




####### Base réforme 
test <- DFTZB[which(as.numeric(as.character(DFTZB$ANNEE))>=2008 & as.numeric(as.character(DFTZB$ANNEE))<2014 ),] #& DFTZB$CREATION_TC !=1
#test <- test[test$MOIS!=8,]
test <- test[as.numeric(as.character(test$treated))!=2,]
#1er test
myfun4 <- function(x){c(nbr = sum(x,na.rm = TRUE))} # calcul malgré valeurs manquantes ,M = mean(x,na.rm = TRUE)
stats_ref4 <- summaryBy( RJ + LJ+ insuff_actif_RJ + insuff_actif_LJ + insuff_actif  ~ as.factor(ANNEEMOIS) + as.factor(TRIM) +as.factor(treated), data= test, FUN= myfun4)
stats_ref4$PCL <- stats_ref4$RJ.nbr + stats_ref4$LJ.nbr
#names(stats_ref4) <- c("ANNEEMOIS","TRIM","ANNEE","tc_absorbant","RJ","LJ","insuff_actif_RJ","PCL") #, "num_TC_2009"
write.table(stats_ref4, file = "stats_ref4.csv", row.names = FALSE, sep=";", dec=",")

myfun5 <- function(x){c(md = median(x,na.rm = TRUE))} # calcul malgré valeurs manquantes 
stats_ref5 <- summaryBy( LN_S_EE_B0 + LN_S_FL_B0 + LN_AGE_ENTP + LN_EFENCE  ~ as.factor(ANNEEMOIS)+as.factor(treated), data= test, FUN= myfun5)
write.table(stats_ref5, file = "stats_ref5.csv", row.names = FALSE, sep=";", dec=",")



stats_ref6 <- summaryBy( insuff_actif_RJ + insuff_actif_LJ + insuff_actif +PCL  ~ as.factor(time) + as.factor(ANNEEMOIS) +as.factor(num_TC2009) +as.factor(treated), data= test2, FUN= myfun4)
stats_ref6$pct_insuff_actif_LJ <- stats_ref6$insuff_actif_LJ.nbr/ stats_ref6$insuff_actif.nbr
stats_ref6$pct_insuff_actif <- stats_ref6$insuff_actif.nbr/ stats_ref6$PCL.nbr
write.table(stats_ref6, file = "stats_ref6.csv", row.names = FALSE, sep=";", dec=",", na=".")
t.test(stats_ref6[stats_ref6$time==0,]$pct_insuff_actif~stats_ref6[stats_ref6$time==0,]$treated)
t.test(stats_ref6[stats_ref6$time==1,]$pct_insuff_actif~stats_ref6[stats_ref6$time==1,]$treated)

test3 <- test2[,c("I_SIREN","NAF1","L_TR_EFF","LN_S_EE_B0","LN_S_FL_B0","LN_AGE_ENTP","LN_EFENCE","time","ANNEEMOIS","date","insuff_actif","RJ","LJ","PLAN","AGE_FAILURE","num_TC2009","treated")]
#test3 <- test3[complete.cases(test3),]
write.table(test3, file = "test3.csv", row.names = FALSE, sep=";", dec=".", na=".")
test3$N_LN_S_EE_B0 <- ifelse(test3$LN_S_EE_B0>quantile(test3$LN_S_EE_B0, probs = c(0.95)),quantile(test3$LN_S_EE_B0, probs = c(0.95)),test3$LN_S_EE_B0) #C99
t.test(test3[test3$time==0,]$N_LN_S_EE_B0~test3[test3$time==0,]$treated)
t.test(test3[test3$time==1,]$N_LN_S_EE_B0~test3[test3$time==1,]$treated)

stats_ref7 <- summaryBy( LN_S_EE_B0 + LN_S_FL_B0 + LN_AGE_ENTP + LN_EFENCE  ~ as.factor(time) + as.factor(ANNEEMOIS) +as.factor(num_TC2009) +as.factor(treated), data= test2, FUN= myfun5)

library(Hmisc)
describe(test2[,c("LN_S_EE_B0","LN_S_FL_B0","LN_AGE_ENTP","LN_EFENCE")]) 


####### Impact reforme sur IA
myfun2 <- function(x){c(M = mean(x,na.rm = TRUE))} # calcul malgré valeurs manquantes 
test <- DFTZB[which(as.numeric(as.character(DFTZB$ANNEE))>=2006 & (is.na(DFTZB$Ref2009)==TRUE| (DFTZB$tc_absorbant==1 & as.numeric(as.character(DFTZB$CREATION_TC))==0))),]
stats_ref2 <- summaryBy( RJ + LJ+ insuff_actif_RJ + insuff_actif_PLAN  ~ as.factor(ANNEE)+as.factor(treated), data= test, FUN= myfun2)
#stats_ref2$PCL <- stats_ref2$RJ.nbr + stats_ref2$LJ.nbr
write.table(stats_ref2, file = "stats_ref2.csv", row.names = FALSE, sep=";", dec=",")

stats_ref3 <- summaryBy( insuff_actif  ~ as.factor(ANNEE)+as.factor(abs_ref2009), data= test[which(as.numeric(as.character(test$ANNEE))>=2006 & as.numeric(as.character(test$ANNEE))<=2012),], FUN= myfun2)
write.table(stats_ref3, file = "stats_ref3.csv", row.names = FALSE, sep=";", dec=",")


######## Avec carte des TI

myfun4 <- function(x){c(nbr = mean(x,na.rm = TRUE))} # calcul malgré valeurs manquantes ,M = mean(x,na.rm = TRUE)
#stats_ref10 <- summaryBy( RJ + LJ  +insuff_actif_RJ + insuff_actif_LJ + insuff_actif~ as.factor(ANNEE) +as.factor(ANNEEMOIS) + as.factor(TRIM) + as.factor(SEM) + as.factor(as.character(TC_ABS)), data= DFTZ4[which(as.numeric(as.character(DFTZ4$ANNEE))>=2007 & DFTZ4$Exploitable==1),], FUN= myfun4) # +as.factor(as.character(num_TCABS)) +as.factor(as.character(num_TC))
#write.table(stats_ref10, file = "stats_ref10.csv", row.names = FALSE, sep=";", dec=",")
stats_ref10a <- summaryBy( RJ + LJ + PLAN + AGE_FAILURE ~  as.factor(TRIM) + as.factor(SEM) + as.factor(as.character(TC_ABS)), data= DFTZ4[which(as.numeric(as.character(DFTZ4$ANNEE))>=2007 & as.numeric(as.character(DFTZ4$ANNEE))<2014 &as.character(DFTZ4$TC_ABS) != "2"),], FUN= myfun4) # +as.factor(as.character(num_TCABS)) +as.factor(as.character(num_TC))
#stats_ref10$RJ_LJ <- ifelse(stats_ref10$LJ.nbr==0, NA, stats_ref10$RJ.nbr / stats_ref10$LJ.nbr)
#stats_ref10$RJ_PCT <- stats_ref10$RJ.nbr / (stats_ref10$RJ.nbr + stats_ref10$LJ.nbr)
#names(stats_ref4) <- c("ANNEEMOIS","TRIM","ANNEE","tc_absorbant","RJ","LJ","insuff_actif_RJ","PCL") #, "num_TC_2009"
write.table(stats_ref10a, file = "stats_ref10a.csv", row.names = FALSE, sep=";", dec=",")
#stats_ref11 <- summaryBy( RJ + LJ  ~ as.factor(TRIM) + as.factor(num_TC) + as.factor(TC_ABS), data= DFTZ4[as.numeric(as.character(DFTZ4$ANNEE))>=2006,], FUN= myfun4)
#stats_ref11$RJ_LJ <- ifelse(stats_ref11$LJ.nbr==0, 1, stats_ref11$RJ.nbr / stats_ref11$LJ.nbr)
#stats_ref11$RJ_PCT <- stats_ref11$RJ.nbr / (stats_ref11$RJ.nbr + stats_ref11$LJ.nbr)


myfun4 <- function(x){c(nbr = sum(x,na.rm = TRUE))} # calcul malgré valeurs manquantes ,M = mean(x,na.rm = TRUE)
stats_ref4b <- summaryBy( RJ + LJ+ insuff_actif_RJ + insuff_actif_LJ + insuff_actif  ~ as.factor(ANNEEMOIS) + as.factor(TRIM) +as.factor(TC_ABS), data= DFTZ4[as.numeric(as.character(DFTZ4$ANNEE))>=2007,], FUN= myfun4)
stats_ref4b$PCL <- stats_ref4b$RJ.nbr + stats_ref4b$LJ.nbr
#names(stats_ref4) <- c("ANNEEMOIS","TRIM","ANNEE","tc_absorbant","RJ","LJ","insuff_actif_RJ","PCL") #, "num_TC_2009"
write.table(stats_ref4b, file = "stats_ref4b.csv", row.names = FALSE, sep=";", dec=",")




# taux median pr être envoyé en LJ
#myfun5 <- function(x){c(q = quantile(x,na.rm = TRUE))} # calcul malgré valeurs manquantes ,M = mean(x,na.rm = TRUE)
myfun5 <- function(x){c(m = mean(x,na.rm = TRUE),q = quantile(x,na.rm = TRUE),sd = sd(x,na.rm = TRUE))}
stats_ref12 <- summaryBy( insuff_actif_pct + RJ  ~ as.factor(TRIM) + as.factor(SEM) + as.factor(LJ) + as.factor(TC_ABS), data= DFTZ4[which(as.numeric(as.character(DFTZ4$ANNEE))>=2007) ,], FUN= myfun5)
#stats_ref12 <- merge(stats_ref11[,c("ANNEEMOIS","num_TC","TC_ABS","RJ_LJ")], stats_ref12,all.x=T, by=c("ANNEEMOIS"))
write.table(stats_ref12, file = "stats_ref12.csv", row.names = FALSE, sep=";", dec=",")

myfun6 <- function(x){c(m = mean(x,na.rm = TRUE), s=sum(x,na.rm = TRUE))}#,md = median(x,na.rm = TRUE)
DFTZ4$insuff_actif_pct_RJ <- ifelse(DFTZ4$RJ==0,NA, DFTZ4$insuff_actif_pct)
DFTZ4$insuff_actif_pct_LJ <- ifelse(DFTZ4$RJ==1,NA, DFTZ4$insuff_actif_pct)
moy_tcabs <- summaryBy( insuff_actif_pct_RJ + insuff_actif_pct_LJ  + RJ + PCL  ~ as.factor(ANNEEMOIS) +  as.factor(TRIM) +  as.factor(ANNEE)  + as.factor(num_TC)+ as.factor(num_TCABS)+ as.factor(TC_ABS), data= DFTZ4[which(as.numeric(as.character(DFTZ4$ANNEE))>=2008 & as.numeric(as.character(DFTZ4$ANNEE))<=2012),], FUN= myfun6)
moy_tcabs$RJ_PCL <- moy_tcabs$RJ.s/moy_tcabs$PCL.s




#### comportement "clement" des TC prealables et influence
moy_tcabs2 <- summaryBy( insuff_actif_pct_LJ.m + insuff_actif_pct_RJ.m + RJ_PCL  ~   as.factor(num_TC) + as.factor(num_TCABS), data= moy_tcabs[as.numeric(as.character(moy_tcabs$ANNEE))==2008,], FUN= function(x){c(y = mean(x,na.rm = TRUE))})
#moy_tcabs2$num_TCABS <- moy_tcabs2$num_TC
#moy_tcabs2 <- subset(moy_tcabs2, select = - c(num_TC))
moy_tcabs3 <- merge(moy_tcabs, moy_tcabs2[,c("num_TC","insuff_actif_pct_LJ.m.y","insuff_actif_pct_RJ.m.y","RJ_PCL.y")], all.x=T, by=c("num_TC"))
moy_tcabs3 <- merge(moy_tcabs3, moy_tcabs2[,c("num_TCABS","insuff_actif_pct_LJ.m.y","insuff_actif_pct_RJ.m.y","RJ_PCL.y")], all.x=T, by=c("num_TCABS"))
moy_tcabs3$rj_clement <- ifelse(moy_tcabs3$RJ_PCL.y.x > moy_tcabs3$RJ_PCL.y.y,1,0)
moy_tcabs3$iarj_clement <- ifelse(moy_tcabs3$insuff_actif_pct_RJ.m.y.x > moy_tcabs3$insuff_actif_pct_RJ.m.y.y,1,0)
write.table(moy_tcabs3, file = "moy_tcabs3.csv", row.names = FALSE, sep=";", dec=",")






### 2e estimation DiD
test <- DFTZB[which(as.numeric(as.character(DFTZB$ANNEE))>=2008 & as.numeric(as.character(DFTZB$ANNEE))<2010),]
test$time = ifelse(as.character(test$ANNEEMOIS)=="200901", 1, 0)
test$timeplan = ifelse(as.character(test$ANNEEMOIS_PLAN)=="200901", 1, 0)
test$treated = as.factor(ifelse(as.numeric(as.character(test$CREATION_TC))==2,"0",ifelse(as.numeric(as.character(test$CREATION_TC))==1,"2","1")))
test$TGI = ifelse(as.numeric(as.character(test$TGI))==1,1,0)
test$PLAN <- ifelse(as.character(test$LJ)=="1", NA,test$PLAN)
#test$insuff_actif <- test$insuff_actif_LJ - test$insuff_actif_RJ ###a mieux coder
test$LN_S_EE_B0 <- ifelse(test$S_EE_B0<0,NA,log(1+test$S_EE_B0))
test$LN_S_FL_B0 <- ifelse(test$S_FL_B0<0,NA,log(1+test$S_FL_B0))
test$LN_AGE_ENTP <- ifelse(test$AGE_ENTP<0,NA,log(1+test$AGE_ENTP))
test$LN_EFENCE <- ifelse(test$EFENCE<0,NA,log(1+test$EFENCE))
#test$TR_EFF_ENT <- as.numeric(as.character(test$TR_EFF_ENT))
#test$L_TR_EFF <- as.factor(ifelse(is.na(test$TR_EFF_ENT )==TRUE|test$TR_EFF_ENT == 0,0, ifelse(test$TR_EFF_ENT > 0 & test$TR_EFF_ENT < 10 ,0,  ifelse(test$TR_EFF_ENT > 10 & test$TR_EFF_ENT < 20 , 1, 2 ))))
didreg1LJ = lm(LJ ~  treated*time + LN_S_EE_B0 + LN_S_FL_B0 + LN_AGE_ENTP, data = test)
summary(didreg1LJ)
didreg1RJ = lm(RJ ~  treated*time + LN_S_EE_B0 + LN_S_FL_B0 + LN_AGE_ENTP, data = test)
summary(didreg1RJ)
didreg2 = lm(insuff_actif ~ treated*time + LN_S_EE_B0 + LN_S_FL_B0 + LN_AGE_ENTP, data = test)
summary(didreg2)
didreg2LJ = lm(LJ ~ treated*time + LN_S_EE_B0 + LN_S_FL_B0 + LN_AGE_ENTP, data = test[test$insuff_actif==1,])
summary(didreg2LJ)
didreg2RJ = lm(insuff_actif ~ treated*time + LN_S_EE_B0 + LN_S_FL_B0 + LN_AGE_ENTP, data = test[test$RJ==1,])
summary(didreg2RJ)
didreg2Plan = lm(PLAN ~ treated*timeplan + LN_S_EE_B0 + LN_S_FL_B0 + LN_AGE_ENTP, data = test[test$insuff_actif==1,])
summary(didreg2Plan)
didreg3PRJ = lm(PLAN ~ treated*time + LN_S_EE_B0 + LN_S_FL_B0 + LN_AGE_ENTP, data = test[test$RJ==1,]) #[test$RJ==1,]
summary(didreg3PRJ)
didreg3Pall = lm(PLAN ~ treated*time + LN_S_EE_B0 + LN_S_FL_B0 + LN_AGE_ENTP, data = test) #[test$RJ==1,]
summary(didreg3Pall)
test$FAIL_1Y <- ifelse(is.na(test$AGE_FAILURE)==TRUE|test$AGE_FAILURE>12,0,1)
test$FAIL_2Y <- ifelse(is.na(test$AGE_FAILURE)==TRUE|test$AGE_FAILURE>24,0,1)
test$FAIL_3Y <- ifelse(is.na(test$AGE_FAILURE)==TRUE|test$AGE_FAILURE>36,0,1)
didreg4RJ = lm(FAIL_2Y ~ treated*time + LN_S_EE_B0 + LN_S_FL_B0 + LN_AGE_ENTP, data = test[test$insuff_actif==1 & test$RJ==1,])
summary(didreg4RJ)
didreg4all = lm(FAIL_2Y ~ treated*time + LN_S_EE_B0 + LN_S_FL_B0 + LN_AGE_ENTP, data = test)
summary(didreg4all)


### 2e estimation DiD avec placebo
test <- DFTZB[which(as.numeric(as.character(DFTZB$ANNEE))>=2008 & as.numeric(as.character(DFTZB$ANNEE))<2010),]
test$placebo = ifelse(as.character(test$ANNEEMOIS)=="200812", 1, 0)
test$treated = as.factor(ifelse(as.numeric(as.character(test$CREATION_TC))==2,"0",ifelse(as.numeric(as.character(test$CREATION_TC))==1,"2","1")))
#test$insuff_actif <- test$insuff_actif_LJ - test$insuff_actif_RJ ###a mieux coder
test$LN_S_EE_B0 <- ifelse(test$S_EE_B0<0,NA,log(1+test$S_EE_B0))
test$LN_S_FL_B0 <- ifelse(test$S_FL_B0<0,NA,log(1+test$S_FL_B0))
test$LN_AGE_ENTP <- ifelse(test$AGE_ENTP<0,NA,log(1+test$AGE_ENTP))
didreg1LJ = lm(LJ ~  treated*placebo + LN_S_EE_B0 + LN_S_FL_B0 + LN_AGE_ENTP, data = test)
summary(didreg1LJ)
didreg1RJ = lm(RJ ~  treated*placebo + LN_S_EE_B0 + LN_S_FL_B0 + LN_AGE_ENTP, data = test)
summary(didreg1RJ)
didreg2 = lm(insuff_actif ~ treated*placebo + LN_S_EE_B0 + LN_S_FL_B0 + LN_AGE_ENTP, data = test)
summary(didreg2)
didreg2LJ = lm(insuff_actif ~ treated*placebo + LN_S_EE_B0 + LN_S_FL_B0 + LN_AGE_ENTP, data = test[test$LJ==1,])
summary(didreg2LJ)
didreg2RJ = lm(insuff_actif ~ treated*placebo + LN_S_EE_B0 + LN_S_FL_B0 + LN_AGE_ENTP, data = test[test$RJ==1,])
summary(didreg2RJ)
didreg2Plan = lm(insuff_actif_PLAN ~ treated*time + LN_S_EE_B0 + LN_S_FL_B0 + LN_AGE_ENTP, data = test[test$RJ==1,])
summary(didreg2Plan)

## panel 
library(plm)
test2 <- test[,c("num_TC2009","ANNEEMOIS","FJ_2","ANNEE","tc_absorbant","PLAN","AGE_FAILURE","S_EE_B0","S_FL_B0","EFF","TX_MB_EXP","TX_DOB","DPT","I_SIREN","NAF2","NAF1","AGE_ENTP","TR_EFF_ENT","EFENCE","A_NBR_ETAB","DATE_OUVERTURE","RJ","LJ","DATE_PLAN","DATE_LIQUID","frais_ouv_pcl","frais_bes","remun_admin","remun_admin_plan","actif","insuff_actif","insuff_actif_RJ","insuff_actif_LJ","insuff_actif_PLAN","time","treated","LN_S_EE_B0","LN_S_FL_B0","LN_AGE_ENTP","FAIL_2Y")]
write.table(test2, file = "DFTZ_stata.csv", row.names = FALSE, sep=";", dec=".",na=".")





