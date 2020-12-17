#' ---
#' title: "Data wrangling - lecture code"
#' author: "Giulio Genova - giulio.genova@eurac.edu"
#' date: "2020"
#' output:
#'   html_document:
#'     toc: true
#'     toc_float: true
#' ---

#' # Data wrangling
#' Data wrangling, sometimes referred to as data munging, is the process of 
#' transforming and mapping data from one "raw" data form into another format with the 
#' intent of making it more appropriate and valuable for a variety of downstream purposes 
#' such as analytics.
#' 

# source: https://en.wikipedia.org/wiki/Data_wrangling

#' # Libraries
#' We will use {dplyr}
library(dplyr)

#' # Read
#' We read the soil dataset as we did in the last lecture

df = read.csv("data/soil_data.csv")

#' # Rename
#' **rename()** is a convenient function that allows you to rename the columns of your dataframe.
#' The first argument of the function is the dataframe you want to rename (df in this case) and 
#' the following arguments are written in the form of "new name" = "old name" 

df = rename(df, texture = textabbr_fingprob, ph = ph_cacl2, som = som_elmntprc, 
            p = p_calmg100g , k = k_calmg100g, mg = mg_catmgkg, b =  b_catmgkg , 
            mn = mn_catmgkg,cu =  cu_catmgkg,zn =  zn_catmgkg)

#' # Select
#' **select()** allows you to select the columns from a dataframe.
#' The first argument of the function is the dataframe (df in this case) and 
#' the following arguments are written the column names you wan to retain, 
#' the rest of the columns will be deleted. 
#' We call this new smaller dataframe df_sel

df_sel = select(df,landuse, texture, ph, som, cu , zn)

head(df_sel)

#' # Mutate
#' **mutate()** allows you to modify the values in a dataframe.
#' The first argument of the function is the dataframe (df_sel in this case) and 
#' the following arguments in the form of "new name" = "expression". The expression 
#' can be several things, in this case we use the function **log()** (natural logarithm). 
#' The nice thing about this is that we can use other variables (columns) of the dataframe
#' inside the expression. In this case we will create *cu_log* and *zn_log* using the **log()**
#' of the variables *cu* and *zn*.
#' We call this new dataframe df_sel_mut

df_sel_mut = mutate(df_sel, cu_log = log(cu), zn_log = log(zn))

head(df_sel_mut)

#' # Filter
#' **filter()** allows you to filter a dataframe according to the values (rows).
#' In other words it consists of subsetting the dataframe by row.
#' The first argument of the function is the dataframe (df_sel in this case) and 
#' the following arguments are in the form of "logical expression". This logical expression 
#' can be a vector of *TRUE* and *FALSE* values (same length as number of rows), 
#' or can be a logical evaluation of the variables (columns) of the dataframe. 
#' In this case we want to filter for all the rows that have *cu* > 400 and *ph* <= 6.7.
#' We call this new dataframe df_sel_filt

df_sel_filt = filter(df_sel, cu > 400, ph <= 6.7)

df_sel_filt

#' # Gorup by and summarise
#' **group_by()** lets you group dataframe values by one or more categories
#' The first argument of the function is the dataframe (df_sel in this case) and
#' the other agruments are the variables with which we want to create the gorups.
#' In this case we gorup by landuse.
#' We call this new dataframe df_sel_grouped. Notice how appearently nothing changed to the
#' dataframe (it looks identical to df_sel). But if you check its class you will see ti is
#' actually a grouped dataframe. But what do I do with that?

df_sel_grouped  = group_by(df_sel,landuse)

head(df_sel_grouped)
head(df_sel)

class(df_sel_grouped)

#' **group_by()** just groups your dataframe, it does not change its values. **group_by()** is
#' used in combination to **summarise()** to make summary statistics by group.
#' So **summarise()** takes a grouped dataframe as first argument the following arguments 
#' in the form
#' of "new name" = "expression" where "new name" is a variable name and "expression" 
#' is any function 
#' returning one value from a list of values. So the "expression" is going to be a 
#' summary funciton like **mean()**, **median()**, **max()**, **min()**, **sum()**.
#' Here we compure the mean of *cu* and *zn* by *landuse* and save the result into
#' df_sel_grouped_summar. As you can see the new dataframe has two rows (landuse categories)
#' and three columns: *landuse* and the computed minimum, mean and maximum values 
#' for *cu* and *zn*
#' 

df_sel_grouped_summar = summarise(df_sel_grouped,
                                  cu_min = min(cu), 
                                  cu_mean = mean(cu),
                                  cu_max = max(cu), 
                                  zn_min = min(zn), 
                                  zn_mean = mean(zn),
                                  zn_max = max(zn))

df_sel_grouped_summar

#' # Save results
#' We now want to save our work. We will save the *df_sel* and the 
#' *df_sel_grouped_summar* dataframes. Since we consider them outputs 
#' of our work we save them into the *output* directory.
#' We save them as csv files so we use the functon **write.csv()**

write.csv(x = df_sel,file = "output/soil_data_sel.csv",
          quote = FALSE,row.names = FALSE)

write.csv(x = df_sel_grouped_summar,file = "output/soil_data_summary_cu_zn.csv",
          quote = FALSE,row.names = FALSE)

