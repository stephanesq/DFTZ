### Packages ------------
#install.packages("readstata13")
#install.packages("tidyverse")
#install.packages("did")
library("tidyverse")
library("here")
library("did")
library("readstata13")

### donnees de stata
dftz <- read.dta13("donnees/DFTZ_modele2.dta")

