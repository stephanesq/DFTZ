# chargement base ----
DFTZ <- read.csv2("donnees/DFTZ_EXP.csv", sep = ";", dec=".", na=".")
##################
# préparation data ----
DFTZ <- DFTZ[,c("I_SIREN","I_CD_POST_SIEGE","I_FJ","FJ_1","NAF2","NAF1","AGE_ENTP","TR_EFF_ENT","EFENCE","A_NBR_ETAB","I_ORIGINE","DATE_OUVERTURE","RJ","SAUV","LJ","DATE_PLAN","DATE_LIQUID","DATE_CONV","DATE_PLAN_CT","DATE_MORT","CD_MORT","DATE_PLAN_CESS","P_CESSION","DATE_CL_CT","CL_CESSION","FAILURE","AGE_FAILURE","AGEBILAN","BILAN_24M","S_DT_CLO_B0","S_EE_B0","S_FL_B0","EFF","TX_MA_GL","TX_VA","TX_MB_EXP","TX_DOB","RENT_B_K_EXP","RENT_N_K_EXP","CAP_GEN_CASH","RENTA_FI","SUR_FI","COUV_IMMO_FP","CRED_BK_COURANT_BFR","CP_VA","PDS_INT","VMC","DET_FOUR","CREA_CLI","DUR_FOUR","DUR_CLI","RENTA_ECO","RES_FIN","RES_EXCEP","PDS_MAS_SAL","SOLDE_COM","LIQUI","CAF","FR","BFR","TRESO_N","ENDET_BRUT","ENDET_NET","TX_ENDET_NET","TX_ENDET_BRUT","CT_ENDET","TX_RENTA_FI_KP","PDS_INT_REV_GLOB","PERS_RRP","PRET_RRP","COMPTES_ASSOCIES","CNAF","RES_HORS_EXP","RRP","STOCKS","CUR_AS_CUR_LI","TRESO_ACT","IMMO","A_PCL_TC")]
DFTZ$PROC <- as.factor(ifelse(DFTZ$RJ==1,"RJ", ifelse(DFTZ$SAUV==1, "SAUV", "LJ")))
DFTZ <- DFTZ[DFTZ$SAUV==0,] #on enlève sauvegarde
DFTZ$PCL <- DFTZ$RJ + DFTZ$LJ

## Modif var INSEE ----
# selectionne que NAF pertinentes
DFTZ <- DFTZ[which(DFTZ$FJ_1==5|DFTZ$FJ_1==6),] #on conserve quesociétés commerciales (FJ 5 et 6)
DFTZ$TR_EFF_ENT <- as.factor(DFTZ$TR_EFF_ENT)
DFTZ$FJ_2 <- as.factor(substr(as.character(DFTZ$I_FJ),1,2))
DFTZ$FJ <- as.character(DFTZ$FJ_2)
DFTZ$FJ <- as.factor(ifelse(DFTZ$FJ=="51"|DFTZ$FJ=="52"|DFTZ$FJ=="53"|DFTZ$FJ=="56","AUTRES", DFTZ$FJ))
DFTZ$DPT <- as.factor(substr(as.character(DFTZ$I_CD_POST_SIEGE),1,2))
DFTZ$DOMTOM <- ifelse(substr(as.character(DFTZ$DPT),1,2)=="97",1,0)
DFTZ$NAF1 <- as.character(DFTZ$NAF1)
DFTZ$NAF <- as.factor(ifelse(DFTZ$NAF1=="B"|DFTZ$NAF1=="D"|DFTZ$NAF1=="E","Z",DFTZ$NAF1))
DFTZ$NAF1 <- as.factor(DFTZ$NAF1)
DFTZ$DNAF <- ifelse(DFTZ$NAF=="C"|DFTZ$NAF=="F"|DFTZ$NAF=="G"|DFTZ$NAF=="H"|DFTZ$NAF=="I"|DFTZ$NAF=="J"|DFTZ$NAF=="L"|DFTZ$NAF=="N"|DFTZ$NAF=="T"|DFTZ$NAF=="Z",1,0) 
DFTZ <- DFTZ[which(DFTZ$DNAF==1 & DFTZ$DOMTOM==0),]

DFTZ$LN_AGE_ENTP <- ifelse(DFTZ$AGE_ENTP<0,NA,log(1+DFTZ$AGE_ENTP))
DFTZ$LN_EFENCE <- ifelse(DFTZ$EFENCE<0,NA,log(1+DFTZ$EFENCE))
DFTZ$TR_EFF_ENT <- as.numeric(as.character(DFTZ$TR_EFF_ENT))
DFTZ$L_TR_EFF <- as.factor(ifelse(is.na(DFTZ$TR_EFF_ENT )==TRUE|DFTZ$TR_EFF_ENT == 0,0, ifelse(DFTZ$TR_EFF_ENT > 0 & DFTZ$TR_EFF_ENT < 10 ,0, 1)))

## info sur date ----
DFTZ$ANNEE <- as.factor(substr(as.character(DFTZ$DATE_OUVERTURE),1,4))
DFTZ$ANNEEMOIS <- as.factor(substr(as.character(DFTZ$DATE_OUVERTURE),1,6))
DFTZ$ANNEEMOIS_PLAN <- as.factor(substr(as.character(DFTZ$DATE_PLAN),1,6))
DFTZ$PLAN <- ifelse(as.character(DFTZ$DATE_PLAN)=="", 0,1)
DFTZ$PLAN <- ifelse(as.character(DFTZ$LJ)=="1", NA,DFTZ$PLAN)
DFTZ$MOIS <- as.numeric(format(as.Date(substr(DFTZ$DATE_OUVERTURE,1,8), format="%Y%m%d"), "%m"))
DFTZ$ANNEE_TRIM <- ifelse(DFTZ$MOIS<=3,"T1",ifelse(DFTZ$MOIS>=3 & DFTZ$MOIS<=6,"T2",ifelse(DFTZ$MOIS>=3 & DFTZ$MOIS<=6,"T2",ifelse(DFTZ$MOIS>=6 & DFTZ$MOIS<=9,"T3","T4"))))
DFTZ$ANNEE_SEM <- ifelse(DFTZ$MOIS<=6,"S1","S2")
DFTZ$TRIM <- paste(DFTZ$ANNEE,DFTZ$ANNEE_TRIM, sep="")
DFTZ$TRIM <- as.factor(DFTZ$TRIM)
DFTZ$SEM <- paste(DFTZ$ANNEE,DFTZ$ANNEE_SEM, sep="")
DFTZ$SEM <- as.factor(DFTZ$SEM)
DFTZ <- subset(DFTZ, select = - c(ANNEE_TRIM,ANNEE_SEM))
DFTZ2 <- DFTZ[,c("I_SIREN","NAF","FJ","L_TR_EFF","LN_AGE_ENTP","TR_EFF_ENT","I_CD_POST_SIEGE","DATE_OUVERTURE","DATE_PLAN","DATE_LIQUID","DATE_MORT","ANNEEMOIS","MOIS","SEM","TRIM","ANNEE","RJ","LJ","PCL","PLAN","AGE_FAILURE")]

####### Fusion réforme
## Ajoute DPT et REGION ----
dpts <- read.csv2("depts2008.csv", sep = ";", dec =",")
dpts$DPT <- as.factor(substr(as.character(dpts$DPT),2,3))
dpts$REGION <- as.factor(as.character(dpts$REGION))
DFTZ <- merge(DFTZ, dpts,all.x=TRUE, by=c("DPT"))
#attribution des tc et leurs informations (absorbtion)
tc_ville <- read.csv2("donnees/CDPOST_TC_MJ.csv", sep = ";", dec =",", na="")
tc_ville$I_CD_POST_SIEGE <- as.factor(substr(as.character(tc_ville$I_CD_POST_SIEGE),2,6)) #encore des code communes sans TC
tc_ville$num_TC_2009 <- tc_ville$ferm_2009
tc_ville$num_TC_2011 <- tc_ville$ferm_2011
tc_ville$num_TC_2013 <- tc_ville$ferm_2013
tc_ville$num_TC <- tc_ville$actuel
tc_ville <- tc_ville[!is.na(tc_ville$num_TC_2009)==TRUE,]

##
lien_tc <- read.csv2("donnees/LIEN_TC_MJ.csv", sep = ";", na="")
lien_tc <- lien_tc %>% select(i_elst, libel_crt)

## 2009
tc_ville <- merge(tc_ville, lien_tc, all.x=T, by.x=("num_TC_2009"), by.y=("i_elst")) %>% 
  rename(libel_crt_2009=libel_crt)
## 2011
tc_ville <- merge(tc_ville, lien_tc, all.x=T, by.x=("num_TC_2011"), by.y=("i_elst"))%>% 
  rename(libel_crt_2011=libel_crt)
## 2013
tc_ville <- merge(tc_ville, lien_tc, all.x=T, by.x=("num_TC_2013"), by.y=("i_elst"))%>% 
  rename(libel_crt_2013=libel_crt)
## Actuel
tc_ville <- merge(tc_ville, lien_tc, all.x=T, by.x=("num_TC"), by.y=("i_elst"))

tc_ville <- tc_ville[!duplicated(tc_ville[,c('I_CD_POST_SIEGE')]),] #a vérifier

DFTZ2 <- merge(DFTZ, tc_ville, by=c("I_CD_POST_SIEGE"))
DFTZ4$time <-DFTZ4$TRIM