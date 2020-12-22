############################################################################################
# PART 1
############################################################################################

# load the dplyr package with the function library()

library(dplyr)

# Read the csv soil_data in the data directory assing the data frame to the variable df

df <- read.csv("data/soil_data.csv")

# Rename the variables in the dataframe as follows:
# land_use = landuse texture = textabbr_fingprob  ph = ph_cacl2  som = som_elmntprc 
# p = p_calmg100g  k = k_calmg100g

df <- rename(df, land_use = landuse, texture = textabbr_fingprob,
             ph = ph_cacl2, som = som_elmntprc,
             p = p_calmg100g, k = k_calmg100g)

# Select only those variables that you renamed. store your result in a new dataframe

df_selected <- select(df, land_use, texture, ph, som, p, k)

# Group the last dataframe you created by both land_use and texture

df_selected_grouped <- group_by(df_selected, land_use, texture)

# Get the median of all the variables in the grouped dataframe (besides the grouping variables)
# how many rows and columns now are there in this data frame?
# store your result in a new dataframe.
# hint: R has a median() function

df_summary <- summarise(df_selected_grouped,
                        ph = median(ph, na.rm = TRUE),
                        som = median(som, na.rm = TRUE),
                        p = median(p, na.rm = TRUE),
                        k = median(k, na.rm = TRUE))

#or

df_summary <- summarise_all(df_selected_grouped,
                            ~ median(.x, na.rm = TRUE))
  
#or (with the new version of dplyr with the function across())

df_summary <- summarise(df_selected_grouped,
                            across(c("ph","som","p","k"),~ median(.x, na.rm = TRUE)))

# save your result in the output directory

write.csv(x = df_summary, file = "output/df_summary.csv")

############################################################################################
# PART 2
############################################################################################

# load the dplyr package with the function library()

library(dplyr)

# Read the csv soil_data in the data directory assing the data frame to the variable df

df <- read.csv("data/soil_data.csv")

# Rename the variables in the dataframe as follows:
# land_use = landuse texture = textabbr_fingprob  mg = mg_catmgkg  b =  b_catmgkg  
# mn = mn_catmgkg cu =  cu_catmgkg zn =  zn_catmgkg

df <- rename(df, 
             land_use = landuse, texture = textabbr_fingprob,
             mg = mg_catmgkg,  b =  b_catmgkg,  
             mn = mn_catmgkg, cu = cu_catmgkg, zn =  zn_catmgkg)

# Select only those variables that you renamed. store your result in a new dataframe

df_selected <- select(df, land_use, texture, mg, b, mn, cu, zn)

# Filter the dataframe you just created keeping the three most common texture classes.
# To know which ones are the most common classes you can do summary() of the 
# column texture of the dataframe. then you can filter using the %in% operator
# and creating a character vector with the three desired classes

# in order to see summary statistics of the texture column we need to convert
# this column into a factor:

df_selected$texture <- as.factor(df_selected$texture)


summary(df_selected)

# now we can see that the first three soil texture classes are Sl3 Us Sl2

df_filtered <- filter(df_selected, texture %in% c("Sl3","Us","Sl2"))

# Group the last dataframe you created by both land_use and texture

df_grouped <- group_by(df_filtered, texture, land_use)


# Get the standard deviation minimum and maximum of all the variables in the grouped dataframe (besides the grouping variables)
# how many rows and columns now are there in this data frame?
# store your result in a new dataframe.
# hint: R has a sd() function for the standard deviation

df_summary <- summarise_all(df_grouped,
                            list(min = ~ min(., na.rm = TRUE),
                                 max = ~ max(., na.rm = TRUE),
                                 sd = ~ sd(., na.rm = TRUE)))
