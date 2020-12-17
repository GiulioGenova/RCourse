#' ---
#' title: "Flextable - lecture code"
#' author: "Giulio Genova - giulio.genova@eurac.edu"
#' date: "2020"
#' output:
#'   html_document:
#'     toc: false
#'     toc_float: true
#' ---

library(flextable)
library(officer)
library(dplyr)

df = read.csv("data/soil_data.csv")

df = select(df, landuse, texture = textabbr_fingprob, ph = ph_cacl2, som = som_elmntprc, 
            p = p_calmg100g , k = k_calmg100g, mg = mg_catmgkg, b =  b_catmgkg , 
            mn = mn_catmgkg,cu =  cu_catmgkg,zn =  zn_catmgkg, clay, sand)



myft <- flextable(
  head(df),
  col_keys = colnames(df))

myft

df_grouped = group_by(df,landuse,texture)

df_grouped_summar = summarise(df_grouped,
                                  cu_min = min(cu), 
                                  cu_mean = mean(cu),
                                  cu_max = max(cu), 
                                  zn_min = min(zn), 
                                  zn_mean = mean(zn),
                                  zn_max = max(zn))

df_grouped_summar$cu_mean = round(df_grouped_summar$cu_mean,digits = 0)
df_grouped_summar$zn_mean = round(df_grouped_summar$zn_mean,digits = 0)

myft_2 <- flextable(df_grouped_summar)

myft_2

myft_3 <- flextable(df_grouped_summar)
myft_3 <- merge_v(myft_3, j = c("landuse", "texture") )
myft_3 <- autofit(myft_3)
myft_3


save_as_docx("Summary for Cu and Zn" = myft_2, 
             path = "output/doc_test_2.docx")

save_as_docx("Summary for Cu and Zn" = myft_3, 
             path = "output/doc_test_3.docx")
