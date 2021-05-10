

pull (dftz, pcl) %>%
  table () %>%
  as.data.frame () %>%
  datatable (rownames = FALSE, colnames = c ("pcl", "Nombre"))