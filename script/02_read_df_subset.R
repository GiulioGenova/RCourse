#' ---
#' title: "Read dataframes - lecture code"
#' author: "Giulio Genova - giulio.genova@eurac.edu"
#' date: "2020"
#' output:
#'   html_document:
#'     toc: true
#'     toc_float: true
#' ---

#' # Read data
#' We read our soil data using the **read.csv()** function ad we assign the dataframe to the variable df.
#' 

df = read.csv(file = "data/soil_data.csv",stringsAsFactors = TRUE)

#' This time we set the argument **stringsAsFactors = FALSE to demonstrate how the character columns can be red 
#' either as factors or as characters. We assign this dataframe to the variable df_char
#' 

df_char = read.csv(file = "data/soil_data.csv",stringsAsFactors = FALSE)

#' we check the class of the landuse column in the two dataframes

class(df$landuse)
levels(df$landuse)
class(df_char$landuse)

#' # A first look at our data
#' R has a **summary()** function that can be applied to may objects like vectors, dataframes,
#'  and also linear models and other kinds of R objects
#'  here we use it on our dataframe
#' This gives us interesting insights ad allows us to start thinking about our future analysis.
#' Notice how the summary of df for landuse and texture are more infromative than the one for df_char.
#' This is because df_char has only characters while df has factors.

summary(df)
summary(df_char)

#' # Subsetting (filtering)
#' You can subset (filter) a dataframe by rows and columns ids (position).
#' The syntax is the following **"dataframe name"["row indexes","column indexes"]**.
#' 
#' Here we subset the dataframe df selecting the first 10 rows (from 1 to 10) and the first 5 columns (from 1 to 5)

df[1:10,1:5]

#' Another way of subsetting is to use boolean vectors (vectors of TRUE or FALS values).
#' For instance if we want to know which rows (our samples) have a Cu concentration higher than 400
#' we type the following. We will get a very long vector with a list of TRUE and FALSE values

df$cu_catmgkg > 400

#' We can use this vector to select the rows that fulfill that condition (just like we did with vecots).
#' 
#' we assign this filtered dataframe to the variable df_cu_high.
#' 
df_cu_high = df[df$cu_catmgkg > 400,]

#' And we print it to see what ve have selected

df_cu_high

#' We can also store our boolean vecotr into a variable (here called filter_cu) and use that variable
#' as filter for the dataframe's rows

filter_cu = df$cu_catmgkg > 400
df_cu_high = df[filter_cu,]

#' And we get the same result

df_cu_high

#'   