#' ---
#' title: "Plotting with ggplot2 - lecture code exaples"
#' author: "Giulio Genova - giulio.genova@eurac.edu"
#' date: "2020"
#' output:
#'   html_document:
#'     toc: true
#'     toc_float: true
#' ---

#' This tutorial gives you an overview on how to plot using the R package ggplot2. 
#' For this tutorial it is required to install the following packages:


library(ggplot2)
library(dplyr)


#' # Read Data

#' Let's start with reading our soil dataset

df = read.csv("data/soil_data.csv")
df = rename(df, texture = textabbr_fingprob, ph = ph_cacl2, som = som_elmntprc, 
            p = p_calmg100g , k = k_calmg100g, mg = mg_catmgkg, b =  b_catmgkg , 
            mn = mn_catmgkg,cu =  cu_catmgkg,zn =  zn_catmgkg)

#' # Box plot
#' Let's try a boxplot for cu
#' you can do "mapping" of the aesthetics direcly in the **ggplot()** funciton
#' you wou want your **geom_** functions to intherit them

ggplot(df,aes(y = cu))+
  geom_boxplot()

#' The previous works but it is not really informative.
#' Let's try make it better. We map the "x" axis to to landuse
#' to make as many boxplots as the categories of landuse

ggplot(df,aes(y = cu,x = landuse))+
  geom_boxplot()+
  coord_flip()

ggplot(df,aes(y = landuse,x = cu))+
  geom_boxplot()

#' Add color 

ggplot(df,aes(y = cu,x = landuse,color = landuse))+
  geom_boxplot()

#' Add fill

ggplot(df,aes(y = cu,x = landuse,fill = landuse))+
  geom_boxplot()

#' # Bar plot
#' Let's try a bar plot for landuse

ggplot(df,aes(landuse))+
  geom_bar()

#' And of texture

ggplot(df,aes(texture,fill = texture))+
  geom_bar()

#' # Stacked bar plot
#' Stacked bar plot. The basic version works but is not very informative as 
#' orchards are much more than vineyards

ggplot(df, aes(fill=texture, x=landuse)) + 
  geom_bar()

#' We now change the way the bars a stacked using *position = "fill"*
#' in **geom_bar()**

ggplot(df,aes(x=landuse,fill=texture))+ 
  labs(y=NULL,x="")+
  geom_bar(position = "fill",colour="black",width = 0.75)+
  scale_y_continuous(labels = scales::percent)

#' Could make sense to invert the aesthetics. We plot texture on the
#' x axis and landuse to fill

ggplot(df,aes(x=texture,fill=landuse))+ 
  labs(y=NULL,x="")+
  geom_bar(position = "fill",colour="black",width = 0.75)+
  scale_fill_manual (values =c("black","white"))+
  scale_y_continuous(labels = scales::percent)+
  theme_minimal()
