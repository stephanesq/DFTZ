clear all
global path_data "/Users/stephaneesquerre/Documents/LA Thèse/Recherche/DFTZ/DATA"
global path_folder "/Users/stephaneesquerre/Documents/LA Thèse/Recherche/DFTZ/" 
global path_result "/Users/stephaneesquerre/Documents/LA Thèse/Recherche/DFTZ/Results" 
	
	
/******
 Notes sur dates : 614 = 201103 627 = 201204
*******/

****************
*Import de donnees
****************	
/*
import delimited "$path_data//DFTZ_stata.csv", delimiter(";") 
compress
save "$path_data//DFTZ_stata.dta",replace
*/
 
use "$path_data//DFTZ_stata.dta",clear


** 1.1. Transformation des dates en valeur stata
*ouverture pcl
drop annee mois 
gen annee=substr(date_ouverture,1,4)
gen mois=substr(date_ouverture,5,2)
gen jour=substr(date_ouverture,7,2)
destring annee mois jour, replace
gen date = mdy(mois,jour,annee)
drop mois jour
gen quarter = qofd(date)
gen semest = hofd(date)			

*plan pcl
gen annee_plan=substr(date_plan,1,4)
gen mois_plan=substr(date_plan,5,2)
gen jour_plan=substr(date_plan,7,2)
destring annee_plan mois_plan jour_plan, replace
drop date_plan
** pour que l'information soit coherente on ne regarde que les plans conclus 12 mois après l'ouverture de la procédure
** et ceux dont l'ouverture est avan aout 2013
gen date_plan = mdy(mois_plan,jour_plan,annee_plan)
	replace date_plan =. if date_plan > mdy(12,31,2013)

	gen start_month=mofd(date)
	gen plan_month=mofd(date_plan)
gen age_plan_month = plan_month - start_month
gen plan_12m = (age_plan<=12 & age_plan!=.)
	replace plan_12m=. if date > mdy(08,31,2013) /* puisque les derniers plans sont en août 2014 */
drop annee_plan mois_plan jour_plan

*on prepare les infos à de l'analyse de survie
gen plan2 = (date_plan!=.)
	replace date_plan = mdy(08,31,2014) if date_plan==.
gen age_plan = date_plan - date 
	

*liquid pcl et on rajoute liquidation directe
gen annee_liquid=substr(date_liquid,1,4)
gen mois_liquid=substr(date_liquid,5,2)
gen jour_liquid=substr(date_liquid,7,2)
destring annee_liquid mois_liquid jour_liquid, replace
drop date_liquid
gen date_liquid = mdy(mois_liquid,jour_liquid,annee_liquid)
	replace date_liquid=. if date_liquid > mdy(12,31,2013)
	replace date_liquid=date if lj==1

drop annee_liquid mois_liquid jour_liquid

*cloture pcl
gen annee_mort=substr(date_mort,1,4)
gen mois_mort=substr(date_mort,5,2)
gen jour_mort=substr(date_mort,7,2)
destring annee_mort mois_mort jour_mort, replace
drop date_mort
gen date_mort = mdy(mois_mort,jour_mort,annee_mort)
	replace date_mort=. if date_mort > mdy(12,31,2013)

drop annee_mort mois_mort jour_mort

**** Variable d'echec pcl
gen byte fail = (date_liquid != . | date_mort !=.)
*	replace fail=. if rj!=1
gen date_fin_et = mdy(12,31,2013)
	replace date_fin_et = min(date_liquid,date_mort) if fail ==1
gen age_fin_et = date_fin_et - date
*	replace age_fin_et=. if rj!=1

** Variables de traitements
gen reforme = (quarter>=196)
gen tc_traitement = 0
	replace tc_traitement = 1 if tc_abs == 0
	replace tc_traitement = 2 if tc_abs == 1
	replace tc_traitement = 3 if tc_abs == 2

gen reforme_tc = reforme*tc_traitement
gen insuf_tc = insuff_actif*tc_traitement
gen reforme_insuf = insuff_actif*reforme
gen reforme_insuf_tc = insuff_actif*tc_traitement*reforme


* Calcul des volumes trim de faillites
preserve
 keep num_tc_2009 start_month tc_vol_2009
 sort num_tc_2009 start_month
      quietly by num_tc_2009 start_month: gen dup = cond(_N==1,0,_n)
drop if dup > 1

xtset num_tc_2009 start_month
tsfill, full
    replace tc_vol_2009=0 if tc_vol_2009==.
gen tc_trim_2009 = L1.tc_vol_2009 + L2.tc_vol_2009 + L3.tc_vol_2009
    replace tc_trim_2009=0 if tc_trim_2009==.
drop tc_vol_2009 dup
sort num_tc_2009 start_month
save "$path_data//tc_vol_2009.dta", replace
* on fait pareil pour après 2009
restore, preserve
 keep num_tc start_month tc_vol
 sort num_tc start_month
      quietly by num_tc start_month: gen dup = cond(_N==1,0,_n)
drop if dup > 1
xtset num_tc start_month
tsfill, full
    replace tc_vol=0 if tc_vol==.
gen tc_trim = L1.tc_vol + L2.tc_vol + L3.tc_vol
    replace tc_trim=0 if tc_trim==.
drop tc_vol dup
sort num_tc start_month
save "$path_data//tc_vol.dta", replace
restore

sort num_tc_2009 start_month
merge m:1 num_tc_2009 start_month using "$path_data//tc_vol_2009.dta"
drop _merge
/* Il y a des ibservations vides datant de 2004 */
sort num_tc start_month
merge m:1 num_tc start_month using "$path_data//tc_vol.dta"
drop _merge

*rename num_tc_2009 num_tc
*rename tc_trim_2009 tc_trim
*save "$path_data//tc_vol_2009.dta", replace
/*
bysort num_tc2009: egen lj_mean=mean(lj)
twoway scatter lj num_tc2009, msize(tiny) || connected lj_mean num_tc2009, connect(L) clwidth(thick) clcolor(black) mcolor(black) msymbol(none) || , ytitle(lj)
*/
** Selection de la periode d'etude
drop if annee < 2006 | annee >2013
** Variables independantes

	gen distance = distance_tc
		replace distance = distance_tcabs if reforme ==1
	gen ln_dist=ln(1+distance)
	gen diff_dist = distance_tcabs - distance_tc
	gen ln_tc_vol = ln(1+tc_trim_2009)
		replace ln_tc_vol = ln(1+tc_trim) if reforme ==1	
	egen naf_cat=group(naf)
drop naf
		rename naf_cat naf
*Rappel : 54 : SARL ; 55 : avec CA ; 57 : SAS
replace fj="AUTRES" if fj=="62"|fj=="63"|fj=="65"
    egen fj_cat=group(fj)
drop fj
		rename fj_cat fj
			replace fj=2 if fj==4
*on recode pour les stats desc
	ta naf, ge(d_naf)
	ta fj, ge(d_fj)
	ta tc_traitement, ge(d_tc_traitement)
	ta reforme_tc, ge(d_reforme_tc)
	ta insuf_tc, ge(d_insuf_tc)
	ta reforme_insuf_tc, ge(d_reforme_insuf_tc)
** on coupe les variables renta_eco et le ratio immo/FP pour qu'elle soit lisible
*** Ne change rien si on garde les centiles 
sum renta_eco,d
drop if renta_eco<r(p1) | renta_eco>r(p99)
sum  couv_immo_fp,d
drop if  couv_immo_fp<r(p1) |  couv_immo_fp>r(p99)

compress

label variable rj "Reorganization" 
label variable lj "Direct liquidation" 
label variable plan "Plan" 
label variable fail "Failure" 
label variable insuff_actif "Assets shortfall"

label variable tc_traitement "Type of TC"
label define tc_traitement 1 "Absorbing" 0 "Same" 2 "Absorbed" 3 "New" 
label variable d_tc_traitement2 "Absorbing" 
label variable d_tc_traitement1 "Same"
label variable d_tc_traitement3 "Absorbed" 
label variable d_tc_traitement4 "New" 

label variable reforme "Reform"

label variable  reforme_tc "Reform on TC"
label define reforme_tc 1 "Reform for Absorbing" 0 "Reform for Same" 2 "Reform for Absorbed" 3 "Reform for New" 
label variable d_reforme_tc1 "Reform for Same"
label variable d_reforme_tc2 "Reform for Absorbing" 
label variable d_reforme_tc3 "Reform for Absorbed" 
label variable d_reforme_tc4 "Reform for New" 

label variable  insuf_tc "Continuation bias by TC"
label variable d_insuf_tc2 "CB in Absorbing" 
label variable d_insuf_tc1 "CB in Same"
label variable d_insuf_tc3 "CB in Absorbed" 
label variable d_insuf_tc4 "CB in New"

label variable  reforme_insuf "Reform on continuation bias"
label variable  reforme_insuf_tc "Reform on continuation bias by TC"
label variable d_reforme_insuf_tc2 "Reform on CB in Absorbing" 
label variable d_reforme_insuf_tc1 "Reform on CB in Same"
label variable d_reforme_insuf_tc3 "Reform on CB in Absorbed" 
label variable d_reforme_insuf_tc4 "Reform on CB in New" 

label variable ln_dist "Ln(1+distance)"
label variable ln_tc_vol "Ln(1+bankruptcies)"
label variable ln_s_ee_b0 "Ln(1+size of assets)"
label variable ln_s_fl_b0 "Ln(1+sales)"
label variable ln_age_entp "Ln(1+age)"
label variable ln_efence "Ln(1+empl.)"
label variable renta_eco "Profitability"
label variable sur_fi "Financial strength"
label variable couv_immo_fp "Fixed assets coverage"
label variable cur_as_cur_li "Solvency ratio"
label variable fj "Legal form"
label define fj 1 "LLC" 2 "Others" 3 "Simpl. LLC" 
label variable d_fj2 "Others"
label variable d_fj1 "LLC" 
label variable d_fj3 "Simpl. LLC" 

label variable naf "Business activity (NAF)"
label define naf 1 "Manufacturing" 2 "Construction" 3 " Wholesale-retail" 4 "Transport-storage" 5 "Accommodation-Food" 6 "Inform.-Com." 7 "Real estate" 8 "Admin.-Support" 9 "Energy, Water, Waste"
label variable d_naf1 "Manufacturing" 
label variable d_naf2 "Construction" 
label variable d_naf3 " Wholesale-retail" 
label variable d_naf4 "Transportation-storage" 
label variable d_naf5 "Accommodation-food serv." 
label variable d_naf6 "Inform.-Com." 
label variable d_naf7 "Real estate" 
label variable d_naf8 "Administrative-support activ." 
label variable d_naf9 "Energy, Water, Waste mgmt"

save "$path_data//DFTZ_modele.dta",replace
saveold "$path_data//DFTZ_modele2.dta", version(13) replace


****************
*ANNEXES
****************
/*
label variable renta_eco "Profitability (\%)"
label variable distance "Distance"
label variable echev "Echevinage (1=yes)"


fj_2 naf1 rj lj insuff_actif_rj insuff_actif_lj  fail_2y
 
	reghdfe rj i.time##i.treated ln_s_ee_b0 ln_s_fl_b0 ln_age_entp , cl(num_tc2009) a(num_tc2009 anneemois)	
	reghdfe lj i.time##i.treated ln_s_ee_b0 ln_s_fl_b0 ln_age_entp , cl(num_tc2009) a(num_tc2009 anneemois)	
	reghdfe insuff_actif_lj i.time##i.treated ln_s_ee_b0 ln_s_fl_b0 ln_age_entp , cl(num_tc2009) a(num_tc2009 anneemois)	


compress
