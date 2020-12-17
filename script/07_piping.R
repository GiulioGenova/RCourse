#' ---
#' title: "What is a pipe in R - lecture code"
#' author: "Giulio Genova - giulio.genova@eurac.edu"
#' date: "2020"
#' output:
#'   html_document:
#'     toc: false
#'     toc_float: true
#' ---

#' Pipes

#' nice tutorial on pipes by Data Camp
#' https://www.datacamp.com/community/tutorials/pipe-r-tutorial


#' Pipe is implemented in the package magrittr
library(magrittr)
library(dplyr)

df = read.csv("data/soil_data.csv")
df = rename(df, texture = textabbr_fingprob, ph = ph_cacl2, som = som_elmntprc, 
            p = p_calmg100g , k = k_calmg100g, mg = mg_catmgkg, b =  b_catmgkg , 
            mn = mn_catmgkg,cu =  cu_catmgkg,zn =  zn_catmgkg)


#' This
group_by(df,landuse)
#' is equal to this
df %>% group_by(landuse)


#' This
summarise(.data = group_by(df,landuse), n=n(),
         Cu_below_25 = sum(cu<=25),
         Cu_above_25 = sum(cu>25),
         Cu_above_50 = sum(cu>50),
         Cu_above_100 = sum(cu>100),
         Cu_above_200 = sum(cu>200),
         Cu_above_400 = sum(cu>400))

#' is equal to this

df %>% group_by(landuse) %>% 
  summarise(n=n(),
            Cu_below_25 = sum(cu<=25),
            Cu_above_25 = sum(cu>25),
            Cu_above_50 = sum(cu>50),
            Cu_above_100 = sum(cu>100),
            Cu_above_200 = sum(cu>200),
            Cu_above_400 = sum(cu>400))