#Changer le format
library(reshape)
CREA_VAR <- read.csv2("CREA_VAR.csv", sep = ";")
crea <- melt(CREA_VAR, id.vars="ANNEEMOIS")
write.table(crea, file = "CREA_VAR36M.csv", sep=";" , dec = ",", row.names = FALSE)

#Renommer des variables
names(data.wide)[names(data.wide)=="cond1"] <- "first"
names(data.wide)[names(data.wide)=="cond2"] <- "second"

TEST2 <- read.csv2("20140515_DFTZ_BLN.csv", sep = ";")

## Variables présentes
"I_SIREN","DATE_OUVERTURE","RJ","SAUV","LJ","DATE_PLAN","PLAN","DATE_LIQUID","LIQUID","DATE_CONV","CONV_RJ","DATE_PLAN_CT","PLAN_CT","DATE_MORT","MORT","CD_MORT","DATE_PLAN_CESS","P_CESSION","DATE_CL_CT","CL_CESSION","DATE_PLAN_RJ","PLAN_RJ","I_CD_POST_SIEGE","DPT","CODE_REGION","REGION_NAME","S_NOMENCL","S_TC","A_CD_STATUT","A_DT_STATUT","I_FJ","FJ_1","I_CD_NAF","NAF2","NAF1","I_DT_CREA_ENT","AGE_ENTP","I_CAP_SOC","I_TR_EFF_ENT","TR_EFF_ENT","I_EFENCE","R_DT_NAISS_DIR","AGE_DIR","R_NBR_DIR","I_SAISONAT","A_NBR_ETAB","I_EXPLEN","I_TCA","I_TCAEXPOR","I_RECME","I_ORIGINE","I_MODEN","I_MONOREG","I_MONOACT","I_TCD","I_NBTOA","AGEBILAN","BILAN_24M","BILAN_ETAT1","S_DT_CLO_B0","S_EE_B0","S_FL_B0","EFF","S_DT_CLO_B1","S_EE_B1","S_FL_B1","EFF_1","TX_MA_GL","TX_VA","TX_MB_EXP","TX_M_COM","TX_DOB","RENT_B_K_EXP","RENT_N_K_EXP","CAP_GEN_CASH","RENTA_FI","SUR_FI","COUV_IMMO_FP","CRED_BK_COURANT_BFR","CP_VA","PDS_INT","VMC","DET_FOUR","CREA_CLI","ROT_STOCK_MP","ROT_STOCK_MAR","ROT_STOCK_PF","DUR_FOUR","DUR_CLI","RENTA_ECO","RES_FIN","RES_EXCEP","PDS_MAS_SAL","ROT_STO_MAT_APPRO","DEL_RO_STO_MARCH","DEL_RO_STO_P_FINI","SOLDE_COM","LIQUI","CAF","RE_ET_DEV1","RE_ET_DEV2","FR","BFR","TRESO_N","ENDET_BRUT","ENDET_NET","TX_ENDET_NET","TX_ENDET_BRUT","CT_ENDET","TX_RENTA_FI_KP","PDS_INT_REV_GLOB","PERS_RRP","PRET_RRP","COMPTES_ASSOCIES","VAR_TX_MA_GL","VAR_CA","VAR_ACTIF","VAR_TX_VA","VAR_TX_MB_EXP","VAR_TX_M_COMM","VAR_TX_DOB","VAR_RENT_B_K_EXP","VAR_RENT_N_K_EXP","VAR_CAP_GEN_CASH","VAR_RENTA_FI","VAR_SUR_FI","VAR_COUV_IMMO_FP","VAR_CRED_BK_COURANT_BFR","VAR_ROT_STO_MAT_APPRO","VAR_DEL_RO_STO_MARCH","VAR_DEL_RO_STO_P_FINI","VAR_SOLDE_COM","VAR_LIQUI","VAR_CAF","VAR_RE_ET_DEV2","VAR_FR","VAR_BFR","VAR_TRESO_N","VAR_CP_VA","VAR_PDS_INT","VAR_PDS_MAS_SAL","VAR_VMC","VAR_DET_FOUR","VAR_ROT_STOCK_MP","VAR_ROT_STOCK_MAR","VAR_ROT_STOCK_PF","VAR_DUR_FOUR","VAR_DUR_CLI","VAR_RENTA_ECO","VAR_RES_FIN","VAR_RES_EXCEP","VAR_EFF","VAR_ENDT_BRUT","VAR_ENDET_NET","VAR_CT_ENDET","VAR_COMPTE_ASSO","VAR_PERS_RRP","VAR_PRET_RRP","TR_EFF_BILAN"

#Imprimer un fichier
write.table(DFTZB, file = "DFTZB.csv", sep = ";",  row.names = FALSE)

# Nettoyer
rm(list=ls()) #Tout
rm(x) # efface x 

#RÈpertoire :

options(scipen=999)
setwd("/Users/stephaneesquerre/Dropbox/Articles/2013 - Premiers travaux/Dont feed the zombies/DATA")
DFTZ <- read.csv2("20140926_DFTZ_INC.csv", sep = ";")
#COMPLET : DFTZ <- DFTZ[,c("I_SIREN","DPT","CODE_REGION","I_FJ","FJ_1","NAF2","NAF1","AGE_ENTP","TR_EFF_ENT","EFENCE","A_NBR_ETAB","I_ORIGINE","I_MONOACT","I_TCD","DATE_OUVERTURE","RJ","SAUV","LJ","DATE_PLAN","PLAN","DATE_LIQUID","LIQUID","DATE_CONV","CONV_RJ","DATE_PLAN_CT","PLAN_CT","DATE_MORT","MORT","CD_MORT","DATE_PLAN_CESS","P_CESSION","DATE_CL_CT","CL_CESSION","DATE_PLAN_RJ","PLAN_RJ","S_TC","S_NOMENCL","RJ_VOL","SAUV_VOL","LJ_VOL","TC_VOL","AGE_PLAN_LIQUID","AGE_PLAN_MORT","FAILURE","AGE_FAILURE","FAILURE_12M","FAILURE_24M","FAILURE_36M","RJ_VOL_PCT","SAUV_VOL_PCT","LJ_VOL_PCT","ECHEVINAGE","TX_CHOM_NAT","TX_CHOM","TX_CHOM_MOY","CHOM_BAD","CLIM_AFF","INDIC_RETOUR","TX_CREA","TX_CREA_MOY","PIB","FBCF_ENTP_NF","AGEBILAN","BILAN_24M","BILAN_12M","S_DT_CLO_B0","S_EE_B0","S_FL_B0","EFF","TR_EFF_BILAN","TX_MA_GL","TX_VA","TX_MB_EXP","TX_M_COM","TX_DOB","RENT_B_K_EXP","RENT_N_K_EXP","CAP_GEN_CASH","RENTA_FI","SUR_FI","COUV_IMMO_FP","CRED_BK_COURANT_BFR","CP_VA","PDS_INT","VMC","DET_FOUR","CREA_CLI","DUR_FOUR","DUR_CLI","RENTA_ECO","RES_FIN","RES_EXCEP","PDS_MAS_SAL","SOLDE_COM","LIQUI","CAF","FR","BFR","TRESO_N","ENDET_BRUT","ENDET_NET","TX_ENDET_NET","TX_ENDET_BRUT","CT_ENDET","TX_RENTA_FI_KP","PDS_INT_REV_GLOB","PERS_RRP","PRET_RRP","COMPTES_ASSOCIES","CNAF","RES_HORS_EXP","RRP","STOCKS","CUR_AS_CUR_LI","TRESO_ACT","IMMO","LN_S_EE_B0","LN_S_FL_B0","LN_BFR","LN_TRESO_N","LN_ENDET_BRUT","LN_ENDET_NET","LN_COMPTES_ASSOCIES","LN_DET_FOUR","LN_CREA_CLI","LN_STOCKS","LN_TRESO_ACT","LN_IMMO")]
DFTZ <- DFTZ[,c("I_SIREN","DPT","CODE_REGION","I_FJ","FJ_1","NAF2","NAF1","AGE_ENTP","TR_EFF_ENT","EFENCE","A_NBR_ETAB","I_ORIGINE","I_MONOACT","I_TCD","DATE_OUVERTURE","RJ","SAUV","LJ","S_TC","S_NOMENCL","RJ_VOL","SAUV_VOL","LJ_VOL","TC_VOL","FAILURE","AGE_FAILURE","FAILURE_12M","FAILURE_24M","FAILURE_36M","DATE_PLAN","PLAN","DATE_LIQUID","LIQUID","DATE_CONV","CONV_RJ","DATE_PLAN_CT","PLAN_CT","DATE_MORT","MORT","CD_MORT","DATE_PLAN_CESS","P_CESSION","DATE_CL_CT","CL_CESSION","DATE_PLAN_RJ","PLAN_RJ","RJ_VOL_PCT","SAUV_VOL_PCT","LJ_VOL_PCT","ECHEVINAGE","AGEBILAN","BILAN_24M","BILAN_12M","S_DT_CLO_B0","S_EE_B0","S_FL_B0","EFF","TX_VA","TX_MB_EXP","TX_DOB","RENT_B_K_EXP","RENT_N_K_EXP","CAP_GEN_CASH","RENTA_FI","SUR_FI","COUV_IMMO_FP","CRED_BK_COURANT_BFR","CP_VA","DET_FOUR","CREA_CLI","DUR_FOUR","DUR_CLI","RENTA_ECO","PDS_MAS_SAL","SOLDE_COM","LIQUI","ENDET_BRUT","ENDET_NET","TX_ENDET_NET","TX_ENDET_BRUT","CT_ENDET","TX_RENTA_FI_KP","PDS_INT_REV_GLOB","PERS_RRP","PRET_RRP","RRP","STOCKS","CUR_AS_CUR_LI","TRESO_ACT","IMMO","LN_S_EE_B0","LN_S_FL_B0","LN_BFR","LN_TRESO_N","LN_ENDET_BRUT","LN_ENDET_NET","LN_COMPTES_ASSOCIES","LN_DET_FOUR","LN_CREA_CLI","LN_STOCKS","LN_TRESO_ACT","LN_IMMO")]

DFTZ$PROC <- as.factor(ifelse(DFTZ$RJ==1,"RJ", ifelse(DFTZ$SAUV==1, "SAUV", "LJ")))
DFTZ$TR_EFF_ENT <- as.factor(DFTZ$TR_EFF_ENT)
DFTZ$FJ_2 <- as.factor(substr(as.character(DFTZ$I_FJ),1,2))
DFTZ$ANNEE <- as.factor(substr(as.character(DFTZ$DATE_OUVERTURE),1,4))
DFTZ$FJ <- as.character(DFTZ$FJ_2)
DFTZ$FJ <- as.factor(ifelse(DFTZ$FJ=="51"|DFTZ$FJ=="52"|DFTZ$FJ=="53"|DFTZ$FJ=="56","AUTRES", DFTZ$FJ))

DFTZ$NAF1 <- as.character(DFTZ$NAF1)
DFTZ$NAF <- as.factor(ifelse(DFTZ$NAF1=="B"|DFTZ$NAF1=="D"|DFTZ$NAF1=="E","Z",DFTZ$NAF1))
DFTZ$NAF1 <- as.factor(DFTZ$NAF1)
DFTZ$ANNEE_NAF <- paste(substr(as.character(DFTZ$DATE_OUVERTURE),1,4),as.character(DFTZ$NAF), sep="")
DFTZ$ANNEE_NAF <- as.factor(DFTZ$ANNEE_NAF)
DFTZ$ANNEEMOIS <- substr(as.character(DFTZ$DATE_OUVERTURE),1,6)

DFTZ$DOMTOM <- ifelse(substr(as.character(DFTZ$DPT),1,2)=="97",1,0)

####### IMPORTANT
# Selection de la base - SC et NAF et metrop
DFTZ$DNAF <- ifelse(DFTZ$NAF=="C"|DFTZ$NAF=="F"|DFTZ$NAF=="G"|DFTZ$NAF=="H"|DFTZ$NAF=="I"|DFTZ$NAF=="J"|DFTZ$NAF=="L"|DFTZ$NAF=="N"|DFTZ$NAF=="T"|DFTZ$NAF=="Z",1,0) 
DFTZ <- DFTZ[which(DFTZ$FJ_1==5 & DFTZ$DNAF==1 & DFTZ$DOMTOM==0),]
####### IMPORTANT

# Infos de date et âge 
DFTZ$date_ouverture <- as.Date(substr(DFTZ$DATE_OUVERTURE,1,8), format="%Y%m%d")
DFTZ$date_plan <- as.Date(substr(DFTZ$DATE_PLAN,1,8), format="%Y%m%d")
DFTZ$date_conv <- as.Date(substr(DFTZ$DATE_CONV,1,8), format="%Y%m%d")
DFTZ$date_lj <- as.Date(substr(DFTZ$DATE_LIQUID,1,8), format="%Y%m%d")
DFTZ$date_pc <- as.Date(substr(DFTZ$DATE_PLAN_CT,1,8), format="%Y%m%d")
DFTZ$date_mort <- as.Date(substr(DFTZ$DATE_MORT,1,8), format="%Y%m%d")
DFTZ$date_cens <-  as.Date("20140228", format="%Y%m%d")

DFTZ$age_plan <- as.numeric((DFTZ$date_plan-DFTZ$date_ouverture)/365.25)
DFTZ$age_conv <- as.numeric((DFTZ$date_conv-DFTZ$date_ouverture)/365.25)
DFTZ$age_lj <- as.numeric((DFTZ$date_lj-DFTZ$date_ouverture)/365.25)
DFTZ$age_pc <- as.numeric((DFTZ$date_pc-DFTZ$date_ouverture)/365.25)
DFTZ$age_mort <- as.numeric((DFTZ$date_mort-DFTZ$date_ouverture)/365.25)
DFTZ$age_cens <- as.numeric((DFTZ$date_cens-DFTZ$date_ouverture)/365.25)


## On rajoute les variables de secteurs de la BDF:

SECTEUR <- read.csv2("SECTEURBDF.csv", sep = ";")
DFTZ <- merge(DFTZ,SECTEUR[,c("ANNEE_NAF","TX_ENDET_BRUT_MOY","TX_ENDET_NET_MOY","PRET_RRP_MOYEN","PERS_RRP_MOYEN","CT_ENDET_MOY","PDS_INT_REV_GLOB_MOY","VAR_CA_MOY","VAR_VA_MOY","TX_MA_MOY","BFR_MOY","CDT_INTERPT_MOY","DEL_CLI_MOY","DEL_FOUR_MOY","STOCKS_MOY","VAR_CDT_INTERPT_MOY","VAR_DEL_CLI_MOY","VAR_DEL_FOUR_MOY","VAR_STOCKS_MOY","VAR_BFR_MOY","VAR_PRET_RRP_MOYEN","VAR_PERS_RRP_MOYEN","RENTA_B_CAPEX_MOY","RENTA_F_CP_MOY","RENTA_N_CAPEX_MOY","RENTA_N_CP_MOY","TX_AUTOFI_MOY","VAR_RENTA_B_CAPEX_MOY","VAR_RENTA_F_CP_MOY","VAR_RENTA_N_CAPEX_MOY","VAR_RENTA_N_CP_MOY","VAR_TX_AUTOFI_MOY")],all.x=TRUE, by="ANNEE_NAF")

## On rajoute la croissance du PIB par trim selon l'OCDE:
#PIB <- read.csv2("CROISS_PIB.csv", sep = ";")
#DFTZ <- merge(DFTZ,PIB,all.x=TRUE, by="TRIM")
## On rajoute les variations 36M du nombre de créa par dpt et du PIB par trimestre + chom
DFTZ$ANNEEMOIS <- as.numeric(substr(as.character(DFTZ$DATE_OUVERTURE),1,6))

CREA_VAR36M <- read.csv2("CREA_VAR36M.csv", sep = ";", dec =",")
DFTZ <- merge(DFTZ, CREA_VAR36M,all.x=TRUE, by=c("ANNEEMOIS","DPT"))
DFTZ$CREA_VAR36M <-as.numeric(as.character(DFTZ$CREA_VAR36M))

DFTZ$MOIS <- as.numeric(format(as.Date(DFTZ$date_ouverture), "%m"))
DFTZ$ANNEE_TRIM <- ifelse(DFTZ$MOIS<=3,"T1",ifelse(DFTZ$MOIS>=3 & DFTZ$MOIS<=6,"T2",ifelse(DFTZ$MOIS>=3 & DFTZ$MOIS<=6,"T2",ifelse(DFTZ$MOIS>=6 & DFTZ$MOIS<=9,"T3","T4"))))
DFTZ$TRIM <- paste(DFTZ$ANNEE,DFTZ$ANNEE_TRIM, sep="")
DFTZ$TRIM <- as.factor(DFTZ$TRIM)
  
VAR_PIB_TRIM <- read.csv2("VAR_PIB_TRIM.csv", sep = ";", dec =",")
DFTZ <- merge(DFTZ, VAR_PIB_TRIM,all.x=TRUE, by=c("TRIM"))

DFTZ$DPT<- ifelse(as.character(DFTZ$DPT)=="2A"|as.character(DFTZ$DPT)=="2B",as.character(DFTZ$DPT),as.character(as.integer(DFTZ$DPT)))
DFTZ$DPT<- as.factor(DFTZ$DPT)
TX_CHOM <- read.csv2("TX_CHOM.csv", sep = ";", dec =",")
DFTZ <- merge(DFTZ, TX_CHOM,all.x=TRUE, by=c("TRIM","DPT"))

#CREA_VAR24M <- read.csv2("CREA_VAR24M.csv", sep = ";", dec =",")
#DFTZ <- merge(DFTZ, CREA_VAR24M,all.x=TRUE, by=c("ANNEEMOIS","DPT"))
#DFTZ$CREA_VAR24M <-as.numeric(as.character(DFTZ$CREA_VAR24M))


# Var envtles :
DFTZ$CREA_VAR36M <-DFTZ$CREA_VAR36M*100
#DFTZ$CREA_VAR24M <-DFTZ$CREA_VAR24M*100
DFTZ$ECART_TX_CHOM <- DFTZ$TX_CHOM - DFTZ$TX_CHOM_NAT

# Determiner le prochain état de la procédure
### premier état
DFTZ$MIN_ETAT1 <- pmin(DFTZ$age_plan,DFTZ$age_pc,DFTZ$age_conv,DFTZ$age_lj,DFTZ$age_mort,DFTZ$age_cens,na.rm = TRUE)
DFTZ$AGE_ETAT1 <- DFTZ$MIN_ETAT1
DFTZ$PLAN_ETAT1 <- ifelse(DFTZ$MIN_ETAT1 == DFTZ$age_plan , "PLAN",NA)
DFTZ$LJ_ETAT1 <- ifelse(DFTZ$MIN_ETAT1 == DFTZ$age_lj , "LJ",NA)
DFTZ$CONV_ETAT1 <- ifelse(DFTZ$MIN_ETAT1 == DFTZ$age_conv , "CONV",NA)
DFTZ$PC_ETAT1 <- ifelse(DFTZ$MIN_ETAT1 == DFTZ$age_pc , "PC",NA)
DFTZ$MORT_ETAT1 <- ifelse(DFTZ$MIN_ETAT1 == DFTZ$age_mort , "MORT",NA)
DFTZ$CENS_ETAT1 <- ifelse(DFTZ$MIN_ETAT1 == DFTZ$age_cens , "CENS",NA)
DFTZ$ETAT1 <- ifelse(is.na(DFTZ$PLAN_ETAT1) == FALSE, "PLAN",ifelse(is.na(DFTZ$CONV_ETAT1) == FALSE, "CONV",ifelse(is.na(DFTZ$PC_ETAT1) == FALSE, "PC",ifelse(is.na(DFTZ$LJ_ETAT1) == FALSE, "LJ",ifelse(is.na(DFTZ$MORT_ETAT1) == FALSE, "MORT",ifelse(is.na(DFTZ$CENS_ETAT1) == FALSE & DFTZ$CENS_ETAT1 <= 2 , "PROC","CENS"))))))
DFTZ$ETAT1 <- as.factor(ifelse(DFTZ$PROC=="LJ" & DFTZ$ETAT1!= "CENS","PROC",as.character(DFTZ$ETAT1))) #oter les etapes apres LJ autres que cens

### ATTENTION Que fait-on des infos censurées ?
#DFTZ <- DFTZ[which(as.character(DFTZ$ETAT1)!="CENS"),]  # finalement peu nombreux pour les RJ et les Sauv / Il faudra faire un point !!


### ATTENTION
DFTZ$PROC2 <- as.factor(paste(as.character(DFTZ$PROC), as.character(DFTZ$ETAT1), sep="_"))
DFTZ$PROC3 <- as.factor(ifelse(as.character(DFTZ$PROC2)=="LJ_CENS"|as.character(DFTZ$PROC2)=="LJ_MORT"|as.character(DFTZ$PROC2)=="LJ_PROC","LJ",ifelse(as.character(DFTZ$PROC2)=="SAUV_PC"|as.character(DFTZ$PROC2)=="SAUV_LJ"|as.character(DFTZ$PROC3)=="SAUV_CENS","SAUV_MORT",ifelse(as.character(DFTZ$PROC2)=="RJ_LJ"|as.character(DFTZ$PROC3)=="RJ_CENS","RJ_MORT",as.character(DFTZ$PROC2)))))
DFTZ$choice <- DFTZ$PROC3
DFTZ$TEFF <- as.integer(as.character(DFTZ$TR_EFF_ENT))
DFTZ$L_TR_EFF <- as.ordered(ifelse(is.na(DFTZ$TEFF )==TRUE,0,ifelse(DFTZ$TEFF == 0, 1, ifelse(DFTZ$TEFF > 0 & DFTZ$TEFF < 10 ,2,  ifelse(DFTZ$TEFF > 10 & DFTZ$TEFF <= 12 , 3, ifelse(DFTZ$TEFF > 20 & DFTZ$TEFF <= 31,4, 5 ))))))



### Stats gnles

#1. sur typologie des procédures
summary(DFTZ$PROC)
table_proc_annee <- table(DFTZ$PROC,DFTZ$ANNEE)
addmargins(table_proc_annee) # somme colonnes et lignes
prop.table(table_proc_annee,2) #Pourcentage en colonne
 
#2. sur couverture info de bilan
table_proc_bilan <- table(DFTZ$PROC,DFTZ$BILAN_24M)
addmargins(table_proc_bilan) #
prop.table(table_proc_bilan,1)
 
#3. sur couverture tr eff
table_proc_treff <- table(DFTZ$PROC,DFTZ$TR_EFF_ENT)
addmargins(table_proc_treff) #
prop.table(table_proc_treff,1)

#2. sur couverture info de bilan et eff
DFTZ$TEFF <- as.integer(as.character(DFTZ$TR_EFF_ENT))
DFTZ$L_TR_EFF <- as.ordered(ifelse(is.na(DFTZ$TEFF )==TRUE,0,ifelse(DFTZ$TEFF == 0, 1, ifelse(DFTZ$TEFF > 0 & DFTZ$TEFF < 10 ,2,  ifelse(DFTZ$TEFF > 10 & DFTZ$TEFF <= 12 , 3, ifelse(DFTZ$TEFF > 20 & DFTZ$TEFF <= 31,4, 5 ))))))
DFTZ$L_TR_EFF <- ordered(DFTZ$L_TR_EFF,levels = c(0:5),labels = c("Unknown", "No known empl.", "Inf than 10 empl.", "Btw 10 to 50 empl.", "Btw 50 to 250 empl.", "Over 250 empl." )) # labels

table_eff_bilan <- table(DFTZ$L_TR_EFF,DFTZ$BILAN_24M, useNA="ifany")
addmargins(table_eff_bilan) #
prop.table(table_eff_bilan,1)

tabligne=cbind(addmargins(prop.table(addmargins(table_eff_bilan,1),1),2), c(margin.table(table_eff_bilan,1),sum(table_eff_bilan))) 
colnames(tabligne)<-c("Financial not available (%)","Financial available (%)","TOTAL","Volume")
tabligne

DFTZ$L_TR_EFF <- as.ordered(ifelse(is.na(DFTZ$TEFF )==TRUE,0,ifelse(DFTZ$TEFF == 0, 1, ifelse(DFTZ$TEFF > 0 & DFTZ$TEFF < 10 ,2,  ifelse(DFTZ$TEFF > 10 & DFTZ$TEFF <= 12 , 3, ifelse(DFTZ$TEFF > 20 & DFTZ$TEFF <= 31,4, 5 )))))) 

 
#4. sur variable continues
library(doBy)
myfun1 <- function(x){c(M = mean(x,na.rm = TRUE), md=median(x,na.rm = TRUE) ,SD = sd(x,na.rm = TRUE), nbr =length(x))} # calcul malgré valeurs manquantes
summaryBy( AGE_ENTP  +S_EE_B0 + S_FL_B0  + TEFENCE ~ as.factor(PROC), data= DFTZ, FUN= myfun1)

# Distribution Etat 1 par procédures
summary(DFTZ$ETAT1) #verif des proportions
table_proc_etat1 <- table(DFTZ$PROC,DFTZ$ETAT1)
addmargins(table_proc_etat1)
prop.table(table_proc_etat1,1)

# Ampleur des dégats de la censure - analyse par année

## Statistiques
DFTZ$AFT_FIL <- ifelse(DFTZ$PLAN_RJ==1,"Plan",ifelse(DFTZ$PLAN_CT==1, "CT", ifelse(DFTZ$LIQUID==1, "Liquid", "Clos")))
myfun1 <- function(x){c(me=mean(x, na.rm=TRUE), md=median(x, na.rm=TRUE),quant=quantile(x, probs=c(0.25,0.75),na.rm=TRUE), sd=sd(x,na.rm=TRUE), nbr=length(x))}
library(doBy)
summaryBy( AGE_PROC  ~ AFT_FIL, data= subset(DFTZ), FUN= myfun1)


### MODELE - DFTZ 1
library(nnet)
DFTZ$PROC2 <- relevel(DFTZ$PROC, ref = "RJ")
multin <- multinom(PROC2 ~ AGE_ENTP + TR_EFF_ENT + S_FL_B0 + S_EE_B0 + NAF1 + S_TC + FJ_2, data = DFTZ)
z <- summary(multin)$coefficients/summary(multin)$standard.errors
 
### MODELE - DFTZ 2 avec nested model
library(mlogit)
#A. Reshaping data
DFTZ$TEFF <- as.integer(as.character(DFTZ$TR_EFF_ENT))
DFTZ$L_TR_EFF <- as.ordered(ifelse(is.na(DFTZ$TEFF )==TRUE,0,ifelse(DFTZ$TEFF == 0, 1, ifelse(DFTZ$TEFF > 0 & DFTZ$TEFF < 10 ,2,  ifelse(DFTZ$TEFF > 10 & DFTZ$TEFF <= 12 , 3, ifelse(DFTZ$TEFF > 20 & DFTZ$TEFF <= 31,4, 5 ))))))
#B. Que entreprises avec infos de bilan 
DFTZB <- DFTZ[which(DFTZ$BILAN_24M ==1 & DFTZ$L_TR_EFF >= 0 ),] #Avec bilan et Eff >=0
#DFTZB <- DFTZB[which(as.integer(as.character(DFTZB$ANNEE)) <= 2012),] # Pr l'instant, pas besoin d'enlever infos de moins de deux ans

#NON pr instant ON suppr PAS des cens
DFTZB$PROC2 <- as.factor(paste(as.character(DFTZB$PROC), as.character(DFTZB$ETAT1), sep="_"))
DFTZB$PROC3 <- as.factor(ifelse(as.character(DFTZB$PROC2)=="LJ_CENS"|as.character(DFTZB$PROC2)=="LJ_MORT","LJ",ifelse(as.character(DFTZB$PROC2)=="SAUV_PC"|as.character(DFTZB$PROC2)=="SAUV_LJ","SAUV_MORT",ifelse(as.character(DFTZB$PROC2)=="RJ_LJ","RJ_MORT",as.character(DFTZB$PROC2)))))
DFTZB <- DFTZB[which(as.character(DFTZB$ETAT1)!="CENS"),]  # finalement peu nombreux pour les RJ et les Sauv / Il faudra faire un point !!
DFTZB$PROC3 <- as.factor(ifelse(as.character(DFTZB$PROC3)=="LJ_PROC","LJ",ifelse(as.character(DFTZB$PROC3)=="SAUV_CENS","SAUV_MORT",ifelse(as.character(DFTZB$PROC3)=="RJ_CENS","RJ_MORT",as.character(DFTZB$PROC3)))))
DFTZB$choice <- DFTZB$PROC3

DFTZB$S_TC <- as.factor(as.character(DFTZB$S_TC))
DFTZB$TC2 <- factor(DFTZB$S_TC)
levels(DFTZB$TC2) <-  c(1:141)

#test interaction term with logit, il ft passer les data en long d'abord
DFTZB_LG <- mlogit.data(DFTZB,shape="wide",choice="PROC")
ml.DFTZ <- mlogit(PROC ~ 0 | AGE_ENTP + ANNEE + NAF + L_TR_EFF + LN_S_EE_B0 + TX_CHOM + CREA_VAR36M + PIB + S_TC, data = DFTZB_LG)

test_interact <- mlogit(PROC ~ 0 |TC2*LN_S_EE_B0 , data = DFTZB_LG)
summary(test_interact2)
# Suppr var manquantes :
DFTZB2 <- DFTZB[,c("I_SIREN","TX_CHOM","PIB","CREA_VAR36M","L_TR_EFF","PROC","LN_S_EE_B0","NAF1","FJ","NAF","AGE_ENTP","LN_IMMO","ANNEE","CUR_AS_CUR_LI","TC_VOL","RJ_PCT","DEL_FOUR_MOY","TX_MA_MOY","BFR_MOY","DEL_CLI_MOY","PERS_RRP_MOYEN")]
DFTZB2 <- DFTZB2[complete.cases(DFTZB2),]
DFTZB_LG2 <- mlogit.data(DFTZB2,shape="wide",choice="PROC")

test_interact2 <- mlogit(PROC ~ 0 |AGE_ENTP + CREA_VAR36M  + PIB + TX_CHOM + TC2*LN_S_EE_B0 + TC2*LN_IMMO , data = DFTZB_LG2)
summary(test_interact2)
texreg(list(ml.DFTZ),  include.rsquared=FALSE,include.maxrs=FALSE,stars = c(0.01, 0.05, 0.10),digits = 3)



# Autour des TC - boucle : données secteur bdf jusqu'à 2012 ou max 201306...
DFTZB2 <- DFTZB[,c("I_SIREN","S_TC","TX_CHOM","PIB","L_TR_EFF","PROC","LN_S_EE_B0","NAF1","FJ","NAF","AGE_ENTP","LN_IMMO","ANNEE","LN_DET_FOUR","PDS_MAS_SAL","CUR_AS_CUR_LI","TC_VOL","RJ_VOL_PCT")]
DFTZB2 <- DFTZB2[complete.cases(DFTZB2),]
table(DFTZB2$ANNEE)

# Gestion des outliers en récupérent les centiles
DFTZB2$N_CUR_AS_CUR_LI <- ifelse(DFTZB2$CUR_AS_CUR_LI<quantile(DFTZB2$CUR_AS_CUR_LI, probs = c(0.01)),quantile(DFTZB2$CUR_AS_CUR_LI, probs = c(0.01)),DFTZB2$CUR_AS_CUR_LI) #C1
DFTZB2$N_CUR_AS_CUR_LI <- ifelse(DFTZB2$CUR_AS_CUR_LI>quantile(DFTZB2$CUR_AS_CUR_LI, probs = c(0.99)),quantile(DFTZB2$CUR_AS_CUR_LI, probs = c(0.99)),DFTZB2$CUR_AS_CUR_LI) #C99

DFTZB2$N_PDS_MAS_SAL <- ifelse(DFTZB2$PDS_MAS_SAL<quantile(DFTZB2$PDS_MAS_SAL, probs = c(0.01)),quantile(DFTZB2$PDS_MAS_SAL, probs = c(0.01)),DFTZB2$PDS_MAS_SAL) #C1
DFTZB2$N_PDS_MAS_SAL <- ifelse(DFTZB2$PDS_MAS_SAL>quantile(DFTZB2$PDS_MAS_SAL, probs = c(0.99)),quantile(DFTZB2$PDS_MAS_SAL, probs = c(0.99)),DFTZB2$PDS_MAS_SAL) #C99


#Gestion des var categorielles
DFTZB2$TC3 <- factor(DFTZB2$TC2)
levels(DFTZB2$TC3) <-  c(1:length(unique(DFTZB2$TC3)))
DFTZB2$ANNEE2 <- factor(DFTZB2$ANNEE)
levels(DFTZB2$ANNEE2) <-  c(1:length(unique(DFTZB2$ANNEE2)))
DFTZB2$NAF2 <- factor(DFTZB2$NAF)
levels(DFTZB2$NAF2) <-  c(1:length(unique(DFTZB2$NAF2)))
DFTZB2$FJ2 <- factor(DFTZB2$FJ)
levels(DFTZB2$FJ2) <-  c(1:length(unique(DFTZB2$FJ2)))

DFTZB_LG2 <- mlogit.data(DFTZB2,shape="wide",choice="PROC")
# test facile sur factor : table(DFTZB2$PROC,DFTZB2$ANNEE)

table(DFTZB2$PROC,DFTZB2$FJ2)
# REPRENDRE LES TC
for (i in c(1:length(unique(DFTZB2$TC3)))){
  ml.tc <- mlogit(PROC ~ 0 | AGE_ENTP + NAF2 + TX_CHOM + CREA_VAR36M + PIB + LN_S_EE_B0 + LN_IMMO + N_CUR_AS_CUR_LI + LN_DET_FOUR+N_PDS_MAS_SAL + TC_VOL+RJ_VOL_PCT, data = DFTZB_LG2[which(as.integer(as.character(DFTZB_LG2$TC3))==i),]) 
  assign(paste("ml.tc",i,sep="_"),ml.tc,envir=.GlobalEnv) }

table(DFTZ$BILAN_24M,DFTZ$ANNEE)
table(DFTZB2$ANNEE)

#Extraction
DFTZB <- DFTZB[,c("I_SIREN","S_TC","TX_CHOM_NAT","TX_CHOM","TX_CHOM_MOY","TX_ENDET_NET","TX_ENDET_BRUT","CT_ENDET","PERS_RRP","PDS_INT","PDS_MAS_SAL","I_ORIGINE","I_TCD","AGEBILAN","BILAN_24M","RJ_PCT","LJ_PCT","SAUV_PCT","ECART_TX_CHOM","TX_ENDET_BRUT_MOY","TX_ENDET_NET_MOY","PRET_RRP_MOYEN","ANNEEMOIS","DPT","DATE_OUVERTURE","RJ","SAUV","LJ","BILAN_12M","S_EE_B0","S_FL_B0","EFF","choice","TEFF","L_TR_EFF","CLIM_AFF","INDIC_RETOUR","RJ_VOL","SAUV_VOL","LJ_VOL","TC_VOL","TX_CREA","TX_CREA_MOY","PIB","FBCF_ENTP_NF","MIN_ETAT1","AGE_ETAT1","ETAT1","PROC2","PROC3","DEL_FOUR_MOY","STOCKS_MOY","VAR_CDT_INTERPT_MOY","VAR_DEL_CLI_MOY","VAR_DEL_FOUR_MOY","VAR_STOCKS_MOY","VAR_BFR_MOY","FAILURE_24M","FAILURE_36M","LN_S_EE_B0","LN_S_FL_B0","LN_ENDET_BRUT","LN_ENDET_NET","NAF1","FJ","NAF","AGE_ENTP","TR_EFF_ENT","EFENCE","LN_DET_FOUR","LN_CREA_CLI","LN_STOCKS","LN_TRESO_ACT","LN_IMMO","ECHEVINAGE","PROC","FJ_2","ANNEE","PERS_RRP_MOYEN","CT_ENDET_MOY","PDS_INT_REV_GLOB_MOY","VAR_CA_MOY","VAR_VA_MOY","TX_MA_MOY","BFR_MOY","CDT_INTERPT_MOY","DEL_CLI_MOY","STOCKS","CUR_AS_CUR_LI","FAILURE","AGE_FAILURE","FAILURE_12M","RENTA_B_CAPEX_MOY","RENTA_F_CP_MOY","RENTA_N_CAPEX_MOY","RENTA_N_CP_MOY","TX_AUTOFI_MOY","VAR_RENTA_B_CAPEX_MOY","VAR_RENTA_F_CP_MOY","VAR_RENTA_N_CAPEX_MOY","VAR_RENTA_N_CP_MOY","VAR_TX_AUTOFI_MOY","CREA_VAR36M")]
write.table(DFTZB, file = "DFTZB.csv", sep = ";",  row.names = FALSE, na=".")

########################################
########################################
########################################
########################################

#création des "uniques"
length(DFTZB$I_SIREN) #DFTZ si doublons
length(unique(DFTZB$I_SIREN)) #DFTZ si doublons
DFTZB$I_SIREN <- paste(as.character(DFTZB$I_SIREN), as.character(DFTZB$ANNEE), sep="")

#Modele avec alternative
DFTZ_PROC <- DFTZ[,c("I_SIREN","date_ouverture","PROC","PROC3","ETAT1","choice","AGE_ETAT1","ANNEE","I_FJ","FJ_2","TX_CHOM_NAT","TX_CHOM","TX_CREA","S_TC","RJ_VOL","LJ_VOL","SAUV_VOL","TC_VOL","EFENCE","I_FJ","FJ_1","NAF","NAF2","NAF1","AGE_ENTP","L_TR_EFF","AGE_DIR","R_NBR_DIR","A_NBR_ETAB","AGEBILAN","BILAN_24M","BILAN_12M","S_EE_B0","S_FL_B0","PDS_MAS_SAL","TX_VA","CP_VA","EFF","RENTA_ECO","DUR_FOUR","DUR_CLI","TX_ENDET_NET","PERS_RRP","PRET_RRP","RJ_PCT","LJ_PCT","SAUV_PCT","TX_ENDET_BRUT_MOY","TX_ENDET_NET_MOY","PRET_RRP_MOYEN",  "PERS_RRP_MOYEN","CT_ENDET_MOY","VAR_CA_MOY","VAR_VA_MOY","TX_MA_MOY","BFR_MOY","DEL_CLI_MOY","DEL_FOUR_MOY","S_EE_B0_LogN","S_FL_B0_LogN","TX_VA_LogN","TX_MB_EXP_LogN","TX_DOB_LogN","RENT_B_K_EXP_LogN","RENT_N_K_EXP_LogN","CAP_GEN_CASH_LogN","RENTA_FI_LogN","SUR_FI_LogN","COUV_IMMO_FP_LogN","CRED_BK_COURANT_BFR_LogN","DET_FOUR_LogN","CREA_CLI_LogN","DUR_FOUR_LogN","DUR_CLI_LogN","RENTA_ECO_LogN","RES_FIN_LogN","RES_EXCEP_LogN","PDS_MAS_SAL_LogN","TRESO_N_LogN","ENDET_BRUT_LogN","ENDET_NET_LogN","TX_ENDET_NET_LogN","TX_ENDET_BRUT_LogN","CT_ENDET_LogN","PERS_RRP_LogN","PRET_RRP_LogN","CREA_VAR36M", "CREA_VAR24M")]
DFTZ_PROC$PROC_ALT <- ifelse(DFTZ_PROC$PROC == "LJ", 1,ifelse(DFTZ_PROC$PROC == "RJ", 2, 3))
DFTZ_PROC$PCT_PROC <- ifelse(DFTZ_PROC$PROC == "LJ", DFTZ_PROC$LJ_PCT,ifelse(DFTZ_PROC$PROC == "RJ", DFTZ_PROC$RJ_PCT,DFTZ_PROC$SAUV_PCT))
DFTZ_PROC$ETAPE_ALT <- as.factor(ifelse(DFTZ_PROC$choice == "LJ", 1,ifelse(DFTZ_PROC$choice == "RJ_MORT", 2,ifelse(DFTZ_PROC$choice == "RJ_PC", 3,ifelse(DFTZ_PROC$choice == "RJ_PLAN", 4,ifelse(DFTZ_PROC$choice == "SAUV_MORT", 5,ifelse(DFTZ_PROC$choice == "SAUV_CONV", 6, 7)))))))

# Extraction
#DFTZ_PROC$sample <- runif(length(DFTZ_PROC$I_SIREN), 0, 1) #création de l'échantillon
#DFTZ_PROC <- DFTZ_PROC[which(DFTZ_PROC$sample <= 0.2),]
write.table(DFTZ_PROC, file = "DFTZ_PROC.csv", sep = ";",  row.names = FALSE, na=".")

#préparation des data
library(mlogit) 
DFTZ_NL <- mlogit.data(DFTZB, choice = "choice",id.var="I_SIREN",shape = "wide")

DFTZ_NL$AGE_ETAT1 <-ifelse(DFTZ_NL$PROC=="LJ",0,DFTZ_NL$AGE_ETAT1)
#DFTZ_NL <- DFTZ_NL[,c("I_SIREN","date_ouverture","choice","PROC","ETAT1","AGE_ETAT1","ANNEE","I_FJ","FJ_2","TX_CHOM_NAT","TX_CHOM","TX_CREA","REGION_NAME","S_NOMENCL","S_TC","RJ_VOL","LJ_VOL","SAUV_VOL","TC_VOL","EFENCE","I_FJ","FJ_1","I_CD_NAF","NAF2","NAF1","AGE_ENTP","I_CAP_SOC","TR_EFF_ENT","I_EFENCE","AGE_DIR","R_NBR_DIR","I_SAISONAT","A_NBR_ETAB","I_EXPLEN","I_RECME","I_ORIGINE","I_MODEN","I_MONOREG","I_MONOACT","I_TCD","I_NBTOA","AGEBILAN","BILAN_24M","BILAN_12M","S_DT_CLO_B0","S_EE_B0","S_FL_B0","EFF","RENTA_ECO","DUR_FOUR","DUR_CLI","TX_ENDET_NET","PERS_RRP","PRET_RRP", "PROC3", "choice", "alt")]
DFTZ_NL$PROC_ALT <- ifelse(substr(DFTZ_NL$alt,1,2) == "LJ", "LJ", ifelse(substr(DFTZ_NL$alt,1,2) == "RJ", "RJ", "SAUV"))
DFTZ_NL$PCT_PROC <- ifelse(DFTZ_NL$PROC_ALT == "LJ", DFTZ_NL$LJ_PCT,ifelse(DFTZ_NL$PROC_ALT == "RJ", DFTZ_NL$RJ_PCT,DFTZ_NL$SAUV_PCT))

DFTZ_NL$choice <- ifelse(DFTZ_NL$choice == FALSE, 0, 1)
DFTZ_NL$procedure <- DFTZ_NL$PROC3
DFTZ_NL$ANNEE <- as.factor(paste("ANNEE", as.character(DFTZ_NL$ANNEE), sep="_"))


# Extraction
write.table(DFTZ_NL, file = "DFTZ_NL.csv", sep = ";",  row.names = FALSE, na=".")
 
ml.DFTZ <- mlogit(PROC ~ 1 | AGE_ENTP + TR_EFF_ENT + S_FL_B0 + S_EE_B0 + NAF1 + AGE_PROC + FJ_2, data = DFTZ_NL)
nl.DFTZ <- mlogit(choice ~ AGE_ENTP + TR_EFF_ENT + S_FL_B0 + S_EE_B0 + NAF1 + AGE_PROC + FJ_2, data = DFTZ_NL,shape='wide', alt.var='mode',
nests = list(continuation = c(RJ=c("RJ_CENS","RJ_PLAN","RJ_PC","RJ_LJ","RJ_MORT"), SAUV=c("SAUV_CENS","SAUV_PLAN","SAUV_PC","SAUV_LJ","SAUV_MORT")), liquid =c("LJ_CENS", "LJ_PROC")))
 
nl.DFTZ <- mlogit(choice ~ AGE_ENTP + TR_EFF_ENT + S_FL_B0 + S_EE_B0 + NAF1 + AGE_PROC + FJ_2, data = DFTZ_NL,shape='wide', alt.var='PROC3',
nests = list(continuation = c(RJ=c("RJ_CENS","RJ_PLAN","RJ_PC","RJ_MORT"), SAUV=c("SAUV_CENS","SAUV_PLAN","SAUV_CONV","SAUV_MORT")), liquid ="LJ"))
summary(nl.DFTZ)
 
nl.DFTZ <- mlogit(choice ~ AGE_ENTP + TR_EFF_ENT + S_FL_B0 + S_EE_B0 + NAF1 + AGE_ETAT1 + FJ_2, data = DFTZ_NL,shape='wide', alt.var='PROC3',nests = list(continuation = c(RJ=c("RJ_PLAN","RJ_PC","RJ_MORT"), SAUV=c("SAUV_PLAN","SAUV_CONV","SAUV_MORT")), liquid ="LJ_PROC"))
summary(nl.DFTZ)

DFTZ_NL2 <- DFTZ_NL[,c("I_SIREN","date_ouverture","choice","AGE_ETAT1","ANNEE","FJ_2","S_TC","NAF1","AGE_ENTP","TEFENCE","S_EE_B0","S_FL_B0","EFF","chid","alt")]

### On sequential
# with only choice on procedures
#B. Que entreprises avec infos de bilan 


### DFTZ nlogit
DFTZ_PROC <- mlogit.data(DFTZB, choice = "PROC",id.var="I_SIREN",shape = "wide")
DFTZ_PROC$PROC_ALT <- ifelse(DFTZ_PROC$PROC == "LJ", 1,ifelse(DFTZ_PROC$PROC == "RJ", 2, 3))
DFTZ_PROC$PCT_PROC <- ifelse(DFTZ_PROC$alt == "LJ", DFTZ_PROC$LJ_PCT,ifelse(DFTZ_PROC$alt == "RJ", DFTZ_PROC$RJ_PCT,DFTZ_PROC$SAUV_PCT))
DFTZ_PROC$ANNEE <- as.factor(paste("ANNEE", as.character(DFTZ_PROC$ANNEE), sep="_"))

# nlogit
nl.DFTZ <- mlogit(choice ~ PCT_PROC | AGE_ENTP + EFENCE + S_EE_B0 + NAF1 + FJ_2, data = DFTZ_PROC,shape='long',nests = list(continuation = c(RJ, SAUV), liquid ="LJ"))
summary(nl.DFTZ)

<- mFormula(choice ~ vcost | income + size | travel) # (dpt variable ~ alt specific variable with gnl coef | indivl specific | alternative specific coeff)
# DFTZ mlogit
DFTZ_NL$AGE_ETAT1 <- ifelse(DFTZ_NL$choice==0,0,DFTZ_NL$AGE_ETAT1)
ml.DFTZ <- mlogit(choice ~ PCT_PROC | AGE_ENTP + EFENCE + S_EE_B0 + NAF1 + FJ_2, DFTZ_NL) # ne fonctionne pas après 3 heures

# Determiner l'état dans un laps de temps
### dans deux ans
DFTZ$MAX_24M <- pmax(pmax(2-DFTZ$age_plan,0,na.rm = TRUE),pmax(2-DFTZ$age_pc,0,na.rm = TRUE),pmax(2-DFTZ$age_conv,0,na.rm = TRUE),pmax(2-DFTZ$age_lj,0,na.rm = TRUE),pmax(2-DFTZ$age_mort,0,na.rm = TRUE),na.rm = TRUE)

DFTZ$PLAN_24M <- ifelse(DFTZ$MAX_24M == 2-DFTZ$age_plan , "PLAN",NA)
DFTZ$LJ_24M <- ifelse(DFTZ$MAX_24M == 2-DFTZ$age_lj , "LJ",NA)
DFTZ$CONV_24M <- ifelse(DFTZ$MAX_24M == 2-DFTZ$age_conv , "CONV",NA)
DFTZ$PC_24M <- ifelse(DFTZ$MAX_24M == 2-DFTZ$age_pc , "PC",NA)
DFTZ$MORT_24M <- ifelse(DFTZ$MAX_24M == 2-DFTZ$age_mort , "MORT",NA)
DFTZ$ETAT_24M <- ifelse(is.na(DFTZ$PLAN_24M) == FALSE, "PLAN",ifelse(is.na(DFTZ$CONV_24M) == FALSE, "CONV",ifelse(is.na(DFTZ$PC_24M) == FALSE, "PC",ifelse(is.na(DFTZ$LJ_24M) == FALSE, "LJ",ifelse(is.na(DFTZ$MORT_24M) == FALSE, "MORT","PROC")))))

table(DFTZ$PROC,DFTZ$ETAT_24M)
summary(as.factor(DFTZ$ETAT_24M)) #verif des proportions


# by(data, factorlist, function)
# example obtain variable means separately for
# each level of byvar in data frame mydata 
by(mydata, mydatat$byvar, function(x) mean(x))

myfunction <- function(arg1, arg2, ... ){
  test <- DFTZB2[which()]
  table()
  return(object)
}
