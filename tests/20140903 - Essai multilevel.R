#Imprimer un fichier
write.table(DFTZB, file = "DFTZB.csv", sep = ";",  row.names = FALSE)

# Nettoyer
rm(list=ls()) #Tout
rm(x) # efface x 

#RÈpertoire :

options(scipen=999)
setwd("/Users/stephaneesquerre/Dropbox/Articles/2013 - Premiers travaux/Dont feed the zombies/DATA")

#############
# Je suis les instr. d'un site pr programmer du multilevel : http://rt.uits.iu.edu/visualization/analytics/docs/hlm-docs/hlm9.php
# Variable dépendante continue
#################

#Chargement package
install.packages(lme4) 
library(lme4)

#Jeu de données d'ex
HSBdata <- read.table("/Users/stephaneesquerre/Dropbox/Articles/2012 - DATA/hbm.txt", header=T, sep=",") 
attach(HSBdata)

#On crée moyenne par ss-groupes puis des var centrées autour des moyennes de groupes
HSBdata$meanses <- ave(ses, list(id)) 
HSBdata$centses <- ses - meanses 
attach(HSBdata)

#A. linear model with random components in brackets
results1 <- lmer(mathach ~ 1 + (1 | id), data = HSBdata) 
summary(results1)
## lecture des résultats : 
#1. niveau moyen parmi ttes les écoles : 12.64
#2.intraclass correlation coefficient is 8.614/(39.148+8.614)=18.04, 18% of the variance is attributable to the school level.

#.B. linear model with fixed effects (socioeco status, ses, and type of school)
results2 <- lmer(mathach ~ 1 + meanses + schtype + (1 | id), data = HSBdata) 
summary(results2)
## lecture : variance of id plus que 2.314 ms ths 2 fois std.dev

#C. dernier modèle avec interaction et introduction des ses en random term
results3 <- lmer(mathach ~ meanses + schtype + centses + meanses*centses + schtype*centses + (1 + centses|id), data = HSBdata)
summary(results3)
# lecture : mieux mais pas ça, par contre lecture déviance/AIC/BIC montre que meilleur modèle

#############
Infos pour nlme 
############
library(nlme)

#comment spécifier fonction
ana1<-lme(modèle fixe, data, random)
# fixe :
# random : random=∼ 1+reg1+reg2+fac1+fac2+reg1∗ fac1|group

#anova
anova(ana1,ana2) 
## test de rapport de vraisemblance des modèles, ils doivent être emboîtés.

### site d'ucla

# estimate the model and store results in m
m <- glmer(remission ~ IL6 + CRP + CancerStage + LengthofStay + Experience +(1 | DID), 
  data = hdp, family = binomial, control = glmerControl(optimizer = "bobyqa"), #to avoid a warning of nonconvergence, we specify a different optimizer
  nAGQ = 10)
# print the mod results without correlations among fixed effects
print(m, corr = FALSE)

## to get confidence intervals (CIs)
se <- sqrt(diag(vcov(m)))
# table of estimates with 95% CI
(tab <- cbind(Est = fixef(m), LL = fixef(m) - 1.96 * se, UL = fixef(m) + 1.96 *se))
exp(tab) # with odd ratios

# solution à l'hyp de gaussiennité des estimateurs/SE -> bootstrap

#################
#### Explication lme4
################

# premier modèle
summary(DFTZB$PROC)
re_test <- glmer(PROC ~  AGE_ENTP + as.factor(TR_EFF_ENT) + LN_S_EE_B0 + as.factor(NAF1) +(1|S_TC), DFTZB, binomial)

print(fm10, corr=FALSE) # so that suppress printing of the rather large correlation matrix of the fixed effects estimators

# Comparison of models:
anova(fm11,fm10)
