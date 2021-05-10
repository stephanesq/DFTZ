#### On tente ici d'avancer sur les régressions pour le modèle 


# 1. Garder le plus d'observations donc éteindre les variables éco
#write.table(DFTZB, file = "20141112_DFTZB.csv", sep=";" , dec = ",")
DFTZB2 <- DFTZB[,c("I_SIREN","S_TC","TX_CHOM","VAR_PIB_TRIM","CREA_VAR36M","L_TR_EFF","PROC","TX_MB_EXP","LN_S_EE_B0","NAF1","FJ","NAF","AGE_ENTP","LN_IMMO","ANNEE","CUR_AS_CUR_LI","TC_VOL","RJ_VOL_PCT")]
DFTZB2 <- DFTZB2[complete.cases(DFTZB2),]
# Gestion des outliers pr les ratios en récupérent les centiles
DFTZB2$N_CUR_AS_CUR_LI <- ifelse(DFTZB2$CUR_AS_CUR_LI<quantile(DFTZB2$CUR_AS_CUR_LI, probs = c(0.01)),quantile(DFTZB2$CUR_AS_CUR_LI, probs = c(0.01)),ifelse(DFTZB2$CUR_AS_CUR_LI>quantile(DFTZB2$CUR_AS_CUR_LI, probs = c(0.99)),quantile(DFTZB2$CUR_AS_CUR_LI, probs = c(0.99)),DFTZB2$CUR_AS_CUR_LI)) #C1 C99
DFTZB2$N_TX_MB_EXP <- ifelse(DFTZB2$TX_MB_EXP<quantile(DFTZB2$TX_MB_EXP, probs = c(0.01)),quantile(DFTZB2$TX_MB_EXP, probs = c(0.01)),ifelse(DFTZB2$TX_MB_EXP>quantile(DFTZB2$TX_MB_EXP, probs = c(0.99)),quantile(DFTZB2$TX_MB_EXP, probs = c(0.99)),DFTZB2$TX_MB_EXP)) #C1 et C99

#Gestion des var categorielles au cas où valeurs manquantes
DFTZB2$TC3 <- factor(DFTZB2$S_TC)
levels(DFTZB2$TC3) <-  c(1:length(unique(DFTZB2$TC3)))

#test changement factor des tr eff nv test <2 ; <10 ; >= 10
levels(DFTZB2$L_TR_EFF) <- c("1","1","2","3","3","3")
DFTZB2$PROC <- relevel(DFTZB2$PROC, ref = "RJ") 
DFTZB2$ANNEE2 <- factor(DFTZB2$ANNEE)
levels(test$ANNEE2) <-  c(1:length(unique(DFTZB2$ANNEE2)))
DFTZB2$NAF2 <- factor(DFTZB2$NAF)
levels(DFTZB2$NAF2) <-  c(1:length(unique(DFTZB2$NAF2)))

library(nnet)
ml.tc <- multinom(PROC ~ AGE_ENTP + ANNEE2 + NAF2 + L_TR_EFF  + VAR_PIB_TRIM + TX_CHOM + CREA_VAR36M + LN_S_EE_B0 + LN_IMMO + N_CUR_AS_CUR_LI +N_TX_MB_EXP + TC3+ TC_VOL+RJ_VOL_PCT, data = DFTZB2, maxit = 200)
alltc_coeff <- cbind(summary(ml.tc)$coefficients,(1 - pnorm(abs(summary(ml.tc)$coefficients/summary(ml.tc)$standard.errors), 0, 1)) * 2 )
write.table(alltc_coeff, file = "20141219_DFTZ_alltc_coeff_TC.csv", sep=";" , dec = ",")


#On lance une première fois pr TC = 1 et pr créer la base all_coeff
test <- DFTZB2[which(as.integer(as.character(DFTZB2$TC3))==1),]
test$L_TR_EFF2 <- factor(test$L_TR_EFF)
test$ANNEE2 <- factor(test$ANNEE)
levels(test$ANNEE2) <-  c(1:length(unique(test$ANNEE2)))
test$NAF2 <- factor(test$NAF)
levels(test$NAF2) <-  c(1:length(unique(test$NAF2)))
levels(test$L_TR_EFF2) <-  c(1:length(unique(test$L_TR_EFF2)))
ml.tc <- multinom(PROC ~ AGE_ENTP + ANNEE2 + NAF2 + L_TR_EFF2  + VAR_PIB_TRIM + TX_CHOM + CREA_VAR36M + LN_S_EE_B0 + LN_IMMO + N_CUR_AS_CUR_LI +N_TX_MB_EXP + TC_VOL+RJ_VOL_PCT, data = test, maxit = 200)
all_coeff <- cbind(summary(ml.tc)$coefficients,(1 - pnorm(abs(summary(ml.tc)$coefficients/summary(ml.tc)$standard.errors), 0, 1)) * 2 )
all_coeff <- data.frame(all_coeff,TC = 1)

# Pb ac certains TC : 1, 3, 13, 15, 18, 19, 23, 25, 31, 32, 33, 37, 38, 44, 45,51 , 52, 53,54, 61, 63, 64, 69, 75, 79, 80, 84, 87, 88,98,  99, 102, 108, 114, 115, 117,118, 126, 129, 136, 137, 140,141
lis <- c(1,2,4,5,6,7,8,9,10,11,12,14,16,17,20,21,22,24,26,27,28,29,30,34,35,36,39,40,41,42,43,46,47,48,49,50)
lis1 <- c(55,56,57,58,59,60,62,65,66,67,68,70,71,72,73,74,76,77,78,81,82,83,85,86,89,90,91,92,93,94,95,96,97)
lis2 <- c(100,101,103,104,105,106,107,109,110,111,112,113)
lis3 <- c(117,119,120,121,122,123,124,125,127,128,130,131,132,133,134,135,138,139)

for (i in 35:length(unique(DFTZB2$ANNEE2))){
  test <- DFTZB2[which(as.integer(as.character(DFTZB2$TC3))==i),]
  test$L_TR_EFF2 <- factor(test$L_TR_EFF)
  levels(test$L_TR_EFF2) <-  c(1:length(unique(test$L_TR_EFF2)))
  test$ANNEE2 <- factor(test$ANNEE)
  levels(test$ANNEE2) <-  c(1:length(unique(test$ANNEE2)))
  test$NAF2 <- factor(test$NAF)
  levels(test$NAF2) <-  c(1:length(unique(test$NAF2)))
  ml.tc <- multinom(PROC ~ AGE_ENTP + ANNEE2 + NAF2 + L_TR_EFF2  + VAR_PIB_TRIM + TX_CHOM + CREA_VAR36M + LN_S_EE_B0 + LN_IMMO + N_CUR_AS_CUR_LI +N_TX_MB_EXP+ TC_VOL+RJ_VOL_PCT, data = test, maxit = 200)
  coeff <- cbind(summary(ml.tc)$coefficients,(1 - pnorm(abs(summary(ml.tc)$coefficients/summary(ml.tc)$standard.errors), 0, 1)) * 2 )
  coeff <- data.frame(coeff,TC = i)
  all_coeff <- rbind(all_coeff,coeff)
  assign(paste("ml.tc",i,sep="_"),ml.tc,envir=.GlobalEnv) }

#CMT: certaines bases étaient illisibles
#CMT: j'ai relancé une procédure pour l'une de ses bases (13) et elles sont toutes devenues visibles ..
## Je teste pour celles qui passent pas
test <- DFTZB2[which(as.integer(as.character(DFTZB2$TC3))==141),]
test$L_TR_EFF2 <- factor(test$L_TR_EFF)
levels(test$L_TR_EFF2) <-  c(1:length(unique(test$L_TR_EFF2)))
test$ANNEE2 <- factor(test$ANNEE)
levels(test$ANNEE2) <-  c(1:length(unique(test$ANNEE2)))
test$NAF2 <- factor(test$NAF)
levels(test$NAF2) <-  c(1:length(unique(test$NAF2)))
ml.tc <- multinom(PROC ~ AGE_ENTP + ANNEE2 + NAF2 + L_TR_EFF2  + VAR_PIB_TRIM + TX_CHOM + CREA_VAR36M + LN_S_EE_B0 + LN_IMMO + N_CUR_AS_CUR_LI +N_TX_MB_EXP+ TC_VOL+RJ_VOL_PCT, data = test, maxit = 200)
coeff <- cbind(summary(ml.tc)$coefficients,(1 - pnorm(abs(summary(ml.tc)$coefficients/summary(ml.tc)$standard.errors), 0, 1)) * 2 )
coeff <- data.frame(coeff,TC = 141)
all_coeff <- rbind(all_coeff,coeff)

write.table(all_coeff, file = "20141223_DFTZ_allcoeff_byTC.csv", sep=";" , dec = ",")
#table de correspondance pour les TC
corresp_tc <- DFTZB2[,c("TC3","S_TC")]
corresp_tc<- unique(corresp_tc)
write.table(corresp_tc, file = "20141223_corresp_tc.csv", sep=";" , dec = ",", row.names = FALSE)

#### TEST SOLUTION
# j'essaie de créer une nouvelle table Il faut déclarer une table avec tous les inputs (et donc une trame gnle) et la remplir
# Je sais pas comment faire
# Pb ac certains TC : 1, 3, 13, 15, 18, 19, 23, 25, 31, 32, 33, 37, 38, 44, 45,51 , 52, 53,54, 61, 63, 64, 69, 75, 79, 80, 84, 87, 88,98,  99, 102, 108, 114, 115, 117,118, 126, 129, 136, 137, 140,141
test <- DFTZB2[which(as.integer(as.character(DFTZB2$TC3))==1),]
test$L_TR_EFF2 <- factor(test$L_TR_EFF)
test$ANNEE2 <- factor(test$ANNEE)
levels(test$ANNEE2) <-  c(1:length(unique(test$ANNEE2)))
test$NAF2 <- factor(test$NAF)
levels(test$NAF2) <-  c(1:length(unique(test$NAF2)))
levels(test$L_TR_EFF2) <-  c(1:length(unique(test$L_TR_EFF2)))
ml.tc <- multinom(PROC ~ AGE_ENTP + ANNEE2 + NAF2 + L_TR_EFF2  + VAR_PIB_TRIM + TX_CHOM + CREA_VAR36M + LN_S_EE_B0 + LN_IMMO + N_CUR_AS_CUR_LI +N_TX_MB_EXP + TC_VOL+RJ_VOL_PCT, data = test, maxit = 200)
all_coeff_bis <- cbind(summary(ml.tc)$coefficients,(1 - pnorm(abs(summary(ml.tc)$coefficients/summary(ml.tc)$standard.errors), 0, 1)) * 2 )
all_coeff_bis <- data.frame(all_coeff_bis,TC = 1)

lisbis <- c(1,   15, 18, 19, 23, 25, 31, 32, 33, 37, 38, 44, 45,51 , 52, 53,54, 61, 63, 64, 69, 75, 79, 80, 84, 87, 88,98,  99, 102, 108, 114, 115, 117,118, 126, 129, 136, 137, 140,141)
for (i in lisbis){
  test <- DFTZB2[which(as.integer(as.character(DFTZB2$TC3))==i),]
  test$L_TR_EFF2 <- factor(test$L_TR_EFF)
  levels(test$L_TR_EFF2) <-  c(1:length(unique(test$L_TR_EFF2)))
  test$ANNEE2 <- factor(test$ANNEE)
  levels(test$ANNEE2) <-  c(1:length(unique(test$ANNEE2)))
  test$NAF2 <- factor(test$NAF)
  levels(test$NAF2) <-  c(1:length(unique(test$NAF2)))
  ml.tc <- multinom(PROC ~ AGE_ENTP + ANNEE2 + NAF2 + L_TR_EFF2  + VAR_PIB_TRIM + TX_CHOM + CREA_VAR36M + LN_S_EE_B0 + LN_IMMO + N_CUR_AS_CUR_LI +N_TX_MB_EXP+ TC_VOL+RJ_VOL_PCT, data = test, maxit = 200)
  coeff <- cbind(summary(ml.tc)$coefficients,(1 - pnorm(abs(summary(ml.tc)$coefficients/summary(ml.tc)$standard.errors), 0, 1)) * 2 )
  coeff <- data.frame(coeff,TC = i)
  all_coeff_bis <- rbind(all_coeff_bis,coeff)
  assign(paste("ml.tc",i,sep="_"),ml.tc,envir=.GlobalEnv) }
# ne fonctionne pas avec 3, 13,




################### Extraire coef, s.e. et p
######
se <- summary(ml.tc_48)$coefficients/summary(ml.tc_48)$standard.errors
p <- (1 - pnorm(abs(se), 0, 1)) * 2 
# rajouter variable dans data frame
test3 <- data.frame(test3,TC = 28)

### Reshaping 
setwd('/Users/stephaneesquerre/Desktop/Data')
library(reshape)
CHOM_DPT <- read.csv2("CHOM2.csv", sep = ";")
chom <- melt(CHOM_DPT, id.vars="ANNEEMOIS")
write.table(chom, file = "chom2.csv", sep=";" , dec = ",", row.names = FALSE)

### Code ultra utile pour charger des variables au nom de fichiers csv 
 # set a directory
   setwd( '~/myworkingdirectory' )
 #
   # get a file list and strip off the csv to turn the filenames into variable names
   # note this assumes all files are csvs; you could filter files by the files that match if you needed
   files <- list.files()
 names <- gsub(pattern='\\.csv$', '', files, ignore.case=T)
 
   for( i in 1:length(names)){
      a <- paste(names[i], ' <- read.csv( file=\'', files[i], '\', header=T, sep=\',\')', sep='')
      # print( a )
        eval(parse( text=a ))
     }

# On teste boucle avec noms des variables
valeur = evalin('base',['ml.tc_' num2str(24) ]);
eval(['maxtab' num2str(i) '=valeur']);

#######
#On lance une première fois pr TC = 13 et pr créer la base all_coeff
test <- DFTZB2[which(as.integer(as.character(DFTZB2$TC3))==13),]
test$L_TR_EFF2 <- factor(test$L_TR_EFF)
levels(test$L_TR_EFF2) <-  c(1:length(unique(test$L_TR_EFF2)))
ml.tc <- multinom(PROC ~ AGE_ENTP + L_TR_EFF2  + PIB + TX_CHOM + CREA_VAR36M + LN_S_EE_B0 + LN_IMMO + N_CUR_AS_CUR_LI + TC_VOL+RJ_VOL_PCT, data = test)
all_coeff <- cbind(summary(ml.tc)$coefficients,(1 - pnorm(abs(summary(ml.tc)$coefficients/summary(ml.tc)$standard.errors), 0, 1)) * 2 )
all_coeff <- data.frame(all_coeff,TC = 13)

# Pb ac certains TC : 15,
for (i in c(16:length(unique(DFTZB2$TC3)))){
  test <- DFTZB2[which(as.integer(as.character(DFTZB2$TC3))==i),]
  test$L_TR_EFF2 <- factor(test$L_TR_EFF)
  levels(test$L_TR_EFF2) <-  c(1:length(unique(test$L_TR_EFF2)))
  #test$ANNEE2 <- factor(test$ANNEE)
  #levels(test$ANNEE2) <-  c(1:length(unique(test$ANNEE2)))
  #test$NAF2 <- factor(test$NAF)
  #levels(test$NAF2) <-  c(1:length(unique(test$NAF2)))
  ml.tc <- multinom(PROC ~ AGE_ENTP + L_TR_EFF2  + PIB + TX_CHOM + CREA_VAR36M + LN_S_EE_B0 + LN_IMMO + N_CUR_AS_CUR_LI + TC_VOL+RJ_VOL_PCT, data = test)
  coeff <- cbind(summary(ml.tc)$coefficients,(1 - pnorm(abs(summary(ml.tc)$coefficients/summary(ml.tc)$standard.errors), 0, 1)) * 2 )
  coeff <- data.frame(coeff,TC = i)
  all_coeff <- rbind(all_coeff,coeff)
  assign(paste("ml.tc",i,sep="_"),ml.tc,envir=.GlobalEnv) }
#CMT: certaines bases étaient illisibles
#CMT: j'ai relancé une procédure pour l'une de ses bases (13) et elles sont toutes devenues visibles ..
## DEBUG : j'essaie de rattraper ici si pb sur certains TC : par ex, 15-16 pas passé ..
test <- DFTZB2[which(as.integer(as.character(DFTZB2$TC3))==16),]
test$L_TR_EFF2 <- factor(test$L_TR_EFF)
levels(test$L_TR_EFF2) <-  c(1:length(unique(test$L_TR_EFF2)))
ml.tc <- multinom(PROC ~ AGE_ENTP + L_TR_EFF2  + PIB + TX_CHOM + CREA_VAR36M + LN_S_EE_B0 + LN_IMMO + N_CUR_AS_CUR_LI + TC_VOL+RJ_VOL_PCT, data = test)
coeff <- cbind(summary(ml.tc)$coefficients,(1 - pnorm(abs(summary(ml.tc)$coefficients/summary(ml.tc)$standard.errors), 0, 1)) * 2 )
coeff <- data.frame(coeff,TC = 16)
all_coeff <- rbind(all_coeff,coeff)
assign(paste("ml.tc",15,sep="_"),ml.tc,envir=.GlobalEnv)


###########################
# Ancien Début du code
#######################
# 1. Garder le plus d'observations donc éteindre les variables éco
table(DFTZB$ANNEE)
DFTZB2 <- DFTZB[,c("I_SIREN","S_TC","L_TR_EFF","PROC","LN_S_EE_B0","NAF1","FJ","NAF","AGE_ENTP","LN_IMMO","ANNEE","LN_DET_FOUR","PDS_MAS_SAL","CUR_AS_CUR_LI","TC_VOL","RJ_VOL_PCT")]
DFTZB2 <- DFTZB2[complete.cases(DFTZB2),]
table(DFTZB2$ANNEE)

# Gestion des outliers pr les ratios en récupérent les centiles
DFTZB2$N_CUR_AS_CUR_LI <- ifelse(DFTZB2$CUR_AS_CUR_LI<quantile(DFTZB2$CUR_AS_CUR_LI, probs = c(0.01)),quantile(DFTZB2$CUR_AS_CUR_LI, probs = c(0.01)),DFTZB2$CUR_AS_CUR_LI) #C1
DFTZB2$N_CUR_AS_CUR_LI <- ifelse(DFTZB2$CUR_AS_CUR_LI>quantile(DFTZB2$CUR_AS_CUR_LI, probs = c(0.99)),quantile(DFTZB2$CUR_AS_CUR_LI, probs = c(0.99)),DFTZB2$CUR_AS_CUR_LI) #C99
DFTZB2$N_PDS_MAS_SAL <- ifelse(DFTZB2$PDS_MAS_SAL<quantile(DFTZB2$PDS_MAS_SAL, probs = c(0.01)),quantile(DFTZB2$PDS_MAS_SAL, probs = c(0.01)),DFTZB2$PDS_MAS_SAL) #C1
DFTZB2$N_PDS_MAS_SAL <- ifelse(DFTZB2$PDS_MAS_SAL>quantile(DFTZB2$PDS_MAS_SAL, probs = c(0.99)),quantile(DFTZB2$PDS_MAS_SAL, probs = c(0.99)),DFTZB2$PDS_MAS_SAL) #C99

#Gestion des var categorielles au cas où valeurs manquantes
DFTZB2$TC3 <- factor(DFTZB2$S_TC)
levels(DFTZB2$TC3) <-  c(1:length(unique(DFTZB2$TC3)))
DFTZB2$ANNEE2 <- factor(DFTZB2$ANNEE)
levels(DFTZB2$ANNEE2) <-  c(1:length(unique(DFTZB2$ANNEE2)))
DFTZB2$NAF2 <- factor(DFTZB2$NAF)
levels(DFTZB2$NAF2) <-  c(1:length(unique(DFTZB2$NAF2)))
DFTZB2$FJ2 <- factor(DFTZB2$FJ)
levels(DFTZB2$FJ2) <-  c(1:length(unique(DFTZB2$FJ2)))

#test changement factor des tr eff
levels(DFTZB2$L_TR_EFF) <- c("1","1","2","3","4","4")

# Donnés de wide en long
DFTZB_LG2 <- mlogit.data(DFTZB2,shape="wide",choice="PROC")
# test facile sur factor : table(DFTZB2$PROC,DFTZB2$ANNEE)

# REPRENDRE LES TC
for (i in c(1:length(unique(DFTZB2$TC3)))){
  test <- DFTZB2[which(as.integer(as.character(DFTZB2$TC3))==i),]
  test$L_TR_EFF2 <- factor(test$L_TR_EFF)
  levels(test$L_TR_EFF2) <-  c(1:length(unique(test$L_TR_EFF2)))
  test2 <- mlogit.data(test,shape="wide",choice="PROC")
  ml.tc <- mlogit(PROC ~ 0 | AGE_ENTP + L_TR_EFF2 + LN_S_EE_B0 + LN_IMMO + N_CUR_AS_CUR_LI + TC_VOL+RJ_VOL_PCT, data = test2) 
  assign(paste("ml.tc",i,sep="_"),ml.tc,envir=.GlobalEnv) }

#autre package, nnet

,"TR_EFF_ENT"


