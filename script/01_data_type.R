#' ---
#' title: "Data type and logical operators - lecture code"
#' author: "Giulio Genova - giulio.genova@eurac.edu"
#' date: "2020"
#' output:
#'   html_document:
#'     toc: false
#'     toc_float: true
#' ---

#' A few things about data type and vecotrs
#' 
#' It is important to know that if you sum two vectors in R, it takes the element-wise sum. 
#' For example, the following three statements are completely equivalent:

c(1, 2, 3) + c(4, 5, 6)
c(1 + 4, 2 + 5, 3 + 6)
c(5, 7, 9)

#' You can also do the calculations with variables that represent vectors:

a <- c(1, 2, 3) 
b <- c(4, 5, 6)
c <- a + b
c

#' Assign the value 66 to x
x <- 66

#' check class of x

class(x)

#' create a numeric vector y

y <- c(1,34,6,7)

#' check class of x

class(y)

#' get the second element of the vector
y[2]

#' assign it to variable

elem_2 = y[2]

#' you can use a vector to access the element(s) of the vector

y[c(1,2)]

#' you can use a vector of booleans (TRUE, FALSE) to access the element(s) of the vector

y[c(TRUE,TRUE,FALSE,FALSE)]

#' you can exclude an alement by its position by placing a minus "-" in front of its index

y[-2]

#' multiply x with y. This will be elemntwise

x*y

#' logical operators

4 > 6
4 == 6
4 != 6

#' this works for vectors too

y<34

#' this means you can select the elements of a vector that fulfill a certain condition

y[y<34]

#' create a character vector z

z = c("one","two","three","four")

#' you can't add a character to a vector

# z + y
#' as it would give and error

#' Sometimes you can coerce a character into numeric

char = c("1","2","3","4")
num = as.numeric(char)

#' R tries to guess the number from the caracter

char_2 = c("1","2","3","4","two")
num_2 = as.numeric(char_2)

#' in this case the character "two" cannot be coerced to numeric and yelds NA (Not a number)

num_2

#' Now you can multipy num with x or y

num * y
num * x

#' If two vectors do not have the same lenght the shortest gets recycled

num * c(1,3)
