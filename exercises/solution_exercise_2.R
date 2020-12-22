# Read the csv iris in the data directory

read.csv(file = "data/iris.csv")

# assing the data frame to the variable df


df <- read.csv(file = "data/iris.csv")

# what variables (columns) are inside df?

colnames(df)

# what is the class of each column?

class(df$Sepal.Length)
class(df$Sepal.Width)
class(df$Petal.Length)
class(df$Petal.Width)
class(df$Species)

# compute basic statistics of all the variables inside df

summary(df)

# select only the rows belonging to the setosa variety

df_selected = df[df$Species == "setosa", ]

# compute again the basic statistics

summary(df_selected)
