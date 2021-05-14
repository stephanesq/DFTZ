DFTZ_EXP <- read.csv2("donnees/DFTZ_EXP.csv", sep = ";", dec=".", na=".")
#extraction SIREN
#DFTZ_SIREN <- DFTZ_EXP %>% select(I_SIREN) %>% unique() #a vérifier
#write.table(DFTZ_SIREN, file = "DFTZ_SIREN.csv", row.names = FALSE, sep=";", dec=".", na=".")
#S_TC <- DFTZ_EXP %>% select(S_TC) %>% unique() %>% str_replace_all(DFTZ_EXP$S_TC, c("ST "="SAINT ", "STE "="SAINTE "))
LIEN_TC_MJ <- read.csv2("donnees/LIEN_TC_MJ.csv", sep = ";", dec=".", na=".")
DFTZ_EXP <- merge(DFTZ_EXP, LIEN_TC_MJ[c("S_TC","i_elst")], all.x=T, by=("S_TC")) %>% rename(i_elst_DFTZ=i_elst)

### Modif DFTZ -----
DFTZ_EXP$NAF <- as.factor(ifelse(DFTZ_EXP$NAF1=="B"|DFTZ_EXP$NAF1=="D"|DFTZ_EXP$NAF1=="E","Z",DFTZ_EXP$NAF1))
DFTZ_EXP$DNAF <- ifelse(DFTZ_EXP$NAF1=="C"|DFTZ_EXP$NAF1=="F"|DFTZ_EXP$NAF1=="G"|DFTZ_EXP$NAF1=="H"|DFTZ_EXP$NAF1=="I"|DFTZ_EXP$NAF1=="J"|DFTZ_EXP$NAF1=="L"|DFTZ_EXP$NAF1=="N"|DFTZ_EXP$NAF1=="T"|DFTZ_EXP$NAF=="Z",1,0) 
DFTZ_EXP$NAF1 <- as.factor(DFTZ_EXP$NAF1)
DFTZ_EXP$ANNEE <- as.factor(substr(as.character(DFTZ_EXP$DATE_OUVERTURE),1,4))
DFTZ_EXP$ANNEEMOIS <- as.factor(substr(as.character(DFTZ_EXP$DATE_OUVERTURE),1,6))
DFTZ_EXP$PROC <- as.factor(ifelse(DFTZ_EXP$RJ==1,"R", ifelse(DFTZ_EXP$SAUV==1, "S", ifelse(DFTZ_EXP$LJ==1, "L", NA))))
DFTZ_EXP$FJ_2 <- substr(as.character(DFTZ_EXP$I_FJ),1,2)
## Création DFTZ2 (version simplifiée) -----
### selectionne que société commerciales  -----
DFTZ2 <- DFTZ_EXP %>% filter(substr(DFTZ_EXP$FJ_2,1,1) %in% c('5','6')) 
### selectionne que activités pertinentes  -----
DFTZ2 <- DFTZ2[which(DFTZ2$DNAF==1),]
## Adapte format DATE
DFTZ2 <- DFTZ2[,c("I_SIREN","S_TC","i_elst_DFTZ","PROC",'FJ_2',"I_CD_NAF","DATE_OUVERTURE","DATE_PLAN","DATE_LIQUID")] %>% 
 mutate_at(.vars = c("DATE_OUVERTURE", "DATE_LIQUID"), list(~substring(.,1,8)))
## test appariement 
appariement <- DFTZ2 %>%  group_by(DATE_OUVERTURE, S_TC, PROC, FJ_2,I_CD_NAF) %>% summarise(n = n()) %>% ungroup()
summary(appariement$n)

##MODIF AC08_DFTZ ------
#AC08 <- read.csv2("donnees/AC08.csv", sep = ";", dec=".", na=".")
AC08_DFTZ <- read.csv2("donnees/AC08_DFTZ.csv", sep = ";", dec=".", na=".")
AC08_DFTZ <- AC08_DFTZ %>% mutate(#SIREN =as.integer(SIREN), 
  ANNEE_OUV=substr(DATE_OUV,1,4),
  FJ_2_S = case_when(
    CATJU =='0A' ~ '13',
    CATJU =='0B' ~ '12',
    CATJU =='0C' ~ '11',
    CATJU =='0D' ~ '54',
    CATJU =='0E' ~ '54',
    CATJU =='0F' ~ '55',
    CATJU =='0G' ~ '53',
    CATJU =='0H' ~ '57',
    CATJU =='0I' ~ '52',
    CATJU =='0J' ~ '53',
    CATJU =='0K' ~ '65',
    CATJU =='0L' ~ '54',
    CATJU =='0M' ~ '62',
    CATJU =='0N' ~ '56',
    TRUE ~ CATJU))
### que avec SIREN et select variables ------
AC08_SS0 <- AC08_DFTZ %>% filter(SIREN!=0) %>% select(I_SIREN, I_ELST,TYPROCOUV, TYPROCO,FJ_2_S, APE, DATE_OUV,DASAI_C,DAFIN_O_C,DAFIN_S_C,OSCA)
### que société commerciales ------
#AC08_SS0 <- AC08_SS0 %>% filter(substr(AC08_SS0$FJ_2_S,1,1) %in% c('5','6')) 


test1 <- merge(DFTZ2, AC08_SS0, all.x=T, by.x=("I_SIREN"), by.y=("I_SIREN"), incomparables)
test2 <- merge(AC08_SS0,DFTZ2 , all.x=T,by.x=("I_SIREN"), by.y=("I_SIREN"),  incomparables)
test3 <- test1[is.na(test1$OSCA),]
appariement3 <- test3 %>%  group_by(DATE_OUVERTURE, S_TC, PROC, FJ_2,I_CD_NAF) %>% summarise(n = n()) %>% ungroup()
summary(appariement3$n)
test5 <- test1[!is.na(test1$OSCA),]
appariement5 <- test5 %>%  group_by(DATE_OUVERTURE, I_ELST, PROC, FJ_2,I_CD_NAF) %>% summarise(n = n()) %>% ungroup()
summary(appariement5$n)

summary(test3)
summary(as.factor(DFTZ2$ANNEE))
summary(as.factor(test5$ANNEE))
summary(as.factor(test3$ANNEE))
summary(as.factor(test3$I_FJ))
summary(as.factor(test3$S_TC))
summary(as.factor(test3$NAF1))

test4 <- test2[is.na(test2$DATE_OUVERTURE),]
summary(as.factor(test4$TYPROCOUV))
summary(as.factor(test4$CATJU)) 
summary(as.factor(test4$NATAFF))
summary(as.factor(test4$ANNEE_OUV))

test1 <- merge(DFTZB, AC08_SS0, all.x=T, by.x=("I_SIREN"), by.y=("SIREN"), incomparables)
test2 <- merge(DFTZB, AC08_SS0, all.y=T, by.x=("I_SIREN"), by.y=("SIREN"), incomparables)
test3 <- test1[is.na(test1$OSCA),]


# AC08 ----
AC08 <- read.csv2("donnees/AC08.csv", sep = ";", dec=".", na=".")
AC08 <- AC08 %>% mutate(SIREN =as.integer(SIREN), 
  ANNEE_OUV=substr(DATE_OUV,1,4),
  FJ_2_S = case_when(
    CATJU =='0A' ~ '13',
    CATJU =='0B' ~ '12',
    CATJU =='0C' ~ '11',
    CATJU =='0D' ~ '54',
    CATJU =='0E' ~ '54',
    CATJU =='0F' ~ '55',
    CATJU =='0G' ~ '53',
    CATJU =='0H' ~ '57',
    CATJU =='0I' ~ '52',
    CATJU =='0J' ~ '53',
    CATJU =='0K' ~ '65',
    CATJU =='0L' ~ '54',
    CATJU =='0M' ~ '62',
    CATJU =='0N' ~ '56',
    TRUE ~ CATJU))
### na Fn pour transformer en NA ----
na <- . %>% na_if("") %>% na_if("00") %>% na_if(., "0000")
### modif table ----
AC08_SSSIR <- AC08 %>% filter(SIREN==0|is.na(SIREN)) %>% 
    select(SIREN, I_ELST,TYPROCOUV, TYPROCO,FJ_2_S, APE, DATE_OUV,DASAI_C,DAFIN_O_C,DAFIN_S_C,OSCA) %>% 
        mutate_if(is.character, na) %>% 
        mutate_at(.vars = c("TYPROCOUV", "TYPROCO","FJ_2_S","APE","OSCA"), list(~as.factor(.)))
## test appariement -----
appariement_AC <- AC08_SSSIR %>%  group_by(DATE_OUV, I_ELST, TYPROCO, FJ_2_S,APE) %>% summarise(n = n()) %>% ungroup()
summary(appariement_AC$n)


