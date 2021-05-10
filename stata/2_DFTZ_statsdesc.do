clear all
global path_data "/Users/stephaneesquerre/Documents/LA Thèse/Recherche/DFTZ/DATA"
global path_folder "/Users/stephaneesquerre/Documents/LA Thèse/Recherche/DFTZ/" 
global path_result "/Users/stephaneesquerre/Documents/LA Thèse/Recherche/DFTZ/Results" 
	
use "$path_data//DFTZ_modele.dta",clear

/*
tab  tc_traitement reforme if annee < 2012, sum(lj) means
tab  tc_traitement reforme if annee < 2012, sum(lj) means
*/
***** II. Stats desc
eststo clear

	replace plan=0 if plan==.
	replace fail=0 if fail==.

bysort num_tc_2009 annee: egen sum_pcl=sum(pcl)

* Nombre de PCL par types de court 
preserve
 keep num_tc_2009 annee sum_pcl tc_traitement
 sort num_tc_2009 annee
      quietly by num_tc_2009 annee: gen dup = cond(_N==1,0,_n)
drop if dup > 1

ta tc_traitement annee, su(sum_pcl) mean label
*Graph*
bysort tc_traitement annee : egen mean_type=mean(sum_pcl)
 keep tc_traitement annee mean_type
 
restore, preserve	
	
*** selon reforme
sort reforme
by reforme: eststo: quietly estpost summarize  rj plan fail  d_tc_traitement1-d_tc_traitement4 ///
insuff_actif ln_dist ln_tc_vol ln_s_ee_b0 renta_eco couv_immo_fp ln_s_fl_b0 ln_age_entp ln_efence d_naf1-d_naf9 d_fj1-d_fj3, listwise
esttab using "$path_result//table_stats_reforme.tex", cell((mean(fmt(%9.2f)) sd(fmt(%9.2f)))) label nodepvar replace compress
eststo clear

*** selon reforme
sort tc_traitement
by tc_traitement: eststo: quietly estpost summarize  rj plan fail insuff_actif ///
 ln_dist ln_tc_vol ln_s_ee_b0 renta_eco couv_immo_fp ln_s_fl_b0 ln_age_entp ln_efence d_naf1-d_naf9 d_fj1-d_fj3, listwise
esttab using "$path_result//table_stats_tc_traitement.tex", cell((mean(fmt(%9.2f)) sd(fmt(%9.2f)))) label nodepvar replace compress
eststo clear

**** II. Graphiques
* Graph hazard ratio fail
graph drop _all
stset age_plan, failure(plan2)
	sts graph if reforme==0, ha by(tc_traitement)  title("Before reform") name("ha_plan_before", replace)
	sts graph if reforme==1, ha by(tc_traitement)  title("After reform") name("ha_plan_after", replace)
graph combine ha_plan_before ha_plan_after, rows(1)  iscale(.5)
graph export "$path_result//hazard_ratio_plan.png", width(720) height(360) replace  

* Graph hazard ratio fail
graph drop _all
stset age_fin_et, failure(fail)
	sts graph if reforme==0, ha by(tc_traitement)  title("Before reform") name("ha_fail_before", replace)
	sts graph if reforme==1, ha by(tc_traitement)  title("After reform") name("ha_fail_after", replace)
graph combine ha_fail_before ha_fail_after, rows(1)  iscale(.5)
graph export "$path_result//hazard_ratio_fail.png", width(720) height(360) replace  


* Graph Kaplan Meier all
graph drop _all
stset age_fin_et, failure(fail)
	sts graph if reforme==0, by(tc_traitement)  title("Before reform") name("surv_fail_before", replace)
	sts graph if reforme==1, by(tc_traitement)  title("After reform") name("surv_fail_after", replace)
graph combine surv_fail_before surv_fail_after, rows(1)  iscale(.5)
graph export "$path_result//survie_all.png", width(720) height(360) replace  


* Graph Kaplan Meier RJ
preserve 
keep if rj==1
graph drop _all
stset age_fin_et, failure(fail)
	sts graph if reforme==0, by(tc_traitement)  title("Before reform") name("survrj_fail_before", replace)
	sts graph if reforme==1, by(tc_traitement)  title("After reform") name("survrj_fail_after", replace)
graph combine survrj_fail_before survrj_fail_after, rows(1)  iscale(.5)
graph export "$path_result//survie_rj.png", width(720) height(360) replace  
restore

graph drop _all
stset age_fin_et, failure(fail)
	sts graph if insuff_actif==0, by(tc_traitement) title("Before reform") name("ha_fail_before", replace)
	sts graph if insuff_actif==1, by(tc_traitement)   title("After reform") name("ha_fail_after", replace)
graph combine ha_fail_before ha_fail_after, rows(1)  iscale(.5)
