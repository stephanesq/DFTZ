rm(list=ls()) #Tout
dev.off() #fermeture des fenetres graphiques ouvertes
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
library(reshape2)
#COMPLET : DFTZ <- DFTZ[,c("I_SIREN","DPT","CODE_REGION","I_FJ","FJ_1","NAF2","NAF1","AGE_ENTP","TR_EFF_ENT","EFENCE","A_NBR_ETAB","I_ORIGINE","I_MONOACT","I_TCD","DATE_OUVERTURE","RJ","SAUV","LJ","DATE_PLAN","PLAN","DATE_LIQUID","LIQUID","DATE_CONV","CONV_RJ","DATE_PLAN_CT","PLAN_CT","DATE_MORT","MORT","CD_MORT","DATE_PLAN_CESS","P_CESSION","DATE_CL_CT","CL_CESSION","DATE_PLAN_RJ","PLAN_RJ","S_TC","S_NOMENCL","RJ_VOL","SAUV_VOL","LJ_VOL","TC_VOL","AGE_PLAN_LIQUID","AGE_PLAN_MORT","FAILURE","AGE_FAILURE","FAILURE_12M","FAILURE_24M","FAILURE_36M","RJ_VOL_PCT","SAUV_VOL_PCT","LJ_VOL_PCT","ECHEVINAGE","TX_CHOM_NAT","TX_CHOM","TX_CHOM_MOY","CHOM_BAD","CLIM_AFF","INDIC_RETOUR","TX_CREA","TX_CREA_MOY","PIB","FBCF_ENTP_NF","AGEBILAN","BILAN_24M","BILAN_12M","S_DT_CLO_B0","S_EE_B0","S_FL_B0","EFF","TR_EFF_BILAN","TX_MA_GL","TX_VA","TX_MB_EXP","TX_M_COM","TX_DOB","RENT_B_K_EXP","RENT_N_K_EXP","CAP_GEN_CASH","RENTA_FI","SUR_FI","COUV_IMMO_FP","CRED_BK_COURANT_BFR","CP_VA","PDS_INT","VMC","DET_FOUR","CREA_CLI","DUR_FOUR","DUR_CLI","RENTA_ECO","RES_FIN","RES_EXCEP","PDS_MAS_SAL","SOLDE_COM","LIQUI","CAF","FR","BFR","TRESO_N","ENDET_BRUT","ENDET_NET","TX_ENDET_NET","TX_ENDET_BRUT","CT_ENDET","TX_RENTA_FI_KP","PDS_INT_REV_GLOB","PERS_RRP","PRET_RRP","COMPTES_ASSOCIES","CNAF","RES_HORS_EXP","RRP","STOCKS","CUR_AS_CUR_LI","TRESO_ACT","IMMO","LN_S_EE_B0","LN_S_FL_B0","LN_BFR","LN_TRESO_N","LN_ENDET_BRUT","LN_ENDET_NET","LN_COMPTES_ASSOCIES","LN_DET_FOUR","LN_CREA_CLI","LN_STOCKS","LN_TRESO_ACT","LN_IMMO")]
#####################################################################################################################
#####################################################################################################################
#####################################################################################################################
## chargement base
setwd("/Users/stephaneesquerre/Documents/LA Thèse/Recherche/Dont feed the zombies/DATA")

#####################
##################### Données du Ministere

TI2011 <- readOGR(dsn="TI2011.tab",layer="TI2011")
#write.table(TI2011[,c("Num_TI_2011","LibComSiege_TI")], file = "ti_ministere.csv", row.names = FALSE, sep=";")
ti_ministere <- read.csv2("ti_ministere.csv", sep = ";", na="NA")
ti_ministere <- ti_ministere[!is.na(ti_ministere$num_TC)==TRUE,]
tc_ti <- merge(TI2011[,c("Num_TI_2011")], ti_ministere, by=c("Num_TI_2011"))
tc_ti <- tc_ti[is.na(tc_ti$num_TC)==FALSE,]
# Convert SpatialPolygons to data frame
tc_ti.df <- as(tc_ti, "data.frame")
tc_ti.shp <- spChFIDs(tc_ti, as.character(tc_ti.df$Num_TI_2011))

ti2 <- unionSpatialPolygons(tc_ti.shp, as.character(tc_ti.shp$num_TC))
ti2.df <- as(tc_ti.shp, "data.frame")
ti2.id <- ti2.df[!duplicated(ti2.df[,c('num_TC')]),]
row.names(ti2.id) <- as.character(ti2.id$num_TC) 
ti2.shp <- SpatialPolygonsDataFrame(ti2, ti2.id)
ti2.shp <- spTransform (ti2.shp, CRS ("+init=epsg:2154") )

plot(ti2.shp)
plot(ti2.shp[ti2.shp$Exploitable==1,],add=TRUE,col="red")
text(ti2.shp, ti2.shp$num_TC)

# intersect from raster package
villes_ti <- intersect(ti2.shp[,c("Num_TI_2011","num_TC")], commune[,c("INSEE_COM")])
write.table(villes_ti[,c("Num_TI_2011","num_TC","INSEE_COM")], file = "ti_tc_ville.csv", row.names = FALSE, sep=";")


#####################
##################### Representation de cartes avec des stats
TC2010 <- readOGR(dsn="TC2010.tab",layer="TC2010")
#write.table(TC2010[,c("Lib_TC_maj")], file = "Lib_TC_maj.csv", row.names = FALSE, sep=";")
Lib_TC_maj <- read.csv2("Lib_TC_maj.csv", sep = ";", na="NA")
TC2010 <- merge(TC2010, Lib_TC_maj, by=c("Lib_TC_maj"))
TC2010 <- TC2010[-1,]

myfun6 <- function(x){c(m = mean(x,na.rm = TRUE))}#,md = median(x,na.rm = TRUE), s=sum(x,na.rm = TRUE)
DFTZ4$insuff_actif_pct_RJ <- ifelse(DFTZ4$RJ==0,NA, DFTZ4$insuff_actif_pct)
DFTZ4$insuff_actif_pct_LJ <- ifelse(DFTZ4$RJ==1,NA, DFTZ4$insuff_actif_pct)
moy_tcabs <- summaryBy( insuff_actif_pct_RJ + insuff_actif_pct_LJ  + RJ  + insuff_actif_LJ ~  as.factor(ANNEE)+ as.factor(num_TC)+ as.factor(num_TCABS), data= DFTZ4[which(as.numeric(as.character(DFTZ4$ANNEE))>=2008 & as.numeric(as.character(DFTZ4$ANNEE))<=2012),], FUN= myfun6) #as.factor(ANNEEMOISMOIS) + as.factor(SEM) +
moy_tcabs2 <- summaryBy( insuff_actif_pct_RJ + insuff_actif_pct_LJ  + RJ  + insuff_actif_LJ ~  as.factor(ANNEE)+ as.factor(num_TCABS), data= DFTZ4[which(as.numeric(as.character(DFTZ4$ANNEE))>=2008 & as.numeric(as.character(DFTZ4$ANNEE))<=2012),], FUN= myfun6) #as.factor(ANNEEMOISMOIS) + as.factor(SEM) +
#moy_tcabs$RJ_PCT <- moy_tcabs$RJ.s/moy_tcabs$PCL.s
#moy_tcabs <- summaryBy( insuff_actif_pct_RJ.m + insuff_actif_pct_LJ.m  + RJ_PCT  ~ as.factor(SEM) + as.factor(num_TC)+ as.factor(num_TCABS), data= moy_tcabs, FUN= myfun6)
moy_tcabs$insuff_actif_LJ.m <- moy_tcabs$insuff_actif_LJ.m*100
moy_tcabs2$insuff_actif_LJ.m <- moy_tcabs2$insuff_actif_LJ.m*100

moy_tcabs$stat <- moy_tcabs$RJ.m
moy_tcabs2$stat <- moy_tcabs2$RJ.m
#moy_tcabs$stat <- ifelse(moy_tcabs$RJ.m<0.25, 1, ifelse(moy_tcabs$RJ.m<0.5, 2,ifelse(moy_tcabs$RJ.m<0.75, 3,4)))
#moy_tcabs2$stat <-ifelse(moy_tcabs2$RJ.m<0.25, 1, ifelse(moy_tcabs2$RJ.m<0.5, 2,ifelse(moy_tcabs2$RJ.m<0.75, 3,4)))

stats_jurid_com <- moy_tcabs[,c("ANNEE","num_TC","stat")]
stats_jurid <- dcast(stats_jurid_com, num_TC ~ ANNEE, value.var="stat")
names(stats_jurid) <- c("num_TC","stat08","stat09","stat10","stat11","stat12") #, "num_TC_2009"

stats_jurid_com2 <- moy_tcabs2[,c("ANNEE","num_TCABS","stat")]
stats_jurid2 <- dcast(stats_jurid_com2, num_TCABS ~ ANNEE, value.var="stat")
names(stats_jurid2) <- c("num_TCABS","stat08","stat09","stat10","stat11","stat12") #, "num_TC_2009"

ti2.shp2 <- merge(ti2.shp, stats_jurid, by=c("num_TC"))
ti2.shp2<-ti2.shp2[!is.na(ti2.shp2$stat08)==T,]

TC20102 <- merge(TC2010, stats_jurid2, by=c("num_TCABS"))
TC20102<-TC20102[!is.na(TC20102$stat08)==T,]

### anciens TC
pdf("IA08.pdf",paper='a4') 
distr <- classIntervals(ti2.shp2$stat08,4,style="fixed",fixedBreaks=c(0, 0.25, 0.5, 0.75, 1))$brks
colours <- brewer.pal(4,"PuOr")
colMap <- colours[(findInterval(ti2.shp2$stat08,distr,all.inside=TRUE))] #attribution des couleurs aux régions
plot(ti2.shp2, col=colMap) #Affichage de la carte
text(ti2.shp, ti2.shp$num_TC)
legend("bottomleft", legend=leglabs(distr),fill=colours, bty="n") #affichage de la légende

distr <- classIntervals(ti2.shp2$stat09,4,style="fixed",fixedBreaks=c(0, 0.25, 0.5, 0.75, 1))$brks
colours <- brewer.pal(4,"PuOr")
colMap <- colours[(findInterval(ti2.shp2$stat09,distr,all.inside=TRUE))] #attribution des couleurs aux régions
plot(ti2.shp2, col=colMap) #Affichage de la carte
text(ti2.shp, ti2.shp$num_TC)
legend("bottomleft", legend=leglabs(distr),fill=colours, bty="n") #affichage de la légende

distr <- classIntervals(ti2.shp2$stat10,4,style="fixed",fixedBreaks=c(0, 0.25, 0.5, 0.75, 1))$brks
colours <- brewer.pal(4,"PuOr")
colMap <- colours[(findInterval(ti2.shp2$stat10,distr,all.inside=TRUE))] #attribution des couleurs aux régions
plot(ti2.shp2, col=colMap) #Affichage de la carte
text(ti2.shp, ti2.shp$num_TC)
legend("bottomleft", legend=leglabs(distr),fill=colours, bty="n") #affichage de la légende

distr <- classIntervals(ti2.shp2$stat11,4,style="fixed",fixedBreaks=c(0, 0.25, 0.5, 0.75, 1))$brks
colours <- brewer.pal(4,"PuOr")
colMap <- colours[(findInterval(ti2.shp2$stat11,distr,all.inside=TRUE))] #attribution des couleurs aux régions
plot(ti2.shp2, col=colMap) #Affichage de la carte
text(ti2.shp, ti2.shp$num_TC)
legend("bottomleft", legend=leglabs(distr),fill=colours, bty="n") #affichage de la légende

dev.off()

#### nouveaux TC
pdf("IA08_abs.pdf",paper='a4') 
distr <- classIntervals(TC20102$stat08,4,style="fixed",fixedBreaks=c(0, 0.25, 0.5, 0.75, 1))$brks
colours <- brewer.pal(4,"PuOr")
colMap <- colours[(findInterval(TC20102$stat08,distr,all.inside=TRUE))] #attribution des couleurs aux régions
plot(TC20102, col=colMap) #Affichage de la carte
text(TC20102, TC20102$num_TCABS)
legend("bottomleft", legend=leglabs(distr),fill=colours, bty="n") #affichage de la légende

distr <- classIntervals(TC20102$stat09,4,style="fixed",fixedBreaks=c(0, 0.25, 0.5, 0.75, 1))$brks
colours <- brewer.pal(4,"PuOr")
colMap <- colours[(findInterval(TC20102$stat09,distr,all.inside=TRUE))] #attribution des couleurs aux régions
plot(TC20102, col=colMap) #Affichage de la carte
text(TC20102, TC20102$num_TCABS)
legend("bottomleft", legend=leglabs(distr),fill=colours, bty="n") #affichage de la légende

distr <- classIntervals(TC20102$stat10,4,style="fixed",fixedBreaks=c(0, 0.25, 0.5, 0.75, 1))$brks
colours <- brewer.pal(4,"PuOr")
colMap <- colours[(findInterval(TC20102$stat10,distr,all.inside=TRUE))] #attribution des couleurs aux régions
plot(TC20102, col=colMap) #Affichage de la carte
text(TC20102, TC20102$num_TCABS)
legend("bottomleft", legend=leglabs(distr),fill=colours, bty="n") #affichage de la légende

distr <- classIntervals(TC20102$stat11,4,style="fixed",fixedBreaks=c(0, 0.25, 0.5, 0.75, 1))$brks
colours <- brewer.pal(4,"PuOr")
colMap <- colours[(findInterval(TC20102$stat11,distr,all.inside=TRUE))] #attribution des couleurs aux régions
plot(TC20102, col=colMap) #Affichage de la carte
text(TC20102, TC20102$num_TCABS)
legend("bottomleft", legend=leglabs(distr),fill=colours, bty="n") #affichage de la légende

dev.off()








####### 2008
######
### stats pour 2008
plotvar <- stats_jurid_com$stat[match(ti2.shp[ti2.shp$Exploitable==1,]$num_TC,stats_jurid_com[as.character(stats_jurid_com$ANNEE)=="2008",]$num_TC)] 
pdf("IA08.pdf",paper='a4') 
plot(ti2.shp[ti2.shp$Exploitable==1,],col=plotvar) #
text(ti2.shp[ti2.shp$Exploitable==1,], ti2.shp[ti2.shp$Exploitable==1 ,]$num_TC)
legend(600963,7801753,legend=names(attr(colcode,"table")),fill=attr(colcode, "palette"), cex=0.5, bty="n")
dev.off()
#stats pr tc absorbant
plotvar <- stats_jurid_com2$stat[match(TC2010[TC2010$Exploitable==1,]$num_TCABS,stats_jurid_com2[as.character(stats_jurid_com$ANNEE)=="2008",]$num_TCABS)] 
#pdf("IA08_abs.pdf",paper='a4') 
plot(TC2010[TC2010$Exploitable==1,],col=plotvar) #
text(TC2010[TC2010$Exploitable==1,], TC2010[TC2010$Exploitable==1 ,]$num_TCABS)
#legend(600963,7801753,legend=names(attr(colcode,"table")),fill=attr(colcode, "palette"), cex=0.5, bty="n")
#dev.off()
####### 2009
plotvar <- stats_jurid_com$stat[match(ti2.shp[ti2.shp$Exploitable==1,]$num_TC,stats_jurid_com[as.character(stats_jurid_com$ANNEE)=="2009",]$num_TC)] 
#pdf("IA09.pdf",paper='a4') 
plot(ti2.shp[ti2.shp$Exploitable==1,],col=plotvar) #
text(ti2.shp[ti2.shp$Exploitable==1,], ti2.shp[ti2.shp$Exploitable==1 ,]$num_TC)
#legend(600963,7801753,legend=names(attr(colcode,"table")),fill=attr(colcode, "palette"), cex=0.5, bty="n")
#dev.off()
#stats pr tc absorbant
plotvar <- stats_jurid_com2$stat[match(TC2010[TC2010$Exploitable==1,]$num_TCABS,stats_jurid_com2[as.character(stats_jurid_com$ANNEE)=="2009",]$num_TCABS)] 
pdf("IA09_abs.pdf",paper='a4') 
plot(TC2010[TC2010$Exploitable==1,],col=plotvar) #
text(TC2010[TC2010$Exploitable==1,], TC2010[TC2010$Exploitable==1 ,]$num_TCABS)
legend(600963,7801753,legend=names(attr(colcode,"table")),fill=attr(colcode, "palette"), cex=0.5, bty="n")
dev.off()


####### 2010
######
### stats pour 2010
plotvar <- stats_jurid_com$stat[match(ti2.shp[ti2.shp$Exploitable==1,]$num_TC,stats_jurid_com[as.character(stats_jurid_com$ANNEE)=="2010",]$num_TC)] 
#plotvar <- guichet_dpt$FERM_DPT/guichet_dpt$GUI_DPT
nclr <- 4
plotclr <- brewer.pal(nclr,"YlOrRd")
plotclr <- plotclr[nclr:1] # r Ìeordonne les couleurs
class <- classIntervals(plotvar, nclr, style="equal")
colcode <- findColours(class, plotclr)
# plot
pdf("IA10.pdf",paper='a4') 
plot(ti2.shp[ti2.shp$Exploitable==1,],col=plotvar) #
text(ti2.shp[ti2.shp$Exploitable==1,], ti2.shp[ti2.shp$Exploitable==1 ,]$num_TC)
legend(600963,7801753,legend=names(attr(colcode,"table")),fill=attr(colcode, "palette"), cex=0.5, bty="n")
dev.off()
#stats pr tc absorbant
plotvar <- stats_jurid_com2$stat[match(TC2010[TC2010$Exploitable==1,]$num_TCABS,stats_jurid_com2[as.character(stats_jurid_com$ANNEE)=="2010",]$num_TCABS)] 
#plotvar <- guichet_dpt$FERM_DPT/guichet_dpt$GUI_DPT
nclr <- 4
plotclr <- brewer.pal(nclr,"YlOrRd")
plotclr <- plotclr[nclr:1] # r Ìeordonne les couleurs
class <- classIntervals(plotvar, nclr, style="equal")
colcode <- findColours(class, plotclr)
# plot
pdf("IA10_abs.pdf",paper='a4') 
plot(TC2010[TC2010$Exploitable==1,],col=plotvar) #
text(TC2010[TC2010$Exploitable==1,], TC2010[TC2010$Exploitable==1 ,]$num_TCABS)
legend(600963,7801753,legend=names(attr(colcode,"table")),fill=attr(colcode, "palette"), cex=0.5, bty="n")
dev.off()


####### 2011
######
### stats pour 2011
plotvar <- stats_jurid_com$stat[match(ti2.shp[ti2.shp$Exploitable==1,]$num_TC,stats_jurid_com[as.character(stats_jurid_com$ANNEE)=="2011",]$num_TC)] 
#plotvar <- guichet_dpt$FERM_DPT/guichet_dpt$GUI_DPT
nclr <- 4
plotclr <- brewer.pal(nclr,"YlOrRd")
plotclr <- plotclr[nclr:1] # r Ìeordonne les couleurs
class <- classIntervals(plotvar, nclr, style="equal")
colcode <- findColours(class, plotclr)
# plot
pdf("IA11.pdf",paper='a4') 
plot(ti2.shp[ti2.shp$Exploitable==1,],col=plotvar) #
text(ti2.shp[ti2.shp$Exploitable==1,], ti2.shp[ti2.shp$Exploitable==1 ,]$num_TC)
legend(600963,7801753,legend=names(attr(colcode,"table")),fill=attr(colcode, "palette"), cex=0.5, bty="n")
dev.off()
#stats pr tc absorbant
plotvar <- stats_jurid_com2$stat[match(TC2010[TC2010$Exploitable==1,]$num_TCABS,stats_jurid_com2[as.character(stats_jurid_com$ANNEE)=="2011",]$num_TCABS)] 
#plotvar <- guichet_dpt$FERM_DPT/guichet_dpt$GUI_DPT
nclr <- 4
plotclr <- brewer.pal(nclr,"YlOrRd")
plotclr <- plotclr[nclr:1] # r Ìeordonne les couleurs
class <- classIntervals(plotvar, nclr, style="equal")
colcode <- findColours(class, plotclr)
# plot
pdf("IA11_abs.pdf",paper='a4') 
plot(TC2010[TC2010$Exploitable==1,],col=plotvar) #
text(TC2010[TC2010$Exploitable==1,], TC2010[TC2010$Exploitable==1 ,]$num_TCABS)
legend(600963,7801753,legend=names(attr(colcode,"table")),fill=attr(colcode, "palette"), cex=0.5, bty="n")
dev.off()








####### 2008
######
### stats pour 2008
plotvar <- stats_jurid_com$stat[match(ti2.shp[ti2.shp$Exploitable==1,]$num_TC,stats_jurid_com[as.character(stats_jurid_com$ANNEE)=="2008",]$num_TC)] 
#plotvar <- guichet_dpt$FERM_DPT/guichet_dpt$GUI_DPT
nclr <- 4
plotclr <- brewer.pal(nclr,"YlOrRd")
plotclr <- plotclr[nclr:1] # r Ìeordonne les couleurs
class <- classIntervals(plotvar, nclr, style="equal") #class <- classIntervals(plotvar, nclr, style="equal")
colcode <- findColours(class, plotclr)
# plot
pdf("IA08.pdf",paper='a4') 
plot(ti2.shp[ti2.shp$Exploitable==1,],col=plotvar) #
text(ti2.shp[ti2.shp$Exploitable==1,], ti2.shp[ti2.shp$Exploitable==1 ,]$num_TC)
legend(600963,7801753,legend=names(attr(colcode,"table")),fill=attr(colcode, "palette"), cex=0.5, bty="n")
dev.off()
#stats pr tc absorbant
plotvar <- stats_jurid_com2$stat[match(TC2010[TC2010$Exploitable==1,]$num_TCABS,stats_jurid_com2[as.character(stats_jurid_com$ANNEE)=="2008",]$num_TCABS)] 
#plotvar <- guichet_dpt$FERM_DPT/guichet_dpt$GUI_DPT
nclr <- 4
plotclr <- brewer.pal(nclr,"YlOrRd")
plotclr <- plotclr[nclr:1] # r Ìeordonne les couleurs
class <- classIntervals(plotvar, nclr, style="equal")
colcode <- findColours(class, plotclr)
# plot
pdf("IA08_abs.pdf",paper='a4') 
plot(TC2010[TC2010$Exploitable==1,],col=plotvar) #
text(TC2010[TC2010$Exploitable==1,], TC2010[TC2010$Exploitable==1 ,]$num_TCABS)
legend(600963,7801753,legend=names(attr(colcode,"table")),fill=attr(colcode, "palette"), cex=0.5, bty="n")
dev.off()


####### 2009
######
### stats pour 2009
plotvar <- stats_jurid_com$stat[match(ti2.shp[ti2.shp$Exploitable==1,]$num_TC,stats_jurid_com[as.character(stats_jurid_com$ANNEE)=="2009",]$num_TC)] 
#plotvar <- guichet_dpt$FERM_DPT/guichet_dpt$GUI_DPT
#nclr <- 4
#plotclr <- brewer.pal(nclr,"YlOrRd")
#plotclr <- plotclr[nclr:1] # r Ìeordonne les couleurs
#class <- classIntervals(plotvar, nclr, style="equal")
#colcode <- findColours(class, plotclr)
# plot
pdf("IA09.pdf",paper='a4') 
plot(ti2.shp[ti2.shp$Exploitable==1,],col=plotvar) #
text(ti2.shp[ti2.shp$Exploitable==1,], ti2.shp[ti2.shp$Exploitable==1 ,]$num_TC)
legend(600963,7801753,legend=names(attr(colcode,"table")),fill=attr(colcode, "palette"), cex=0.5, bty="n")
dev.off()
#stats pr tc absorbant
plotvar <- stats_jurid_com2$stat[match(TC2010[TC2010$Exploitable==1,]$num_TCABS,stats_jurid_com2[as.character(stats_jurid_com$ANNEE)=="2009",]$num_TCABS)] 
#plotvar <- guichet_dpt$FERM_DPT/guichet_dpt$GUI_DPT
nclr <- 4
plotclr <- brewer.pal(nclr,"YlOrRd")
plotclr <- plotclr[nclr:1] # r Ìeordonne les couleurs
class <- classIntervals(plotvar, nclr, style="equal")
colcode <- findColours(class, plotclr)
# plot
pdf("IA09_abs.pdf",paper='a4') 
plot(TC2010[TC2010$Exploitable==1,],col=plotvar) #
text(TC2010[TC2010$Exploitable==1,], TC2010[TC2010$Exploitable==1 ,]$num_TCABS)
legend(600963,7801753,legend=names(attr(colcode,"table")),fill=attr(colcode, "palette"), cex=0.5, bty="n")
dev.off()


####### 2010
######
### stats pour 2010
plotvar <- stats_jurid_com$stat[match(ti2.shp[ti2.shp$Exploitable==1,]$num_TC,stats_jurid_com[as.character(stats_jurid_com$ANNEE)=="2010",]$num_TC)] 
#plotvar <- guichet_dpt$FERM_DPT/guichet_dpt$GUI_DPT
nclr <- 4
plotclr <- brewer.pal(nclr,"YlOrRd")
plotclr <- plotclr[nclr:1] # r Ìeordonne les couleurs
class <- classIntervals(plotvar, nclr, style="equal")
colcode <- findColours(class, plotclr)
# plot
pdf("IA10.pdf",paper='a4') 
plot(ti2.shp[ti2.shp$Exploitable==1,],col=plotvar) #
text(ti2.shp[ti2.shp$Exploitable==1,], ti2.shp[ti2.shp$Exploitable==1 ,]$num_TC)
legend(600963,7801753,legend=names(attr(colcode,"table")),fill=attr(colcode, "palette"), cex=0.5, bty="n")
dev.off()
#stats pr tc absorbant
plotvar <- stats_jurid_com2$stat[match(TC2010[TC2010$Exploitable==1,]$num_TCABS,stats_jurid_com2[as.character(stats_jurid_com$ANNEE)=="2010",]$num_TCABS)] 
#plotvar <- guichet_dpt$FERM_DPT/guichet_dpt$GUI_DPT
nclr <- 4
plotclr <- brewer.pal(nclr,"YlOrRd")
plotclr <- plotclr[nclr:1] # r Ìeordonne les couleurs
class <- classIntervals(plotvar, nclr, style="equal")
colcode <- findColours(class, plotclr)
# plot
pdf("IA10_abs.pdf",paper='a4') 
plot(TC2010[TC2010$Exploitable==1,],col=plotvar) #
text(TC2010[TC2010$Exploitable==1,], TC2010[TC2010$Exploitable==1 ,]$num_TCABS)
legend(600963,7801753,legend=names(attr(colcode,"table")),fill=attr(colcode, "palette"), cex=0.5, bty="n")
dev.off()


####### 2011
######
### stats pour 2011
plotvar <- stats_jurid_com$stat[match(ti2.shp[ti2.shp$Exploitable==1,]$num_TC,stats_jurid_com[as.character(stats_jurid_com$ANNEE)=="2011",]$num_TC)] 
#plotvar <- guichet_dpt$FERM_DPT/guichet_dpt$GUI_DPT
nclr <- 4
plotclr <- brewer.pal(nclr,"YlOrRd")
plotclr <- plotclr[nclr:1] # r Ìeordonne les couleurs
class <- classIntervals(plotvar, nclr, style="equal")
colcode <- findColours(class, plotclr)
# plot
pdf("IA11.pdf",paper='a4') 
plot(ti2.shp[ti2.shp$Exploitable==1,],col=plotvar) #
text(ti2.shp[ti2.shp$Exploitable==1,], ti2.shp[ti2.shp$Exploitable==1 ,]$num_TC)
legend(600963,7801753,legend=names(attr(colcode,"table")),fill=attr(colcode, "palette"), cex=0.5, bty="n")
dev.off()
#stats pr tc absorbant
plotvar <- stats_jurid_com2$stat[match(TC2010[TC2010$Exploitable==1,]$num_TCABS,stats_jurid_com2[as.character(stats_jurid_com$ANNEE)=="2011",]$num_TCABS)] 
#plotvar <- guichet_dpt$FERM_DPT/guichet_dpt$GUI_DPT
nclr <- 4
plotclr <- brewer.pal(nclr,"YlOrRd")
plotclr <- plotclr[nclr:1] # r Ìeordonne les couleurs
class <- classIntervals(plotvar, nclr, style="equal")
colcode <- findColours(class, plotclr)
# plot
pdf("IA11_abs.pdf",paper='a4') 
plot(TC2010[TC2010$Exploitable==1,],col=plotvar) #
text(TC2010[TC2010$Exploitable==1,], TC2010[TC2010$Exploitable==1 ,]$num_TCABS)
legend(600963,7801753,legend=names(attr(colcode,"table")),fill=attr(colcode, "palette"), cex=0.5, bty="n")
dev.off()


#####
######################@
#####################@##




### reconstitution du fichier TI
#annuaire_ti <- read.csv2("annuaire_ti.csv", sep = ";")
#annuaire_ti <- data.frame(lapply(annuaire_ti, as.character), stringsAsFactors=FALSE)
#annuaire_ti2 <- melt(annuaire_ti, id.vars=c("CD_COM","CD_POST","VILLE","TI","num_TC"),na.rm = TRUE)
#write.table(annuaire_ti2, file = "annuaire_ti4.csv", row.names = FALSE, sep=";")
arrondissement<-readShapeSpatial("ARRONDISSEMENT.SHP", proj4string=CRS("+init=epsg:2154")) 
commune<-readShapeSpatial("COMMUNE.SHP", proj4string=CRS("+init=epsg:2154")) 

annuaire_ti <- read.csv2("annuaire_ti4.csv", sep = ";")
annuaire_ti <- annuaire_ti[!is.na(annuaire_ti$num_TC),]
annuaire_ti$CODE <- as.factor(substr(as.character(annuaire_ti$CODE),2,nchar(as.character(annuaire_ti$CODE))))
#write.table(annuaire_ti, file = "annuaire_ti3.csv", row.names = FALSE, sep=";")

annuaire_ti_arr <- annuaire_ti[as.character(annuaire_ti$KIND)=="ArrondissementOfFrance",c(3,4,6,7)]
#annuaire_ti_arrcom <- annuaire_ti[as.character(annuaire_ti$KIND)=="ArrondissementOfCommuneOfFrance",c(8,10:11)]
annuaire_ti_com <- annuaire_ti[as.character(annuaire_ti$KIND)=="CommuneOfFrance"|as.character(annuaire_ti$KIND)=="ArrondissementOfCommuneOfFrance",c(3,4,6,7)]
annuaire_ti_intercom <- annuaire_ti[as.character(annuaire_ti$KIND)=="IntercommunalityOfFrance",c(3,4,6,7)]

intercom <- read.csv2("intercom2015.csv", sep = ";")
intercom$CODE <- as.factor(substr(as.character(intercom$CODE),2,nchar(as.character(intercom$CODE))))
intercom$CODE_COM <- as.factor(substr(as.character(intercom$CODE_COM),2,nchar(as.character(intercom$CODE_COM))))
annuaire_ti_intercom <- merge(intercom, annuaire_ti_intercom[,c("VILLE","CODE","TI","num_TC")], by=c("CODE"))

###1. On reprend d'abord les codes arrondissements
arrondissement$CODE <- as.factor(paste(arrondissement$CODE_DEPT,arrondissement$CODE_ARR,sep="-"))
arrondissement_ti <- merge(arrondissement[,c("CODE")], annuaire_ti_arr, by=c("CODE"))
arrondissement_ti <- arrondissement_ti[is.na(arrondissement_ti$num_TC)==FALSE,]
arrondissement_ti.df <- as(arrondissement_ti, "data.frame")
arrondissement_ti.shp <- spChFIDs(arrondissement_ti, paste("arrondissement",as.character(arrondissement_ti.df$CODE),sep=""))

commune_ti <- merge(commune[,c("INSEE_COM")], annuaire_ti_com, all.y, by.x=c("INSEE_COM"), by.y=c("CODE"))
commune_ti <- commune_ti[is.na(commune_ti$num_TC)==FALSE,]
# Convert SpatialPolygons to data frame
commune_ti.df <- as(commune_ti, "data.frame")
commune_ti.shp <- spChFIDs(commune_ti, paste("commune",as.character(commune_ti.df$INSEE_COM),sep=""))
names(commune_ti.shp) <- c("CODE","VILLE","TI","num_TC") 

intercom_ti <- merge(commune[,c("INSEE_COM")], annuaire_ti_intercom,all.x=TRUE, by.x=c("INSEE_COM"), by.y=c("CODE_COM"))
intercom_ti <- intercom_ti[is.na(intercom_ti$num_TC)==FALSE,]
# Convert SpatialPolygons to data frame
intercom_ti.df <- as(intercom_ti, "data.frame")
# Reconvert data frame to SpatialPolygons
intercom_ti.shp <- spChFIDs(intercom_ti, paste("intercom",as.character(intercom_ti.df$INSEE_COM),sep=""))
intercom_ti.shp <- intercom_ti.shp[,c("CODE","VILLE","TI","num_TC")]

france=spRbind(spRbind(arrondissement_ti.shp,commune_ti.shp),intercom_ti.shp) 
france2 <- unionSpatialPolygons(france, as.character(france$num_TC))
france.df <- as(france, "data.frame")
france.id <- france.df[!duplicated(france.df[,c('num_TC')]),]
row.names(france.id) <- as.character(france.id$num_TC) 
france2.shp <- SpatialPolygonsDataFrame(france2, france.id)
#write.table(france.id, file = "ti_tc.csv", row.names = FALSE, sep=";")


plot(france2.shp, col = "red", lwd = 1)
text(france2.shp, france2.shp$VILLE)
text(france2.shp, france2.shp$num_TC)

# intersect from raster package
villes_ti <- intersect(france2.shp[,c("VILLE","num_TC")], commune[,c("INSEE_COM","CODE_COM","CODE_DEPT")])
write.table(villes_ti[,c("VILLE","num_TC","INSEE_COM")], file = "ti_tc_ville.csv", row.names = FALSE, sep=";")


#####################
##################### Representation de cartes avec des stats

stats_jurid_com <- stats_ref11[,c("TRIM","num_TC","RJ_PCT")]
plotvar_8T4 <- stats_jurid_com$RJ_PCT[match(france2.shp$num_TC,stats_jurid_com[as.character(stats_jurid_com$TRIM)=="2008T1",]$num_TC)] 
plotvar_9T1 <- stats_jurid_com$RJ_PCT[match(france2.shp$num_TC,stats_jurid_com[as.character(stats_jurid_com$TRIM)=="2009T2",]$num_TC)] 
#plotvar <- guichet_dpt$FERM_DPT/guichet_dpt$GUI_DPT
nclr <- 10
plotclr <- brewer.pal(nclr,"RdBu")
plotclr <- plotclr[nclr:1] # r Ìeordonne les couleurs
class_8T4 <- classIntervals(plotvar_8T4, nclr, style="quantile")
colcode_8T4 <- findColours(class_8T4, plotclr)
#plot(jurid_com,col=plotvar)
#legend(556963,6901753,legend=names(attr(colcode,"table")),fill=attr(colcode, "palette"), cex=0.6, bty="n")
par(mfrow = c(1,1))
par(mar=c(1,1,1,1))
plot(france2.shp,col=plotvar_8T4)
text(france2.shp, france2.shp$VILLE)
#legend(600963,7801753,legend=names(attr(colcode_8T4,"table")),fill=attr(colcode_8T4), cex=0.6, bty="n")
nclr <- 10
plotclr <- brewer.pal(nclr,"RdBu")
plotclr <- plotclr[nclr:1] # r Ìeordonne les couleurs
class_9T1 <- classIntervals(plotvar_9T1, nclr, style="quantile")
colcode_9T1 <- findColours(class_9T1, plotclr)
par(mfrow = c(1,1))
par(mar=c(1,1,1,1))
plot(france2.shp,col=plotvar_9T1)
legend(600963,7801753,legend=names(attr(colcode_9T1,"table")),fill=attr(colcode_9T1, "palette"), cex=0.6, bty="n")







############################################################################################################
########### ANNEXE ########################################################################
############################################################################################################

TC2011 <- readOGR(dsn="TC2011.tab",layer="TC2011")






