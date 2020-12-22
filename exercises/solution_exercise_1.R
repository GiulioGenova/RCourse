# Calculate 6 + 12

6+12

# Assign the value 4234 to x

x <- 4234

# Print out the value of the variable x

x

#or

print(x)

# Calculate x times 4 and print it

x * 4

# Assign the value 2 to the variable my_cars

my_cars <- 2

# Assign the value 7 to the variable my_bikes

my_bikes <- 7

# Assign the sum of my_cars and my_bikes into the variable my_vehicles

my_vehicles <- my_cars + my_bikes

# Print my_vehicles

my_vehicles

# Matrix
# Box office Star Wars (in millions!)
new_hope <- c(460.998, 314.4)
empire_strikes <- c(290.475, 247.900)
return_jedi <- c(309.306, 165.8)

#Use c(new_hope, empire_strikes, return_jedi) to combine the three vectors into one vector. 
#Call this vector box_office.
#Construct a matrix with 3 rows, where each row represents a movie. 
#Use the matrix() function to do this. 
#The first argument is the vector box_office, containing all box office figures. 
#Next, you'll have to specify nrow = 3 and byrow = TRUE. 
#Name the resulting matrix star_wars_matrix.

# Create box_office
box_office <- c(new_hope, empire_strikes, return_jedi)
  
# Construct star_wars_matrix
star_wars_matrix <- matrix(box_office, nrow = 3, byrow = TRUE)