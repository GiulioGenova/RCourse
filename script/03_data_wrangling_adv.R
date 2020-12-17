#' ---
#' title: "Data wrangling advanced - lecture code"
#' author: "Giulio Genova - giulio.genova@eurac.edu"
#' date: "2020"
#' output:
#'   html_document:
#'     toc: true
#'     toc_float: true
#' ---

#' # Libraries
#' We will use {dplyr}
library(dplyr)

#' # Code from previous script
#' The following is the legacy code from the script "03_data_wrangling_adv.R"
#' From the dataframes created there we will do some more advanced selection and
#' summarising 

df = read.csv("data/soil_data.csv")
df = rename(df, texture = textabbr_fingprob, ph = ph_cacl2, som = som_elmntprc, 
            p = p_calmg100g , k = k_calmg100g, mg = mg_catmgkg, b =  b_catmgkg , 
            mn = mn_catmgkg,cu =  cu_catmgkg,zn =  zn_catmgkg)
df_sel = select(df,landuse, texture, ph, som, cu , zn)
df_sel_mut = mutate(df_sel, cu_log = log(cu), zn_log = log(zn))
df_sel_filt = filter(df_sel, cu > 400, ph <= 6.7)
df_sel_grouped  = group_by(df_sel,landuse)

#' # select_if
#' What if I want to summarize all the variables inside your dataframe?
#' 
#' Firstly you need to make sure that all the variables you want to summarise
#' fit your summary functions. In this case we will use functions like mean or min
#' that can only be used with numerics.
#' We then need to select the numeric variables only. We can do that with **select_if()**.
#' This function takes a dataframe as first argumenta ad a "predicate" as secod.
#' A predicate is a function that checks the characteristic of the variables to select.
#' In our case we will use the **is.numeric()** function, this will output *TRUE* or *FALSE*
#' whether the variable is numeric or not. Notice that we use the function without the ().

df_sel_grouped_num = select_if(df_sel_grouped, is.numeric)

#' # summarise_all
#' You can now use the **summarise_all()** function to summarise all the variables in the 
#' dataframe. Notice how since we are using a goruped dataframe **select_if()** retained 
#' the grouping variable *landuse* and now **summarise_all()** will make the summary
#' for each group. **summarise_all()** takes a dataframe as first argument and a **list()**
#' of summary functions as second argument. The functions ar specified as follows:
#' "function"(., "additional arguments"). The dot (.) is needed to work with all the
#' different variables, after that you might want to specify additinal agruments to the
#' summary function you selected. In this example we use **mean()** and **min()** and
#' specify the *na.rm* argument as *TRUE*.

summarise_all(df_sel_grouped_num,
              list(mean = ~mean(.,na.rm = TRUE)),min = ~min(.,na.rm = T))


#' There are also other ways to use **summarise_all()**.
#' If you have only one function to specify you can:

summarise_all(df_sel_grouped_num,mean)

#' or if you do not want to specify additional arguments you can:

summarise_all(df_sel_grouped_num,list(mean = mean,min = min,max = max, n = length, sd = sd))

#' If you only have one function you can place the additional arguments of the
#' summary function as  the following
summarise_all(df_sel_grouped_num, list(Q3 = quantile), probs = 0.75)    

