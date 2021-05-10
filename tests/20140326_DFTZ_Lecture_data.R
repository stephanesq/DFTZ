#Renommer des variables
names(data.wide)[names(data.wide)=="cond1"] <- "first"
names(data.wide)[names(data.wide)=="cond2"] <- "second"



## Variables présentes
"I_SIREN","DATE_OUVERTURE","RJ","SAUV","LJ","DATE_PLAN","PLAN","DATE_LIQUID","LIQUID","DATE_CONV","CONV_RJ","DATE_PLAN_CT","PLAN_CT","DATE_MORT","MORT","CD_MORT","DATE_PLAN_CESS","P_CESSION","DATE_CL_CT","CL_CESSION","DATE_PLAN_RJ","PLAN_RJ","I_CD_POST_SIEGE","DPT","CODE_REGION","REGION_NAME","S_NOMENCL","S_TC","A_CD_STATUT","A_DT_STATUT","I_FJ","FJ_1","I_CD_NAF","NAF2","NAF1","I_DT_CREA_ENT","AGE_ENTP","I_CAP_SOC","I_TR_EFF_ENT","TR_EFF_ENT","I_EFENCE","R_DT_NAISS_DIR","AGE_DIR","R_NBR_DIR","I_SAISONAT","A_NBR_ETAB","I_EXPLEN","I_TCA","I_TCAEXPOR","I_RECME","I_ORIGINE","I_MODEN","I_MONOREG","I_MONOACT","I_TCD","I_NBTOA","AGEBILAN","BILAN_24M","BILAN_ETAT1","S_DT_CLO_B0","S_EE_B0","S_FL_B0","EFF","S_DT_CLO_B1","S_EE_B1","S_FL_B1","EFF_1","TX_MA_GL","TX_VA","TX_MB_EXP","TX_M_COM","TX_DOB","RENT_B_K_EXP","RENT_N_K_EXP","CAP_GEN_CASH","RENTA_FI","SUR_FI","COUV_IMMO_FP","CRED_BK_COURANT_BFR","CP_VA","PDS_INT","VMC","DET_FOUR","CREA_CLI","ROT_STOCK_MP","ROT_STOCK_MAR","ROT_STOCK_PF","DUR_FOUR","DUR_CLI","RENTA_ECO","RES_FIN","RES_EXCEP","PDS_MAS_SAL","ROT_STO_MAT_APPRO","DEL_RO_STO_MARCH","DEL_RO_STO_P_FINI","SOLDE_COM","LIQUI","CAF","RE_ET_DEV1","RE_ET_DEV2","FR","BFR","TRESO_N","ENDET_BRUT","ENDET_NET","TX_ENDET_NET","TX_ENDET_BRUT","CT_ENDET","TX_RENTA_FI_KP","PDS_INT_REV_GLOB","PERS_RRP","PRET_RRP","COMPTES_ASSOCIES","VAR_TX_MA_GL","VAR_CA","VAR_ACTIF","VAR_TX_VA","VAR_TX_MB_EXP","VAR_TX_M_COMM","VAR_TX_DOB","VAR_RENT_B_K_EXP","VAR_RENT_N_K_EXP","VAR_CAP_GEN_CASH","VAR_RENTA_FI","VAR_SUR_FI","VAR_COUV_IMMO_FP","VAR_CRED_BK_COURANT_BFR","VAR_ROT_STO_MAT_APPRO","VAR_DEL_RO_STO_MARCH","VAR_DEL_RO_STO_P_FINI","VAR_SOLDE_COM","VAR_LIQUI","VAR_CAF","VAR_RE_ET_DEV2","VAR_FR","VAR_BFR","VAR_TRESO_N","VAR_CP_VA","VAR_PDS_INT","VAR_PDS_MAS_SAL","VAR_VMC","VAR_DET_FOUR","VAR_ROT_STOCK_MP","VAR_ROT_STOCK_MAR","VAR_ROT_STOCK_PF","VAR_DUR_FOUR","VAR_DUR_CLI","VAR_RENTA_ECO","VAR_RES_FIN","VAR_RES_EXCEP","VAR_EFF","VAR_ENDT_BRUT","VAR_ENDET_NET","VAR_CT_ENDET","VAR_COMPTE_ASSO","VAR_PERS_RRP","VAR_PRET_RRP","TR_EFF_BILAN"

#Imprimer un fichier
DFTZ2 <- DFTZ[1:3,]
write.table(DFTZB, file = "DFTZB.csv", sep = ";",  row.names = FALSE)
#Recuperer premiere ligne
test <- DFTZB[1:1,]
write.table(test, file = "ligne.csv", sep = ";", row.names = FALSE)

# Nettoyer
rm(list=ls()) #Tout
rm(x) # efface x 

#RÈpertoire :

options(scipen=999)
###################### IMPORT ##################################################
setwd("/Users/stephaneesquerre/Dropbox/Articles/2013 - Premiers travaux/Dont feed the zombies/DATA")
#DFTZ <- read.csv2("DFTZ.csv", sep = ";")
#DFTZ <- read.csv2("20140429_DFTZ_INC.csv", sep = ";")
DFTZ <- read.csv2("20140610_DFTZ_INC.csv", sep = ";")

###################### I.DATA Mining ##################################################
DFTZ <- DFTZ[,c("I_SIREN","DATE_OUVERTURE","RJ","SAUV","LJ","DATE_PLAN","PLAN","DATE_LIQUID","LIQUID","DATE_CONV","CONV_RJ","DATE_PLAN_CT","PLAN_CT","DATE_MORT","MORT","DATE_PLAN_CESS","P_CESSION","DATE_CL_CT","CL_CESSION","DATE_PLAN_RJ","PLAN_RJ","S_TC","S_TC_NUM","DPT","S_NOMENCL","ANNEETRIM_OUV","TX_CHOM_NAT","TX_CHOM","TX_CHOM_MOY","CHOM_BAD","CLIM_AFF","INDIC_RETOUR","RJ_VOL","SAUV_VOL","LJ_VOL","TC_VOL","TX_CREA","TX_CREA_MOY","PIB","FBCF_ENTP_NF","PIB_PLAN","FBCF_ENTP_NF_PLAN","TX_CHOM_NAT_PLAN","TX_CHOM_PLAN","TX_CREA_PLAN","I_FJ","FJ_1","NAF2","NAF1","AGE_ENTP","TR_EFF_ENT","EFENCE","AGE_DIR","R_NBR_DIR","I_SAISONAT","A_NBR_ETAB","I_ORIGINE","I_MONOREG","I_TCD","I_NBTOA","AGEBILAN","BILAN_24M","BILAN_12M","S_EE_B0","S_FL_B0","EFF","TR_EFF_BILAN","TX_MA_GL","TX_VA","TX_MB_EXP","TX_M_COM","TX_DOB","RENT_B_K_EXP","RENT_N_K_EXP","CAP_GEN_CASH","RENTA_FI","SUR_FI","COUV_IMMO_FP","CRED_BK_COURANT_BFR","CP_VA","PDS_INT","VMC","DET_FOUR","CREA_CLI","DUR_FOUR","DUR_CLI","RENTA_ECO","RES_FIN","RES_EXCEP","PDS_MAS_SAL","SOLDE_COM","LIQUI","CAF","FR","BFR","TRESO_N","ENDET_BRUT","ENDET_NET","TX_ENDET_NET","TX_ENDET_BRUT","CT_ENDET","TX_RENTA_FI_KP","PDS_INT_REV_GLOB","PERS_RRP","PRET_RRP","COMPTES_ASSOCIES","CNAF","RES_HORS_EXP","RRP","STOCKS","CUR_AS_CUR_LI","TRESO_ACT","FAILURE","AGE_FAILURE","FAILURE_12M","FAILURE_24M","FAILURE_36M","LN_S_EE_B0","LN_S_FL_B0","LN_BFR","LN_TRESO_N","LN_ENDET_BRUT","LN_ENDET_NET","LN_COMPTES_ASSOCIES","LN_DET_FOUR","LN_CREA_CLI","LN_STOCKS","LN_TRESO_ACT","RJ_VOL_PCT","SAUV_VOL_PCT","LJ_VOL_PCT","ECHEVINAGE")]

DFTZ$PROC <- as.factor(ifelse(DFTZ$RJ==1, "RJ",ifelse(DFTZ$SAUV==1, "SAUV","LJ")))
DFTZ$TR_EFF_ENT <- as.factor(DFTZ$TR_EFF_ENT)
DFTZ$TEFF <- as.integer(as.character(DFTZ$TR_EFF_ENT))
DFTZ$L_TR_EFF <- as.ordered(ifelse(is.na(DFTZ$TEFF )==TRUE,0,ifelse(DFTZ$TEFF == 0, 1, ifelse(DFTZ$TEFF > 0 & DFTZ$TEFF < 10 ,2,  ifelse(DFTZ$TEFF > 10 & DFTZ$TEFF <= 12 , 3, ifelse(DFTZ$TEFF > 20 & DFTZ$TEFF <= 31,4, 5 ))))))
#DFTZ$EFENCE <- ifelse(DFTZ$I_EFENCE=="NN"|DFTZ$I_EFENCE=="500000",NA,as.integer(as.character(DFTZ$I_EFENCE)))
#DFTZ$TEFENCE <- DFTZ$EFF
#DFTZ$TEFENCE <- ifelse(is.na(DFTZ$TEFENCE)==TRUE, DFTZ$EFENCE, DFTZ$TEFENCE) # il faut prdre garde aux nombre de variables appelées dans un ifelse
DFTZ$FJ_2 <- as.factor(substr(as.character(DFTZ$I_FJ),1,2))
DFTZ$ANNEE <- as.factor(substr(as.character(DFTZ$DATE_OUVERTURE),1,4))
DFTZ$FJ <- as.character(DFTZ$FJ_2)
DFTZ$FJ <- as.factor(ifelse(DFTZ$FJ=="51"|DFTZ$FJ=="52"|DFTZ$FJ=="53"|DFTZ$FJ=="56","AUTRES", DFTZ$FJ))
DFTZ$FJ <- as.factor(ifelse(DFTZ$FJ=="54","SARL",ifelse(DFTZ$FJ=="55","SA_CA",ifelse(DFTZ$FJ=="57","SAS",ifelse(DFTZ$FJ=="AUTRES","AUTRES","NR")))))

DFTZ$NAF1 <- as.character(DFTZ$NAF1)
DFTZ$NAF <- as.factor(ifelse(DFTZ$NAF1=="B"|DFTZ$NAF1=="D"|DFTZ$NAF1=="E","Z",DFTZ$NAF1))
DFTZ$NAF1 <- as.factor(DFTZ$NAF1)

#DFTZ$TRIM <- ifelse((as.integer(substr(as.character(DFTZ$DATE_OUVERTURE),5,2)) >=4 & as.integer(substr(as.character(DFTZ$DATE_OUVERTURE),5,2)) <= 6), paste(substr(as.character(DFTZ$ANNEETRIM_OUV),1,4),"T1", sep=""), ifelse((as.integer(substr(as.character(DFTZ$DATE_OUVERTURE),5,2)) >=7 & as.integer(substr(as.character(DFTZ$DATE_OUVERTURE),5,2)) <= 9), paste(substr(as.character(DFTZ$ANNEETRIM_OUV),1,4),"T2", sep=""),ifelse(substr(as.character(DFTZ$ANNEETRIM_OUV),5,2)=="09", paste(substr(as.character(DFTZ$ANNEETRIM_OUV),1,4),"T3", sep=""),paste(substr(as.character(DFTZ$ANNEETRIM_OUV),1,4),"T4", sep=""))))
 
# Selection de la base - SC et NAF
DFTZ$DNAF <- ifelse(DFTZ$NAF=="C"|DFTZ$NAF=="F"|DFTZ$NAF=="G"|DFTZ$NAF=="H"|DFTZ$NAF=="I"|DFTZ$NAF=="J"|DFTZ$NAF=="L"|DFTZ$NAF=="N"|DFTZ$NAF=="T"|DFTZ$NAF=="Z",1,0) 
DFTZ <- DFTZ[which(DFTZ$FJ_1==5 & DFTZ$DNAF==1),]
DFTZ <- DFTZ[which(as.integer(as.character(DFTZ$ANNEE)) <= 2012),] 

# Infos de date et âge 
DFTZ$date_ouverture <- as.Date(substr(DFTZ$DATE_OUVERTURE,1,8), format="%Y%m%d")
DFTZ$date_plan <- as.Date(substr(DFTZ$DATE_PLAN,1,8), format="%Y%m%d")
DFTZ$date_conv <- as.Date(substr(DFTZ$DATE_CONV,1,8), format="%Y%m%d")
DFTZ$date_lj <- as.Date(substr(DFTZ$DATE_LIQUID,1,8), format="%Y%m%d")
DFTZ$date_pc <- as.Date(substr(DFTZ$DATE_PLAN_CT,1,8), format="%Y%m%d")
DFTZ$date_mort <- as.Date(substr(DFTZ$DATE_MORT,1,8), format="%Y%m%d")
DFTZ$date_cens <- as.Date("20140228", format="%Y%m%d")
DFTZ$age_plan <- as.numeric((DFTZ$date_plan-DFTZ$date_ouverture)/365.25)
DFTZ$age_conv <- as.numeric((DFTZ$date_conv-DFTZ$date_ouverture)/365.25)
DFTZ$age_lj <- as.numeric((DFTZ$date_lj-DFTZ$date_ouverture)/365.25)
DFTZ$age_pc <- as.numeric((DFTZ$date_pc-DFTZ$date_ouverture)/365.25)
DFTZ$age_mort <- as.numeric((DFTZ$date_mort-DFTZ$date_ouverture)/365.25)
DFTZ$age_cens <- as.numeric((DFTZ$date_cens-DFTZ$date_ouverture)/365.25)

DFTZ <- DFTZ[,c("I_SIREN","date_ouverture","ANNEETRIM_OUV","PROC","age_plan","PLAN","age_conv","CONV_RJ","age_lj","LIQUID","age_pc","PLAN_CT","age_mort","age_cens","MORT","ANNEE","S_TC","S_TC_NUM","DPT","S_NOMENCL","ANNEETRIM_OUV","TX_CHOM_NAT","TX_CHOM","TX_CHOM_MOY","CHOM_BAD","CLIM_AFF","INDIC_RETOUR","RJ_VOL","SAUV_VOL","LJ_VOL","TC_VOL","TX_CREA","TX_CREA_MOY","PIB","FBCF_ENTP_NF","PIB_PLAN","FBCF_ENTP_NF_PLAN","TX_CHOM_NAT_PLAN","TX_CHOM_PLAN","TX_CREA_PLAN","FJ","FJ_1","FJ_2","NAF2","NAF1","AGE_ENTP","TR_EFF_ENT","EFENCE","AGE_DIR","R_NBR_DIR","I_SAISONAT","A_NBR_ETAB","I_ORIGINE","I_MONOREG","I_TCD","I_NBTOA","AGEBILAN","BILAN_24M","BILAN_12M","S_EE_B0","S_FL_B0","EFF","TR_EFF_BILAN","TX_MA_GL","TX_VA","TX_MB_EXP","TX_M_COM","TX_DOB","RENT_B_K_EXP","RENT_N_K_EXP","CAP_GEN_CASH","RENTA_FI","SUR_FI","COUV_IMMO_FP","CP_VA","PDS_INT","VMC","DET_FOUR","CREA_CLI","DUR_FOUR","DUR_CLI","RENTA_ECO","PDS_MAS_SAL","SOLDE_COM","LIQUI","CAF","FR","BFR","TRESO_N","ENDET_BRUT","ENDET_NET","TX_ENDET_NET","TX_ENDET_BRUT","CT_ENDET","TX_RENTA_FI_KP","PDS_INT_REV_GLOB","PERS_RRP","PRET_RRP","COMPTES_ASSOCIES","CNAF","CUR_AS_CUR_LI","TRESO_ACT","FAILURE","AGE_FAILURE","FAILURE_12M","FAILURE_24M","FAILURE_36M","LN_S_EE_B0","LN_S_FL_B0","LN_BFR","LN_TRESO_N","LN_ENDET_BRUT","LN_ENDET_NET","LN_COMPTES_ASSOCIES","LN_DET_FOUR","LN_CREA_CLI","LN_STOCKS","LN_TRESO_ACT","RJ_VOL_PCT","SAUV_VOL_PCT","LJ_VOL_PCT","ECHEVINAGE")]

# Var envtles :
DFTZ$RJ_PCT <- DFTZ$RJ_VOL / DFTZ$TC_VOL * 100
DFTZ$LJ_PCT <- DFTZ$LJ_VOL / DFTZ$TC_VOL  * 100
DFTZ$SAUV_PCT <- DFTZ$SAUV_VOL / DFTZ$TC_VOL * 100
DFTZ$TX_CHOM <-DFTZ$TX_CHOM
DFTZ$TX_CHOM_NAT <-DFTZ$TX_CHOM_NAT
DFTZ$ECART_TX_CHOM <- DFTZ$TX_CHOM - DFTZ$TX_CHOM_NAT
DFTZ$TX_CREA <-DFTZ$TX_CREA*100

## On rajoute les variables de secteurs de la BDF:

DFTZ$ANNEE_NAF <- paste(substr(as.character(DFTZ$date_ouverture),1,4),as.character(DFTZ$NAF), sep="")
DFTZ$ANNEE_NAF <- as.factor(DFTZ$ANNEE_NAF)
DFTZ$ANNEEMOIS <- substr(as.character(DFTZ$DATE_OUVERTURE),1,6)
SECTEUR <- read.csv2("SECTEURBDF.csv", sep = ";")
DFTZ <- merge(DFTZ,SECTEUR[,c("ANNEE_NAF","TX_ENDET_BRUT_MOY","TX_ENDET_NET_MOY","PRET_RRP_MOYEN","PERS_RRP_MOYEN","CT_ENDET_MOY","PDS_INT_REV_GLOB_MOY","VAR_CA_MOY","VAR_VA_MOY","TX_MA_MOY","BFR_MOY","CDT_INTERPT_MOY","DEL_CLI_MOY","DEL_FOUR_MOY","STOCKS_MOY","VAR_CDT_INTERPT_MOY","VAR_DEL_CLI_MOY","VAR_DEL_FOUR_MOY","VAR_STOCKS_MOY","VAR_BFR_MOY","VAR_PRET_RRP_MOYEN","VAR_PERS_RRP_MOYEN","RENTA_B_CAPEX_MOY","RENTA_F_CP_MOY","RENTA_N_CAPEX_MOY","RENTA_N_CP_MOY","TX_AUTOFI_MOY","VAR_RENTA_B_CAPEX_MOY","VAR_RENTA_F_CP_MOY","VAR_RENTA_N_CAPEX_MOY","VAR_RENTA_N_CP_MOY","VAR_TX_AUTOFI_MOY")],all.x=TRUE, by="ANNEE_NAF")


CREA_VAR36M <- read.csv2("CREA_VAR36M.csv", sep = ";", dec =",")
CREA_VAR24M <- read.csv2("CREA_VAR24M.csv", sep = ";", dec =",")
DFTZ <- merge(DFTZ, CREA_VAR36M,all.x=TRUE, by=c("ANNEEMOIS","DPT"))
DFTZ <- merge(DFTZ, CREA_VAR24M,all.x=TRUE, by=c("ANNEEMOIS","DPT"))
DFTZ$CREA_VAR36M <-as.numeric(as.character(DFTZ$CREA_VAR36M))
DFTZ$CREA_VAR24M <-as.numeric(as.character(DFTZ$CREA_VAR24M))

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
DFTZ$PROC2 <- as.factor(paste(as.character(DFTZ$PROC), as.character(DFTZ$ETAT1), sep="_"))


###################### II. Stats gnles #############################################################
###### A.SUR BASE SANS SELECTION DE L'INFO (si : que SC)
#A.1. sur typologie des procédures
summary(DFTZ$PROC)
table_proc_annee <- table(DFTZ$PROC,DFTZ$ANNEE)
addmargins(table_proc_annee) # somme colonnes et lignes
prop.table(table_proc_annee,2) #Pourcentage en colonne

#A.2. sur couverture info de bilan
table_proc_bilan <- table(DFTZ$PROC,DFTZ$BILAN_24M)
tabligne_bilan=cbind(addmargins(prop.table(addmargins(table_proc_bilan,1),1),2), c(margin.table(table_proc_bilan,1),sum(table_proc_bilan))) 
colnames(tabligne_bilan)<-c("Financial not available (%)","Financial available (%)","TOTAL","Volume")
tabligne_bilan

#A.3. sur couverture tr eff
table_proc_treff <- table(DFTZ$L_TR_EFF,DFTZ$PROC)
addmargins(table_proc_treff) #
prop.table(table_proc_treff,1)
##3.2. sur couverture info de bilan et eff
#DFTZ$L_TR_EFF <- ordered(DFTZ$L_TR_EFF,levels = c(0:5),labels = c("Unknown", "No known empl.", "Inf than 10 empl.", "Btw 10 to 50 empl.", "Btw 50 to 250 empl.", "Over 250 empl." )) # labels
table_eff_bilan <- table(DFTZ$L_TR_EFF,DFTZ$BILAN_24M, useNA="ifany")
tabligne=cbind(addmargins(prop.table(addmargins(table_eff_bilan,1),1),2), c(margin.table(table_eff_bilan,1),sum(table_eff_bilan))) 
colnames(tabligne)<-c("Financial not available (%)","Financial available (%)","TOTAL","Volume")
tabligne

#A.4. sur état PCL
table_proc_etat <- table(DFTZ$PROC,DFTZ$ETAT1, useNA="ifany")
addmargins(table_proc_etat) #
prop.table(table_proc_etat,1)
###A.4.1. sur evts censures
DFTZ$CENS <- ifelse(DFTZ$ETAT1=="CENS",1,0)
####A.4.1.1. fj
table_cens_fj <- table(DFTZ$FJ,DFTZ$CENS, useNA="ifany")
tabligne_fj=cbind(addmargins(prop.table(addmargins(table_cens_fj,1),1),2), c(margin.table(table_cens_fj,1),sum(table_cens_fj))) 
colnames(tabligne_fj)<-c("Not censored (%)","Censored (%)","TOTAL","Volume")
tabligne_fj
####A.4.1.2. eff
table_cens_eff <- table(DFTZ$L_TR_EFF,DFTZ$CENS, useNA="ifany")
tabligne_eff=cbind(addmargins(prop.table(addmargins(table_cens_eff,1),1),2), c(margin.table(table_cens_eff,1),sum(table_cens_eff))) 
colnames(tabligne_eff)<-c("Not censored (%)","Censored (%)","TOTAL","Volume")
tabligne_eff
####A.4.1.3. par année -> leçon : il faudra être plus précis sur la date de censure
table_cens_annee <- table(DFTZ$ANNEE,DFTZ$CENS, useNA="ifany")
tabligne_annee=cbind(addmargins(prop.table(addmargins(table_cens_annee,1),1),2), c(margin.table(table_cens_annee,1),sum(table_cens_annee))) 
colnames(tabligne_annee)<-c("Not censored (%)","Censored (%)","TOTAL","Volume")
tabligne_annee

#A.5. Distribution Etat 1 par procédures
summary(DFTZ$ETAT1) #verif des proportions
table_proc_etat1 <- table(DFTZ$PROC,DFTZ$ETAT1)
addmargins(table_proc_etat1)
prop.table(table_proc_etat1,1)


###### B. Après selection des donnees non-censurées
### ATTENTION 
DFTZ <- DFTZ[which(as.character(DFTZ$ETAT1)!="CENS"),]  # finalement peu nombreux pour les RJ et les Sauv / Il faudra faire un point !!
DFTZ$PROC3 <- as.factor(ifelse(as.character(DFTZ$PROC2)=="LJ_CENS"|as.character(DFTZ$PROC2)=="LJ_MORT"|as.character(DFTZ$PROC2)=="LJ_PROC","LJ",ifelse(as.character(DFTZ$PROC2)=="SAUV_PC"|as.character(DFTZ$PROC2)=="SAUV_LJ"|as.character(DFTZ$PROC3)=="SAUV_CENS","SAUV_MORT",ifelse(as.character(DFTZ$PROC2)=="RJ_LJ"|as.character(DFTZ$PROC3)=="RJ_CENS","RJ_MORT",as.character(DFTZ$PROC2)))))
DFTZ$choice <- DFTZ$PROC3
#B.1. sur typologie des procédures
summary(DFTZ$PROC)
table_proc_annee <- table(DFTZ$PROC,DFTZ$ANNEE)
addmargins(table_proc_annee) # somme colonnes et lignes
prop.table(table_proc_annee,2) #Pourcentage en colonne
#B.2. sur couverture info de bilan
table_proc_bilan <- table(DFTZ$PROC,DFTZ$BILAN_24M)
tabligne_bilan=cbind(addmargins(prop.table(addmargins(table_proc_bilan,1),1),2), c(margin.table(table_proc_bilan,1),sum(table_proc_bilan))) 
colnames(tabligne_bilan)<-c("Financial not available (%)","Financial available (%)","TOTAL","Volume")
tabligne_bilan
#B.3. sur couverture tr eff
table_proc_treff <- table(DFTZ$L_TR_EFF,DFTZ$PROC)
addmargins(table_proc_treff) #
prop.table(table_proc_treff,1)
##B.3.2. sur couverture info de bilan et eff
table_eff_bilan <- table(DFTZ$L_TR_EFF,DFTZ$BILAN_24M, useNA="ifany")
tabligne=cbind(addmargins(prop.table(addmargins(table_eff_bilan,1),1),2), c(margin.table(table_eff_bilan,1),sum(table_eff_bilan))) 
colnames(tabligne)<-c("Financial not available (%)","Financial available (%)","TOTAL","Volume")
tabligne

###### C. Information du nombre d'employés + Bilan dispo
### ATTENTION 
DFTZB <- DFTZ[which(DFTZ$BILAN_24M ==1 & DFTZ$L_TR_EFF !="Unknown" ),] #Avec bilan et Eff >0
### ATTENTION
#C.1. sur typologie des procédures
summary(DFTZB$PROC)
table_proc_annee <- table(DFTZB$PROC,DFTZ$ANNEE)
addmargins(table_proc_annee) # somme colonnes et lignes
prop.table(table_proc_annee,2) #Pourcentage en colonne
#C.2. sur couverture tr eff
table_proc_treff <- table(DFTZB$L_TR_EFF,DFTZB$PROC)
addmargins(table_proc_treff) #
prop.table(table_proc_treff,1)
tabligne_eff=cbind(addmargins(prop.table(addmargins(table_proc_treff,1),1),2), c(margin.table(table_proc_treff,1),sum(table_proc_treff))) 
colnames(tabligne_eff)<-c("LJ (%)","RJ (%)","SAUV (%)","TOTAL","Volume")
tabligne_eff
#C.3. Sur variables financières
DFTZB$TEFENCE <- ifelse((DFTZB$EFF==0 & DFTZB$EFENCE>=0), DFTZB$EFENCE, DFTZB$EFF)
library(doBy)
myfun1 <- function(x){c(M = mean(x,na.rm = TRUE), md=median(x,na.rm = TRUE) ,SD = sd(x,na.rm = TRUE), mis = sum(is.na(x)), nbr =length(x))} # calcul malgré valeurs manquantes
summaryBy( AGE_ENTP +S_EE_B0 + S_FL_B0 + TEFENCE ~ as.factor(PROC), data= DFTZB, FUN= myfun1)
# analyse valr manquanes des var fin : TX_MA_GL+TX_VA+TX_MB_EXP+TX_M_COM+TX_DOB+RENT_B_K_EXP+RENT_N_K_EXP+CAP_GEN_CASH+RENTA_FI+SUR_FI+COUV_IMMO_FP+CRED_BK_COURANT_BFR+CP_VA+PDS_INT+VMC+DET_FOUR+CREA_CLI+DUR_FOUR+DUR_CLI+RENTA_ECO+RES_FIN+RES_EXCEP+PDS_MAS_SAL+SOLDE_COM+LIQUI+CAF+FR+BFR+TRESO_N+ENDET_BRUT+ENDET_NET+TX_ENDET_NET+TX_ENDET_BRUT+CT_ENDET+TX_RENTA_FI_KP+PDS_INT_REV_GLOB+PERS_RRP+PRET_RRP+COMPTES_ASSOCIES+CNAF+RES_HORS_EXP+RRP+STOCKS+CUR_AS_CUR_LI+TRESO_ACT+LN_S_EE_B0+LN_S_FL_B0+LN_BFR+LN_TRESO_N+LN_ENDET_BRUT+LN_ENDET_NET+LN_COMPTES_ASSOCIES+LN_DET_FOUR+LN_CREA_CLI+LN_STOCKS+LN_TRESO_ACT
missing <- function(x){c(mis = 1- sum(is.na(x)) / length(x))} # calcul malgré valeurs manquantes
summaryBy(S_EE_B0 + S_FL_B0 + TX_MA_GL+TX_VA+TX_MB_EXP+TX_M_COM+TX_DOB+RENT_B_K_EXP+RENT_N_K_EXP+CAP_GEN_CASH+RENTA_FI+SUR_FI+COUV_IMMO_FP+CRED_BK_COURANT_BFR+CP_VA+PDS_INT+VMC+DET_FOUR+CREA_CLI+DUR_FOUR+DUR_CLI+RENTA_ECO+RES_FIN+RES_EXCEP+PDS_MAS_SAL+SOLDE_COM+LIQUI+CAF+FR+BFR+TRESO_N+ENDET_BRUT+ENDET_NET+TX_ENDET_NET+TX_ENDET_BRUT+CT_ENDET+TX_RENTA_FI_KP+PDS_INT_REV_GLOB+PERS_RRP+PRET_RRP+COMPTES_ASSOCIES+CNAF+RES_HORS_EXP+RRP+STOCKS+CUR_AS_CUR_LI+TRESO_ACT+LN_S_EE_B0+LN_S_FL_B0+LN_BFR+LN_TRESO_N+LN_ENDET_BRUT+LN_ENDET_NET+LN_COMPTES_ASSOCIES+LN_DET_FOUR+LN_CREA_CLI+LN_STOCKS+LN_TRESO_ACT~ as.factor(PROC), data= DFTZB, FUN= missing)
# analyse corrélation sur var
FIN <- data.frame(DFTZB$TX_MA_GL,DFTZB$TX_VA,DFTZB$TX_MB_EXP,DFTZB$TX_M_COM,DFTZB$TX_DOB,DFTZB$RENT_B_K_EXP,DFTZB$RENT_N_K_EXP,DFTZB$CAP_GEN_CASH,DFTZB$RENTA_FI,DFTZB$SUR_FI,DFTZB$COUV_IMMO_FP,DFTZB$CRED_BK_COURANT_BFR,DFTZB$CP_VA,DFTZB$PDS_INT,DFTZB$VMC,DFTZB$DET_FOUR,DFTZB$CREA_CLI,DFTZB$DUR_FOUR,DFTZB$DUR_CLI,DFTZB$RENTA_ECO,DFTZB$RES_FIN,DFTZB$RES_EXCEP,DFTZB$PDS_MAS_SAL,DFTZB$SOLDE_COM,DFTZB$LIQUI,DFTZB$CAF,DFTZB$FR,DFTZB$BFR,DFTZB$TRESO_N,DFTZB$ENDET_BRUT,DFTZB$ENDET_NET,DFTZB$TX_ENDET_NET,DFTZB$TX_ENDET_BRUT,DFTZB$CT_ENDET,DFTZB$TX_RENTA_FI_KP,DFTZB$PDS_INT_REV_GLOB,DFTZB$PERS_RRP,DFTZB$PRET_RRP,DFTZB$COMPTES_ASSOCIES,DFTZB$CNAF,DFTZB$RES_HORS_EXP,DFTZB$RRP,DFTZB$STOCKS,DFTZB$CUR_AS_CUR_LI,DFTZB$TRESO_ACT,DFTZB$LN_S_EE_B0,DFTZB$LN_S_FL_B0,DFTZB$LN_BFR,DFTZB$LN_TRESO_N,DFTZB$LN_ENDET_BRUT,DFTZB$LN_ENDET_NET,DFTZB$LN_COMPTES_ASSOCIES,DFTZB$LN_DET_FOUR,DFTZB$LN_CREA_CLI,DFTZB$LN_STOCKS,DFTZB$LN_TRESO_ACT)
library(Hmisc)
corfin <- rcorr(as.matrix(FIN), type="spearman")
corfin <- write.table(corfin$r, file = "corfin.csv", sep = ";", row.names = FALSE)

quant <- function(x){c(me=mean(x, na.rm=TRUE), md=median(x, na.rm=TRUE),quant=quantile(x, probs=c(0.25,0.75),na.rm=TRUE), sd=sd(x,na.rm=TRUE), nbr=length(x))}
DFTZ$AFT_FIL <- ifelse(DFTZ$PLAN_RJ==1,"Plan",ifelse(DFTZ$PLAN_CT==1, "CT", ifelse(DFTZ$LIQUID==1, "Liquid", "Clos")))
summaryBy( AGE_PROC ~ AFT_FIL, data= subset(DFTZ), FUN= myfun1)

###################### III. MODELE - DFTZ 1 ########################################################
###### INITALISATION DES DONNEES
DFTZB <- DFTZ[which(as.character(DFTZ$ETAT1)!="CENS"),]  # finalement peu nombreux pour les RJ et les Sauv / Il faudra faire un point !!
DFTZB <- DFTZB[which(DFTZB$BILAN_24M ==1 & DFTZB$L_TR_EFF !="Unknown" ),] #Avec bilan et Eff >0
DFTZB$PROC3 <- as.factor(ifelse(as.character(DFTZB$PROC2)=="LJ_CENS"|as.character(DFTZB$PROC2)=="LJ_MORT"|as.character(DFTZB$PROC2)=="LJ_PROC","LJ",ifelse(as.character(DFTZB$PROC2)=="SAUV_PC"|as.character(DFTZB$PROC2)=="SAUV_LJ"|as.character(DFTZB$PROC3)=="SAUV_CENS","SAUV_MORT",ifelse(as.character(DFTZB$PROC2)=="RJ_LJ"|as.character(DFTZB$PROC3)=="RJ_CENS","RJ_MORT",as.character(DFTZB$PROC2)))))
DFTZB$choice <- DFTZB$PROC3
DFTZB$PCT_PROC <- ifelse(DFTZB$PROC == "LJ", DFTZB$LJ_PCT,ifelse(DFTZB$PROC == "RJ", DFTZB$RJ_PCT,DFTZB$SAUV_PCT))
DFTZB$VOL_PROC <- ifelse(DFTZB$PROC == "LJ", DFTZB$LJ_VOL,ifelse(DFTZB$PROC == "RJ", DFTZB$RJ_VOL,DFTZB$SAUV_VOL))

rm(DFTZ)
# A extraire:
DFTZ_PROC <- DFTZB[,c("I_SIREN","S_TC","ANNEEMOIS","ANNEE","DPT","REGION_NAME","S_NOMENCL","TX_CHOM_NAT","TX_CHOM","TX_CHOM_MOY","SAUV_VOL","LJ_VOL","TC_VOL","TX_CREA","PIB","FBCF_ENTP_NF","FJ_2","NAF2","AGE_ENTP","TR_EFF_ENT","EFENCE","A_NBR_ETAB","I_MONOACT","I_TCD","AGEBILAN","S_EE_B0","S_FL_B0","EFF","TX_MA_GL","TX_VA","TX_MB_EXP","TX_M_COM","TX_DOB","RENT_B_K_EXP","RENT_N_K_EXP","CAP_GEN_CASH","RENTA_FI","SUR_FI","COUV_IMMO_FP","CRED_BK_COURANT_BFR","CP_VA","PDS_INT","VMC","DET_FOUR","CREA_CLI","DUR_FOUR","DUR_CLI","RENTA_ECO","RES_FIN","RES_EXCEP","PDS_MAS_SAL","SOLDE_COM","LIQUI","CAF","FR","BFR","TRESO_N","ENDET_BRUT","ENDET_NET","TX_ENDET_NET","TX_ENDET_BRUT","CT_ENDET","TX_RENTA_FI_KP","PDS_INT_REV_GLOB","PERS_RRP","PRET_RRP","COMPTES_ASSOCIES","CNAF","RES_HORS_EXP","RRP","STOCKS","CUR_AS_CUR_LI","TRESO_ACT","LN_S_EE_B0","LN_S_FL_B0","LN_BFR","LN_TRESO_N","LN_ENDET_BRUT","LN_ENDET_NET","LN_COMPTES_ASSOCIES","LN_DET_FOUR","LN_CREA_CLI","LN_STOCKS","LN_TRESO_ACT","RJ_VOL_PCT","SAUV_VOL_PCT","LJ_VOL_PCT","ECHEVINAGE","PROC","TEFF","FJ","NAF","RJ_PCT","LJ_PCT","SAUV_PCT","ECART_TX_CHOM","CREA_VAR36M","CREA_VAR24M","AGE_ETAT1","ETAT1","PROC2","PROC3","choice","PCT_PROC","VOL_PROC")]
#DFTZ_PROC$sample <- runif(length(DFTZ_PROC$I_SIREN), 0, 1) #création de l'échantillon
#DFTZ_PROC <- DFTZ_PROC[which(DFTZ_PROC$sample <= 0.5),]
write.table(DFTZ_PROC, file = "DFTZB.csv", sep = ";",  row.names = FALSE)
################################
# test var fin
summaryBy(TX_MA_GL+TX_VA+COUV_IMMO_FP+CP_VA+DUR_FOUR+DUR_CLI+RENTA_ECO+LIQUI+ENDET_BRUT+ENDET_NET+TX_ENDET_NET+TX_ENDET_BRUT+CT_ENDET+CUR_AS_CUR_LI+TRESO_ACT+LN_S_EE_B0+LN_S_FL_B0+LN_BFR+LN_TRESO_N+LN_ENDET_BRUT+LN_ENDET_NET+LN_DET_FOUR+LN_CREA_CLI+LN_TRESO_ACT~ as.factor(PROC), data= DFTZB, FUN= missing)
library(nnet)
DFTZB$PROC2 <- relevel(DFTZB$PROC, ref = "LJ")
multin <- multinom(PROC ~ 0 | AGE_ENTP + TR_EFF_ENT + LN_S_FL_B0 + LN_S_EE_B0 + NAF1 + S_TC + FJ_2 | 0, data = TEST)
z <- summary(multin)$coefficients/summary(multin)$standard.errors
 
### MODELE - DFTZ 2 avec nested model
# to check for multicolinearity
library(MASS)
lm.obj <- lm((PROC)~ LN_S_EE_B0 + PCT_PROC + AGE_ENTP + S_TC,data=DFTZB)
vif.lm <- vif(lm.obj)
vif.lm
# Deleting missing values
TEST <- na.omit(DFTZB[,c("I_SIREN","choice","PROC","ETAT1","ANNEE","NAF1",'AGE_ENTP',"LN_S_EE_B0","S_TC","FJ_2","PCT_PROC")])


library(mlogit)
ml.DFTZ <- mlogit(PROC ~ PCT_PROC | AGE_ENTP + LN_S_EE_B0 + NAF1 + FJ_2 + S_TC, DFTZB, id.var="I_SIREN",shape ="long") # ne fonctionne pas après 3 heures



#pr instant suppr des cens
DFTZB$PROC2 <- as.factor(paste(as.character(DFTZB$PROC), as.character(DFTZB$ETAT1), sep="_"))
DFTZB$PROC3 <- as.factor(ifelse(as.character(DFTZB$PROC2)=="LJ_CENS"|as.character(DFTZB$PROC2)=="LJ_MORT","LJ",ifelse(as.character(DFTZB$PROC2)=="SAUV_PC"|as.character(DFTZB$PROC2)=="SAUV_LJ","SAUV_MORT",ifelse(as.character(DFTZB$PROC2)=="RJ_LJ","RJ_MORT",as.character(DFTZB$PROC2)))))
DFTZB <- DFTZB[which(as.character(DFTZB$ETAT1)!="CENS"),]  # finalement peu nombreux pour les RJ et les Sauv / Il faudra faire un point !!
DFTZB$PROC3 <- as.factor(ifelse(as.character(DFTZB$PROC3)=="LJ_PROC","LJ",ifelse(as.character(DFTZB$PROC3)=="SAUV_CENS","SAUV_MORT",ifelse(as.character(DFTZB$PROC3)=="RJ_CENS","RJ_MORT",as.character(DFTZB$PROC3)))))
DFTZB$choice <- DFTZB$PROC3


#création des "uniques"
length(unique(DFTZB$I_SIREN)) #DFTZ si doublons
DFTZB$I_SIREN <- paste(as.character(DFTZB$I_SIREN), as.character(DFTZB$ANNEE), sep="")

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
DFTZ$TEFF <- as.integer(as.character(DFTZ$TR_EFF_ENT))
DFTZ$L_TR_EFF <- as.ordered(ifelse(is.na(DFTZ$TEFF )==TRUE,0,ifelse(DFTZ$TEFF == 0, 1, ifelse(DFTZ$TEFF > 0 & DFTZ$TEFF < 10 ,2,  ifelse(DFTZ$TEFF > 10 & DFTZ$TEFF <= 12 , 3, ifelse(DFTZ$TEFF > 20 & DFTZ$TEFF <= 31,4, 5 ))))))
DFTZB <- DFTZ[which(DFTZ$BILAN_24M ==1 & DFTZ$L_TR_EFF > 0 ),] #Avec bilan et Eff >0
DFTZB <- DFTZB[which(as.integer(as.character(DFTZB$ANNEE)) <= 2012),] # Enlever infos de moins de deux ans

DFTZ_PROC <- DFTZB[,c("I_SIREN","date_ouverture","PROC","PROC3","ETAT1","choice","AGE_ETAT1","ANNEE","I_FJ","FJ_2","TX_CHOM_NAT","TX_CHOM","TX_CREA","S_TC","RJ_VOL","LJ_VOL","SAUV_VOL","TC_VOL","EFENCE","I_FJ","FJ_1","NAF","NAF2","NAF1","AGE_ENTP","L_TR_EFF","AGE_DIR","R_NBR_DIR","A_NBR_ETAB","AGEBILAN","BILAN_24M","BILAN_12M","S_EE_B0","S_FL_B0","EFF","RENTA_ECO","DUR_FOUR","DUR_CLI","TX_ENDET_NET","PERS_RRP","PRET_RRP","RJ_PCT","LJ_PCT","SAUV_PCT","CREA_VAR36M","TX_ENDET_BRUT_MOY","TX_ENDET_NET_MOY","PRET_RRP_MOYEN",  "PERS_RRP_MOYEN","CT_ENDET_MOY","VAR_CA_MOY","VAR_VA_MOY","TX_MA_MOY","BFR_MOY","DEL_CLI_MOY","DEL_FOUR_MOY","CREA_VAR36M", "CREA_VAR24M")]

DFTZ_PROC$PROC_ALT <- ifelse(DFTZ_PROC$PROC == "LJ", 1,ifelse(DFTZ_PROC$PROC == "RJ", 2, 3))
DFTZ_PROC$PCT_PROC <- ifelse(DFTZ_PROC$PROC == "LJ", DFTZ_PROC$LJ_PCT,ifelse(DFTZ_PROC$PROC == "RJ", DFTZ_PROC$RJ_PCT,DFTZ_PROC$SAUV_PCT))
DFTZ_PROC$ETAPE_ALT <- as.factor(ifelse(DFTZ_PROC$choice == "LJ", 1,ifelse(DFTZ_PROC$choice == "RJ_MORT", 2,ifelse(DFTZ_PROC$choice == "RJ_PC", 3,ifelse(DFTZ_PROC$choice == "RJ_PLAN", 4,ifelse(DFTZ_PROC$choice == "SAUV_MORT", 5,ifelse(DFTZ_PROC$choice == "SAUV_CONV", 6, 7)))))))

#Code pour stata
levels(DFTZ_PROC$NAF)=c(1:18) # Conversion NAF

# Extraction
#DFTZ_PROC$sample <- runif(length(DFTZ_PROC$I_SIREN), 0, 1) #création de l'échantillon
#DFTZ_PROC <- DFTZ_PROC[which(DFTZ_PROC$sample <= 0.2),]
write.table(DFTZ_PROC, file = "DFTZ_PROC.csv", sep = ";",  row.names = FALSE, na=".")

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
ml.DFTZ <- mlogit(choice ~ 0 | AGE_ENTP + EFENCE + S_EE_B0 + NAF1 + FJ_2, DFTZ_NL) # ne fonctionne pas après 3 heures

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




