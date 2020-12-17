#' ---
#' title: "Introduction to R and RStudio - lecture code"
#' author: "Giulio Genova - giulio.genova@eurac.edu"
#' date: "2020"
#' output:
#'   html_document:
#'     toc: true
#'     toc_float: true
#' ---

#+ setup, include=FALSE
knitr::opts_chunk$set(collapse = TRUE)

#' # Overview on RStudio
#' The Panes. The script the Console the Environment
#' 
#' In the upper left pane you find your scripts. This is where you write code and eventually execute it
#' by pressing **CTRL** **ENTER** (Windows) or clicking the **Run** button
#' 
#' In the bottom left pane you find the console. This is where you can type code and execute it (hit *ENTER*)
#' without saving it. All the code and outputs you execute (also coming from scripts) will be shown here
#' 
#' In the upper right corner you find the Environment. This is where you can see all the variables you created.
#' 
#' # Coding
#' basic operations:
#' 
#' An addition

5 + 5 

#' A subtraction

5 - 5 

#' A multiplication

3 * 5

#' A division

(5 + 5) / 2 

#' Exponentiation

2^4


#' # Libraries and packages
#' difference between install.packages and library
#'

#install.packages("ggplot2")

library(ggplot2)

#' # Working directory
#' 
#' Why is it important?
#' It changes the directory where R looks for things by default. 
#' To know where is the current working directory you can type:

getwd()

#' to change the working directory you can specify a path.
#' If the directory is inside your working directory you can simpy type its name:

#setwd("data")


#' to go back to the upper level (previous) directory you type:

#setwd("..")


#' # Functions and the help
#' 
#' Ho to use functions and understand what they do:
#' 
#' We start from the funciton **read.csv()** which allows you to load a csv (comma-separated values)
#' a function has the form **<function_name>()**
#' in the parenthesis you write your inputs accordind to what the function is expecting.
#' The inputs of a function are called arguments. Here below we used two arguments "file" and "header"
#' file is set to "data/soil_data.csv" since the file is in the "data" directory which is in
#' our working directory. So in this case we are using what is called a **relative path**.

df = read.csv(file = "data/soil_data.csv",header = TRUE)

#' To have an idea on how the dataset looks like we can see the first lines as follows

head(df) 

#' # Intall a package to read excel files
#' If you want to import an excel file directly there are no functions in base R to do that.
#' So you are going to have to install a package that does that. In this case we use the package {radxl}
#' and we install it with the command install.packages("readxl")
#' We then load it with the funciton **library()**

library(readxl)

#' Once readxl is loaded we can use the functions it provides us.
#' To see the documentation for the function read_xlsx

?read_xlsx

#' The documentation will appear in the bottom right pane in the **Help** tab
#' By looking at the documentation we understood that **read_xlsx** wants the path
#' to the file we want to read as the **path** argument we call the function as follows:

xslx_file = read_xlsx(path = "data/test.xlsx")

xslx_file

#' # The history
#' The history stores all the commands you typed
#' if you type

history()

#' you will see it in the upper right pane in the **History** tab
