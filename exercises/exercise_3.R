############################################################################################
# PART 1
############################################################################################

# load the dplyr package with the function library()

# Read the csv soil_data in the data directory assing the data frame to the variable df

# Rename the variables in the dataframe as follows:
# land_use = landuse texture = textabbr_fingprob  ph = ph_cacl2  som = som_elmntprc 
# p = p_calmg100g  k = k_calmg100g

# Select only those variables that you renamed. store your result in a new dataframe

# Group the last dataframe you created by both land_use and texture

# Get the median of all the variables in the grouped dataframe (besides the grouping variables)
# how many rows and columns now are there in this data frame?
# store your result in a new dataframe.
# hint: R has a median() function

# save your result in the output directory


############################################################################################
# PART 2
############################################################################################

# load the dplyr package with the function library()

# Read the csv soil_data in the data directory assing the data frame to the variable df

# Rename the variables in the dataframe as follows:
# land_use = landuse texture = textabbr_fingprob  mg = mg_catmgkg  b =  b_catmgkg  
# mn = mn_catmgkg cu =  cu_catmgkg zn =  zn_catmgkg

# Select only those variables that you renamed. store your result in a new dataframe


# Filter the dataframe you just created keeping the three most common texture classes.
# To know which ones are the most common classes you can do summary() of the 
# column texture of the dataframe. then you can filter using the %in% operator
# and creating a character vector with the three desired classes


# Group the last dataframe you created by both land_use and texture

# Get the standard deviation minimum and maximum of all the variables in the grouped dataframe (besides the grouping variables)
# how many rows and columns now are there in this data frame?
# store your result in a new dataframe.
# hint: R has a sd() function for the standard deviation
