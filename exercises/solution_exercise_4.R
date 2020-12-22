# load the ggplot2 and the dplyr package with the function library()

library(ggplot2)
library(dplyr)

# Read the csv soil_data in the data directory assing the data frame to the variable df

df <- read.csv(file = "data/soil_data.csv")

# Rename the variables in the dataframe as follows:
# land_use = landuse texture = textabbr_fingprob  ph = ph_cacl2  som = som_elmntprc 
# p = p_calmg100g  k = k_calmg100g

df <- rename(df, land_use = landuse, texture = textabbr_fingprob,
             ph = ph_cacl2, som = som_elmntprc, 
             p = p_calmg100g, k = k_calmg100g)

# create a boxplot of p where the categorical variable is the texture

ggplot(data = df, aes(x = p, texture))+
  geom_boxplot()

# color the boxplots according to the texture they represent

ggplot(data = df, aes(x = p, texture,color = texture))+
  geom_boxplot()

# add a theme_ of your choice

ggplot(data = df, aes(x = p, texture,color = texture))+
  geom_boxplot()+
  theme_minimal()

# save your result in the output directory.
# Hint: there is a ggsave() function in ggplot2

# first save the plot into a variable 'plot'

plot = ggplot(data = df, aes(x = p, texture,color = texture))+
  geom_boxplot()+
  theme_minimal()

ggsave(filename = "output/plot_exercise_4.png", plot = plot,
       device = "png", width = 10,height = 6, dpi = 300)
# note that you can specify the resolution (dpi) and 
# height and width (in inches in this case)
