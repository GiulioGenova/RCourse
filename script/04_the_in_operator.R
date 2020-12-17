#' ---
#' title: "The %in% operator - lecture code"
#' author: "Giulio Genova - giulio.genova@eurac.edu"
#' date: "2020"
#' output:
#'   html_document:
#'     toc: false
#'     toc_float: true
#' ---


#' # The %in% operator
#' 
#' The *%in%* operator allows you to check wheter a value (or a vector of values)
#' is equal to any of the values inside a vector
#' It works with characters
c("a","b","c","d") %in% c("b","d")
#' but also works with numeric
c(1,3,54,4) %in% c(1,4)