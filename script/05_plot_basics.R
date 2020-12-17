#' ---
#' title: "Plotting with ggplot2 - lecture code basics"
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


#' # Grammar of graphics

#' What does ggplot2 stand for?
#' A Grammar of Graphics!
#'                                                  <br/>
#'                                                  <br/>
#'  **ggplot**(data = "DATA") +                     <br/>
#'  "**GEOM_FUNCTION**"(                            <br/>
#'    mapping = aes("**MAPPINGS**"),                <br/>
#'    stat = "**STAT**",                            <br/>
#'    position = "**POSITION**"                     <br/>
#'  ) +                                             <br/>
#'  "**COORDINATE_FUNCTION**" +                     <br/>
#'  "**FACET_FUNCTION**"                            <br/>


#' You can uniquely describe any plot as a combination of these 7 parameters.

#' # Read Data

#' Let's start with reading our soil dataset

df = read.csv("data/soil_data.csv")
df = rename(df, texture = textabbr_fingprob, ph = ph_cacl2, som = som_elmntprc, 
            p = p_calmg100g , k = k_calmg100g, mg = mg_catmgkg, b =  b_catmgkg , 
            mn = mn_catmgkg,cu =  cu_catmgkg,zn =  zn_catmgkg)

#' Now we attach the data to a ggplot
#' the **ggplot()** function initiates a plot


p <- ggplot(df)

#' If I plot this I do not see anything (yet)

p


#' # MAPPING and adding a geom function

#' Let's see the arguments of a geom function

args(geom_point)

#' We add the geom functions and it's aesthetics aes() [the columns we want to see].
#' Notice how we can add ggplot functions with the **+**, this works with any function and
#' you can chain all the elements of your plot this way 


p <-p + geom_point(aes(x=cu,y=zn))
p
#p + geom_line(aes(x=cu,y=zn)) + geom_point(aes(x=cu,y=zn))

#' Now we see something but it's a mess. Why? Maybe because this correlation is only valid
#' for a specific group of samples...

#

#' # FACETS

#' To avoid the mess we build a different plot for each landuse.
#' **facet_wrap()** does this, it takes as first argument a categorical
#' variable in your dataset (place *~* before the name) and splits the plot
#' into "facets"

#'
p<- p +
  facet_wrap(~landuse)
p


#' # Theme
#' We add a classic theme. The **theme_** functions are a series of
#' shortcuts functions to customize the appearence of your plot

p<-p + theme_classic(base_size = 50)
p

#p + theme_dark()

#' # Color mapping
#' To wrap it up and show the mapping of color
#' we also place the legend at the bottom with the funciton **theme()** 
#' and add title with **ggtitle()**
#' and axis lables with **labs()**

ggplot(df)+
  geom_point(aes(x = cu,y = zn,color = landuse, shape = landuse,size = clay))+ 
  facet_wrap(~landuse,scales = "free")+
  ggtitle("This is a great title!")+
  labs(x = "Cu [mg/kg]",y = "Zn [mg/kg]")+
  theme_classic(base_size = 20)+
  theme(legend.position = "bottom")

#' Change the color with **scale_color_manual()**. In the function you can
#' specify a vector of colors "manually". Here a list of available colors in R
#' http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf.
#' 
#' But you can also specify hexadecimals like this #1fab9e and #c6464a .
#' To find beautiful palettes I usually go here:
#' https://coolors.co/palettes

ggplot(df)+
  geom_point(aes(cu,zn,color=landuse))+ 
  facet_wrap(~landuse,scales = "free")+
  scale_color_manual(values = c("red","green"))+
  ggtitle("This is a great title!")+
  labs(x = "Cu [mg/kg]",y = "Zn [mg/kg]")+
  theme_classic(base_size = 20)+
  theme(legend.position = "bottom")

#' Coords
#' **coord_cartesian()** allows you to zoom in the plot by specifying
#' the limits for which to plot the axis 

ggplot(df)+
  geom_point(aes(cu,zn,color=landuse))+ 
  facet_wrap(~landuse,scales = "free")+
  scale_color_manual(values = c("red","green"))+
  coord_cartesian(xlim = c(0,100),ylim = c(0,100))+
  ggtitle("This is a great title!")+
  labs(x = "Cu [mg/kg]",y = "Zn [mg/kg]")+
  theme_classic(base_size = 20)+
  theme(legend.position = "bottom")
