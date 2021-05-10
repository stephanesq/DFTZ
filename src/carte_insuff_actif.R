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
## installation
#install.packages(RColorBrewer, lib="//intra/profils/D000/H825086/D/Documents/R/win-library/3.1")
# Chargement des donnése
library(doBy, lib.loc="//intra/profils/D000/H825086/D/Documents/R/win-library/3.1")
library(Hmisc, lib.loc="//intra/profils/D000/H825086/D/Documents/R/win-library/3.1")
library(plyr, lib.loc="//intra/profils/D000/H825086/D/Documents/R/win-library/3.1")
library(qte, lib.loc="//intra/profils/D000/H825086/D/Documents/R/win-library/3.1")
library(lubridate, lib.loc="//intra/profils/D000/H825086/D/Documents/R/win-library/3.1")
library(sp, lib.loc="//intra/profils/D000/H825086/D/Documents/R/win-library/3.1")
library(maptools, lib.loc="//intra/profils/D000/H825086/D/Documents/R/win-library/3.1")
library(rgeos, lib.loc="//intra/profils/D000/H825086/D/Documents/R/win-library/3.1")
library(rgdal, lib.loc="//intra/profils/D000/H825086/D/Documents/R/win-library/3.1")
library(raster, lib.loc="//intra/profils/D000/H825086/D/Documents/R/win-library/3.1")
library(rasterVis, lib.loc="//intra/profils/D000/H825086/D/Documents/R/win-library/3.1")
library(classInt, lib.loc="//intra/profils/D000/H825086/D/Documents/R/win-library/3.1")
library(RColorBrewer)
#############
#chargement du dossier principal
setwd("//intra/partages/UA2771_Data/6_Utilisateurs/Stephane/4_Donnees/PERSO")
jurid_com<-readShapeSpatial("jurid_com.SHP", proj4string=CRS("+init=epsg:2154")) #j'ai pris limites plutÃ´t
tc_insuff <- read.csv2("tc_insuff_actif_proc.csv", dec = ".",sep=";")

plotvar <- tc_insuff$MORT[match(jurid_com$Lib_TC_maj,tc_insuff$Lib_TC_maj)] 
#plotvar <- guichet_dpt$FERM_DPT/guichet_dpt$GUI_DPT
nclr <- 5
plotclr <- brewer.pal(nclr,"RdBu")
plotclr <- plotclr[nclr:1] # r ́eordonne les couleurs
class <- classIntervals(plotvar, nclr, style="quantile")
colcode <- findColours(class, plotclr)
plot(jurid_com,col=colcode)
legend(166963,6161753,legend=names(attr(colcode,"table")),fill=attr(colcode, "palette"), cex=0.6, bty="n")
