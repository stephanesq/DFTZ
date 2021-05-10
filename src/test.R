

pull (dftz, pcl) %>%
  table () %>%
  as.data.frame () %>%
  datatable (rownames = FALSE, colnames = c ("pcl", "Nombre"))


tab <- dftz %>% select (num_tc_2009,tc_traitement) %>%
  droplevels () %>% 
  table () %>% 
    as.data.frame () %>% 
  spread (key = tc_abs, value = Freq) %>% 
  datatable (caption = "VENTILATION DES COMMUNES PAR REGION ET PAR CLASSE DE ZAU")
tab

tab <- dftz %>% select (reforme,tc_abs) %>%
  droplevels () %>% 
  table () %>% 
  as.data.frame () %>% 
  spread (key = tc_abs, value = Freq) %>% 
  datatable (caption = "VENTILATION DES COMMUNES PAR REGION ET PAR CLASSE DE ZAU")
tab


tab <- dftz %>% select (reforme,tc_traitement) %>%
  droplevels () %>% 
  table () %>% 
  as.data.frame () %>% 
  spread (key = tc_traitement, value = Freq) %>% 
  datatable (caption = "VENTILATION DES COMMUNES PAR REGION ET PAR CLASSE DE ZAU")
tab

tab <- dftz %>% select (tc_abs,tc_traitement) %>%
  droplevels () %>% 
  table () %>% 
  as.data.frame () %>% 
  spread (key = tc_traitement, value = Freq) %>% 
  datatable (caption = "VENTILATION DES COMMUNES PAR REGION ET PAR CLASSE DE ZAU")
tab
