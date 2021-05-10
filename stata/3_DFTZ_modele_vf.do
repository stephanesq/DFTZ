clear all
global path_data "/Users/stephaneesquerre/Documents/LA Thèse/Recherche/DFTZ/DATA"
global path_folder "/Users/stephaneesquerre/Documents/LA Thèse/Recherche/DFTZ/" 
global path_result "/Users/stephaneesquerre/Documents/LA Thèse/Recherche/DFTZ/Results" 
	
use "$path_data//DFTZ_modele.dta",clear

eststo clear

*** FIRST SECTION
*	egen tc_time=group(num_tc quarter)
compress

/* local controlgroup1
local controlgroup2 */

eststo clear

melogit rj d_reforme_insuf_tc2-d_reforme_insuf_tc4 d_reforme_tc2-d_reforme_tc4  d_insuf_tc2-d_insuf_tc4 reforme_insuf  ///
insuff_actif reforme d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence i.naf i.fj  ,  nolog or
 
logit rj d_reforme_insuf_tc2-d_reforme_insuf_tc4 d_reforme_tc2-d_reforme_tc4  d_insuf_tc2-d_insuf_tc4 reforme_insuf  ///
insuff_actif reforme d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence i.naf i.fj  ,  nolog or

*2.1. RJ
eststo, title("Simple"): quietly  melogit rj d_reforme_insuf_tc2-d_reforme_insuf_tc4 d_reforme_tc2-d_reforme_tc4  d_insuf_tc2-d_insuf_tc4 reforme_insuf  ///
insuff_actif reforme d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence i.naf i.fj  ,  nolog or

eststo, title("Time FE"): quietly  melogit rj d_reforme_insuf_tc2-d_reforme_insuf_tc4 d_reforme_tc2-d_reforme_tc4  d_insuf_tc2-d_insuf_tc4 reforme_insuf  ///
insuff_actif  d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence i.quarter i.naf i.fj  ,  nolog or

/*
eststo, title("Court RE"): quietly  melogit rj d_reforme_insuf_tc2-d_reforme_insuf_tc4 d_reforme_tc2-d_reforme_tc4  d_insuf_tc2-d_insuf_tc4 reforme_insuf  ///
insuff_actif  d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence i.quarter i.naf i.fj  || num_tc:, nolog or
*/
 
 eststo, title("ZE FE"): quietly melogit rj d_reforme_insuf_tc2-d_reforme_insuf_tc4 d_reforme_tc2-d_reforme_tc4 d_insuf_tc2-d_insuf_tc4 reforme_insuf   ///
insuff_actif  d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence i.quarter i.naf i.fj  i.ze,  nolog or

esttab using "$path_result//reg_rj.tex", eform star(* 0.10 ** 0.05 *** 0.01) b(3) p(3) drop(_cons *.naf *.fj *.quarter *.ze renta_eco couv_immo_fp  ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence) nodep compress label replace booktabs ///
  alignment(D{.}{.}{-1}) title(Reorganisation plan accepted \label{tab2})

eststo clear

*** SECOND SECTION : tests alternatifs

*Premier test : est-ce que les resultats sont simplement lies a une modif de distance 
eststo, title("Simple"): quietly  melogit rj c.ln_dist##i.reforme_insuf c.ln_dist##i.insuff_actif c.ln_dist##i.reforme d_tc_traitement2-d_tc_traitement4 ///
insuff_actif reforme ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence i.naf i.fj  ,  nolog or

eststo, title("Time FE"): quietly  melogit rj c.ln_dist##i.reforme_insuf c.ln_dist##i.insuff_actif c.ln_dist##i.reforme d_tc_traitement2-d_tc_traitement4 ///
insuff_actif reforme ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence i.quarter i.naf i.fj  ,  nolog or

/*

eststo, title("Court RE"): quietly  melogit rj c.ln_dist##i.reforme_insuf c.ln_dist##i.insuff_actif c.ln_dist##i.reforme d_tc_traitement2-d_tc_traitement4 ///
insuff_actif reforme ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence i.quarter i.naf i.fj  || num_tc:, nolog or
 
*/ 
 
eststo, title("ZE FE"): quietly  melogit rj c.ln_dist##i.reforme_insuf c.ln_dist##i.insuff_actif c.ln_dist##i.reforme d_tc_traitement2-d_tc_traitement4 ///
insuff_actif reforme ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence i.quarter i.naf i.fj  i.ze,  nolog or


esttab using "$path_result//reg_distance.tex", star(* 0.10 ** 0.05 *** 0.01) b(3) p(3) drop(_cons *.naf *.fj *.quarter *.ze) nodep compress label replace booktabs ///
  alignment(D{.}{.}{-1}) title(Filing for reorganization \label{tab1})

eststo clear


*Deuxième test : effet placebo
*** Variables de placebo
gen reforme_placebo = (quarter>=194)
gen reforme_tc_placebo = reforme_placebo*tc_traitement
gen reforme_insuf_placebo = insuff_actif*reforme_placebo
gen reforme_insuf_tc_placebo = insuff_actif*tc_traitement*reforme_placebo

eststo, title("Simple"): melogit rj i.reforme_insuf_tc_placebo i.reforme_tc_placebo  d_insuf_tc2-d_insuf_tc4 i.reforme_insuf_placebo  ///
i.insuff_actif i.reforme_placebo d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence i.naf i.fj  ,  nolog or

eststo, title("Time FE"): quietly  melogit rj i.reforme_insuf_tc_placebo i.reforme_tc_placebo  d_insuf_tc2-d_insuf_tc4 i.reforme_insuf_placebo  ///
i.insuff_actif i.reforme_placebo d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence i.naf i.fj i.quarter ,  nolog or

/*
eststo, title("Court RE"): quietly  melogit rj d_reforme_insuf_tc2-d_reforme_insuf_tc4 d_reforme_tc2-d_reforme_tc4  d_insuf_tc2-d_insuf_tc4 reforme_insuf  ///
insuff_actif  d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence i.quarter i.naf i.fj  || num_tc:, nolog or
 */
 
 eststo, title("ZE FE"): quietly melogit rj i.reforme_insuf_tc_placebo i.reforme_tc_placebo  d_insuf_tc2-d_insuf_tc4 i.reforme_insuf_placebo  ///
i.insuff_actif i.reforme_placebo d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence i.naf i.fj  i.quarter i.ze,  nolog or

esttab using "$path_result//reg_placebo.tex", star(* 0.10 ** 0.05 *** 0.01) b(3) p(3) drop(_cons *.naf *.fj *.quarter *.ze) nodep compress label replace booktabs ///
  alignment(D{.}{.}{-1}) title(Filing for reorganization (placebo reform) \label{tab1})


 eststo clear

 *** TROISIEME SECTION : survie et plan

**1.2. survival after RJ
preserve
keep if rj==1
stset age_fin_et, failure(fail)

*Time FE
eststo, title("Simple"): quietly  mestreg d_reforme_insuf_tc2-d_reforme_insuf_tc4 d_reforme_tc2-d_reforme_tc4 d_insuf_tc2-d_insuf_tc4 reforme_insuf   ///
insuff_actif reforme d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence i.naf i.fj , distribution(llogistic)
 
*Time FE
eststo, title("Time FE"): quietly  mestreg d_reforme_insuf_tc2-d_reforme_insuf_tc4 d_reforme_tc2-d_reforme_tc4 d_insuf_tc2-d_insuf_tc4 reforme_insuf   ///
insuff_actif  d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence i.quarter i.naf i.fj , distribution(llogistic)

 *RE Courts
/*
eststo, title("Court RE"): quietly  mestreg d_reforme_insuf_tc2-d_reforme_insuf_tc4 d_reforme_tc2-d_reforme_tc4 d_insuf_tc2-d_insuf_tc4 reforme_insuf   ///
insuff_actif  d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence i.quarter i.naf i.fj  || num_tc:, distribution(llogistic)
*/
*FE ZE
eststo, title("ZE FE"): quietly  mestreg d_reforme_insuf_tc2-d_reforme_insuf_tc4 d_reforme_tc2-d_reforme_tc4 d_insuf_tc2-d_insuf_tc4 reforme_insuf   ///
insuff_actif  d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence i.quarter i.naf i.fj  i.ze, distribution(llogistic)

esttab using "$path_result//survival_rj.tex", star(* 0.10 ** 0.05 *** 0.01) b(3) p(3) drop(_cons *.naf *.fj *.quarter *.ze renta_eco couv_immo_fp  ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence) nodep compress label replace booktabs ///
  alignment(D{.}{.}{-1}) title(Survival in reorganization \label{tab2})

 eststo clear

**2.1 Survival pour Plan de reorg - RJ only
keep if rj==1
stset age_plan, failure(plan2)

*Time FE
eststo, title("Simple"): quietly  mestreg d_reforme_insuf_tc2-d_reforme_insuf_tc4 d_reforme_tc2-d_reforme_tc4 d_insuf_tc2-d_insuf_tc4 reforme_insuf   ///
insuff_actif reforme d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence i.naf i.fj , distribution(llogistic)
 
*Time FE
eststo, title("Time FE"): quietly  mestreg d_reforme_insuf_tc2-d_reforme_insuf_tc4 d_reforme_tc2-d_reforme_tc4 d_insuf_tc2-d_insuf_tc4 reforme_insuf   ///
insuff_actif  d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence i.quarter i.naf i.fj , distribution(llogistic)

 *RE Courts

eststo, title("Court RE"): quietly  mestreg d_reforme_insuf_tc2-d_reforme_insuf_tc4 d_reforme_tc2-d_reforme_tc4 d_insuf_tc2-d_insuf_tc4 reforme_insuf   ///
insuff_actif  d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence i.quarter i.naf i.fj  || num_tc:, distribution(llogistic)

*FE ZE
eststo, title("ZE FE"): quietly  mestreg d_reforme_insuf_tc2-d_reforme_insuf_tc4 d_reforme_tc2-d_reforme_tc4 d_insuf_tc2-d_insuf_tc4 reforme_insuf   ///
insuff_actif  d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence i.quarter i.naf i.fj  i.ze, distribution(llogistic)

esttab using "$path_result//survival_plan.tex", star(* 0.10 ** 0.05 *** 0.01) b(3) p(3) drop(_cons *.naf *.fj *.quarter *.ze renta_eco couv_immo_fp  ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence) nodep compress label replace booktabs ///
  alignment(D{.}{.}{-1}) title(Reorganisation plan accepted \label{tab2})


eststo clear

**2.2 Logit pour Plan de reorg - RJ only
keep if rj==1

eststo, title("Simple"): quietly  melogit plan_12m d_reforme_insuf_tc2-d_reforme_insuf_tc4 d_reforme_tc2-d_reforme_tc4  d_insuf_tc2-d_insuf_tc4 reforme_insuf  ///
insuff_actif reforme d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence i.naf i.fj  ,  nolog or

eststo, title("Time FE"): quietly  melogit plan_12m d_reforme_insuf_tc2-d_reforme_insuf_tc4 d_reforme_tc2-d_reforme_tc4  d_insuf_tc2-d_insuf_tc4 reforme_insuf  ///
insuff_actif  d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence i.quarter i.naf i.fj  ,  nolog or


eststo, title("Court RE"): quietly  melogit plan_12m d_reforme_insuf_tc2-d_reforme_insuf_tc4 d_reforme_tc2-d_reforme_tc4  d_insuf_tc2-d_insuf_tc4 reforme_insuf  ///
insuff_actif  d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence i.quarter i.naf i.fj  || num_tc:, nolog or

eststo, title("ZE FE"): quietly  melogit plan_12m d_reforme_insuf_tc2-d_reforme_insuf_tc4 d_reforme_tc2-d_reforme_tc4 d_insuf_tc2-d_insuf_tc4 reforme_insuf   ///
insuff_actif  d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence i.quarter i.naf i.fj  i.ze,  nolog or

esttab using "$path_result//reg_plan.tex", star(* 0.10 ** 0.05 *** 0.01) b(3) p(3) drop(_cons *.naf *.fj *.quarter *.ze renta_eco couv_immo_fp  ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence) nodep compress label replace booktabs ///
  alignment(D{.}{.}{-1}) title(Reorganisation plan accepted \label{tab2})
  
eststo clear
restore, preserve

eststo clear

  **2.3. survival after plan

keep if plan==1
stset age_fin_et, failure(fail)

* distribution llogistic
eststo, title("Simple"): quietly  mestreg d_reforme_insuf_tc2-d_reforme_insuf_tc4 d_reforme_tc2-d_reforme_tc4 d_insuf_tc2-d_insuf_tc4 reforme_insuf   ///
insuff_actif  d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence i.naf i.fj , distribution(llogistic)

* distribution llogistic
eststo, title("Time FE"): quietly  mestreg d_reforme_insuf_tc2-d_reforme_insuf_tc4 d_reforme_tc2-d_reforme_tc4 d_insuf_tc2-d_insuf_tc4 reforme_insuf   ///
insuff_actif  d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence i.quarter i.naf i.fj , distribution(llogistic)

*RE Courts

eststo, title("Court RE"): quietly  mestreg d_reforme_insuf_tc2-d_reforme_insuf_tc4 d_reforme_tc2-d_reforme_tc4 d_insuf_tc2-d_insuf_tc4 reforme_insuf   ///
insuff_actif  d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence i.quarter i.naf i.fj  || num_tc:, distribution(llogistic)
 
*FE ZE
eststo, title("ZE FE"): quietly  mestreg d_reforme_insuf_tc2-d_reforme_insuf_tc4 d_reforme_tc2-d_reforme_tc4 d_insuf_tc2-d_insuf_tc4 reforme_insuf   ///
insuff_actif  d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence i.quarter i.naf i.fj  i.ze, distribution(llogistic)


esttab using "$path_result//survival_plan_rj.tex", star(* 0.10 ** 0.05 *** 0.01) b(3) p(3) drop(_cons *.naf *.fj *.quarter *.ze) nodep compress label replace booktabs ///
  alignment(D{.}{.}{-1}) title(Survival in reorganization \label{tab3})

restore, preserve

eststo clear



 
/*
*	egen tc_time=group(num_tc quarter)
compress

/* local controlgroup1
local controlgroup2 */

eststo clear

*2.1. RJ
eststo, title("Time FE"): quietly  melogit rj d_reforme_insuf_tc2-d_reforme_insuf_tc4 d_reforme_tc2-d_reforme_tc4 ln_tc_vol d_insuf_tc2-d_insuf_tc4 reforme_insuf  ///
insuff_actif reforme d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
ln_age_entp ln_efence i.naf i.fj i.quarter , nolog or

eststo, title("ZE FE"): quietly  melogit rj d_reforme_insuf_tc2-d_reforme_insuf_tc4 d_reforme_tc2-d_reforme_tc4 d_insuf_tc2-d_insuf_tc4 reforme_insuf   ///
insuff_actif reforme d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence i.quarter i.naf i.fj  i.ze,  nolog or

eststo, title("Court RE"): quietly  melogit rj d_reforme_insuf_tc2-d_reforme_insuf_tc4 d_reforme_tc2-d_reforme_tc4 ln_tc_vol d_insuf_tc2-d_insuf_tc4 reforme_insuf  ///
insuff_actif reforme d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
ln_age_entp ln_efence i.naf i.fj i.quarter || num_tc:, nolog or

eststo, title("Court and ZE FE"): quietly  melogit rj d_reforme_insuf_tc2-d_reforme_insuf_tc4 d_reforme_tc2-d_reforme_tc4 ln_tc_vol d_insuf_tc2-d_insuf_tc4 reforme_insuf  ///
insuff_actif reforme d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
ln_age_entp ln_efence i.naf i.fj i.quarter i.ze || num_tc:, nolog or

esttab using "$path_result//reg_rj2.tex", star(* 0.10 ** 0.05 *** 0.01) b(3) p(3) drop(_cons *.naf *.fj *.quarter *.ze) nodep compress label replace booktabs ///
  alignment(D{.}{.}{-1}) title(Filing for reorganization \label{tab1})

eststo clear


**2.2 Plan de reorg - RJ only
preserve
keep if rj==1

eststo, title("Time FE"): quietly  melogit plan d_reforme_insuf_tc2-d_reforme_insuf_tc4 d_reforme_tc2-d_reforme_tc4 ln_tc_vol d_insuf_tc2-d_insuf_tc4 reforme_insuf  ///
insuff_actif reforme d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
ln_age_entp ln_efence i.naf i.fj i.quarter , nolog or

eststo, title("ZE FE"): quietly  melogit plan d_reforme_insuf_tc2-d_reforme_insuf_tc4 d_reforme_tc2-d_reforme_tc4 d_insuf_tc2-d_insuf_tc4 reforme_insuf   ///
insuff_actif reforme d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence i.quarter i.naf i.fj  i.ze,  nolog or

eststo, title("Court RE"): quietly  melogit plan d_reforme_insuf_tc2-d_reforme_insuf_tc4 d_reforme_tc2-d_reforme_tc4 ln_tc_vol d_insuf_tc2-d_insuf_tc4 reforme_insuf  ///
insuff_actif reforme d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
ln_age_entp ln_efence i.naf i.fj i.quarter || num_tc: , nolog or

eststo, title("Court and ZE FE"): quietly  melogit rj d_reforme_insuf_tc2-d_reforme_insuf_tc4 d_reforme_tc2-d_reforme_tc4 ln_tc_vol d_insuf_tc2-d_insuf_tc4 reforme_insuf  ///
insuff_actif reforme d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
ln_age_entp ln_efence i.naf i.fj i.quarter i.ze || num_tc:, nolog or

esttab using "$path_result//reg_plan2.tex", star(* 0.10 ** 0.05 *** 0.01) b(3) p(3) drop(*.naf *.fj *.quarter *.ze)  label replace booktabs ///
  alignment(D{.}{.}{-1}) title(Filing for liquidation \label{tab1})
  
eststo clear

**2.3. survival after RJ

stset age_fin_et, failure(fail)

* distribution llogistic
eststo, title("Time FE"): quietly  mestreg d_reforme_insuf_tc2-d_reforme_insuf_tc4 d_reforme_tc2-d_reforme_tc4 d_insuf_tc2-d_insuf_tc4 reforme_insuf   ///
insuff_actif reforme d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence i.quarter i.naf i.fj , distribution(llogistic)

*FE ZE
eststo, title("Court FE"): quietly  mestreg d_reforme_insuf_tc2-d_reforme_insuf_tc4 d_reforme_tc2-d_reforme_tc4 d_insuf_tc2-d_insuf_tc4 reforme_insuf   ///
insuff_actif reforme d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence i.quarter i.naf i.fj  i.ze, distribution(llogistic)

*RE Courts
eststo, title("Court FE"): quietly  mestreg d_reforme_insuf_tc2-d_reforme_insuf_tc4 d_reforme_tc2-d_reforme_tc4 d_insuf_tc2-d_insuf_tc4 reforme_insuf   ///
insuff_actif reforme d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence i.quarter i.naf i.fj  || num_tc:, distribution(llogistic)

*FE ZE & RE Courts
eststo, title("Court FE"): quietly  mestreg d_reforme_insuf_tc2-d_reforme_insuf_tc4 d_reforme_tc2-d_reforme_tc4 d_insuf_tc2-d_insuf_tc4 reforme_insuf   ///
insuff_actif reforme d_tc_traitement2-d_tc_traitement4 ln_dist ln_tc_vol renta_eco couv_immo_fp   ///
 ln_s_ee_b0 ln_s_fl_b0 ln_age_entp ln_efence i.quarter i.naf i.fj i.ze || num_tc:, distribution(llogistic)


esttab using "$path_result//survival_rj2.tex", star(* 0.10 ** 0.05 *** 0.01) b(3) p(3) drop(*.naf *.fj *.quarter *.ze)  label replace booktabs ///
  alignment(D{.}{.}{-1}) title(Filing for liquidation \label{tab1})

restore
eststo clear
